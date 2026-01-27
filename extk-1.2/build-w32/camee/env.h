/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#pragma once

#define MAX_W   1920
#define MAX_H   1080

#define CAP_W   1280
#define CAP_H   720

#define MAXCAM  25

enum {
    RENDERER_GDI,
    RENDERER_D2D,
    RENDERER_D3D,
};

struct Env {
    int sm_w;
    int sm_h;
    int renderer;
    struct MonitorView {
        int col;
        int row;
        int fps;
    } mv;
    struct CamInfo {
        char url[256];
        int flags; // tbd
    } ci[MAXCAM];
};

int initEnv();
int loadEnv();
int saveEnv();

extern Env env;

