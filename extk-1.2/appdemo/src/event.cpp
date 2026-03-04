//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <exevent.h>
#include <cstring>
#include "watch.h"
#include "event.h"
#include "env.h"

extern ExWatch* exWatchDisp;

#ifdef __linux__
EventList gEventList;

int EventList::add(Event* ev)
{
    enter();
    push_back(ev);
    leave();
    gWatchApp.wakeup();
    return 0;
}

int GetMessage(Event& ev)
{
    gEventList.enter();

    if (gEventList.empty()) {
        gEventList.leave();
        return 0;
    }
#if 0 // no trivial copy-assignment
    std::memcpy(&ev, *gEventList.begin(), sizeof(Event));
#else
    //ev = std::move(**gEventList.begin());
    ev = **gEventList.begin();
#endif
    delete *gEventList.begin();
    gEventList.pop_front();

    gEventList.leave();

    return 1;
}

int PostMessage(int message, ExPoint pt)
{
    Event* ev = new Event;

    ev->message = message;
    ev->msg.pt = pt;
    ev->tick = exWatchDisp->getTick();

    return gEventList.add(ev);
}

int PostMessage(int message, int wparam, int64 lparam)
{
    Event* ev = new Event;

    ev->set(message, wparam, lparam);

    return gEventList.add(ev);
}

int PostEditMsg(int message, int wparam, ExWidget* wgt, char* buf, int len)
{
    Event* ev = new Event;

    ev->set(message, wparam, 0);
    ev->u.edit.wgt = wgt;
    ev->u.edit.buf = buf;
    ev->u.edit.len = len;

    return gEventList.add(ev);
}

int EmitTouchEvent(uint32 tickCount, int message, ExPoint pt)
{
    int32_t raw_x, raw_y, cal_x, cal_y;

    env.tch_tick = tickCount;

    if (gEventList.size() > 2 &&
        message == WM_MOUSEMOVE)
        return 0;

    // translate event
    int x_min = env.abs_x_min + env.rel_x_min;
    int x_max = env.abs_x_max + env.rel_x_max;
    int y_min = env.abs_y_min + env.rel_y_min;
    int y_max = env.abs_y_max + env.rel_y_max;

    pt.x = (pt.x - x_min) * env.fb0_w / (x_max - x_min);
    pt.y = (pt.y - y_min) * env.fb0_h / (y_max - y_min);

    if (env.tch_rotate) {
        raw_x = env.tch_flip_v ? (env.fb0_h - 1) - pt.y : pt.y;
        raw_y = env.tch_flip_h ? (env.fb0_w - 1) - pt.x : pt.x;
    } else {
        raw_x = env.tch_flip_h ? (env.fb0_w - 1) - pt.x : pt.x;
        raw_y = env.tch_flip_v ? (env.fb0_h - 1) - pt.y : pt.y;
    }

    // if (env.is_run_tchcal == 1 ||
    //     env.is_set_tchcal_dat == 0) {
    //     return PostMessage(message, ExPoint(raw_x, raw_y));
    // }

    // apply calib
    #if 0
    TouchPanelCalibrateAPoint(raw_x, raw_y, &cal_x, &cal_y);

    cal_x /= 4;
    cal_y /= 4;
    #else
    cal_x = raw_x;
    cal_y = raw_y;
    #endif

    return PostMessage(message, ExPoint(cal_x, cal_y));
}
#endif // __linux__
