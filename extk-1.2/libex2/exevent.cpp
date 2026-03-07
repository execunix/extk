/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#include "extimer.h"
#include "exwatch.h"
#include "exwindow.h"

#ifdef __linux__
ExEventFifo exEventList;

#if 0
static ExEvent* new_event()
{
    std::allocator<ExEvent> ev_allocator;
    ExEvent* const ev = ev_allocator.allocate(1U);
    ev_allocator.construct(ev, ExEvent(None));
    return ev;
}

static void delete_event(ExEvent* const ev)
{
    std::allocator<ExEvent> ev_allocator;
    // ev_allocator.destroy(ev); // hasnt destructor
    ev_allocator.deallocate(ev, 1UL);
}
#endif

ExEvent* ExEventFifo::add(ExEvent* const ev)
{
    ExEvent* back;
    (void)enter();
    back = pushBack();
    if (back != nullptr) {
        *back = *ev;
    }
    (void)leave();
    (void)exWatchDisp->wakeup(); // tbd
    return back;
}

ExEvent* ExEventFifo::add(HWND hwnd, int32 message, uint32 wParam, int64 lParam)
{
    ExEvent* back;
    (void)enter();
    back = pushBack();
    if (back != nullptr) {
        back->clear();
        back->hwnd = hwnd;
        back->message = message;
        back->wParam = wParam;
        back->lParam = lParam;
    }
    (void)leave();
    (void)exWatchDisp->wakeup(); // tbd
    return back;
}

ExEvent* ExGetMessage(ExEvent* ev)
{
    ExEvent* front;
    bool hasEvent = false;
    (void)exEventList.enter();
    front = exEventList.popFront();
    if ((ev != nullptr) && (front != nullptr)) {
        *ev = *front;
    }
    (void)exEventList.leave();
    return front;
}

ExEvent* ExPostPtrMsg(const int32 message, const int32 pt_x, const int32 pt_y)
{
    ExEvent* back = exEventList.add(None, message);
    if (back != nullptr) {
        back->pt.x = static_cast<int16>(pt_x);
        back->pt.y = static_cast<int16>(pt_y);
        back->time = exWatchDisp->getTick();
    }
    return back;
}

bool PostMessage(HWND hwnd, const int32 message, const int32 wparam, const int64 lparam)
{
    ExEvent ev(None);
    ExEvent* back = exEventList.add(&ev.set(hwnd, message, wparam, lparam));
    return (back != nullptr);
}
#endif // __linux__

bool ExEventPeek(ExEvent* event)
{
#ifdef WIN32
    MSG msg;
    BOOL bRet;
    exWatchDisp->leave();
    if ((bRet = GetMessage(&msg, NULL, 0, 0)) != TRUE) {
        exassert(msg.message == WM_QUIT);
        // WM_DESTROY => PostQuitMessage
        bRet = TRUE;
    }
    exWatchDisp->enter();
    return bRet;
#else
    return false; // tbd
#endif
}

ExEventFunc exEventFunc = &ExEventPeek;

// ExEmit APIs - deprecated
//

#ifdef WIN32
bool ExEmitMessage(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    BOOL r = PostMessage(hwnd, message, wParam, lParam);
    return r ? true : false;
}

bool ExEmitKeyEvent(ExWidget* widget, UINT message, int32 virtkey, long keydata) {
    HWND hwnd;
    if (widget && widget->getFlags(Ex_Realized) &&
        (hwnd = widget->getWindow()->getHwnd()) != NULL) {
        return ExEmitMessage(hwnd, message, virtkey, keydata);
    }
    return false;
}

bool ExEmitPtrEvent(ExWidget* widget, UINT message, WPARAM wParam, int32 x, int32 y) {
    HWND hwnd;
    if (widget && widget->getFlags(Ex_Realized) &&
        (hwnd = widget->getWindow()->getHwnd()) != NULL) {
        ExPoint pt(widget->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        LPARAM lParam = MAKELPARAM(x, y);
        return ExEmitMessage(hwnd, message, wParam, lParam);
    }
    return false;
}

bool ExEmitButPress(ExWidget* widget, int32 x, int32 y) {
    return (ExEmitPtrEvent(widget, WM_MOUSEMOVE, 0, x, y) &&
            ExEmitPtrEvent(widget, WM_LBUTTONDOWN, 0, x, y));
}

bool ExEmitButRelease(ExWidget* widget, int32 x, int32 y) {
    return ExEmitPtrEvent(widget, WM_LBUTTONUP, 0, x, y);
}
#endif

#ifdef __linux__
bool ExEmitMessage(const int32 type, const int32 message, const int32 wParam, const int64 lParam) {
    return false;
}
#endif // __linux__
