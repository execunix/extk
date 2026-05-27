/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"
#ifdef __linux__
#include <sys/epoll.h>
#include <pthread.h>
#endif // __linux__

class ExEvent {
protected:
    #ifdef WIN32
    HANDLE          hev;    // handle event
    #else // __linux__
    int32           efd;    // event fd
    #endif // __linux__
    mutable uint64  u64;
public:
    ~ExEvent() noexcept { (void)fini(); }
    #ifdef WIN32
    explicit ExEvent() noexcept : hev(nullptr), u64(0UL) {}
    operator HANDLE () const { return hev; }
    #else // __linux__
    explicit ExEvent() noexcept : efd(-1), u64(0UL) {}
    operator int32 () const { return efd; }
    #endif // __linux__
    bool fini() noexcept;
    bool init() noexcept;
    bool reset() const { return getEvent(&u64); };
    bool signal() const { return setEvent(1UL); };
    bool getEvent(uint64* u64 = nullptr) const;
    bool setEvent(uint64 u64 = 1UL) const;
    bool isSignaled() const;
};

class ExMutex {
protected:
    #ifdef WIN32
    mutable HANDLE  mutex;
    #else // __linux__
    mutable pthread_mutex_t mutex;
    #endif // __linux__
public:
    #ifdef WIN32
    ~ExMutex() noexcept {
        CloseHandle(mutex);
    }
    explicit ExMutex() noexcept : mutex(nullptr) {
        mutex = CreateMutex(nullptr, FALSE, nullptr);
    }
    bool lock() const noexcept;
    bool unlock() const noexcept {
        return (FALSE != ReleaseMutex(mutex));
    }
    operator HANDLE () const { return mutex; }
    #else // __linux__
    ~ExMutex() noexcept {
        pthread_mutex_destroy(&mutex);
    }
    explicit ExMutex() noexcept : mutex() {
        pthread_mutex_init(&mutex, nullptr);
    }
    bool lock() const noexcept {
        return (0 == pthread_mutex_lock(&mutex));
    }
    bool unlock() const noexcept {
        return (0 == pthread_mutex_unlock(&mutex));
    }
    #endif // __linux__
};

#if 0 // deprecated
class ExAutoLock {
protected:
    const ExMutex& mutex;
public:
    ~ExAutoLock() noexcept { mutex.unlock(); }
    explicit ExAutoLock(const ExMutex& mutex) noexcept : mutex(mutex) {
        mutex.lock();
    }
};
#endif

#endif//__exevent_h__
