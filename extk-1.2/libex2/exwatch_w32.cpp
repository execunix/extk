/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "extimer.h"

#ifdef WIN32

#define EVENTPROC_HAVETHREAD

uint64 ExGetMonoClock() {
    LARGE_INTEGER freq, tick;
    QueryPerformanceFrequency(&freq);
    QueryPerformanceCounter(&tick);
    double usec = 1000000.0;
    usec *= static_cast<double>(tick.QuadPart);
    usec /= static_cast<double>(freq.QuadPart);
    return static_cast<uint64>(usec);
}

uint32 ExGetTickCount() {
    uint32 msec;
    msec = GetTickCount();
    return msec;
}

// Iomux
//
void ExWatch::IomuxMap::fini() {
    dirty = 0;
    clear();
}

void ExWatch::IomuxMap::init(size_t max) {
    max = max; // compat linux
}

DWORD ExWatch::IomuxMap::setup() {
    size_t ret = size();
    if (dirty) {
        dirty = 0;
        int32 cnt = 0U;
        for (const_iterator i = begin(); i != end(); ++i) {
            const Iomux& iomux = i->second;
            handles[cnt++] = iomux.mux_fd;
        }
        exassert(cnt < MAXIMUM_WAIT_OBJECTS);
    }
    return static_cast<DWORD>(ret);
}

const ExWatch::Iomux* ExWatch::IomuxMap::search(HANDLE mux_fd) const {
    const Iomux* iomux = nullptr;
    const_iterator i = find(mux_fd);
    if (i != end()) {
        iomux = &i->second;
    }
    return iomux;
}

uint32 ExWatch::IomuxMap::probe(const ExCallback& callback, void* cbinfo) {
    uint32 r = Ex_Continue;
    for (iterator i = begin(); i != end(); ++i) {
        Iomux* iomux = &i->second;
        r = callback(iomux, cbinfo);
        if (r != Ex_Continue) {
            break;
        }
    }
    return r;
}

bool ExWatch::IomuxMap::add(HANDLE mux_fd, const ExNotify& notify) {
    int32 r = -1;
    if (size() < MAXIMUM_WAIT_OBJECTS) {
        Iomux* iomux = nullptr;
        std::pair<iterator, bool> pr;
        pr = insert(value_type(mux_fd, Iomux(mux_fd)));
        iomux = &pr.first->second;
        if (pr.second == false) {
            dprint1("IomuxMap::add: duplicate mux_fd:%zu\n", (size_t)mux_fd);
        }
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        dirty++;
        r = 0;
    } else {
        dprint1("IomuxMap::add: size:%zu\n", size());
    }
    return (r == 0);
}

bool ExWatch::IomuxMap::mod(HANDLE mux_fd, const ExNotify& notify) {
    int32 r = -1;
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        r = 0;
    } else {
        dprint1("IomuxMap::mod: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    return (r == 0);
}

bool ExWatch::IomuxMap::del(HANDLE mux_fd) {
    int32 r = -1;
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        erase(i);
        dirty++;
        r = 0;
    } else {
        dprint1("IomuxMap::del: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    return (r == 0);
}

uint32 ExWatch::IomuxMap::invoke(uint32 waittick) {
    DWORD nCount = setup();
    LPHANDLE pHandles = handles;
    DWORD dwMilliseconds = waittick;//INFINITE;
    DWORD dwWaitRet; // signaled number

    watch->leave();
    //Sleep(1);
#if defined(EVENTPROC_HAVETHREAD)
    dwWaitRet = WaitForMultipleObjects(nCount, pHandles, FALSE, dwMilliseconds);
#else
    DWORD dwWakeMask = QS_ALLEVENTS;//QS_ALLINPUT;
    DWORD dwFlags = MWMO_INPUTAVAILABLE;
    dwWaitRet = MsgWaitForMultipleObjectsEx(nCount, pHandles,
                                            dwMilliseconds, dwWakeMask, dwFlags);
#endif
    watch->enter();
    watch->tickCount = GetTickCount(); // update tick

    if (dwWaitRet == WAIT_TIMEOUT) {
        dprint0("IomuxMap: nCount=%d WAIT_TIMEOUT\n", nCount);
        return 0U; // no messages are available
    }
#if !defined(EVENTPROC_HAVETHREAD)
    if (dwWaitRet == WAIT_OBJECT_0 + nCount) {
        dprint0("IomuxMap: nCount=%d GOT_GWES_MSG\n", nCount);
        return 1U; // got message from gwes
    }
#endif
    if ((dwWaitRet >= WAIT_OBJECT_0) &&
        (dwWaitRet < (WAIT_OBJECT_0 + nCount))) {
        dprint("IomuxMap: dwWaitRet=%p nCount=%d\n", dwWaitRet, nCount);
        uint32 cnt = 0U;
        for (DWORD n = 0U; n < nCount; n++) {
            const Iomux* iomux = search(pHandles[n]);
            if (iomux == nullptr) { // is removed ?
                dprint("IomuxMap: mux_fd:%p removed\n", iomux->mux_fd);
                continue; // discard
            }
            // check mux_fd is signaled
            if ((n != (dwWaitRet - WAIT_OBJECT_0)) &&
                (WaitForSingleObject(iomux->mux_fd, 0U) != WAIT_OBJECT_0)) {
                continue; // not signaled
            }
            // proc iomux handler
            exassert(iomux->notify.func);
            uint32 r = iomux->notify(iomux->mux_fd);
            if ((r & Ex_Halt) != 0U) {
                return watch->setHalt(r);
            }
            if ((r & Ex_Remove) != 0U) {
                del(iomux->mux_fd);
                dirty++;
            }
            cnt++;
        }
        return cnt; // got input signal
    }
    exerror("IomuxMap: dwWaitRet:%p GetLastError:0x%p\n", dwWaitRet, GetLastError());
    return 0U; // error
}

// Watch thread
//
uint32 ExWatch::tickAppLaunch = ExGetTickCount();

DWORD ExWatch::tls_key = TLS_OUT_OF_INDEXES;

void ExWatch::tls_specific(const char* name)
{
    if (tls_key == TLS_OUT_OF_INDEXES) {
        tls_key = TlsAlloc();
    }
    exassert(tls_key != TLS_OUT_OF_INDEXES);
    exassert(TlsGetValue(tls_key) == nullptr);
    LPVOID key_name = strdup(name);
    TlsSetValue(tls_key, key_name);
}

DWORD WINAPI ExWatch::start(_In_ LPVOID arg) {
    ExWatch* watch = (ExWatch*)arg;
    uint32 r = watch->proc();
    exassert(r == 0U);
    return 0U;
}

bool ExWatch::fini() {
    int32 r = 0;
    idThread = 0U;
    if (hThread != nullptr) {
        setHalt(Ex_Halt);
        leave();
        if (WaitForSingleObject(hThread, INFINITE) == WAIT_FAILED) {
            exerror("%s - WaitForSingleObject fail.\n", __func__);
            r -= 1;
        }
        enter();
        if (CloseHandle(hThread) == 0) {
            exerror("%s - CloseHandle fail.\n", __func__);
            r -= 1;
        }
        hThread = nullptr;
    }
    iomuxmap.fini();
    timerset.fini();
    if (efd != nullptr) {
        CloseHandle(efd);
        efd = nullptr;
    }
    return (r == 0);
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    exassert(hThread == nullptr);
    iomuxmap.init(max_iomux);

    efd = CreateEvent(nullptr, FALSE, FALSE, nullptr); // hev
    exassert(efd != nullptr);
    ioAdd(this, &ExWatch::onEvent, efd);

    tickCount = GetTickCount(); // update tick

    hThread = CreateThread(nullptr, stacksize, start, this, 0, &idThread);
    dprint1("CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    exassert(hThread != nullptr);

    return (hThread != nullptr);
}

bool ExWatch::enter() const {
    DWORD dwWaitRet;
#ifdef DEBUG
    for (int32 i = 0; i < 100; i++) {
        dwWaitRet = WaitForSingleObject(mutex, 3000);
        if (dwWaitRet == WAIT_OBJECT_0) {
            break;
        }
        exerror("ExWatch::enter(TID=%p) %s %d\n", GetCurrentThreadId(),
                dwWaitRet == WAIT_TIMEOUT ? "WAIT_TIMEOUT" : "WAIT_FAILED", i);
    }
#else
    dwWaitRet = WaitForSingleObject(mutex, INFINITE);
#endif
    return true;
}

bool ExWatch::leave() const {
    ReleaseMutex(mutex);
    return true;
}

bool ExWatch::isSelf() const {
    return ((idThread == 0U) || (idThread == GetCurrentThreadId()));
}

uint32 ExWatch::setHalt(uint32 r)
{
    exassert((halt | r) & Ex_Halt);
    if (!(halt & 0x80000000)) {
        halt |= 0x80000000;
        setEvent(1UL);
    }
    return (halt |= r);
}

bool ExWatch::getEvent(uint64* u64) const {
    u64 = u64;
    BOOL ret = ResetEvent(efd);
    return (ret != 0);
}

bool ExWatch::setEvent(uint64 u64) const {
    u64 = u64;
    BOOL ret = SetEvent(efd);
    return (ret != 0);
}

uint32 ExWatch::onEvent(HANDLE hev) {
    dprint0("%s: hev:%p\n", __func__, hev);

    #if 0 // for manual reset
    uint64 u64 = 0UL;
    if (getEvent(&u64)) {
        dprint0("%s: got event %lu\n", __func__, u64);
    } else {
        dprint1("%s: got event fail.\n", __func__);
    }
    #endif

    #if 0 // tbd - cond wait and signal
    pthread_cond_wait(&cond, &mutex);
    ...
    pthread_cond_signal(&cond);
    #endif

    return 0U;
}

#endif // WIN32
