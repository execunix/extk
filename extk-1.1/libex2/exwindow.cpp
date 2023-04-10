/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exrender.h"
#include "exwatch.h"
#include "exiconv.h"
#include "exapp.h"
#include <map>

#define logdraw dprint0
#define logdra1 dprint1
#define logdra0 dprint0
#define logproc dprint
#define logpro0 dprint0

ExWatch* exWatchDisp = NULL;

#ifdef WIN32
typedef std::map<HWND, ExWindow*> ExWindowMap;

static ExWindowMap attachWindowMap;

static int32 detachWindow(HWND hwnd) {
    dprint("%s: hwnd=0x%p addr=0x%p\n", __func__, hwnd, attachWindowMap[hwnd]);
    //SetWindowLong(hwnd, GWL_USERDATA, (LONG)NULL); // detach window handle
    attachWindowMap.erase(hwnd);
    return 0;
}

static int32 attachWindow(HWND hwnd, ExWindow* window) {
    dprint("%s: hwnd=0x%p addr=0x%p name=%s\n", __func__, hwnd, window, window->getName());
    //SetWindowLong(hwnd, GWL_USERDATA, (LONG)this); // attach window handle
    attachWindowMap[hwnd] = window;
    return 0;
}
#endif

typedef std::list<ExWindow*> ExWindowList;

static ExWindowList detachWindowList;

void collectWindow() {
    while (!detachWindowList.empty()) {
        ExWindow* w = detachWindowList.front();
        detachWindowList.pop_front();

        dprint1("collectWindow %s\n", w->getName());
        w->destroy();
    }
}

// class ExWindow
//
ExWindow::~ExWindow() {
    if (canvas)
        delete canvas;
    //handlerList.clear();
    //filterList.clear();
}

ExWindow::ExWindow()
    : ExWidget()
#ifdef WIN32
    , hwnd(NULL)
    , dwStyle(0)
    , dwExStyle(0)
#endif
    , notifyFlags(0)
    , renderFlags(0)
    , wgtCapture(NULL)
    , wgtEntered(NULL)
    , wgtPressed(NULL)
    , wgtFocused(NULL)
    , flushFunc()
    , paintFunc()
    , canvas(NULL)
    , event(NULL)
    , filterList()
    , handlerList() {
    flags |= Ex_HasOwnGC;
    flushFunc = ExFlushFunc(this, &ExWindow::onExFlush);
    paintFunc = ExFlushFunc(this, &ExWindow::onWmPaint);
}

uint32 ExWindow::init(const char_t* name, int32 w, int32 h) {
    ExRect rc(0, 0, w, h);
    ExWidget::init(NULL/*parent*/, name, &rc);
    renderFlags |= Ex_RenderRebuild;
    return 0;
}

ExWindow* // static
ExWindow::create(const char_t* name, int32 w, int32 h) {
    ExWindow* window = new ExWindow();
    exassert(window != NULL);
    window->flags |= Ex_FreeMemory;
    window->init(name, w, h);
    return window;
}

uint32 ExWindow::destroy() {
    if (getFlags(Ex_Destroyed))
        return 1;

#ifdef WIN32
    HWND hwnd = this->hwnd;
#endif
    ExWidget::destroy();

    // Now, member variables are not accessible.
#ifdef WIN32
    if (hwnd != NULL) { // is not detached ?
        detachWindow(hwnd);
        DestroyWindow(hwnd); // send WM_DESTROY
    }
#endif
    return 0;
}

#ifdef WIN32
bool ExWindow::showWindow(DWORD dwExStyle, DWORD dwStyle, int32 x, int32 y) {
    renderFlags |= Ex_RenderRebuild;
    this->dwExStyle = dwExStyle;
    this->dwStyle = dwStyle;

    HWND hwnd = NULL;
    HWND hwndParent = NULL;
    LPCSTR lpWindowName = name;
    HINSTANCE hInstance = ExApp::hInstance;
    //if (parent) hwndParent = parent->getWindow()->getHwnd(); // tbd
    hwnd = CreateWindowEx(dwExStyle, getClassName(), lpWindowName, dwStyle,
                          x, y, this->area.w, this->area.h,
                          hwndParent, NULL, hInstance, (PVOID)this);
    exassert(this->hwnd && this->hwnd == hwnd);
    return showWindow();
}

bool ExWindow::showWindow() {
    if (hwnd == NULL)
        return false;
    if (!ShowWindow(hwnd, (dwStyle & WS_CHILD) ? SW_SHOW : SW_SHOWNORMAL))
        return false;
    // send WM_PAINT if the window's update region is not empty
    if (!UpdateWindow(hwnd)) // can be skip
        return false;
    return true;
}

bool ExWindow::hideWindow() {
    bool r = false;
    if (hwnd != NULL) {
        r = ShowWindow(hwnd, SW_HIDE);
    }
    return r;
}
#endif

ExWidget* ExWindow::giveFocus(ExWidget* newFocus) {
    if (newFocus == wgtFocused)
        return wgtFocused;
    if (newFocus != NULL) {
        if (newFocus->getFlags(Ex_Blocked) ||
            !newFocus->isVisible())
            return wgtFocused;
    }

    ExWidgetList got;
    if (newFocus) {
        for (ExWidget* w = newFocus; w; w = w->parent)
            got.push_front(w);
        if (got.front() != this) {
            exerror("can't give focus %s to %s different parent\n", newFocus->name, name);
            return wgtFocused;
        }
    }
    ExWidgetList lost;
    if (wgtFocused) {
        for (ExWidget* w = wgtFocused; w; w = w->parent)
            lost.push_front(w);
    }

    ExWidgetList::iterator got_i = got.begin();
    ExWidgetList::iterator lost_i = lost.begin();
    while (got_i != got.end() && lost_i != lost.end()) {
        dprint("compare %s %s\n", (*got_i)->name, (*lost_i)->name);
        if (*lost_i != *got_i)
            break;
        ++lost_i;
        if (*got_i == newFocus)
            break;
        ++got_i;
    }
    lost.erase(lost.begin(), lost_i);
    got.erase(got.begin(), got_i);

    // reset focused flag
    lost_i = lost.end();
    while (lost_i != lost.begin()) {
        ExWidget* w = *--lost_i;
        w->flags &= ~Ex_Focused;
        if (w->getFlags(Ex_FocusRender))
            w->damage();
        dprint("lost focus %s\n", w->name);
    }
    got_i = got.begin();
    while (got_i != got.end()) {
        ExWidget* w = *got_i++;
        w->flags |= Ex_Focused;
        if (w->getFlags(Ex_FocusRender))
            w->damage();
        dprint("got focus %s\n", w->name);
    }

    // invoke callback
    ExCbInfo cbinfo(0, 0, NULL, newFocus);
    lost_i = lost.end();
    cbinfo.type = Ex_CbLostFocus;
    while (lost_i != lost.begin()) {
        ExWidget* w = *--lost_i;
        cbinfo.subtype = w == wgtFocused ? 1 : 0;
        w->invokeListener(Ex_CbLostFocus, &cbinfo);
    }
    wgtFocused = newFocus; // tbd - change for callback refer
    got_i = got.begin();
    cbinfo.type = Ex_CbGotFocus;
    while (got_i != got.end()) {
        ExWidget* w = *got_i++;
        cbinfo.subtype = w == wgtFocused ? 1 : 0;
        w->invokeListener(Ex_CbGotFocus, &cbinfo);
    }
    return wgtFocused;
}

ExWidget* ExWindow::moveFocus(uint32 dir) { // sample
    if (wgtFocused == NULL) {
        if (dir == Ex_DirUp || dir == Ex_DirLeft)
            return giveFocus(this);
        return giveFocus(last());
    }
    switch (dir) {
        case Ex_DirUp:
            if (wgtFocused->broPrev && wgtFocused->broPrev != wgtFocused)
                return giveFocus(wgtFocused->broPrev);
        case Ex_DirDown:
            if (wgtFocused->broNext && wgtFocused->broNext != wgtFocused)
                return giveFocus(wgtFocused->broNext);
        case Ex_DirLeft:
            if (wgtFocused->parent)
                return giveFocus(wgtFocused->parent);
        case Ex_DirRight:
            if (wgtFocused->childHead)
                return giveFocus(wgtFocused->childHead);
    }
    return wgtFocused;
}

uint32 ExWindow::render() {
#if 0
    buildExtent();
    buildRegion();
    damageRgn.setRect(extent);
    ExWidget::render(canvas);
#else
    ExRender::render(canvas, this, renderFlags);
#endif
    renderFlags = 0;
    return 0;
}

uint32 ExWindow::flush() {
    flushFunc(this, &damageRgn);
    return 0;
}

uint32 ExWindow::paint() {
    paintFunc(this, &damageRgn);
    return 0;
}

#define GDICLIP_FLUSH
#define GDICLIP_PAINT

void ExWindow::onExFlush(ExWindow* window, const ExRegion* updateRgn) {
#ifdef WIN32
    // updateRgn is filled after render call.
    this->render();

    if (!(hwnd && canvas && canvas->gc))
        return;

    HDC hdc = GetDC(hwnd);
#ifdef GDICLIP_FLUSH
    HRGN hrgn = ExRegionToGdi(hdc, updateRgn);
#endif
    BITMAPINFO bmi;
    memset(&bmi, 0, sizeof(BITMAPINFO));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = canvas->gc->width;
    bmi.bmiHeader.biHeight = -canvas->gc->height;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = canvas->gc->bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
    SetDIBitsToDevice(hdc, 0, 0, canvas->gc->width, canvas->gc->height,
                      0, 0, 0, canvas->gc->height, canvas->gc->bits, &bmi, DIB_RGB_COLORS);
#ifdef GDICLIP_FLUSH
    SelectClipRgn(hdc, NULL);
    DeleteObject(hrgn);
#endif
    ReleaseDC(hwnd, hdc);
#if 1
    ValidateRect(hwnd, NULL);
#else
    RECT clip;
    clip.left = updateRgn->extent.l;
    clip.top = updateRgn->extent.t;
    clip.right = updateRgn->extent.r;
    clip.bottom = updateRgn->extent.b;
    ValidateRect(hwnd, &clip);
#endif
#endif // WIN32
}

void ExWindow::onWmPaint(ExWindow* window, const ExRegion* updateRgn) {
#ifdef WIN32
    // updateRgn is filled after render call.
    this->render();

    exassert(hwnd && canvas && canvas->gc);

    PAINTSTRUCT ps;
    HDC hdc = BeginPaint(hwnd, &ps);
#ifdef GDICLIP_PAINT
    RECT* clip = &ps.rcPaint;
    HRGN hrgn = CreateRectRgnIndirect(clip);
    SelectClipRgn(hdc, hrgn);
    // rcPaint : Specifies a RECT structure that specifies the upper left and lower right corners
    //           of the rectangle in which the painting is requested.
    logdraw("[0x%p] WM_PAINT hdc=0x%p x=%d y=%d w=%d h=%d\n",
            hwnd, hdc, clip->left, clip->top, clip->right - clip->left, clip->bottom - clip->top);
#endif

    BITMAPINFO bmi;
    memset(&bmi, 0, sizeof(BITMAPINFO));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = canvas->gc->width;
    bmi.bmiHeader.biHeight = -canvas->gc->height;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = canvas->gc->bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
    SetDIBitsToDevice(hdc, 0, 0, canvas->gc->width, canvas->gc->height,
                      0, 0, 0, canvas->gc->height, canvas->gc->bits, &bmi, DIB_RGB_COLORS);

#ifdef GDICLIP_PAINT
    SelectClipRgn(hdc, NULL);
    DeleteObject(hrgn);
#endif
    EndPaint(hwnd, &ps);
#endif // WIN32
}

uint32 ExWindow::onRepeatBut(ExTimer* timer, ExCbInfo* cbinfo) {
    if (wgtPressed &&
        wgtPressed == wgtEntered && ++ExApp::butRepeatCnt() > 0) {
        if (!wgtPressed->listenerList.empty()) {
            cbinfo->event = event; // tbd - backup msg ?
            cbinfo->set(Ex_CbButRepeat, ExApp::butRepeatCnt());
            return wgtPressed->invokeListener(Ex_CbActivate, cbinfo);
        }
    }
    return Ex_Continue;
}

uint32 ExWindow::onRepeatKey(ExTimer* timer, ExCbInfo* cbinfo) {
    // tbd
    return Ex_Continue;
}

uint32 ExWindow::basicWndProc(ExCbInfo* cbinfo) {
#ifdef WIN32
    UINT& message = cbinfo->event->message;
    WPARAM& wParam = cbinfo->event->wParam;
    LPARAM& lParam = cbinfo->event->lParam;

    switch (message) {
        case WM_PAINT: {
            this->paint();
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            return Ex_Break;
        }
        case WM_ERASEBKGND: {
#if 0
            HDC hdc = (HDC)wParam;
            logproc("[0x%p] WM_ERASEBKGND hdc=0x%p\n", hwnd, hdc);
#endif
            // An application should return nonzero if it erases the background;
            // otherwise, it should return zero.
            cbinfo->event->lResult = 1;
            return Ex_Break;
        }
#if 0
        case WM_NCCALCSIZE: {
            RECT* r = (RECT*)lParam;
            //NCCALCSIZE_PARAMS* rc = (NCCALCSIZE_PARAMS*)lParam;
            logproc("[0x%p] WM_NCCALCSIZE wParam=%d %d,%d-%d,%d\n", hwnd, wParam,
                    r->left, r->top, r->right, r->bottom);
            cbinfo->event->lResult = 0;
            return Ex_Break;
        }
#endif
        case WM_GETMINMAXINFO: {
            MINMAXINFO* mmi = (MINMAXINFO*)lParam;
            logproc("[0x%p] WM_GETMINMAXINFO %d %d,%d\n", hwnd, wParam,
                    mmi->ptMinTrackSize.x, mmi->ptMinTrackSize.y);
            mmi->ptMinTrackSize.x = 640 + 16;
            mmi->ptMinTrackSize.y = 360 + 39;
            return Ex_Continue;
        }
        case WM_SIZE: {
            int32 width = LOWORD(lParam);
            int32 height = HIWORD(lParam);
            logproc("[0x%p] WM_SIZE wParam=0x%d w=%u h=%u\n", hwnd, wParam, width, height);
            if (wParam != SIZE_MINIMIZED) {
                if (width < 640)
                    width = 640;
                if (height < 360)
                    height = 360;
                ExSize sz(width, height);
                if (this->area.u.sz != sz) {
                    ExRect ar(this->area.u.pt, sz);
                    layout(ar);
                }
            }
            return Ex_Continue;
        }
        case WM_MOUSEMOVE: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logpro0("[0x%p] WM_MOUSEMOVE     fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            if (wgtCapture != NULL) {
                if (wgtCapture == wgtEntered &&
                    wgtCapture == wgtPressed &&
                    wgtCapture->getFlags(Ex_Visible)) {
                    return wgtCapture->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrMove, 0));
                }
                wgtCapture = NULL;
            }
            ExWidget* wgttmp = NULL;
            ExWidget* widget = getSelectable(ExPoint(xPos, yPos));
            if (wgtEntered != widget) {
                wgttmp = wgtEntered;
                wgtEntered = widget;
                if (wgttmp != NULL) {
                    wgttmp->flags &= ~Ex_PtrEntered;
                    wgttmp->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrLeave, 0));
                    // tbd - check return code
                    if (wgttmp->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight)
                        wgttmp->damage();
                }
                if (widget != NULL &&
                    widget == wgtEntered) {
                    widget->flags |= Ex_PtrEntered;
                    widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrEnter, 0));
                    // tbd - check return code
                    if (widget->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight)
                        widget->damage();
                } else {
                    widget = NULL; // cancel event
                }
                //ExApp::butRepeatCnt() = 0; // tbd
            }
            if (widget != NULL) {
                widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrMove, 0));
                // tbd - check return code
            }
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            return Ex_Continue;
        }
        case WM_LBUTTONDOWN: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logpro0("[0x%p] WM_LBUTTONDOWN   fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            ExWidget* wgttmp = NULL;
            ExWidget* widget = getSelectable(ExPoint(xPos, yPos));
            ExApp::button_x[0] = ExApp::button_x[1];
            ExApp::button_x[1] = xPos;
            ExApp::button_y[0] = ExApp::button_y[1];
            ExApp::button_y[1] = yPos;
            ExApp::button_click_time[0] = ExApp::button_click_time[1];
            ExApp::button_click_time[1] = exWatchDisp->getTick();
            ExApp::button_widget[0] = ExApp::button_widget[1];
            ExApp::button_widget[1] = widget;
            ExApp::button_window[0] = ExApp::button_window[1];
            ExApp::button_window[1] = this;
            if (widget && widget ==
                ExApp::button_widget[0] &&
                ExApp::double_click_time >
                ExApp::button_click_time[1] -
                ExApp::button_click_time[0] &&
                ExApp::double_click_distance >
                std::abs(ExApp::button_x[1] - ExApp::button_x[0]) +
                std::abs(ExApp::button_y[1] - ExApp::button_y[0])) {
                // tbd: proc double_click_event callback
                ExApp::double_click_count++;
                cbinfo->event->message = WM_LBUTTONDBLCLK;
            } else {
                ExApp::double_click_count = 0;
                if (widget && widget !=
                    ExApp::button_widget[0] &&
                    ExApp::button_react_delay >
                    ExApp::button_click_time[1] -
                    ExApp::button_click_time[0]) {
                    return Ex_Continue;
                }
            }
            if (wgtEntered != widget) {
                wgttmp = wgtEntered;
                wgtEntered = widget;
                if (wgttmp != NULL) {
                    wgttmp->flags &= ~Ex_PtrEntered;
                    wgttmp->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrLeave, 0));
                    // tbd: proc double_click_event callback
                    if (wgttmp->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight)
                        wgttmp->damage();
                }
                if (widget != NULL &&
                    widget == wgtEntered) {
                    widget->flags |= Ex_PtrEntered;
                    widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrEnter, 0));
                    // tbd: proc double_click_event callback
                    if (widget->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight)
                        widget->damage();
                } else {
                    widget = NULL; // cancel event
                }
            }
            wgtPressed = widget;
            if (widget != NULL) {
                ex_but_timer_instant_initial = ex_but_timer_default_initial;
                ex_but_timer_instant_repeat = ex_but_timer_default_repeat;
                widget->flags |= Ex_ButPressed;
                widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbButPress, 0));
                // tbd: proc double_click_event callback
                if (widget->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight)
                    widget->damage();
                if (widget == wgtPressed) {
                    //SetTimer(hwnd, ID_TIMER_REPEAT_BUT, 99, NULL);
                    ExApp::but_timer.init(exWatchDisp, this, &ExWindow::onRepeatBut);
                    ExApp::but_timer.start(ex_but_timer_instant_initial, ex_but_timer_instant_repeat);
                    ExApp::butRepeatCnt() = 0;//-2;
                }
            }
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            return Ex_Continue;
        }
#if 0
        case WM_LBUTTONDBLCLK: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logproc("[0x%p] WM_LBUTTONDBLCLK fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            /*	Only windows that have the CS_DBLCLKS style can receive WM_LBUTTONDBLCLK
                messages, which the OS generates when the user presses, releases, and
                again presses the left mouse button within the time limit for double-clicks
                for the system. Double-clicking the left mouse button actually generates
                the following series of four messages:
                    1. WM_LBUTTONDOWN
                    2. WM_LBUTTONUP
                    3. WM_LBUTTONDBLCLK
                    4. WM_LBUTTONUP
            */
            return Ex_Continue;
        }
#endif
        case WM_LBUTTONUP: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logpro0("[0x%p] WM_LBUTTONUP     fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            ExWidget* wgttmp = wgtPressed;
            ExApp::but_timer.stop();
            if (wgttmp != NULL) {
                wgttmp->flags &= ~Ex_ButPressed;
                wgttmp->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbButRelease, 0));
                // tbd: proc double_click_event callback
                if (wgttmp->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight)
                    wgttmp->damage();
                if (wgttmp != wgtPressed)
                    wgttmp = NULL; // cancel event
                else
                    wgtPressed = NULL;
            }
            if (wgttmp != NULL &&
                wgttmp == getSelectable(ExPoint(xPos, yPos))) {
                if (ExApp::butRepeatCnt() < 0)
                    ExApp::butRepeatCnt() = 0;
                wgttmp->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbActivate, ExApp::butRepeatCnt()));
                // tbd: proc double_click_event callback
                //if (ExApp::butRepeatCnt() == 0)
                //  ExApp::button_click_time[1] = exWatchDisp->getTick();
            }
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            return Ex_Continue;
        }
        case WM_ACTIVATE: {
            WORD fActive = LOWORD(wParam);
            BOOL fMinimized = (BOOL)HIWORD(wParam);
            HWND hwndPrevious = (HWND)lParam;
            logproc("[0x%p] WM_ACTIVATE fActive=%d fMinimized=%d hwndPrevious=0x%p\n",
                    hwnd, fActive, fMinimized, hwndPrevious);
#if 0
            // tbd: set widget flags
            if (fMinimized)
                ExWidget::unrealize();
            else
                ExWidget::realize();
#endif
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            return Ex_Continue;
        }
        case WM_KEYDOWN: {
            if (ExApp::key_state == (uint32)wParam &&
                (lParam & 0xC0000000) == 0x40000000) {
                lParam = ((lParam & 0xFFFF0000) | (++ExApp::keyRepeatCnt() & 0xFFFF));
            } else {
                ExApp::keyRepeatCnt() = 1;
                ExApp::key_state = (uint32)wParam;
            }
            return Ex_Continue;
        }
        case WM_KEYUP: {
            ExApp::keyRepeatCnt() = 0;
            ExApp::key_state = 0;
            return Ex_Continue;
        }
#if 0
        case WM_TIMER: {
            //logproc("[0x%p] WM_TIMER wParam=%d\n", hwnd, wParam);
            //window->onWmTimer((UINT)wParam);
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            return Ex_Break; // skip handler
        }
#endif
#if 0 // secure FindWindow()
        case WM_GETTEXTLENGTH: {
            return Ex_Break; // skip handler
        }
        case WM_GETTEXT: {
            return Ex_Break; // skip handler
        }
#endif
    } // end switch
    LRESULT lResult;
    exWatchDisp->leave();
    lResult = DefWindowProc(hwnd, message, wParam, lParam);
    exWatchDisp->enter();
    cbinfo->event->lResult = lResult;
#if 0 // tbd - pass to handler ?
    if (cbinfo->event->lResult != 0) {
        logproc("hwnd=%p msg=%p lResult=%d\n",
                hwnd, message, cbinfo->event->lResult);
        return Ex_Break;
    }
#endif
#endif // WIN32
    return Ex_Continue;
}

#ifdef WIN32
LRESULT CALLBACK // static
ExWindow::sysWndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    ExWindow* window = NULL;
    exWatchDisp->enter();
#if 0
    MSG& m = ExApp::event.msg;
    logproc("hwnd=%p,%p msg=%p,%p wp=%p,%p lp=%p,%p\n",
            m.hwnd, hwnd, m.message, message, m.wParam, wParam, m.lParam, lParam);
#endif

    // attach
#ifdef _WIN32_WCE
    if (message == WM_CREATE) {
        window = (ExWindow*)((LPCREATESTRUCT)lParam)->lpCreateParams;
        exassert(window && !window->hwnd);
        attachWindow(hwnd, window);
        window->hwnd = hwnd;
        logproc("[0x%p][0x%p] WM_CREATE\n", hwnd, window);
        // If an application processes this message, it should return 0 to continue creation of the window.
        // If the application returns -1, the window is destroyed and the CreateWindowEx or CreateWindow function returns a NULL handle.
        exWatchDisp->leave();
        return 0;
    }
#else
    if (message == WM_NCCREATE) {
        window = (ExWindow*)((LPCREATESTRUCT)lParam)->lpCreateParams;
        exassert(window && !window->hwnd);
        attachWindow(hwnd, window);
        window->hwnd = hwnd;
        logproc("[0x%p][0x%p] WM_NCCREATE\n", hwnd, window);
        exWatchDisp->leave();
        return TRUE;
    }
#endif

    //window = (ExWindow*)GetWindowLong(hwnd, GWL_USERDATA);
    window = attachWindowMap[hwnd];
    if (!(window && window->hwnd == hwnd)) {
        logproc("[0x%p] WM_0x%04x\n", hwnd, message);
        exWatchDisp->leave();
        return DefWindowProc(hwnd, message, wParam, lParam);
    }

    // detach
    if (message == WM_DESTROY) {
        logproc("[0x%p][0x%p] WM_DESTROY\n", hwnd, window);
        exassert(window && window->hwnd == hwnd);
        window->hwnd = NULL;
        detachWindow(hwnd);
        detachWindowList.push_back(window);
        if (ExApp::mainWnd == window) {
            ExApp::mainWnd = NULL; // stop timer/flush/input exlib proc
            PostQuitMessage(ExApp::retCode); // stop main loop
        }
        exWatchDisp->leave();
        // An application should return zero if it processes this message.
        return 0;
    }

    // setup cbinfo->event
    ExCbInfo msginfo(0);
    ExCbInfo* cbinfo = &msginfo;
    window->event = &ExApp::event;
    cbinfo->event = &ExApp::event;
    cbinfo->event->hwnd = hwnd;
    cbinfo->event->message = message;
    cbinfo->event->wParam = wParam;
    cbinfo->event->lParam = lParam;
    cbinfo->event->lResult = 0;
    //exassert(cbinfo->event->msg.time == window->event->msg.time);
    //exassert(cbinfo->event->msg.pt == window->event->msg.pt);
#if 0 // deprecated
    if (message == WM_ExEvEmit) { // emitted msg is key,btn,...
        window->event = (ExEvent*)lParam;
        cbinfo->event = window->event; // replace...
        exassert(hwnd == window->event->hwnd);
    }
#endif

    cbinfo->type = Ex_CbFilter;
    if (window->invokeFilter(cbinfo) & Ex_Break)
        goto leave;
    cbinfo->type = Ex_CbUnknown;
    if (window->basicWndProc(cbinfo) & Ex_Break)
        goto leave;
    cbinfo->type = Ex_CbHandler;
    if (window->invokeHandler(cbinfo) & Ex_Break)
        goto leave;
leave:
    exWatchDisp->leave();
    return cbinfo->event->lResult;
}
#endif // WIN32

#ifdef WIN32
ATOM // static
ExWindow::classInit(HINSTANCE hInstance) {
    static ATOM wcid = 0;

    if (wcid == 0) {
        WNDCLASS wc;
        wc.style = /*CS_DBLCLKS | */CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = (WNDPROC)sysWndProc;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        wc.hInstance = hInstance;
        wc.hIcon = 0;//LoadIcon(hInstance, MAKEINTRESOURCE(IDI_APPWGT));
        wc.hCursor = LoadCursor(NULL, IDC_ARROW);
        wc.hbrBackground = 0;//(HBRUSH)GetStockObject(HOLLOW_BRUSH);
        wc.lpszMenuName = 0;//MAKEINTRESOURCE(IDC_APPDEMO);
        wc.lpszClassName = getClassName();
        wcid = RegisterClass(&wc);
        dprint("classInit(0x%p) wcid=0x%p\n", hInstance, wcid);
    }
    return wcid;
}
#endif // WIN32

ExDrawFunc exDrawFuncTrap;

// test
//
#ifdef WIN32
#if 0
extern ExWindowMap attachWindowMap;

void      ExWindowMapInsert(HWND hwnd, ExWindow* window);
void      ExWindowMapRemove(HWND hwnd);
ExWindow* ExWindowMapSearch(HWND hwnd);

void
ExWindowMapInsert(HWND hwnd, ExWindow* window) {
    exassert(hwnd && window);
    exassert(attachWindowMap.find(hwnd) == attachWindowMap.end());
    //attachWindowMap[hwnd] = window;
    //attachWindowMap.insert(ExWindowMap::value_type(hwnd, window));
    std::pair<ExWindowMap::iterator, bool> pr;
    pr = attachWindowMap.insert(ExWindowMap::value_type(hwnd, window));
    exassert(pr.second == false && pr.first->second == window);
    exassert(pr.second == true);
}

void
ExWindowMapRemove(HWND hwnd) {
    exassert(hwnd);
    //attachWindowMap.erase(hwnd);
    ExWindowMap::iterator i = attachWindowMap.find(hwnd);
    exassert(attachWindowMap.end() != i);
    if (attachWindowMap.end() != i)
        attachWindowMap.erase(i);
}

ExWindow*
ExWindowMapSearch(HWND hwnd) {
    exassert(hwnd);
    ExWindowMap::iterator i = attachWindowMap.find(hwnd);
    return attachWindowMap.end() != i ? i->second : NULL;
}
#endif
#endif
