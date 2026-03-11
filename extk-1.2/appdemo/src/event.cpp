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

bool TouchCalib(ExEvent* event)
{
    int32 pt_x = event->pt.x;
    int32 pt_y = event->pt.y;

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
#if 0
    if ((env.is_run_tchcal == 1) ||
        (env.is_set_tchcal_dat == 0)) {
        //dprint("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n", origin_y, origin_x, env.abs_x_max, env.rel_x_max, env.abs_x_min, env.rel_x_min, env.abs_y_max, env.rel_y_max, env.abs_y_min, env.rel_y_min);
        raw_x = ((raw_x < 0) ? 0 : ((raw_x >= env.sm_w) ? (env.sm_w - 1) : raw_x));
        raw_y = ((raw_y < 0) ? 0 : ((raw_y >= env.sm_h) ? (env.sm_h - 1) : raw_y));
        event->pt.x = raw_x;
        event->pt.y = raw_y;
    } else {
        int32_t cal_y;
        int32_t cal_x;
        // apply calib
        tch_apply_calib(raw_x, raw_y, &cal_x, &cal_y);
        cal_x /= 4;
        cal_y /= 4;
        //dprint("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n", origin_y, origin_x, cal_x, cal_y, env.abs_x_max, env.rel_x_max, env.abs_x_min, env.rel_x_min, env.abs_y_max, env.rel_y_max, env.abs_y_min, env.rel_y_min);
        cal_x = ((cal_x < 0) ? 0 : ((cal_x >= env.sm_w) ? (env.sm_w - 1) : cal_x));
        cal_y = ((cal_y < 0) ? 0 : ((cal_y >= env.sm_h) ? (env.sm_h - 1) : cal_y));
        event->pt.x = cal_x;
        event->pt.y = cal_y;
    }
#else
    raw_x = ((raw_x < 0) ? 0 : ((raw_x >= env.sm_w) ? (env.sm_w - 1) : raw_x));
    raw_y = ((raw_y < 0) ? 0 : ((raw_y >= env.sm_h) ? (env.sm_h - 1) : raw_y));
    event->pt.x = raw_x;
    event->pt.y = raw_y;
#endif

    (void)recordTouchEvent(event);
    // record tick on WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE
    touch_ic_overheat_dataset.push(1U, event->time);

    return true;
}

#endif // __linux__
