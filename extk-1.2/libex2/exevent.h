/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"
#ifdef __linux__
#include <pthread.h>
#endif // __linux__

class ExEvent {
protected:
    #ifdef WIN32
    HANDLE          hev;    // handle event
    #endif // WIN32
    #ifdef __linux__
    int32           efd;    // event fd
    #endif // __linux__
    mutable uint64  u64;
public:
    ~ExEvent() noexcept { fini(); }
    #ifdef WIN32
    explicit ExEvent() noexcept : hev(nullptr), u64(0UL) {}
    operator HANDLE () const { return hev; }
    #endif // WIN32
    #ifdef __linux__
    explicit ExEvent() noexcept : efd(-1), u64(0UL) {}
    operator int32 () const { return efd; }
    #endif // __linux__
public:
    void fini() noexcept;
    bool init() noexcept;
    bool reset() const { return getEvent(&u64); };
    bool signal() const { return setEvent(1UL); };
    bool getEvent(uint64* u64 = nullptr) const;
    bool setEvent(uint64 u64 = 1UL) const;
    bool isSignaled() const;
public:
    friend class ExWatch;
};

class ExMutex {
protected:
    #ifdef WIN32
    mutable HANDLE          mutex;
    mutable DWORD           owner;
    #endif // WIN32
    #ifdef __linux__
    mutable pthread_mutex_t mutex;
    mutable pthread_cond_t  cond;
    mutable pthread_t       owner;
    #endif // __linux__
    mutable uint32          recurs;
public:
    #ifdef WIN32
    ~ExMutex() noexcept {
        CloseHandle(mutex);
    }
    explicit ExMutex() noexcept : mutex(nullptr), owner(0U), recurs(0U) {
        mutex = CreateMutex(nullptr, FALSE, nullptr);
    }
    #endif // WIN32
    #ifdef __linux__
    ~ExMutex() noexcept {
        (void)pthread_cond_destroy(&cond);
        (void)pthread_mutex_destroy(&mutex);
    }
    explicit ExMutex() noexcept : mutex(), cond(), owner(0U), recurs(0U) {
        (void)pthread_mutex_init(&mutex, nullptr);
        (void)pthread_cond_init(&cond, nullptr);
    }
    #endif // __linux__
    bool isowner() const noexcept;
    bool unlock() const noexcept;
    bool lock() const noexcept;
public:
    friend class ExWatch;
};

class ExAutoLock {
    const ExMutex& mutex;
public:
    ~ExAutoLock() noexcept {
        (void)mutex.unlock();
    }
    explicit ExAutoLock(const ExMutex& mutex) noexcept : mutex(mutex) {
        (void)mutex.lock();
    }
    // prevent copy
    ExAutoLock(const ExAutoLock&) = delete;
    ExAutoLock& operator = (const ExAutoLock&) = delete;
};

#endif//__exevent_h__
