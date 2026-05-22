/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#include "extimer.h"
#include "exwatch.h"
#include "exwindow.h"
#include "exwproc.h"

#ifdef __linux__
ExEventFifo exEventList;

#if 0
static ExEvent* new_event()
{
    std::allocator<ExEvent> ev_allocator;
    ExEvent* const event = ev_allocator.allocate(1U);
    ev_allocator.construct(event, ExEvent(None));
    return event;
}

static void delete_event(ExEvent* const event)
{
    std::allocator<ExEvent> ev_allocator;
    // ev_allocator.destroy(event); // hasnt destructor
    ev_allocator.deallocate(event, 1UL);
}
#endif

ExEvent* ExEventFifo::get_event(ExEvent* const event)
{
    ExEvent* evref = nullptr;
    (void)enter();
    if (!empty()) {
        evref = &pull_head();
        if (event != nullptr) {
            *event = *evref;
        }
    }
    (void)leave();
    return evref;
}

ExEvent* ExEventFifo::peek_event(ExEvent* const event)
{
    ExEvent* evref = nullptr;
    (void)enter();
    if (!empty()) {
        evref = &head();
        if (event != nullptr) {
            *event = *evref;
        }
    }
    (void)leave();
    return evref;
}

ExEvent* ExEventFifo::post_event(const ExEvent* const event)
{
    ExEvent* evref = nullptr;
    (void)enter();
    if (!is_full()) {
        evref = &push_tail();
        if (event != nullptr) {
            *evref = *event;
        }
    } else {
        dprint1("ExEventFifo::post_event() full\n");
    }
    (void)leave();
    return evref;
}

ExEvent* ExEventFifo::post_event(HWND hwnd, int32 message, uint32 wParam, int64 lParam)
{
    #if 1
    ExEvent event(hwnd, message, wParam, lParam);
    return exEventList.post_event(&event);
    #else
    ExEvent* evref = exEventList.post_event(nullptr);
    if (evref != nullptr) {
        evref->clear();
        evref->hwnd = hwnd;
        evref->message = message;
        evref->wParam = wParam;
        evref->lParam = lParam;
    }
    return evref;
    #endif
}

ExEvent* ExGetMessage(ExEvent* event)
{
    return exEventList.get_event(event);
}

ExEvent* ExPostPtrMsg(int32 message, int32 pt_x, int32 pt_y)
{
    ExEvent* evref = exEventList.post_event(None, message);
    if (evref != nullptr) {
        evref->pt.x = static_cast<int16>(pt_x);
        evref->pt.y = static_cast<int16>(pt_y);
        evref->time = exWatchDisp->getTick();
    }
    (void)exWatchDisp->wakeup();
    return evref;
}

bool PostMessage(HWND hwnd, int32 message, uint32 wparam, int64 lparam)
{
    ExEvent* evref = exEventList.post_event(hwnd, message, wparam, lparam);
    (void)exWatchDisp->wakeup();
    return (evref != nullptr);
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
    ExEvent event(None);
    event.message = message;
    event.pt.x = pt_x;
    event.pt.y = pt_y;
    event.time = exWatchDisp->getTick();
    if (exCalibFunc != nullptr) {
        (void)exCalibFunc(&event);
    }
    ExEvent* back = exEventList.post_event(&event);
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
