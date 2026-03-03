//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "osal/osal.h"
#include <stdio.h>
#include "env.h"

Env env;

int initEnv()
{
    #ifdef WIN32
    env.sm_w = GetSystemMetrics(SM_CXSCREEN);
    env.sm_h = GetSystemMetrics(SM_CYSCREEN);
    env.wnd.show = SW_SHOWNORMAL;
    env.wnd.x = CW_USEDEFAULT;
    env.wnd.y = CW_USEDEFAULT;
    #else // !WIN32
    env.sm_w = 1920;
    env.sm_h = 1080;
    env.wnd.show = 1;
    env.wnd.x = 5;
    env.wnd.y = 5;
    #endif // WIN32
    env.wnd.w = 1280;
    env.wnd.h = 720;

    loadEnv();

    return 0;
}

static const char* envfile = "./appenv.ini";

int loadEnv()
{
    #ifdef WIN32
    env.wnd.show = GetPrivateProfileIntA("wnd", "show", env.wnd.show, envfile);
    env.wnd.x = GetPrivateProfileIntA("wnd", "x", env.wnd.x, envfile);
    env.wnd.y = GetPrivateProfileIntA("wnd", "y", env.wnd.y, envfile);
    env.wnd.w = GetPrivateProfileIntA("wnd", "w", env.wnd.w, envfile);
    env.wnd.h = GetPrivateProfileIntA("wnd", "h", env.wnd.h, envfile);

    if (env.wnd.show != SW_SHOWMAXIMIZED &&
        env.wnd.show != SW_SHOWNORMAL)
        env.wnd.show = SW_SHOWNORMAL;
    if (env.wnd.w > env.sm_w)
        env.wnd.w = env.sm_w;
    if (env.wnd.h > env.sm_h)
        env.wnd.h = env.sm_h;
    if (env.wnd.x < 0)
        env.wnd.x = 0;
    if (env.wnd.y < 0)
        env.wnd.y = 0;
    #else // !WIN32
    // tbd
    #endif // WIN32

    return 0;
}

int saveEnv()
{
    #ifdef WIN32
    char val[256];

    snprintf(val, 32, "%d", env.wnd.show);
    WritePrivateProfileStringA("wnd", "show", val, envfile);

    snprintf(val, 32, "%d", env.wnd.x);
    WritePrivateProfileStringA("wnd", "x", val, envfile);

    snprintf(val, 32, "%d", env.wnd.y);
    WritePrivateProfileStringA("wnd", "y", val, envfile);

    snprintf(val, 32, "%d", env.wnd.w);
    WritePrivateProfileStringA("wnd", "w", val, envfile);

    snprintf(val, 32, "%d", env.wnd.h);
    WritePrivateProfileStringA("wnd", "h", val, envfile);
    #else // !WIN32
    // tbd
    #endif // WIN32

    return 0;
}

