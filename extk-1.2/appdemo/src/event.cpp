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

#ifdef __linux__

bool PostPtrMsg(const int32 message, const int32 pt_x, const int32 pt_y)
{
    ExEvent ev(None);
    ev.message = message;
    ev.pt.x = pt_x;
    ev.pt.y = pt_y;
    ev.time = exWatchDisp->getTick();
    ExEvent* back = exEventList.add(&ev);
    (void)recordTouchEvent(back);
    return (back != nullptr);
}

void EmitTouchEvent(const uint32 tickCount, const int32 message, int32 pt_x, int32 pt_y)
{
    //int32_t origin_x = pt_x, origin_y = pt_y;

    env.tch_tick = tickCount;

    if ((exEventList.size() > 2UL) && (message == WM_MOUSEMOVE)) {
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
