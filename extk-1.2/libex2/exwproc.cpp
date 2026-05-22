/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwproc.h"
#include "exwatch.h"
#include "exapp.h"

#define logproc dprint
#define logpro0 dprint0

ExWindowMap exWndProcMap;

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

uint32 ProcWndEvent(ExWindow* const window, ExCbInfo* const cbinfo)
{
    uint32 cbret_code;
    const int32 message = cbinfo->event->message;
    WPARAM wParam = static_cast<WPARAM>(cbinfo->event->wParam);
    LPARAM lParam = static_cast<LPARAM>(cbinfo->event->lParam);

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
#ifdef WIN32
            MINMAXINFO* mmi = (MINMAXINFO*)lParam;
            logproc("[0x%p] WM_GETMINMAXINFO %d %d,%d\n", window->getHwnd(), wParam,
                    mmi->ptMinTrackSize.x, mmi->ptMinTrackSize.y);
            mmi->ptMinTrackSize.x = 640 + 16;
            mmi->ptMinTrackSize.y = 360 + 39;
#endif // WIN32
#ifdef __linux__
            ExSize* sz = (ExSize*)lParam;
            logproc("[0x%p] WM_GETMINMAXINFO %d %d,%d\n", window->getHwnd(), wParam, sz->w, sz->h);
            sz->w = 640 + 16;
            sz->h = 360 + 39;
#endif // __linux__
            cbret_code = Ex_Continue;
            break;
        }
        case WM_SIZE: {
            ExSize sz = cbinfo->event->sz;
            logproc("[0x%p] WM_SIZE wParam=0x%d w=%u h=%u\n", window->getHwnd(), wParam, sz.w, sz.h);
            if (wParam != SIZE_MINIMIZED) {
                if (sz.w < 640) {
                    sz.w = 640;
                }
                if (sz.h < 360) {
                    sz.h = 360;
                }
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
            ExPoint pt = cbinfo->event->pt;
            logpro0("[0x%p] WM_MOUSEMOVE     fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, pt.x, pt.y);
            ExWidget* widget;
            // process already capture
            widget = window->getCapture();
            if (widget != nullptr) {
                if (widget->isFlagVisible() &&
                    (widget == window->getEntered()) &&
                    (widget == window->getPressed())) {
                    cbret_code = widget->invokeListener(Ex_CbActivate, cbinfo->set(Ex_CbPtrMove, 0U));
                    break;
                } else {
                    window->setCapture(nullptr); // cancel event
                }
            }
            widget = window->getSelectable(pt);
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
            ExPoint pt = cbinfo->event->pt;
            logpro0("[0x%p] WM_LBUTTONDOWN   fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, pt.x, pt.y);
            ExWidget* widget;
            widget = window->getSelectable(pt);
            ExApp::button_x[0] = ExApp::button_x[1];
            ExApp::button_x[1] = pt.x;
            ExApp::button_y[0] = ExApp::button_y[1];
            ExApp::button_y[1] = pt.y;
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
            ExPoint pt = cbinfo->event->pt;
            logproc("[0x%p] WM_LBUTTONDBLCLK fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, pt.x, pt.y);
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
            ExPoint pt = cbinfo->event->pt;
            logpro0("[0x%p] WM_LBUTTONUP     fwKeys=0x%p xPos=%d yPos=%d\n", hwnd, fwKeys, pt.x, pt.y);
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
            widget = window->getSelectable(pt);
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
            uint16 fActive = LOWORD(wParam);
            bool fMinimized = (bool)HIWORD(wParam);
            HWND hwndPrevious = (HWND)lParam;
            logproc("[0x%p] WM_ACTIVATE fActive=%d fMinimized=%d hwndPrevious=0x%p\n",
                    window->getHwnd(), fActive, fMinimized, hwndPrevious);
#if 0
            // tbd: set widget flags
            if (fMinimized) {
                ExWidget::unrealize();
            } else {
                ExWidget::realize();
            }
#endif
            // An application should return zero if it processes this message.
            //cbinfo->event->lResult = 0;
            cbret_code = Ex_Continue;
            break;
        }
        case WM_KEYDOWN: {
            const uint64 key_flags = static_cast<uint64>(lParam);
            if ((ExApp::key_state == static_cast<uint32>(wParam)) &&
                ((key_flags & 0xC0000000UL) == 0x40000000UL)) {
                ++ExApp::keyRepeatCnt();
                const uint32 key_repeat_cnt = (ExApp::keyRepeatCnt() & 0xFFFFU);
                ExApp::key_flags = ((key_flags & 0xFFFF0000UL) | static_cast<uint64>(key_repeat_cnt));
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
#ifdef WIN32
            lResult = DefWindowProc(window->getHwnd(), message, wParam, lParam);
#endif // WIN32
#ifdef __linux__
            // tbd - lResult = DefWindowProc(cbinfo->event);
            lResult = 0; // tbd
#endif // __linux__
            exWatchDisp->enter();
            cbinfo->event->lResult = lResult;
            cbret_code = Ex_Continue;
#if 0 // tbd - pass to handler ?
            if (cbinfo->event->lResult != 0) {
                logproc("hwnd=%p msg=%p lResult=%d\n", hwnd, message, cbinfo->event->lResult);
                cbret_code = Ex_Break;
            }
#endif
            break;
        }
    } // end switch
    return cbret_code;
}

#ifdef __linux__
int64 DefWndProc(ExEvent& ev)
#endif // __linux__
#ifdef WIN32
LRESULT CALLBACK
DefWndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
#endif // WIN32
{
    ExWindow* window;
    ExCbInfo cbinfo(0U);
#ifdef WIN32
    ExEvent ev(hwnd, message, wParam, lParam);
#endif // WIN32

    cbinfo.event = &ev;
    cbinfo.event->lResult = 0;

    (void)exWatchDisp->enter();

#if 0
    logproc("hwnd:%p msg:%p wp:%p lp:%p\n", hwnd, message, wParam, lParam);
#endif

    // attach
#ifdef WIN32
#ifdef _WIN32_WCE
    constexpr uint32 wm_create = WM_CREATE;
#else
    constexpr uint32 wm_create = WM_NCCREATE;
#endif
    if (message == wm_create) {
        window = (ExWindow*)((LPCREATESTRUCT)lParam)->lpCreateParams;
        exassert((window != nullptr) && (window->getHwnd() == nullptr));
        (void)exWndProcMap.attach(hwnd, window);
        window->setHwnd(hwnd);
        logproc("[0x%p][0x%p] WM_CREATE\n", hwnd, window);
#ifdef _WIN32_WCE
        // If an application processes this message, it should return 0 to continue creation of the window.
        // If the application returns -1, the window is destroyed and the CreateWindowEx or CreateWindow function returns a NULL handle.
        // cbinfo.event->lResult = 0;
#else
        cbinfo.event->lResult = 1;
#endif
        goto setup_proc;
    }
#endif // WIN32

    if ((ev.hwnd == None) && (ExApp::mainWnd != nullptr)) {
        ev.hwnd = ExApp::mainWnd->getHwnd();
    }
    window = (ev.hwnd != None) ? exWndProcMap.search(ev.hwnd) : nullptr;
    // WIN32 usage: window = (ExWindow*)GetWindowLong(hwnd, GWL_USERDATA);
    if ((window == nullptr) || (window->getHwnd() != ev.hwnd)) {
        logproc("[0x%p] WM_0x%04x\n", ev.hwnd, ev.message);
#ifdef WIN32
        cbinfo.event->lResult = DefWindowProc(hwnd, message, wParam, lParam);
#else // linux
        ;
#endif // WIN32
        goto leave_proc;
    }

    window->event = &ev; // valid only within the event callback

    // detach
#ifdef WIN32
    if (ev.message == WM_DESTROY) {
        logproc("[0x%p][0x%p] WM_DESTROY\n", ev.hwnd, window);
        exassert((window != nullptr) && (window->getHwnd() == ev.hwnd));
        window->setHwnd(None);
        (void)exWndProcMap.detach(ev.hwnd);
        ExApp::addCollectWindow(window);
        if (ExApp::mainWnd == window) {
            ExApp::mainWnd = nullptr; // stop timer/flush/input exlib proc
            PostQuitMessage(ExApp::retCode); // stop main loop
        }
        // An application should return zero if it processes this message.
        goto leave_proc;
    }
#endif // WIN32

#ifdef WIN32
    // setup cbinfo
setup_proc:
    if ((ev.message >= WM_MOUSEFIRST) &&
        (ev.message <= WM_MOUSELAST)) {
        cbinfo.event->pt.x = LOWORD(ev.lParam);
        cbinfo.event->pt.y = HIWORD(ev.lParam);
    } else if (ev.message == WM_SIZE) {
        cbinfo.event->sz.w = LOWORD(ev.lParam);
        cbinfo.event->sz.h = HIWORD(ev.lParam);
    }
#endif // WIN32

    cbinfo.type = Ex_CbFilter;
    if ((window->invokeFilter(&cbinfo) & Ex_Break) != 0U) {
        goto leave_proc;
    }
    cbinfo.type = Ex_CbUnknown;
    if ((ProcWndEvent(window, &cbinfo) & Ex_Break) != 0U) {
        goto leave_proc;
    }
    cbinfo.type = Ex_CbHandler;
    if ((window->invokeHandler(&cbinfo) & Ex_Break) != 0U) {
        // fallthrough: goto leave_proc;
    }
leave_proc:
    (void)exWatchDisp->leave();
    return cbinfo.event->lResult;
}

// custom usage:
// #ifdef __linux__
//__attribute__((weak))
// #else
// #pragma comment(linker, "/alternatename:procWndEvent=ProcWndEvent")
// #pragma comment(linker, "/alternatename:defWndProc=DefWndProc")
// #endif // __linux__
