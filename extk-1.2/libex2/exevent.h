/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"
#ifdef __linux__
#include <sys/eventfd.h>
#include <sys/epoll.h>
#include <pthread.h>
#endif

class ExEvent {
protected:
    #ifdef WIN32
    HANDLE          hev;    // handle event
    #else // __linux__
    int32           efd;    // event fd
    #endif
    mutable uint64  u64;
public:
    ~ExEvent() noexcept { (void)fini(); }
    #ifdef WIN32
    explicit ExEvent() noexcept : hev(nullptr), u64(0UL) {}
    operator HANDLE () const { return hev; }
    #else // __linux__
    explicit ExEvent() noexcept : efd(-1), u64(0UL) {}
    operator int32 () const { return efd; }
    #endif
    bool fini() noexcept;
    bool init() noexcept;
    bool reset() const { return getEvent(&u64); };
    bool signal() const { return setEvent(1UL); };
    bool getEvent(uint64* u64 = nullptr) const;
    bool setEvent(uint64 u64 = 1UL) const;
    bool isSignaled() const;
};

#endif//__exevent_h__
