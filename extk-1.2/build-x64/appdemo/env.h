//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <extypes.h>

struct Env {
    int sm_w;
    int sm_h;
    struct {
        int show;
        int x;
        int y;
        int w;
        int h;
    } wnd;
};

int initEnv();
int loadEnv();
int saveEnv();

extern Env env;

