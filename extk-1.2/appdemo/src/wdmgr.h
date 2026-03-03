//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _wdmgr_h_
#define _wdmgr_h_

#include <exdebug.h>
#include <extimer.h>

#ifdef __linux__

class Watchdog {
protected:
    int32 fd;
    ExTimer wdtimer;
public:
    ~Watchdog() { fini(); }
    Watchdog() : fd(0), wdtimer() {}
public:
    int fini();
    int init();
    int keep();
    uint32 on_alive(const ExTimer* timer, const ExCbInfo* cbinfo);
};

extern Watchdog gWatchdog;

#endif // __linux__

#endif // _wdmgr_h_
