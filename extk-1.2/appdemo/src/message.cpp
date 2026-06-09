//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <exwindow.h>
#include <exmessage.h>
#include "message.h"
#include <cstring>
#include "watch.h"
#include "env.h"

bool TouchCalib(ExMsg& em)
{
    int32 pt_x = em.pt.x;
    int32 pt_y = em.pt.y;

    // translate em
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
        em.pt.x = raw_x;
        em.pt.y = raw_y;
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
        em.pt.x = cal_x;
        em.pt.y = cal_y;
    }
#else
    raw_x = ((raw_x < 0) ? 0 : ((raw_x >= env.sm_w) ? (env.sm_w - 1) : raw_x));
    raw_y = ((raw_y < 0) ? 0 : ((raw_y >= env.sm_h) ? (env.sm_h - 1) : raw_y));
    em.pt.x = raw_x;
    em.pt.y = raw_y;
#endif

    #ifdef __linux__
    (void)recordTouchEvent(&em);
    #endif // __linux__
    // record tick on WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE
    touch_ic_overheat_dataset.push(1U, em.time);

    return true;
}

bool EmitPtrEvent(ExMsg& em)
{
    ExMsg* emref = nullptr;
    #if 1
    //int32_t origin_x = pt_x, origin_y = pt_y;
    //ExWindow* window = exWndProcMap.search(hwnd);
    if ((exMsgList.size() > 2UL) && (em.message == WM_MOUSEMOVE)) {
        dprint0("skip frequent move em\n");
        goto done;
    }
    #endif
    emref = exMsgList.emitMessage(nullptr);
    if (emref != nullptr) {
        (void)TouchCalib(em);
        *emref = em;
        emref->lParam = MAKELPARAM(em.pt.x, em.pt.y);
        emref->time = exWatchDisp->getTickMs();
    }
    (void)exWatchDisp->wakeup();
done:
    return (emref != nullptr);
}

bool EmitPtrEvent(int32 message, int32 pt_x, int32 pt_y)
{
    ExMsg em(None, message, pt_x, pt_y);
    return EmitPtrEvent(em);
}

// ExEmit APIs - deprecated
//
#ifdef WIN32
bool EmitButPress(ExWidget* w, int32 x, int32 y) {
    bool r;
    ExWindow* window = w->getWindow();
    HWND hwnd = (window != nullptr) ? window->getHwnd() : None;
    if (hwnd != None) {
        ExPoint pt(w->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        r = (EmitPtrEvent(WM_MOUSEMOVE, x, y) &&
             EmitPtrEvent(WM_LBUTTONDOWN, x, y));
    } else {
        r = false;
    }
    return r;
}

bool EmitButRelease(ExWidget* w, int32 x, int32 y) {
    bool r;
    ExWindow* window = w->getWindow();
    HWND hwnd = (window != nullptr) ? window->getHwnd() : None;
    if (hwnd != None) {
        ExPoint pt(w->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        r = EmitPtrEvent(WM_LBUTTONUP, x, y);
    } else {
        r = false;
    }
    return r;
}
#endif
