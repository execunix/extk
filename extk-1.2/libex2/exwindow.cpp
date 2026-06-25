/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwproc.h"
#include "exrender.h"
#include "exwatch.h"
#include "exiconv.h"
#include "exapp.h"

#define logdraw dprint0
#define logdra1 dprint1
#define logdra0 dprint0
#define logproc dprint
#define logpro0 dprint0

// class ExWindow
//
ExWindow::~ExWindow() noexcept {
    //handlerList.clear();
    //filterList.clear();
}

ExWindow::ExWindow() noexcept
    : ExWidget()
    , hwnd(None)
#ifdef WIN32
    , dwStyle(0)
    , dwExStyle(0)
#endif
    , wgtCapture(nullptr)
    , wgtEntered(nullptr)
    , wgtPressed(nullptr)
    , wgtFocused(nullptr)
    , flushFunc()
    , paintFunc()
    , exmsg(nullptr)
    , filterList()
    , handlerList() {
    flags |= Ex_HasOwnGC;
    flushFunc = ExFlushFunc(this, &ExWindow::onExFlush);
    paintFunc = ExFlushFunc(this, &ExWindow::onWmPaint);
}

uint32 ExWindow::init(const char* name, int32 w, int32 h) {
    ExRect rc(0, 0, w, h);
    ExWidget::init(nullptr/*parent*/, name, &rc);
    flags |= Ex_Rebuild;
    return 0;
}

ExWindow* // static
ExWindow::create(const char* name, int32 w, int32 h) {
    ExWindow* window = new ExWindow();
    exassert(window != nullptr);
    window->flags |= Ex_FreeMemory;
    window->init(name, w, h);
    return window;
}

uint32 ExWindow::destroy() {
    if (getFlags(Ex_Destroyed) != 0U) {
        return 1;
    }
    HWND hwnd = this->hwnd;
    ExWidget::destroy();

    // Now, member variables are not accessible.
    if (hwnd != None) { // is not detached ?
        // (void)exWndProcMap.detach(hwnd);
#ifdef WIN32
        DestroyWindow(hwnd); // send WM_DESTROY
#endif
#ifdef __linux__
#ifdef CONF_X11
        ExApp::EnvX11& x11 = ExApp::x11;
        (void)XDestroyWindow(x11.display, hwnd);
#endif
        (void)exWndProcMap.detach(hwnd);
        ExApp::addCollectWindow(this);

        ExMsg em(hwnd, WM_DESTROY, 0, reinterpret_cast<int64>(this));
        ExCbInfo cbinfo(Ex_CbFilter, 0U, &em);
        if ((invokeFilter(&cbinfo) & Ex_Break) == 0U) {
            (void)invokeHandler(&cbinfo(Ex_CbHandler));
        }
        hwnd = None;
        if (ExApp::mainWnd == this) {
            ExApp::mainWnd = nullptr; // stop timer/flush/input exlib proc
            (void)ExEmitMessage(WM_QUIT, EXIT_SUCCESS); // stop main loop
        }
#endif // __linux__
    }
    return 0;
}

#ifdef WIN32
bool ExWindow::showWindow(DWORD dwExStyle, DWORD dwStyle, int32 x, int32 y) {
    this->dwExStyle = dwExStyle;
    this->dwStyle = dwStyle;
    flags |= Ex_Rebuild;

    HWND hwnd = nullptr;
    HWND hwndParent = nullptr;
    LPCSTR lpWindowName = name;
    HINSTANCE hInstance = ExApp::hInstance;
    //if (parent) hwndParent = parent->getWindow()->getHwnd(); // tbd
    hwnd = CreateWindowEx(dwExStyle, getClassName(), lpWindowName, dwStyle,
                          x, y, this->area.w, this->area.h,
                          hwndParent, nullptr, hInstance, (PVOID)this);
    exassert(this->hwnd && this->hwnd == hwnd);
    return showWindow();
}

bool ExWindow::showWindow() {
    if (hwnd == nullptr) {
        return false;
    }
    if (!ShowWindow(hwnd, (dwStyle & WS_CHILD) ? SW_SHOW : SW_SHOWNORMAL)) {
        return false;
    }
    // send WM_PAINT if the window's update region is not empty
    if (!UpdateWindow(hwnd)) { // can be skip
        return false;
    }
    return true;
}

bool ExWindow::hideWindow() {
    bool r = false;
    if (hwnd != nullptr) {
        r = ShowWindow(hwnd, SW_HIDE);
    }
    return r;
}
#endif

#ifdef __linux__
bool ExWindow::showWindow(ulong type, int32 x, int32 y) {
#ifdef CONF_X11
    ExApp::EnvX11& x11 = ExApp::x11;

    int64 event_mask = 0;
    event_mask |= KeyPressMask | KeyReleaseMask;
    event_mask |= ButtonPressMask | ButtonReleaseMask | PointerMotionMask;
    event_mask |= EnterWindowMask | LeaveWindowMask | FocusChangeMask;
    event_mask |= ExposureMask | ResizeRedirectMask;
    event_mask |= StructureNotifyMask;
    // event_mask |= SubstructureNotifyMask;

    uint64 value_mask = 0;
    value_mask |= CWBackPixmap | CWBackPixel;
    value_mask |= CWBorderPixel | CWBackingStore;
    value_mask |= CWEventMask;
    // value_mask |= CWColormap; // only if 8-bpp mode

    // create parent window
    XSetWindowAttributes attr;
    attr.background_pixmap = None; //ParentRelative;
    attr.background_pixel = BlackPixel(x11.display, 0);
    //attr.border_pixmap = CopyFromParent;
    attr.border_pixel = WhitePixel(x11.display, 0);
    //attr.bit_gravity = ForgetGravity;
    //attr.win_gravity = NorthWestGravity;
    attr.backing_store = Always; //NotUseful;
    //attr.backing_planes = All ones;
    //attr.backing_pixel = zero;
    //attr.save_under = False;
    attr.event_mask = event_mask;
    //attr.do_not_propagate_mask = empty set;
    //attr.override_redirect = False;
    attr.colormap = CopyFromParent;
    //attr.cursor = None;
    hwnd = XCreateWindow(x11.display, x11.root,
        x, y, this->area.w, this->area.h, 2, x11.depth,
        InputOutput, x11.visual, value_mask, &attr);

    XSetWMProtocols(x11.display, hwnd, x11.wm_atom, ExApp::WM_MAX);
    if (1) {
        Atom* pa = 0;
        int32 cnt = 0;
        XGetWMProtocols(x11.display, hwnd, &pa, &cnt);
        dprint("XGetWMProtocols: cnt=%d\n", cnt);
        for (int32 i = 0; i < cnt; i++) {
            dprint("atom[%d]=%lu:%s\n", i, pa[i], XGetAtomName(x11.display, pa[i]));
        }
        if (pa) {
            XFree(pa);
        }
    }
    XStoreName(x11.display, hwnd, this->name);
#endif
    (void)exWndProcMap.attach(hwnd, this);

    ExMsg em(hwnd, WM_CREATE, 0, reinterpret_cast<int64>(this));
    ExCbInfo cbinfo(Ex_CbFilter, 0U, &em);
    if ((invokeFilter(&cbinfo) & Ex_Break) == 0U) {
        (void)invokeHandler(&cbinfo(Ex_CbHandler));
    }
    // tbd - send_message(WM_SIZE, area.w, area.h); // layout
    exMsgList.emitMessage(hwnd, WM_SIZE)->sz = area.u.sz; // layout
    (void)exWatchDisp->wakeup();
    return showWindow();
}

bool ExWindow::showWindow() {
#ifdef CONF_X11
    ExApp::EnvX11& x11 = ExApp::x11;
    XMapWindow(x11.display, hwnd);
#endif
    return true;
}

bool ExWindow::hideWindow() {
    // tbd - type
    return true;
}
#endif // __linux__

ExWidget* ExWindow::giveFocus(ExWidget* newFocus) {
    if (newFocus == wgtFocused) {
        return wgtFocused;
    }
    if (newFocus != nullptr) {
        if ((newFocus->getFlags(Ex_Blocked) != 0U) ||
            !newFocus->isVisible()) {
            return wgtFocused;
        }
    }

    ExWidgetList got;
    if (newFocus) {
        for (ExWidget* w = newFocus; w != nullptr; w = w->parent) {
            got.push_front(w);
        }
        if (got.front() != this) {
            exerror("can't give focus %s to %s different parent\n", newFocus->name, name);
            return wgtFocused;
        }
    }
    ExWidgetList lost;
    if (wgtFocused) {
        for (ExWidget* w = wgtFocused; w != nullptr; w = w->parent) {
            lost.push_front(w);
        }
    }

    ExWidgetList::iterator got_i = got.begin();
    ExWidgetList::iterator lost_i = lost.begin();
    while (got_i != got.end() && lost_i != lost.end()) {
        dprint("compare %s %s\n", (*got_i)->name, (*lost_i)->name);
        if (*lost_i != *got_i) {
            break;
        }
        ++lost_i;
        if (*got_i == newFocus) {
            break;
        }
        ++got_i;
    }
    lost.erase(lost.begin(), lost_i);
    got.erase(got.begin(), got_i);

    // reset focused flag
    lost_i = lost.end();
    while (lost_i != lost.begin()) {
        ExWidget* w = *--lost_i;
        w->flags &= ~Ex_Focused;
        if (w->getFlags(Ex_FocusRender) != 0U) {
            w->damage();
        }
        dprint("lost focus %s\n", w->name);
    }
    got_i = got.begin();
    while (got_i != got.end()) {
        ExWidget* w = *got_i++;
        w->flags |= Ex_Focused;
        if (w->getFlags(Ex_FocusRender) != 0U) {
            w->damage();
        }
        dprint("got focus %s\n", w->name);
    }

    // invoke callback
    ExCbInfo cbinfo(0, 0, nullptr, newFocus);
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
    if (wgtFocused == nullptr) {
        if (dir == Ex_DirUp || dir == Ex_DirLeft) {
            return giveFocus(this);
        }
        return giveFocus(last());
    }
    switch (dir) {
        case Ex_DirUp: {
            if (wgtFocused->broPrev && wgtFocused->broPrev != wgtFocused) {
                return giveFocus(wgtFocused->broPrev);
            }
            break;
        }
        case Ex_DirDown: {
            if (wgtFocused->broNext && wgtFocused->broNext != wgtFocused) {
                return giveFocus(wgtFocused->broNext);
            }
            break;
        }
        case Ex_DirLeft: {
            if (wgtFocused->parent) {
                return giveFocus(wgtFocused->parent);
            }
            break;
        }
        case Ex_DirRight: {
            if (wgtFocused->childHead) {
                return giveFocus(wgtFocused->childHead);
            }
            break;
        }
    }
    return wgtFocused;
}

uint32 ExWindow::render() {
    ExRender::render(canvas, this);
    flags &= ~Ex_Rebuild;
    return 0;
}

uint32 ExWindow::flush() {
    exassert(canvas != nullptr);
    flushFunc(this, &canvas->update);
    canvas->update.setEmpty();
    return 0;
}

uint32 ExWindow::paint() {
    exassert(canvas != nullptr);
    paintFunc(this, &canvas->update);
    canvas->update.setEmpty();
    return 0;
}

#define GDICLIP_FLUSH
#define GDICLIP_PAINT

void ExWindow::onExFlush(ExWindow* window, const ExRegion* updateRgn) {
#ifdef WIN32
    // updateRgn is filled after render call.
    this->render();

    if (!(hwnd && canvas))
        return;

    HDC hdc = GetDC(hwnd);
#ifdef GDICLIP_FLUSH
    HRGN hrgn = ExRegionToGdi(hdc, updateRgn);
#endif
    BITMAPINFO bmi;
    memset(&bmi, 0, sizeof(BITMAPINFO));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = canvas->gc.width;
    bmi.bmiHeader.biHeight = -canvas->gc.height;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = canvas->gc.bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
    SetDIBitsToDevice(hdc, 0, 0, canvas->gc.width, canvas->gc.height,
                      0, 0, 0, canvas->gc.height, canvas->gc.bits, &bmi, DIB_RGB_COLORS);
#ifdef GDICLIP_FLUSH
    SelectClipRgn(hdc, nullptr);
    DeleteObject(hrgn);
#endif
    ReleaseDC(hwnd, hdc);
#if 1
    ValidateRect(hwnd, nullptr);
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

    exassert(hwnd && canvas);

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
    bmi.bmiHeader.biWidth = canvas->gc.width;
    bmi.bmiHeader.biHeight = -canvas->gc.height;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = canvas->gc.bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
    SetDIBitsToDevice(hdc, 0, 0, canvas->gc.width, canvas->gc.height,
                      0, 0, 0, canvas->gc.height, canvas->gc.bits, &bmi, DIB_RGB_COLORS);

#ifdef GDICLIP_PAINT
    SelectClipRgn(hdc, nullptr);
    DeleteObject(hrgn);
#endif
    EndPaint(hwnd, &ps);
#endif // WIN32
}

uint32 ExWindow::onRepeatBut(ExTimer* timer, ExCbInfo* cbinfo) {
    if (wgtPressed &&
        wgtPressed == wgtEntered && ++ExApp::butRepeatCnt() > 0) {
        if (!wgtPressed->listenerList.empty()) {
            cbinfo->exmsg = exmsg; // tbd - backup msg ?
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

#ifdef WIN32
ATOM // static
ExWindow::initClass(HINSTANCE hInstance) {
    static ATOM wcid = 0;

    if (wcid == 0) {
        WNDCLASS wc;
        wc.style = /*CS_DBLCLKS | */CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = (WNDPROC)&DefWndProc;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        wc.hInstance = hInstance;
        wc.hIcon = 0;//LoadIcon(hInstance, MAKEINTRESOURCE(IDI_APPWGT));
        wc.hCursor = LoadCursor(nullptr, IDC_ARROW);
        wc.hbrBackground = 0;//(HBRUSH)GetStockObject(HOLLOW_BRUSH);
        wc.lpszMenuName = 0;//MAKEINTRESOURCE(IDC_APPDEMO);
        wc.lpszClassName = getClassName();
        wcid = RegisterClass(&wc);
        dprint("initClass(0x%p) wcid=0x%p\n", hInstance, wcid);
    }
    return wcid;
}
#endif // WIN32

ExDrawFunc exDrawFuncTrap;
