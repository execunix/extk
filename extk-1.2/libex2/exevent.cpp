/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#ifdef __linux__
#include <sys/eventfd.h>
#endif // __linux__

#ifdef WIN32
void ExEvent::fini() noexcept {
    if (hev != nullptr) {
        (void)CloseHandle(hev);
        hev = nullptr;
    }
}

bool ExEvent::init() noexcept {
    exassert(hev == nullptr);
    hev = CreateEvent(nullptr, TRUE, FALSE, nullptr); // manual reset, non-signaled
    exassert(hev != nullptr);
    return (hev != nullptr);
}

bool ExEvent::getEvent(uint64* u64) const {
    if (u64 != nullptr) {
        *u64 = this->u64;
    }
    exassert(hev != nullptr);
    BOOL r = ResetEvent(hev);
    exassert(r != FALSE);
    this->u64 = 0UL; // reset
    return (r != FALSE);
}

bool ExEvent::setEvent(uint64 u64) const {
    this->u64 += u64;
    exassert(hev != nullptr);
    BOOL r = SetEvent(hev);
    exassert(r != FALSE);
    return (r != FALSE);
}

bool ExEvent::isSignaled() const {
    return (WAIT_OBJECT_0 == WaitForSingleObject(hev, 0U));
}
#endif // WIN32

#ifdef __linux__
void ExEvent::fini() noexcept {
    if (efd != -1) {
        (void)close(efd);
        efd = -1;
    }
}

bool ExEvent::init() noexcept {
    exassert(efd == -1);
    efd = eventfd(0U, EFD_CLOEXEC);
    exassert(efd != -1);
    return (efd != -1);
}

bool ExEvent::getEvent(uint64* u64) const {
    ssize_t r = 0;
    if (u64 == nullptr) {
        u64 = &this->u64;
    }
    exassert(efd != -1);
    r = read(efd, u64, sizeof(uint64));
    exassert(r == ssizeof(*u64));
    this->u64 = 0UL; // reset
    return (r == ssizeof(*u64));
}

bool ExEvent::setEvent(uint64 u64) const {
    ssize_t r = 0;
    this->u64 += u64;
    exassert(efd != -1);
    r = write(efd, &u64, sizeof(uint64));
    exassert(r == ssizeof(u64));
    return (r == ssizeof(u64));
}

bool ExEvent::isSignaled() const {
    return (this->u64 != 0UL); // tbd - check eventfd state
}
#endif // __linux__

#ifdef WIN32
bool ExMutex::isowner() const noexcept {
    return (owner == GetCurrentThreadId());
}

bool ExMutex::unlock() const noexcept {
    DWORD self = GetCurrentThreadId();
    if (owner != self) {
        dprint1("ExMutex::unlock() invalid owner:%zu recurs:%u\n",
                (size_t)owner, recurs);
        exassert2(owner != self, _fileline_); // trap
        return false;
    }
    recurs--;
    if (recurs == 0U) {
        owner = 0U;
    }
    return (FALSE != ReleaseMutex(mutex));
}

bool ExMutex::lock() const noexcept {
    DWORD self = GetCurrentThreadId();
    if (owner == self) { // already locked
        WaitForSingleObject(mutex, INFINITE); // sync kernel recurs
        recurs++;
        return true;
    }
    #ifdef DEBUG
    DWORD dwWaitRet;
    for (int32 i = 0; i < 1000; i++) {
        dwWaitRet = WaitForSingleObject(mutex, 1U);
        if (WAIT_OBJECT_0 == dwWaitRet) {
            owner = self;
            recurs++;
            break;
        }
        if (dwWaitRet != WAIT_TIMEOUT) {
            dprint1("ExMutex::lock() err#%d:%s\n", dwWaitRet, "WAIT_FAILED");
        }
    }
    if (WAIT_OBJECT_0 == dwWaitRet) {
        return true;
    }
    dprint1("ExMutex::lock() %s TID:%p err#%d:%s\n", "detect deadlock", self,
            dwWaitRet, dwWaitRet == WAIT_TIMEOUT ? "WAIT_TIMEOUT" : "WAIT_FAILED");
    exassert2(WAIT_OBJECT_0 != dwWaitRet, _fileline_); // trap
    #else
    if (WAIT_OBJECT_0 == WaitForSingleObject(mutex, INFINITE)) {
        owner = self;
        recurs++;
        return true;
    }
    #endif
    return false;
}
#endif // WIN32
#ifdef __linux__
bool ExMutex::isowner() const noexcept {
    return ((recurs > 0U) && (0 != pthread_equal(owner, pthread_self())));
}

bool ExMutex::unlock() const noexcept {
    pthread_mutex_lock(&mutex);
    if ((recurs == 0U) || (0 == pthread_equal(owner, pthread_self()))) {
        dprint1("ExMutex::unlock() invalid owner:%zu recurs:%u\n",
                (size_t)owner, recurs);
        exassert2(recurs == 0U, _fileline_); // trap
    } else {
        recurs--;
        if (recurs == 0U) {
            owner = (pthread_t)0U;
            pthread_cond_signal(&cond); // wakeup other thread
        }
    }
    return (0 == pthread_mutex_unlock(&mutex));
}

bool ExMutex::lock() const noexcept {
    int32 r;
    pthread_t self = pthread_self();
    #ifdef DEBUG
    for (int32 i = 0; i < 1000; i++) {
        r = pthread_mutex_trylock(&mutex);
        if (r == 0) {
            break;
        }
        (void)usleep(1000U);
    }
    if (r != 0) {
        dprint1("ExMutex::lock() %s TID:%p err#%d:%s\n",
                "detect deadlock", self, r, exstrerr());
        exassert2(r != 0, _fileline_); // trap
    }
    #else
    r = pthread_mutex_lock(&mutex);
    #endif
    if ((recurs > 0U) && pthread_equal(owner, self)) {
        recurs++;
    } else { // owner is other thread
        while (recurs > 0U) { // wait unlock
            pthread_cond_wait(&cond, &mutex);
            // tbd - detect deadlock as pthread_cond_timedwait
        }
        owner = self;
        recurs = 1U;
    }
    pthread_mutex_unlock(&mutex);
    return (r == 0);
}
#endif // __linux__
