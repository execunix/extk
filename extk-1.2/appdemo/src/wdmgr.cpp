//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <exdebug.h>
#ifdef __linux__
#include <sys/ioctl.h>
#include <linux/watchdog.h>
#endif // __linux__
#include "watch.h"
#include "wdmgr.h"

#ifdef CONF_ARM
//x
#endif

#ifdef __linux__

bool Watchdog::fini() noexcept
{
    bool bRet = false;
    if (fd != 0) {
        wdtimer.stop();
        int32 opt = WDIOS_DISABLECARD;
        if (ioctl(fd, WDIOC_SETOPTIONS, &opt) < 0) {
            dprint("wd opt fail. %s\n", exstrerr());
        }
        (void)close(fd);
        fd = 0;
        bRet = true;
    }
    return bRet;
}

bool Watchdog::init() noexcept
{
    bool bRet = false;
    fd = open("/dev/watchdog", O_RDWR);
    if (fd == -1) {
        dprint("wd open fail. %s\n", exstrerr());
        fd = 0;
    } else {
#ifdef _DEBUG
        int32 tmo = 5000;
#else
        int32 tmo = 5;
#endif
        if (ioctl(fd, WDIOC_SETTIMEOUT, &tmo) != 0) {
            dprint("wd set fail. %s\n", exstrerr());
        } else {
            wdtimer.init(&gWatchDev, this, &Watchdog::on_alive);
            wdtimer.start(1000U, 1000U);
            bRet = true;
        }
    }
    return bRet;
}

bool Watchdog::keep()
{
    bool bRet = false;
    if (fd != 0) {
        if (ioctl(fd, WDIOC_KEEPALIVE, nullptr) < 0) {
            dprint("wd keep fail. %s\n", exstrerr());
        } else {
            bRet = true;
        }
    }
    callback_serial++;
    return bRet;
}

uint32 Watchdog::on_alive(const ExTimer* const /*timer*/, const ExCbInfo* const /*cbinfo*/)
{
    (void)keep();
    return Ex_Continue;
}

Watchdog gWatchdog;

#endif // __linux__
