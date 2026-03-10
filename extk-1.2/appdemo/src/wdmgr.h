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
private:
    int32 fd;
    ExTimer wdtimer;
    int32 callback_serial; // for misra rules
public:
    ~Watchdog() noexcept { (void)fini(); }
    Watchdog() noexcept : fd(0), wdtimer(), callback_serial(0) {}
public:
    bool fini() noexcept;
    bool init() noexcept;
    bool keep();
    uint32 on_alive(const ExTimer* const timer, const ExCbInfo* const cbinfo);
};

extern Watchdog gWatchdog;

#endif // __linux__

#endif // _wdmgr_h_
