//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <stdlib.h>
#include <sys/ioctl.h>
#include <linux/watchdog.h>
#include "watch.h"
#include "wdmgr.h"

#ifdef CONF_ARM
//x
#endif

#ifdef __linux__

int Watchdog::fini()
{
    if (!fd) {
        return -1;
    }
    wdtimer.stop();
    int opt = WDIOS_DISABLECARD;
    if (ioctl(fd, WDIOC_SETOPTIONS, &opt) < 0) {
        printf("wd opt fail. %s\n", exstrerr());
    }
    close(fd);
    fd = 0;
    return 0;
}

int Watchdog::init()
{
    fd = open("/dev/watchdog", O_RDWR);
    if (fd == -1) {
        printf("wd open fail. %s\n", exstrerr());
        fd = 0;
        return -1;
    }
#ifdef _DEBUG
    int tmo = 5000;
#else
    int tmo = 5;
#endif
    if (ioctl(fd, WDIOC_SETTIMEOUT, &tmo) != 0) {
        printf("wd set fail. %s\n", exstrerr());
        return -1;
    }
    wdtimer.init(&gWatchApp, this, &Watchdog::on_alive);
    wdtimer.start(1000, 1000);
    return 0;
}

int Watchdog::keep()
{
    if (!fd) {
        return -1;
    }
    if (ioctl(fd, WDIOC_KEEPALIVE, NULL) < 0) {
        printf("wd keep fail. %s\n", exstrerr());
    }
    return 0;
}

uint32 Watchdog::on_alive(const ExTimer* timer, const ExCbInfo* cbinfo)
{
    keep();
    return Ex_Continue;
}

Watchdog gWatchdog;

#endif // __linux__
