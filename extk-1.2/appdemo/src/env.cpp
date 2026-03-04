//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "osal/osal.h"
#include <stdio.h>
#include <fstream>
#include "env.h"

Env env;

bool initEnv() noexcept
{
    #ifdef __linux__
    if (getcwd(&env.cwd[0], 64UL) != nullptr) {
        dprint("cwd: %s\n", &env.cwd[0]);
    }
    #endif // __linux__
    #ifdef WIN32
    env.sm_w = GetSystemMetrics(SM_CXSCREEN);
    env.sm_h = GetSystemMetrics(SM_CYSCREEN);
    env.wnd.show = SW_SHOWNORMAL;
    env.wnd.x = CW_USEDEFAULT;
    env.wnd.y = CW_USEDEFAULT;
    #else // !WIN32
    env.sm_w = 1920;
    env.sm_h = 1080;
    #endif // WIN32

    #ifdef CONF_X11
    (void)memset(&env.wm_atom[0], 0, sizeof(env.wm_atom));
    env.display = nullptr;
    env.visual = nullptr;
    env.screen = 0;
    env.depth = 0;
    env.root = None;
    env.top = None;
    env.ximg = nullptr;
    #endif

    env.fb0_w = 0;
    env.fb0_h = 0;
    env.fb0_bpp = 0;
    env.fb0_bpl = 0;
    env.fb0_bits = nullptr;
    env.fb0_rotate = 270;

    env.fb1_w = 0;
    env.fb1_h = 0;
    env.fb1_bpp = 0;
    env.fb1_bpl = 0;
    env.fb1_bits = nullptr;

    env.abs_x_min = 0;
    env.abs_x_max = 799;
    env.abs_y_min = 0;
    env.abs_y_max = 479;

    env.rel_x_min = 0;
    env.rel_x_max = 0;
    env.rel_y_min = 0;
    env.rel_y_max = 0;

    env.tch_tick = 0U;
    env.tch_flip_h = 0;
    env.tch_flip_v = 1;
    env.tch_rotate = 0;
    env.wnd.show = 1;
    env.wnd.x = 5;
    env.wnd.y = 5;
    env.wnd.w = 1280;
    env.wnd.h = 720;

    env.dp_bit = 9;
    env.dp_gps = 5;
    env.dp_isr = 999;
    env.dp_pkt = 3;

    (void)loadEnv();

    return true;
}

bool loadEnv(const char* const envfile) noexcept
{
    bool ret = false;
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
    std::ifstream fp;

    fp.open(envfile);
    if (fp.fail()) {
        dprint("ifstream(%s) fail. %s\n", envfile, exstrerr());
        goto fp_fail;
    }
    while (true) {
        char line[256];
        (void)fp.getline(&line[0], 256);
        if (!fp.good()) { // good is !(bad|eof|fail)
            #if 0 // for debug
            if (!fp.eof()) {
                dprint1("%s - warning: expect eof but...\n", __func__);
            }
            #endif
            break;
        }
        exassert2(fp.gcount() > 0, __FILE__ "@" Ex_STRINGIFY(__LINE__)); // Signed integral type
        char* const str = strtrim(&line[0], " \t\r\n"); // trim white char...
        exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
        char* tocken[32];
        const size_t cnt = strsplit(tocken, 32, str, '=');
        if (cnt == 2UL) {
            const char* const key = strtrim(tocken[0], " ='\"\t\r\n");
            const char* const val = strtrim(tocken[1], " ='\"\t\r\n");
            exassert2(val != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
            if (0 == exstrcmp(key, "wnd.show")) {
                env.wnd.show = atoi32(val);
            }
            else if (0 == exstrcmp(key, "wnd.x")) {
                env.wnd.x = atoi32(val);
            }
            else if (0 == exstrcmp(key, "wnd.y")) {
                env.wnd.y = atoi32(val);
            }
            else if (0 == exstrcmp(key, "wnd.w")) {
                env.wnd.w = atoi32(val);
            }
            else if (0 == exstrcmp(key, "wnd.h")) {
                env.wnd.h = atoi32(val);
            }
            else if (0 == exstrcmp(key, "dp_bit")) {
                env.dp_bit = atoi32(val);
            }
            else if (0 == exstrcmp(key, "dp_gps")) {
                env.dp_gps = atoi32(val);
            }
            else if (0 == exstrcmp(key, "dp_isr")) {
                env.dp_isr = atoi32(val);
            }
            else if (0 == exstrcmp(key, "dp_pkt")) {
                env.dp_pkt = atoi32(val);
            }
            else if (0 == exstrcmp(key, "fb0_rotate")) {
                env.fb0_rotate = atoi32(val);
            }
            else if (0 == exstrcmp(key, "tch_rotate")) {
                env.tch_rotate = atoi32(val);
            }
            else if (0 == exstrcmp(key, "tch_flip_h")) {
                env.tch_flip_h = atoi32(val);
            }
            else if (0 == exstrcmp(key, "tch_flip_v")) {
                env.tch_flip_v = atoi32(val);
            }
            else {
                // defense code
            }
        }
    }
    fp.close();
    #endif // WIN32

    ret = true;
fp_fail:
    return ret;
}

bool saveEnv(const char* const envfile) noexcept
{
    #ifdef WIN32
    char val[256];
    bool ret = false;

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
    int32 n;
    char line[256];
    bool ret = false;
    std::ofstream fp;

    fp.open(envfile);
    if (fp.fail()) {
        dprint("ofstream(%s) fail. %s\n", envfile, exstrerr());
        goto fp_fail;
    }
    n = snprintf(&line[0], 256UL, "%s=%d\n", "dp_bit", env.dp_bit);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "dp_gps", env.dp_gps);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "dp_isr", env.dp_isr);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "dp_pkt", env.dp_pkt);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "fb0_rotate", env.fb0_rotate);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "tch_rotate", env.tch_rotate);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "tch_flip_h", env.tch_flip_h);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "tch_flip_v", env.tch_flip_v);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "wnd.show", env.wnd.show);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "wnd.x", env.wnd.x);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "wnd.y", env.wnd.y);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "wnd.w", env.wnd.w);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));
    n = snprintf(&line[0], 256UL, "%s=%d\n", "wnd.h", env.wnd.h);
    (void)fp.write(&line[0], static_cast<std::streamsize>(n));

    (void)fp.flush();
    fp.close();
    #endif // WIN32

    ret = true;
fp_fail:
    return ret;
}

