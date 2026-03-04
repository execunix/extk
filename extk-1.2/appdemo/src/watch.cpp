//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <stdlib.h>
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
#define FB0DEV_NAME "/dev/fb0"
#define FB1DEV_NAME "/dev/fb1"
#define EV2DEV_NAME "/dev/input/event2"

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

#define APP_FIFO "/tmp/app.fifo"

uint32 WatchApp::on_ev2dev(const epoll_event* ev)
{
    int xy = 0;
    ssize_t rsize;
    uint32 packet_count = 0;
    struct input_event ev2;
    static ExPoint pt0(0, 0);
    static int msg = 0;
    ExPoint pt(pt0);

    exassert(ev->data.fd == ev2dev_fd);
    dprint0("%s: ev2dev_fd=%d\n", __func__, ev2dev_fd);

    while ((rsize = read(ev2dev_fd, &ev2, sizeof(ev2))) > 0) {
        if (rsize != (ssize_t)sizeof(ev2)) {
            dprint("%s: rsize=%d, %s\n", __func__, rsize, exstrerr());
            return 0;
        }
        dprint0("%s: rsize=%d type:%d code:%d value:%d\n", __func__, rsize,
               ev2.type, ev2.code, ev2.value);
        packet_count++;

        if (ev2.type == EV_KEY) {
            if (ev2.code == BTN_TOUCH)
                msg = ev2.value ? WM_LBUTTONDOWN : WM_LBUTTONUP;
        } else if (ev2.type == EV_ABS) {
            if (ev2.code == ABS_X || ev2.code == ABS_MT_POSITION_X) {
                pt.x = ev2.value;
                xy |= 1;
            } else if (ev2.code == ABS_Y || ev2.code == ABS_MT_POSITION_Y) {
                pt.y = ev2.value;
                xy |= 2;
            }
        } else if (ev2.type == EV_SYN || (pt != pt0 && xy == 3)) {
            dprint0("%s.%d: %d - %d,%d\n", __func__, tickCount, msg, pt.x, pt.y);
            EmitTouchEvent(tickCount, msg, pt);
            pt0 = pt;
            xy = 0;
            if (msg == WM_LBUTTONDOWN)
                msg = WM_MOUSEMOVE;
        }
    }
    if (pt != pt0 && xy != 0) { // check broken event
        dprint0("%s.%d: %d - %d,%d\n", __func__, tickCount, msg, pt.x, pt.y);
        EmitTouchEvent(tickCount, msg, pt);
        pt0 = pt;
    }
    return 0U;
}

int WatchApp::cleanup()
{
    int r = 0;

    if (ev2dev_fd) {
        ioDel(ev2dev_fd);
        close(ev2dev_fd);
        ev2dev_fd = 0;
    }
    if (fb1dev_fd) {
        if (munmap(env.fb1_bits, env.fb1_bpl * env.fb1_h) == -1)
            dprint("munmap(fb1_bits) failed.\n");
        close(fb1dev_fd);
        fb1dev_fd = 0;
    }
    if (fb0dev_fd) {
        memset(env.fb0_bits, 0x7f, env.fb0_bpl * env.fb0_h); // fill gray
        if (munmap(env.fb0_bits, env.fb0_bpl * env.fb0_h) == -1)
            dprint("munmap(fb0_bits) failed.\n");
        close(fb0dev_fd);
        fb0dev_fd = 0;
    }

    ioDel(/*stdin*/ 0);

    fini_fifo();

    tid = 0;
    iomuxmap.fini();
    timerset.clearAll();
    if (efd != -1) {
        close(efd);
        efd = -1;
    }
    return r;
}

int WatchApp::startup()
{
    int r = 0;

    exWatchMain = this;
    exWatchLast = this;
    exWatchDisp = this;

    exassert(tid == 0);
    iomuxmap.init(256);

    efd = eventfd(0, 0);
    exassert(efd != -1);
    ioAdd(this, &WatchApp::onEvent, efd);

    tickCount = getTickCount(); // update tick
    env.tch_tick = tickCount;

    tid = pthread_self();

    init_fifo();

    ioAdd(this, &WatchApp::on_cmdline, /*stdin*/0, EPOLLIN);

    fb0dev_fd = open(FB0DEV_NAME, O_RDWR);
    if (fb0dev_fd < 0) {
        fb0dev_fd = 0;
        dprint("open(%s) error\n", FB0DEV_NAME);
    } else {
        struct fb_var_screeninfo vinfo;
        ioctl(fb0dev_fd, FBIOGET_VSCREENINFO, &vinfo);
        env.fb0_w = vinfo.xres;
        env.fb0_h = vinfo.yres;
        env.fb0_bpp = vinfo.bits_per_pixel;
        env.fb0_bpl = env.fb0_bpp * env.fb0_w / 8;
        env.fb0_bits = (uint8*)mmap(0, env.fb0_bpl * env.fb0_h,
                                   PROT_READ | PROT_WRITE, MAP_SHARED, fb0dev_fd, 0);
        dprint("fb0: %dx%dx%dbpp bits=%p\n", env.fb0_w, env.fb0_h, env.fb0_bpp, env.fb0_bits);
        //memset(env.fb0_bits, 0, env.fb0_bpl * env.fb0_h);
    }

    fb1dev_fd = open(FB1DEV_NAME, O_RDWR);
    if (fb1dev_fd < 0) {
        fb1dev_fd = 0;
        dprint("open(%s) error\n", FB1DEV_NAME);
    } else {
        struct fb_var_screeninfo vinfo;
        ioctl(fb1dev_fd, FBIOGET_VSCREENINFO, &vinfo);
        env.fb1_w = vinfo.xres;
        env.fb1_h = vinfo.yres;
        env.fb1_bpp = vinfo.bits_per_pixel;
        env.fb1_bpl = env.fb1_bpp * env.fb1_w / 8;
        env.fb1_bits = (uint8*)mmap(0, env.fb1_bpl * env.fb1_h,
                                    PROT_READ | PROT_WRITE, MAP_SHARED, fb1dev_fd, 0);
        dprint("fb1: %dx%dx%dbpp bits=%p\n", env.fb1_w, env.fb1_h, env.fb1_bpp, env.fb1_bits);
        memset(env.fb1_bits, 0x7f, env.fb1_bpl * env.fb1_h); // fill gray
        #if 0 // api test - ok
        uint8* bits2 = (uint8*)mmap(0, env.fb1_bpl * env.fb1_h,
                                    PROT_READ | PROT_WRITE, MAP_SHARED, fb1dev_fd, 0);
        dprint("fb2: %dx%dx%dbpp bits=%p\n", env.fb1_w, env.fb1_h, env.fb1_bpp, bits2);
        // < test result >
        // fb1: 480x800x32bpp bits=0xfffff1259000
        // fb2: 480x800x32bpp bits=0xfffff10e2000
        #endif
    }

    ev2dev_fd = open(EV2DEV_NAME, O_RDONLY | O_NONBLOCK, 0);
    if (ev2dev_fd < 0) {
        ev2dev_fd = 0;
        dprint("open(%s) error\n", EV2DEV_NAME);
    } else {
        int abs_x[6];
        int abs_y[6];
        ioctl(ev2dev_fd, EVIOCGABS(ABS_X), abs_x);
        ioctl(ev2dev_fd, EVIOCGABS(ABS_Y), abs_y);
        env.abs_x_min = abs_x[1];
        env.abs_x_max = abs_x[2];
        env.abs_y_min = abs_y[1];
        env.abs_y_max = abs_y[2];
        dprint("ABS_X Min:%d Max:%d\n", env.abs_x_min, env.abs_x_max);
        dprint("ABS_Y Min:%d Max:%d\n", env.abs_y_min, env.abs_y_max);
        ioAdd(this, &WatchApp::on_ev2dev, ev2dev_fd);
    }
    env.tch_rotate = 1;
    // env.board_type = 1; // pdu default
    // if (env.abs_x_max > 799 && env.abs_y_max > 479) { // is ft5x06 ?
    //     env.tch_flip_h = 1;
    //     env.tch_flip_v = 0;
    //     env.abs_x_min = 250;
    //     env.abs_x_max = 3750;
    //     env.abs_y_min = 180;
    //     env.abs_y_max = 3800;
    // } else {
    //     env.board_type = 0; // evk
    // }

    return r;
}

int WatchApp::mainloop()
{
    Event& ev = this->event;

    enter();
    while (getHalt() == 0) {
        while (GetMessage(ev) > 0) { // is message available ?
            if (ev.message == WM_QUIT) {
                dprint("WM_QUIT tick=%d\n", tickCount);
                setHalt(Ex_Halt); // stop event loop
                goto halt;
            }
            exWatchDisp->leave();
            //DefWndProc(ev); // dispatch
            exWatchDisp->enter();
            if (getHalt() != 0)
                goto halt;
        }
        int waittick = timerset.invoke(tickCount);
        if (getHalt() != 0)
            break;
        ExApp::collect();
        if (ExApp::mainWnd != NULL)
            ExApp::mainWnd->flush();
        // blocked
        iomuxmap.invoke(waittick);
    }
halt:
    ExApp::collect();
    leave();
    return 0;
}
#endif // __linux__

#if 0
int WatchApp::modal_loop(void* ctrl)
{
    Event& ev = this->event;

    enter();
    while (getHalt() == 0) {
        while (GetMessage(ev) > 0) { // is message available ?
            if (ev.message == WM_CLOSE || ctrl->done) {
                dprint("WM_CLOSE tick=%d\n", tickCount);
                setHalt(Ex_Halt); // stop event loop
                goto halt;
            }
            exWatchDisp->leave();
            DefWndProc(ev); // dispatch
            exWatchDisp->enter();
            if (getHalt() != 0)
                goto halt;
        }
        int waittick = timerset.invoke(tickCount);
        if (getHalt() != 0)
            break;
        ExApp::collect();
        if (ExApp::mainWnd != NULL)
            ExApp::mainWnd->flush();
        // blocked
        iomuxmap.invoke(waittick);
    }
halt:
    ExApp::collect();
    leave();
    return 0;
}
#endif

#ifdef __linux__
uint32 WatchApp::on_cmdline(const epoll_event* ev)
{
    char cmdline[512];

    //dprint("%s\n", __func__);
    if (ev->data.fd != 0) { // fifo
        int n;
        exassert(app_fifo);
        if ((n = read(app_fifo, cmdline, 512)) <= 0) {
            return 0;
        }
        cmdline[n] = 0;
        printf("cmd: %s\n", cmdline);
    } else { // stdin
        char* p;
        if ((p = fgets(cmdline, 512, stdin)) == NULL) {
            return 0;
        }
        printf("app: %s\n", cmdline);
    }

    // parse cmdline
    char* str = strtrim(cmdline, " \t\r\n"); // trim white char...
    if (str && *str) { // is not empty ?
        char* argv[32];
        int32 argc = strsplit(argv, 32, str, ' ');
        exassert(argc > 0);
        #if 1
        //ExCbInfo cbinfo(ev->data.fd, argc, NULL, argv);
        cmdline_callback_list.invoke(&argc, &argv[0]);
        #else // CFLAGS += -fpermissive
        cmdline_callback_list.invoke(ev, &ExCbInfo(ev->data.fd, argc, NULL, argv));
        #endif
    }
    return 0U;
}

int WatchApp::fini_fifo()
{
    if (app_fifo) {
        ioDel(app_fifo);
        close(app_fifo);
        app_fifo = 0;
    }
    remove(APP_FIFO);
    return 0;
}

int WatchApp::init_fifo()
{
    if (mkfifo(APP_FIFO, 0666) != 0) {
        dprint("mkfifo(%s) error\n", APP_FIFO);
        return -1;
    }
    if ((app_fifo = open(APP_FIFO, O_RDONLY | O_NONBLOCK)) < 0) {
        dprint("open(%s) error\n", APP_FIFO);
        app_fifo = 0;
        return -1;
    }

    // this is watch
    this->ioAdd(this, &WatchApp::on_cmdline, app_fifo, EPOLLIN | EPOLLET);

    return 0;
}
#endif // __linux__

WatchApp gWatchApp;

#ifdef __linux__
int
dprint_appinfo(char* mbs, int len)
{
    char buf[32];
    void* tls = NULL;
    if (ExWatch::tls_key && (tls = pthread_getspecific(ExWatch::tls_key))) {
        strncpy(buf, (char*)tls, 31);
        buf[31] = 0;
    } else {
        pthread_t tid = pthread_self();
        snprintf(buf, 32, "%03u", (int)(tid % 1000));
    }
    uint32 tick = ExWatch::getTickCount() - ExWatch::tickAppLaunch;
    return snprintf(mbs, len, "[%4u.%03u:%s] ", tick / 1000, tick % 1000, buf);
}
#endif // __linux__

ExCallbackList cmdline_callback_list;
