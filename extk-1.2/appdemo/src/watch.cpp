//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <iostream>
#include <exdebug.h>
#ifdef __linux__
#include <linux/fb.h>
#include <linux/input.h>
#include <sys/mman.h>
#endif // __linux__
#include "watch.h"
#include "exapp.h"
#include "env.h"
#include "res.h"

#ifdef __linux__
#ifndef CONF_X11
static const char* const FB0DEV_NAME = "/dev/fb0";
static const char* const EV2DEV_NAME = "/dev/input/event2";
#endif // CONF_X11
static const char* const APP_FIFO = "/tmp/app.fifo";

// WatchDev
//

WatchDev gWatchDev;

// WatchMap
//

WatchMap gWatchMap;

// WatchNet
//

WatchNet gWatchNet;

// WatchApp
//

#ifdef CONF_X11
#else // CONF_X11
uint32 WatchApp::on_ev2dev(const epoll_event* const ev)
{
    static ExMsg em0(None);
    ExMsg em(None);
    uint32 xy = 0U;
    uint32 packet_count = 0U;
    em.message = em0.message;
    em.pt.x = em0.pt.x;
    em.pt.y = em0.pt.y;

    exassert2(ev->data.fd == ev2dev_fd, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    dprint0("%s: ev2dev_fd=%d\n", __func__, ev2dev_fd);

    while (true) {
        ssize_t rsize;
        struct input_event ev2;
        rsize = read(ev2dev_fd, &ev2, sizeof(ev2));
        if (rsize <= 0) {
            break; // no more input
        }
        if (rsize != ssizeof(ev2)) {
            dprint("%s: rsize=%d, %s\n", __func__, rsize, exstrerr());
            goto done; // size error
        }
        dprint0("%s: rsize=%d type:%d code:%d value:%d\n", __func__, rsize, ev2.type, ev2.code, ev2.value);
        packet_count++;

        if (ev2.type == static_cast<uint16>(EV_KEY)) {
            if (ev2.code == static_cast<uint16>(BTN_TOUCH)) {
                if (ev2.value != 0) {
                    em.message = WM_LBUTTONDOWN;
                } else {
                    em.message = WM_LBUTTONUP;
                }
            }
        } else if (ev2.type == static_cast<uint16>(EV_ABS)) {
            if ((ev2.code == static_cast<uint16>(ABS_X)) || (ev2.code == static_cast<uint16>(ABS_MT_POSITION_X))) {
                em.pt.x = ev2.value;
                xy |= 1U;
            } else if ((ev2.code == static_cast<uint16>(ABS_Y)) || (ev2.code == static_cast<uint16>(ABS_MT_POSITION_Y))) {
                em.pt.y = ev2.value;
                xy |= 2U;
            } else {
                // defense code
            }
        } else if ((ev2.type == static_cast<uint16>(EV_SYN)) || (((em.pt.x != em0.pt.x) || (em.pt.y != em0.pt.y)) && (xy == 3U))) {
            dprint0("%s.%d: %d - %d,%d\n", __func__, tickCount, em.message, em.pt.x, em.pt.y);
            (void)EmitPtrEvent(em);
            em0.pt.x = em.pt.x;
            em0.pt.y = em.pt.y;
            xy = 0U;
            if (em.message == WM_LBUTTONDOWN) {
                em.message = WM_MOUSEMOVE;
            }
        } else {
            // defense code
        }
    }

    if (env.is_run_tchcal == 1) {
        touch_ic_overheat_dataset.truncat2(0U);
    } else {
        touch_ic_overheat_dataset.push(packet_count, tickCount);
    }

    if (((em.pt.x != em0.pt.x) || (em.pt.y != em0.pt.y)) && (xy != 0U)) { // check broken event
        dprint0("%s.%d: %d - %d,%d\n", __func__, tickCount, em.message, em.pt.x, em.pt.y);
        (void)EmitPtrEvent(em);
        em0.pt.x = em.pt.x;
        em0.pt.y = em.pt.y;
    }
    em0.message = em.message;
done:
    return 0U;
}
#endif // CONF_X11

bool WatchApp::cleanup()
{
    if (ev2dev_fd > 0) {
        (void)ioDel(ev2dev_fd);
        (void)close(ev2dev_fd);
        ev2dev_fd = 0;
    }
    ExHeapManager<uint8>::deallocate(env.fb1_bits);
    env.fb1_bits = nullptr;
#ifdef CONF_X11
    (void)ExApp::finiX11(this);
#else // CONF_X11
    if (fb0dev_fd > 0) {
        const int32 fb0_fill = static_cast<int32>(0x7F);
        const int32 fb0_size = (env.fb0_bpl * env.fb0_h);
        (void)memset(env.fb0_bits, fb0_fill, static_cast<size_t>(fb0_size)); // fill gray
        if (munmap(env.fb0_bits, static_cast<size_t>(fb0_size)) == -1) {
            dprint("munmap(fb0_bits) failed.\n");
        }
        (void)close(fb0dev_fd);
        fb0dev_fd = 0;
    }
#endif // CONF_X11

    (void)ioDel(STDIN_FILENO);

    fini_fifo();

    tid = 0U;
    iomuxmap.fini();
    timerset.fini();
    evWake.fini();
    return true;
}

bool WatchApp::startup()
{
    int32 r = 0;

    exWatchMain = this;
    exWatchLast = this;
    exWatchDisp = this;

    exassert2(tid == 0U, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    iomuxmap.init(256UL);

    evWake.init();
    (void)ioAdd(this, &WatchApp::onEvent, evWake);

    tickCount = ExGetTickCount(); // update tick

    tid = pthread_self();

    fini_fifo();
    init_fifo();
    open_fifo();

    (void)ioAdd(this, &WatchApp::on_cmdline, STDIN_FILENO, EPOLLIN);

#ifdef CONF_X11
    (void)ExApp::initX11(this);

    env.fb0_w = env.sm_w;
    env.fb0_h = env.sm_h;
#else
    fb0dev_fd = open(FB0DEV_NAME, 2/*O_RDWR*/);
    if (fb0dev_fd < 0) {
        fb0dev_fd = 0;
        dprint("open(%s) error\n", FB0DEV_NAME);
        r = -1;
    } else {
        struct fb_var_screeninfo vinfo;
        (void)ioctl(fb0dev_fd, FBIOGET_VSCREENINFO, &vinfo);
        env.fb0_w = static_cast<int32>(vinfo.xres);
        env.fb0_h = static_cast<int32>(vinfo.yres);
        env.fb0_bpp = static_cast<int32>(vinfo.bits_per_pixel);
        env.fb0_bpl = (env.fb0_bpp * env.fb0_w) / 8;
        const int32 fb0_size = (env.fb0_bpl * env.fb0_h);
        void* const va = mmap(nullptr, static_cast<size_t>(fb0_size),
                              PROT_READ | PROT_WRITE, MAP_SHARED, fb0dev_fd, 0L);
        env.fb0_bits = reinterpret_cast<uint8*>(va);
        dprint("fb0: %dx%dx%dbpp bits=%p\n", env.fb0_w, env.fb0_h, env.fb0_bpp, env.fb0_bits);
        //(void)memset(env.fb0_bits, 0, static_cast<size_t>(fb0_size));
    }
#endif // CONF_X11
    env.fb1_w = 800; // MAP_W;
    env.fb1_h = 480; // MAP_H;
    env.fb1_bpp = 32;
    env.fb1_bpl = (env.fb1_bpp * env.fb1_w) / 8;
    const int32 fb1_size = (env.fb1_bpl * env.fb1_h);
    env.fb1_bits = ExHeapManager<uint8>::allocate(static_cast<size_t>(fb1_size));

#ifdef CONF_X11
    //env.tch_flip_h = 0;
    //env.tch_flip_v = 0;
    env.tch_rotate = 0;
    env.board_type = 0; // evk
    env.abs_x_min = 0;
    env.abs_x_max = env.fb0_w - 1;
    env.abs_y_min = 0;
    env.abs_y_max = env.fb0_h - 1;
#else
    const int32 oflags = (0 + 2048); // (O_RDONLY | O_NONBLOCK)
    ev2dev_fd = open(EV2DEV_NAME, oflags);
    if (ev2dev_fd < 0) {
        ev2dev_fd = 0;
        dprint("open(%s) error\n", EV2DEV_NAME);
        r = -1;
    } else {
        int32 ev_abs_x[6];
        int32 ev_abs_y[6];
        (void)ioctl(ev2dev_fd, EVIOCGABS(ABS_X), &ev_abs_x[0]);
        (void)ioctl(ev2dev_fd, EVIOCGABS(ABS_Y), &ev_abs_y[0]);
        env.abs_x_min = ev_abs_x[1];
        env.abs_x_max = ev_abs_x[2];
        env.abs_y_min = ev_abs_y[1];
        env.abs_y_max = ev_abs_y[2];
        dprint("ABS_X Min:%d Max:%d\n", env.abs_x_min, env.abs_x_max);
        dprint("ABS_Y Min:%d Max:%d\n", env.abs_y_min, env.abs_y_max);
        (void)ioAdd(this, &WatchApp::on_ev2dev, ev2dev_fd);
    }
    env.tch_rotate = 1;
    env.board_type = 1; // pdu default
    if ((env.abs_x_max > 799) && (env.abs_y_max > 479)) { // is ft5x06 ?
        env.tch_flip_h = 1;
        env.tch_flip_v = 0;
        env.abs_x_min = 250;
        env.abs_x_max = 3750;
        env.abs_y_min = 180;
        env.abs_y_max = 3800;
    } else {
        env.board_type = 0; // evk
    }
#endif // CONF_X11
    return (r == 0);
}
#else // WIN32
bool WatchApp::cleanup()
{
    idThread = 0U;
    iomuxmap.fini();
    timerset.fini();
    evWake.fini();
    return true;
}

bool WatchApp::startup()
{
    int32 r = 0;

    exWatchMain = this;
    exWatchLast = this;
    exWatchDisp = this;

    exassert2(idThread == 0U, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    iomuxmap.init(256UL);

    evWake.init();
    (void)ioAdd((ExWatch*)this, &ExWatch::onEvent, evWake);

    tickCount = ExGetTickCount(); // update tick

    idThread = GetCurrentThreadId();

    return (r == 0);
}
#endif // __linux__

#ifdef __linux__
uint32 WatchApp::on_cmdline(const epoll_event* const ev)
{
    const char* prompt = "app";
    char cmdline[512];
    char* str;

    //dprint("%s\n", __func__);
    if (ev->data.fd != 0) { // fifo
        ssize_t n;
        exassert2(app_fifo > 0, __FILE__ "@" Ex_STRINGIFY(__LINE__));
        n = read(app_fifo, &cmdline[0], 511UL);
        if (n <= 0) {
            goto done;
        }
        cmdline[n] = '\0';
        prompt = "cmd";
    } else { // stdin
        (void)std::cin.getline(&cmdline[0], 512);
        if (!std::cin.good()) {
            goto done;
        }
    }

    // parse cmdline
    str = strtrim(&cmdline[0], " \t\r\n"); // trim white char...
#if 1
    static char cmd_bk[512] = "help";
    if (*str == '\0') { // is empty ?
        (void)exstrcpy(&cmdline[0], &cmd_bk[0]); // use previous command
        str = &cmdline[0];
    } else {
        (void)exstrcpy(&cmd_bk[0], &str[0]); // backup command
    }
#endif
    dprint("%s: %s\n", prompt, str);
    if (*str != '\0') { // is not empty ?
        char* argv[32];
        int32 argc = strsplit(argv, 32, str, ' ');
        exassert(argc > 0);
        cmdline_callback_list.invoke(&argc, &argv[0]);
    }
done:
    ev_serial++;
    return 0U;
}

void WatchApp::fini_fifo()
{
    if (app_fifo > 0) {
        (void)ioDel(app_fifo);
        (void)close(app_fifo);
        app_fifo = 0;
    }
    (void)unlink(APP_FIFO);
}

void WatchApp::init_fifo()
{
    if (mkfifo(APP_FIFO, 0b110110110U/*rw-rw-rw*/) != 0) {
        dprint("mkfifo(%s) error\n", APP_FIFO);
        app_fifo = 0;
    }
}

void WatchApp::open_fifo()
{
    const int32 oflags = (O_RDONLY | O_NONBLOCK);
    app_fifo = open(APP_FIFO, oflags);
    if (app_fifo != -1) {
        // this is watch
        (void)this->ioAdd(this, &WatchApp::on_cmdline, app_fifo, (EPOLLIN | EPOLLET));
    } else {
        dprint("open(%s) error\n", APP_FIFO);
        app_fifo = 0;
    }
}
#endif // __linux__

WatchApp gWatchApp;

int32 dprint_appinfo(char* const mbs, const int32 len)
{
    char buf[32];
    const ExWatch* const watch = ExWatch::getTlsSpecific();
    const char* name = (watch != nullptr) ? watch->name : nullptr;
    if (name == nullptr) {
        uint32 tid;
#ifdef __linux__
        tid = (uint32)pthread_self();
#else
        tid = (uint32)GetCurrentThreadId();
#endif // __linux__
        (void)snprintf(&buf[0], 32UL, "%03u", static_cast<uint32>(tid % 1000UL));
        name = buf;
    }
    const uint32 tick = static_cast<uint32>(ExGetTickCount() - ExWatch::tickAppLaunch);
    return snprintf(mbs, static_cast<size_t>(len), "[%4u.%03u:%s] ", tick / 1000U, tick % 1000U, name);
}

ExCallbackList cmdline_callback_list;
