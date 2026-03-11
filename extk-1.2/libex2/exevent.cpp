/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#include "extimer.h"
#include "exwatch.h"
#include "exwindow.h"
#include "exwndproc.h"

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
    (void)exEventList.enter();
    front = exEventList.popFront();
    if ((ev != nullptr) && (front != nullptr)) {
        *ev = *front;
    }
    (void)exEventList.leave();
    return front;
}

ExEvent* ExPostPtrMsg(int32 message, int32 pt_x, int32 pt_y)
{
    ExEvent* back = exEventList.add(None, message);
    if (back != nullptr) {
        back->pt.x = static_cast<int16>(pt_x);
        back->pt.y = static_cast<int16>(pt_y);
        back->time = exWatchDisp->getTick();
    }
    return back;
}

bool PostMessage(HWND hwnd, int32 message, uint32 wparam, int64 lparam)
{
    ExEvent ev(None);
    ExEvent* back = exEventList.add(&ev.set(hwnd, message, wparam, lparam));
    return (back != nullptr);
}
#endif // __linux__

#ifdef WIN32
bool ExEventPeek(MSG& msg)
{
    BOOL bRet;
    exWatchDisp->leave();
    if ((bRet = GetMessage(&msg, NULL, 0, 0)) != TRUE) {
        exassert(msg.message == WM_QUIT);
        // WM_DESTROY => PostQuitMessage
        bRet = TRUE;
    }
    exWatchDisp->enter();
    return bRet;
}
#else
bool ExEventPeek(ExEvent* event)
{
    return false; // tbd
}
#endif

ExEventFunc exEventFunc = &ExEventPeek;
ExEventFunc exCalibFunc = nullptr;

// ExEmit APIs - deprecated
//

#ifdef __linux__
static bool PostPtrMsg(int32 message, int32 pt_x, int32 pt_y)
{
    ExEvent ev(None);
    ev.message = message;
    ev.pt.x = pt_x;
    ev.pt.y = pt_y;
    ev.time = exWatchDisp->getTick();
    if (exCalibFunc != nullptr) {
        (void)exCalibFunc(&ev);
    }
    ExEvent* back = exEventList.add(&ev);
    return (back != nullptr);
}

bool ExEmitMessage(HWND hwnd, int32 message, uint32 wParam, int64 lParam)
{
    return PostMessage(hwnd, message, wParam, lParam);
}

bool ExEmitPtrEvent(HWND hwnd, int32 message, int32 pt_x, int32 pt_y)
{
    bool r = true;
    //int32_t origin_x = pt_x, origin_y = pt_y;
    //ExWindow* window = exWndProcMap.search(hwnd);
    if ((exEventList.size() > 2UL) && (message == WM_MOUSEMOVE)) {
        dprint0("skip frequent move event\n");
    } else {
        r = PostPtrMsg(message, pt_x, pt_y);
    }
    return r;
}
#endif // __linux__

#ifdef WIN32
bool ExEmitMessage(HWND hwnd, int32 message, uint32 wParam, int64 lParam) {
    BOOL r = PostMessage(hwnd, message, wParam, lParam);
    return r ? true : false;
}

bool ExEmitPtrEvent(HWND hwnd, int32 message, int32 x, int32 y) {
    LPARAM lParam = MAKELPARAM(x, y);
    return ExEmitMessage(hwnd, message, 0U, lParam);
}

bool ExEmitButPress(ExWidget* w, int32 x, int32 y) {
    bool r;
    ExWindow* window = w->getWindow();
    HWND hwnd = (window != nullptr) ? window->getHwnd() : None;
    if (hwnd != None) {
        ExPoint pt(w->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        r = (ExEmitPtrEvent(hwnd, WM_MOUSEMOVE, x, y) &&
             ExEmitPtrEvent(hwnd, WM_LBUTTONDOWN, x, y));
    } else {
        r = false;
    }
    return r;
}

bool ExEmitButRelease(ExWidget* w, int32 x, int32 y) {
    bool r;
    ExWindow* window = w->getWindow();
    HWND hwnd = (window != nullptr) ? window->getHwnd() : None;
    if (hwnd != None) {
        ExPoint pt(w->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        r = ExEmitPtrEvent(hwnd, WM_LBUTTONUP, x, y);
    } else {
        r = false;
    }
    return r;
}
#endif
