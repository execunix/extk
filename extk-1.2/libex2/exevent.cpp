/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"

#ifdef WIN32

bool ExEvent::fini() noexcept {
    BOOL r = TRUE;
    if (hev != nullptr) {
        r = CloseHandle(hev);
        hev = nullptr;
    }
    return (r != FALSE);
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
    return (WaitForSingleObject(hev, 0U) != WAIT_TIMEOUT);
}

#else // __linux__

bool ExEvent::fini() noexcept {
    int32 r = 0;
    if (efd != -1) {
        r = close(efd);
        efd = -1;
    }
    return (r == 0);
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

#endif
