//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <exwindow.h>
#include <exevent.h>
#include <cstring>
#include "watch.h"
#include "event.h"
#include "env.h"

extern ExWatch* exWatchDisp;

#ifdef __linux__

static Event* new_event()
{
    std::allocator<Event> ev_allocator;
    Event* const ev = ev_allocator.allocate(1U);
    ev_allocator.construct(ev, Event(nullptr));
    return ev;
}

static void delete_event(Event* const ev)
{
    std::allocator<Event> ev_allocator;
    // ev_allocator.destroy(ev); // hasnt destructor
    ev_allocator.deallocate(ev, 1UL);
}

EventList gEventList;

bool EventList::add(Event* const ev)
{
    (void)enter();
    push_back(ev);
    (void)leave();
    (void)gWatchApp.wakeup();
    return true;
}

bool GetMessage(Event& ev)
{
    bool hasEvent = false;
    (void)gEventList.enter();

    if (!gEventList.empty()) {
        ev = **gEventList.begin();
        delete_event(*gEventList.begin());
        gEventList.pop_front();
        hasEvent = true;
    }
    (void)gEventList.leave();

    return hasEvent;
}

bool PostPtrMsg(const int32 message, const int32 pt_x, const int32 pt_y)
{
    Event* const ev = new_event();
    exassert2(ev != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    ev->message = message;
    ev->msg.pt.x = static_cast<int16>(pt_x);
    ev->msg.pt.y = static_cast<int16>(pt_y);
    ev->tick = exWatchDisp->getTick();
    (void)recordTouchEvent(ev);

    return gEventList.add(ev);
}

bool PostMessage(const int32 message, const int32 wparam, const int64 lparam)
{
    Event* const ev = new_event();
    exassert2(ev != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    (void)ev->set(message, wparam, lparam);

    return gEventList.add(ev);
}

void EmitTouchEvent(const uint32 tickCount, const int32 message, int32 pt_x, int32 pt_y)
{
    //int32_t origin_x = pt_x, origin_y = pt_y;

    env.tch_tick = tickCount;

    if ((gEventList.size() > 2UL) && (message == WM_MOUSEMOVE)) {
        dprint0("skip frequent move event\n");
    } else {
        // translate event
        int32 raw_x;
        int32 raw_y;
        const int32 x_min = env.abs_x_min + env.rel_x_min;
        const int32 x_max = env.abs_x_max + env.rel_x_max;
        const int32 y_min = env.abs_y_min + env.rel_y_min;
        const int32 y_max = env.abs_y_max + env.rel_y_max;

        pt_x = ((pt_x - x_min) * env.fb0_w) / (x_max - x_min);
        pt_y = ((pt_y - y_min) * env.fb0_h) / (y_max - y_min);

        if (env.tch_rotate != 0) {
            raw_x = ((env.tch_flip_v != 0) ? ((env.fb0_h - 1) - pt_y) : pt_y);
            raw_y = ((env.tch_flip_h != 0) ? ((env.fb0_w - 1) - pt_x) : pt_x);
        } else {
            raw_x = ((env.tch_flip_h != 0) ? ((env.fb0_w - 1) - pt_x) : pt_x);
            raw_y = ((env.tch_flip_v != 0) ? ((env.fb0_h - 1) - pt_y) : pt_y);
        }
        raw_x = ((raw_x < 0) ? 0 : ((raw_x >= env.sm_w) ? (env.sm_w - 1) : raw_x));
        raw_y = ((raw_y < 0) ? 0 : ((raw_y >= env.sm_h) ? (env.sm_h - 1) : raw_y));
        (void)PostPtrMsg(message, raw_x, raw_y);
    }
}

#endif // __linux__
