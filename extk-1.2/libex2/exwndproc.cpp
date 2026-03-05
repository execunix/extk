/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwndproc.h"
#include "exwatch.h"
#include "exapp.h"

#define logproc dprint
#define logpro0 dprint0

#ifdef WIN32
typedef std::map<HWND, ExWindow*> ExWindowMap;

static ExWindowMap gWindowMap;

static int32 detachWindowMap(HWND hwnd) {
    dprint("%s: hwnd=0x%p addr=0x%p\n", __func__, hwnd, gWindowMap[hwnd]);
    //SetWindowLong(hwnd, GWL_USERDATA, (LONG)NULL); // detach window handle
    gWindowMap.erase(hwnd);
    return 0;
}

static int32 attachWindowMap(HWND hwnd, ExWindow* window) {
    dprint("%s: hwnd=0x%p addr=0x%p name=%s\n", __func__, hwnd, window, window->getName());
    //SetWindowLong(hwnd, GWL_USERDATA, (LONG)this); // attach window handle
    gWindowMap[hwnd] = window;
    return 0;
}

static ExWindow* searchWindowMap(HWND hwnd) {
    return gWindowMap[hwnd];
}

#if 0 // test
void      ExWindowMapInsert(HWND hwnd, ExWindow* window);
void      ExWindowMapRemove(HWND hwnd);
ExWindow* ExWindowMapSearch(HWND hwnd);

void
ExWindowMapInsert(HWND hwnd, ExWindow* window) {
    exassert(hwnd && window);
    exassert(gWindowMap.find(hwnd) == gWindowMap.end());
    //gWindowMap[hwnd] = window;
    //gWindowMap.insert(ExWindowMap::value_type(hwnd, window));
    std::pair<ExWindowMap::iterator, bool> pr;
    pr = gWindowMap.insert(ExWindowMap::value_type(hwnd, window));
    exassert(pr.second == false && pr.first->second == window);
    exassert(pr.second == true);
}

void
ExWindowMapRemove(HWND hwnd) {
    exassert(hwnd);
    //gWindowMap.erase(hwnd);
    ExWindowMap::iterator i = gWindowMap.find(hwnd);
    exassert(gWindowMap.end() != i);
    if (gWindowMap.end() != i)
        gWindowMap.erase(i);
}

ExWindow*
ExWindowMapSearch(HWND hwnd) {
    exassert(hwnd);
    ExWindowMap::iterator i = gWindowMap.find(hwnd);
    return gWindowMap.end() != i ? i->second : NULL;
}
#endif // test

static uint32 getDoubleClickDiff(const uint32 (&click_time)[2])
{
    const uint32 diff = static_cast<uint32>(click_time[1] - click_time[0]);
    return diff;
}

static uint32 getDoubleClickDist(const int32 (&x)[2], const int32 (&y)[2])
{
    const int32 abs_x = std::abs(x[1] - x[0]);
    const int32 abs_y = std::abs(y[1] - y[0]);
    const int32 dist = abs_x + abs_y;
    return static_cast<uint32>(dist);
}

static int64 procPtrLeaveEnter(ExWindow* const window, ExWidget* const widget, ExCbInfo* const cbinfo)
{
    int64 lResult = 0;
    if (window->getEntered() != widget) {
        ExWidget* wgttmp; // prev entered
        wgttmp = window->getEntered();
        window->setEntered(widget);
        if (wgttmp != nullptr) {
            (void)wgttmp->setFlags(Ex_PtrEntered, 0U);
            (void)wgttmp->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrLeave, 0U));
            // tbd - check halt and result code
            if (wgttmp->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight) {
                (void)wgttmp->damage();
            }
        }
        if (widget != nullptr) {
            exassert2(widget == window->getEntered(), __FILE__ "@" Ex_STRINGIFY(__LINE__));
            (void)widget->setFlags(Ex_PtrEntered, Ex_PtrEntered);
            (void)widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrEnter, 0U));
            // tbd - check halt and result code
            if (widget->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight) {
                (void)widget->damage();
            }
        }
        //ExApp::butRepeatCnt() = 0; // tbd
    }
    if (cbinfo->event != nullptr) {
        lResult = cbinfo->event->lResult;
    }
    return lResult;
}

uint32 basicWndProc(ExWindow* const window, ExCbInfo* const cbinfo)
{
    uint32 cbret_code;
    int32& message = (int32&)cbinfo->event->message;
    WPARAM& wParam = cbinfo->event->wParam;
    LPARAM& lParam = cbinfo->event->lParam;

    switch (message) {
        case WM_PAINT: {
            (void)window->paint();
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Break;
            break;
        }
        case WM_ERASEBKGND: {
    #if 0
            HDC hdc = (HDC)wParam;
            logproc("[0x%p] WM_ERASEBKGND hdc=0x%p\n", hwnd, hdc);
    #endif
            // An application should return nonzero if it erases the background;
            // otherwise, it should return zero.
            cbinfo->event->lResult = 1;
            cbret_code = Ex_Break;
            break;
        }
    #if 0
        case WM_NCCALCSIZE: {
            RECT* r = (RECT*)lParam;
            //NCCALCSIZE_PARAMS* rc = (NCCALCSIZE_PARAMS*)lParam;
            logproc("[0x%p] WM_NCCALCSIZE wParam=%d %d,%d-%d,%d\n", hwnd, wParam,
                r->left, r->top, r->right, r->bottom);
            cbinfo->event->lResult = 0;
            cbret_code = Ex_Break;
            break;
        }
    #endif
        case WM_GETMINMAXINFO: {
            MINMAXINFO* mmi = (MINMAXINFO*)lParam;
            logproc("[0x%p] WM_GETMINMAXINFO %d %d,%d\n", window->getHwnd(), wParam,
                mmi->ptMinTrackSize.x, mmi->ptMinTrackSize.y);
            mmi->ptMinTrackSize.x = 640 + 16;
            mmi->ptMinTrackSize.y = 360 + 39;
            cbret_code = Ex_Continue;
            break;
        }
        case WM_SIZE: {
            int32 width = LOWORD(lParam);
            int32 height = HIWORD(lParam);
            logproc("[0x%p] WM_SIZE wParam=0x%d w=%u h=%u\n", window->getHwnd(), wParam, width, height);
            if (wParam != SIZE_MINIMIZED) {
                if (width < 640) {
                    width = 640;
                }
                if (height < 360) {
                    height = 360;
                }
                ExSize sz(width, height);
                if (window->area.u.sz != sz) {
                    ExRect ar(window->area.u.pt, sz);
                    (void)window->layout(ar);
                }
            }
            cbret_code = Ex_Continue;
            break;
        }
        case WM_MOUSEMOVE: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logpro0("[0x%p] WM_MOUSEMOVE     fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            ExWidget* widget;
            // process already capture
            widget = window->getCapture();
            if (widget != nullptr) {
                if ((widget == window->getEntered()) &&
                    (widget == window->getPressed()) &&
                    (widget->getFlags(Ex_Visible) != 0U)) {
                    cbret_code = widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrMove, 0U));
                    break;
                } else {
                    window->setCapture(nullptr); // cancel event
                }
            }
            widget = window->getSelectable(ExPoint(xPos, yPos));
            (void)procPtrLeaveEnter(window, widget, cbinfo);
            if (widget != nullptr) {
                (void)widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrMove, 0U));
                // tbd - check return code
            }
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Continue;
            break;
        }
        case WM_LBUTTONDOWN: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logpro0("[0x%p] WM_LBUTTONDOWN   fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            ExWidget* widget;
            widget = window->getSelectable(ExPoint(xPos, yPos));
            ExApp::button_x[0] = ExApp::button_x[1];
            ExApp::button_x[1] = xPos;
            ExApp::button_y[0] = ExApp::button_y[1];
            ExApp::button_y[1] = yPos;
            ExApp::button_click_time[0] = ExApp::button_click_time[1];
            ExApp::button_click_time[1] = exWatchDisp->getTick();
            ExApp::button_widget[0] = ExApp::button_widget[1];
            ExApp::button_widget[1] = widget;
            ExApp::button_window[0] = ExApp::button_window[1];
            ExApp::button_window[1] = window;
            if ((widget != nullptr) && (widget == ExApp::button_widget[0]) &&
                (ExApp::double_click_time > getDoubleClickDiff(ExApp::button_click_time)) &&
                (ExApp::double_click_distance > getDoubleClickDist(ExApp::button_x, ExApp::button_y))) {
                // tbd: proc double_click_event callback
                ExApp::double_click_count++;
                cbinfo->event->message = WM_LBUTTONDBLCLK;
            } else {
                ExApp::double_click_count = 0U;
                if ((widget != nullptr) && (widget != ExApp::button_widget[0]) &&
                    (ExApp::button_react_delay > getDoubleClickDiff(ExApp::button_click_time))) {
                    cbret_code = Ex_Continue;
                    break;
                }
            }
            (void)procPtrLeaveEnter(window, widget, cbinfo);
            window->setPressed(widget);
            if (widget != nullptr) {
                ex_but_timer_instant_initial = ex_but_timer_default_initial;
                ex_but_timer_instant_repeat = ex_but_timer_default_repeat;
                (void)widget->setFlags(Ex_ButPressed, Ex_ButPressed);
                (void)widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbButPress, 0U));
                // tbd: proc double_click_event callback
                if (widget->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight) {
                    (void)widget->damage();
                }
                if (widget == window->getPressed()) {
                    //SetTimer(hwnd, ID_TIMER_REPEAT_BUT, 99, nullptr);
                    ExApp::but_timer.init(exWatchDisp, window, &ExWindow::onRepeatBut);
                    ExApp::but_timer.start(ex_but_timer_instant_initial, ex_but_timer_instant_repeat);
                    ExApp::butRepeatCnt() = 0U;
                }
            }
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Continue;
            break;
        }
    #if 0
        case WM_LBUTTONDBLCLK: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logproc("[0x%p] WM_LBUTTONDBLCLK fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            /*  Only windows that have the CS_DBLCLKS style can receive WM_LBUTTONDBLCLK
                messages, which the OS generates when the user presses, releases, and
                again presses the left mouse button within the time limit for double-clicks
                for the system. Double-clicking the left mouse button actually generates
                the following series of four messages:
                    1. WM_LBUTTONDOWN
                    2. WM_LBUTTONUP
                    3. WM_LBUTTONDBLCLK
                    4. WM_LBUTTONUP
            */
            cbret_code = Ex_Continue;
            break;
        }
    #endif
        case WM_LBUTTONUP: {
            UINT fwKeys = (UINT)wParam;
            int32 xPos = LOWORD(lParam);
            int32 yPos = HIWORD(lParam);
            logpro0("[0x%p] WM_LBUTTONUP     fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, xPos, yPos);
            ExWidget* widget;
            ExWidget* wgttmp = window->getPressed();
            ExApp::but_timer.stop();
            if (wgttmp != nullptr) {
                (void)wgttmp->setFlags(Ex_ButPressed, 0U);
                (void)wgttmp->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbButRelease, 0U));
                // tbd: proc double_click_event callback
                if (wgttmp->getFlags(Ex_Highlighted | Ex_AutoHighlight) == Ex_AutoHighlight) {
                    (void)wgttmp->damage();
                }
                if (wgttmp != window->getPressed()) {
                    wgttmp = nullptr; // cancel event
                } else {
                    window->setPressed(nullptr);
                }
            }
            widget = window->getSelectable(ExPoint(xPos, yPos));
            if ((widget == wgttmp) &&
                (widget != nullptr)) {
                (void)widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbActivate, ExApp::butRepeatCnt()));
                // tbd: proc double_click_event callback
                //if (ExApp::butRepeatCnt() == 0)
                //  ExApp::button_click_time[1] = exWatchDisp->getTick();
            }
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Continue;
            break;
        }
        case WM_ACTIVATE: {
            WORD fActive = LOWORD(wParam);
            BOOL fMinimized = (BOOL)HIWORD(wParam);
            HWND hwndPrevious = (HWND)lParam;
            logproc("[0x%p] WM_ACTIVATE fActive=%d fMinimized=%d hwndPrevious=0x%p\n",
                window->getHwnd(), fActive, fMinimized, hwndPrevious);
    #if 0
            // tbd: set widget flags
            if (fMinimized)
                ExWidget::unrealize();
            else
                ExWidget::realize();
    #endif
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Continue;
            break;
        }
        case WM_KEYDOWN: {
            if (ExApp::key_state == (uint32)wParam &&
                (lParam & 0xC0000000) == 0x40000000) {
                lParam = ((lParam & 0xFFFF0000) | (++ExApp::keyRepeatCnt() & 0xFFFF));
            } else {
                ExApp::keyRepeatCnt() = 1U;
                ExApp::key_state = static_cast<uint32>(wParam);
            }
            cbret_code = Ex_Continue;
            break;
        }
        case WM_KEYUP: {
            ExApp::keyRepeatCnt() = 0U;
            ExApp::key_state = 0U;
            cbret_code = Ex_Continue;
            break;
        }
    #if 0
        case WM_TIMER: {
            //logproc("[0x%p] WM_TIMER wParam=%d\n", hwnd, wParam);
            //window->onWmTimer((UINT)wParam);
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Break; // skip handler
            break;
        }
    #endif
    #if 0 // secure FindWindow()
        case WM_GETTEXTLENGTH: {
            cbret_code = Ex_Break; // skip handler
            break;
        }
        case WM_GETTEXT: {
            cbret_code = Ex_Break; // skip handler
            break;
        }
    #endif
        default: {
            LRESULT lResult;
            exWatchDisp->leave();
            lResult = DefWindowProc(window->getHwnd(), message, wParam, lParam);
            exWatchDisp->enter();
            cbinfo->event->lResult = lResult;
            cbret_code = Ex_Continue;
#if 0 // tbd - pass to handler ?
            if (cbinfo->event->lResult != 0) {
                logproc("hwnd=%p msg=%p lResult=%d\n",
                    hwnd, message, cbinfo->event->lResult);
                cbret_code = Ex_Break;
            }
#endif
            break;
        }
    } // end switch
    return cbret_code;
}

LRESULT CALLBACK // static
SysWndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    ExWindow* window;
    (void)exWatchDisp->enter();
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
        attachWindowMap(hwnd, window);
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
        exassert(window && (window->getHwnd() != nullptr));
        attachWindowMap(hwnd, window);
        window->setHwnd(hwnd);
        logproc("[0x%p][0x%p] WM_NCCREATE\n", hwnd, window);
        exWatchDisp->leave();
        return TRUE;
    }
#endif

    //window = (ExWindow*)GetWindowLong(hwnd, GWL_USERDATA);
    window = searchWindowMap(hwnd);
    if (!(window && (window->getHwnd() == hwnd))) {
        logproc("[0x%p] WM_0x%04x\n", hwnd, message);
        exWatchDisp->leave();
        return DefWindowProc(hwnd, message, wParam, lParam);
    }

    // detach
    if (message == WM_DESTROY) {
        logproc("[0x%p][0x%p] WM_DESTROY\n", hwnd, window);
        exassert(window && (window->getHwnd() == hwnd));
        window->setHwnd(nullptr);
        detachWindowMap(hwnd);
        ExApp::addCollectWindow(window);
        if (ExApp::mainWnd == window) {
            ExApp::mainWnd = NULL; // stop timer/flush/input exlib proc
            PostQuitMessage(ExApp::retCode); // stop main loop
        }
        exWatchDisp->leave();
        // An application should return zero if it processes this message.
        return 0;
    }

    // setup cbinfo->event
    ExCbInfo msginfo(0U);
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
    if ((window->invokeFilter(cbinfo) & Ex_Break) != 0U) {
        goto leave_proc;
    }
    cbinfo->type = Ex_CbUnknown;
    if ((basicWndProc(window, cbinfo) & Ex_Break) != 0U) {
        goto leave_proc;
    }
    cbinfo->type = Ex_CbHandler;
    if ((window->invokeHandler(cbinfo) & Ex_Break) != 0U) {
        // fallthrough: goto leave_proc;
    }
leave_proc:
    (void)exWatchDisp->leave();
    return cbinfo->event->lResult;
}
#endif // WIN32
