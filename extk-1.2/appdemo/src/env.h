//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _env_h_
#define _env_h_

#include <extypes.h>
#include "tools.h"

struct Env {
    char cwd[64];
    int32 sm_w;
    int32 sm_h;

    int32 fb0_w;
    int32 fb0_h;
    int32 fb0_bpp;
    int32 fb0_bpl;
    uint8* fb0_bits;
    int32 fb0_rotate;

    int32 fb1_w;
    int32 fb1_h;
    int32 fb1_bpp;
    int32 fb1_bpl;
    uint8* fb1_bits;

    int32 abs_x_min;
    int32 abs_x_max;
    int32 abs_y_min;
    int32 abs_y_max;

    int32 rel_x_min;
    int32 rel_x_max;
    int32 rel_y_min;
    int32 rel_y_max;

    uint32 tch_tick;
    int32 tch_flip_h;
    int32 tch_flip_v;
    int32 tch_rotate; // 0:landscape, 1:portrait
    int32 is_run_tchcal;
    int32 is_set_tchcal_dat;

    int32 board_type; // 0:evk, 1:pdu
    char locale[32];
    uint32 gui_tick;
    uint64 key_flags;

    struct {
        int32 show;
        int32 x;
        int32 y;
        int32 w;
        int32 h;
    } wnd;

    // show: # echo "dp var 3" > /tmp/app.fifo
    int32 dp_bit; // 9
    int32 dp_gps; // 5
    int32 dp_isr; // 999
    int32 dp_pkt; // 5
};

static constexpr const char* const def_envfile = "./appenv.ini";

bool initEnv() noexcept;
bool loadEnv(const char* const envfile = def_envfile) noexcept;
bool saveEnv(const char* const envfile = def_envfile) noexcept;

extern Env env;

#endif // _env_h_
