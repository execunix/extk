/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exdebug.h>
#include "watch.h"
#include "exapp.h"
#include "env.h"

#ifdef __linux__

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

static int32 procPtrLeaveEnter(ExWindow* const window, ExWidget* const widget, ExCbInfo* const cbinfo)
{
    int32 lResult = 0;
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

static uint32 basicWndProc(ExWindow* const window, ExCbInfo* const cbinfo)
{
    uint32 cbret_code;
    int32& message = cbinfo->event->message;
    Event& ev = static_cast<Event&>(*cbinfo->event);

    switch (message) {
        case WM_PAINT: {
            (void)window->paint();
            cbret_code = Ex_Break;
            break;
        }
        case WM_SIZE: {
            if (window->area.u.sz != ev.msg.sz) {
                ExRect ar(window->area.u.pt, ev.msg.sz);
                (void)window->layout(ar);
            }
            cbret_code = Ex_Continue;
            break;
        }
        case WM_MOUSEMOVE: {
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
            widget = window->getSelectable(ev.msg.pt);
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
            ExWidget* widget;
            widget = window->getSelectable(ev.msg.pt);
            ExApp::button_x[0] = ExApp::button_x[1];
            ExApp::button_x[1] = ev.msg.pt.x;
            ExApp::button_y[0] = ExApp::button_y[1];
            ExApp::button_y[1] = ev.msg.pt.y;
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
        case WM_LBUTTONUP: {
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
            widget = window->getSelectable(ev.msg.pt);
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
        case WM_KEYDOWN: {
            const uint64 key_flags = static_cast<uint64>(ev.lParam);
            if ((ExApp::key_state == static_cast<uint32>(ev.wParam)) &&
                ((key_flags & 0xC0000000UL) == 0x40000000UL)) {
                ++ExApp::keyRepeatCnt();
                const uint32 key_repeat_cnt = (ExApp::keyRepeatCnt() & 0xFFFFU);
                env.key_flags = ((key_flags & 0xFFFF0000UL) | static_cast<uint64>(key_repeat_cnt));
            } else {
                ExApp::keyRepeatCnt() = 1U;
                ExApp::key_state = static_cast<uint32>(ev.wParam);
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
        default: {
            cbret_code = Ex_Continue;
            break;
        }
    } // end switch
    return cbret_code;
}

int32 DefWndProc(Event& ev)
{
    ExWindow* window;
    ExCbInfo msginfo(0U);
    ExCbInfo* cbinfo = &msginfo;

    cbinfo->event = &ev;
    cbinfo->event->lResult = 0;

    (void)exWatchDisp->enter();

    // attach
    if (ev.message == WM_CREATE) {
        window = static_cast<ExWindow*>(ev.collector);
        exassert2(window != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
        ExApp::mainWnd = window;
#ifdef CONF_X11
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
        attr.background_pixel = BlackPixel(env.display, 0);
        //attr.border_pixmap = CopyFromParent;
        attr.border_pixel = WhitePixel(env.display, 0);
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
        env.top = XCreateWindow(env.display, env.root, 100, 50, env.sm_w, env.sm_h, 2, env.depth,
            InputOutput, env.visual, value_mask, &attr);

        XMapWindow(env.display, env.top);

        env.wm_atom[Env::WM_PROTOCOLS] = XInternAtom(env.display, "WM_PROTOCOLS", True);
        env.wm_atom[Env::WM_TAKE_FOCUS] = XInternAtom(env.display, "WM_TAKE_FOCUS", True);
        env.wm_atom[Env::WM_SAVE_YOURSELF] = XInternAtom(env.display, "WM_SAVE_YOURSELF", True); // deprecated
        env.wm_atom[Env::WM_DELETE_WINDOW] = XInternAtom(env.display, "WM_DELETE_WINDOW", True);
        XSetWMProtocols(env.display, env.top, env.wm_atom, Env::WM_MAX);
        if (1) {
            Atom* pa = 0;
            int32 cnt = 0;
            XGetWMProtocols(env.display, env.top, &pa, &cnt);
            dprint("XGetWMProtocols: cnt=%d\n", cnt);
            for (int32 i = 0; i < cnt; i++) {
                dprint("atom[%d]=%lu:%s\n", i, pa[i], XGetAtomName(env.display, pa[i]));
            }
            if (pa) {
                XFree(pa);
            }
        }

        XStoreName(env.display, env.top, "PDU Emulator - v1.0");
#endif
        //goto leave_proc;
    }

    // pdu - has single window
    window = ExApp::mainWnd;
    exassert2(window != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    // pdu

    // detach
    if (ev.message == WM_DESTROY) {
        if (true) { // ExApp::mainWnd == window
            ExApp::mainWnd = nullptr; // stop timer/flush/input exlib proc
            (void)PostMessage(WM_QUIT); // stop main loop
#ifdef CONF_X11
            XDestroyWindow(env.display, env.top);
            env.top = 0;
#endif
        }
        goto leave_proc;
    }

    *gWatchApp.get_def_event() = ev;

    // setup cbinfo->event
    window->event = gWatchApp.get_def_event();
    cbinfo->event->setHwnd(window);

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

#endif // __linux__
