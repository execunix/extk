/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "extimer.h"

#ifdef WIN32

//#define IOMUX_WAIT_NO_GWES
#define USE_SLEEP_BUSYWAIT

int32 exmsleep(const uint32 msec) {
    Sleep((DWORD)msec);
    return 0;
}

int32 exusleep(const uint32 usec) {
    Sleep((DWORD)(usec / 1000U));
    return 0;
}

#if defined(USE_SLEEP_BUSYWAIT)
static int32 exbusywait(const uint64 usec_tick) {
    uint64 tick;
    do {
        tick = ExGetTickCount();
    } while (tick < usec_tick);
    return 0;
}
#endif // USE_SLEEP_BUSYWAIT

uint64 ExGetTickCount() {
#if defined(USE_SLEEP_BUSYWAIT)
    LARGE_INTEGER freq, tick;
    QueryPerformanceFrequency(&freq);
    QueryPerformanceCounter(&tick);
    double usec = 1000000.0;
    usec *= static_cast<double>(tick.QuadPart);
    usec /= static_cast<double>(freq.QuadPart);
    return static_cast<uint64>(usec);
#else // !USE_SLEEP_BUSYWAIT
    uint32 msec;
    msec = GetTickCount();
    return static_cast<uint64>(msec) * 1000UL;
#endif // USE_SLEEP_BUSYWAIT
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
    if (dirty > 0) {
        dirty = 0;
        int32 cnt = 0;
        for (const_iterator i = begin(); i != end(); ++i) {
            const Iomux& iomux = i->second;
            handles[cnt++] = iomux.mux_fd;
        }
        exassert(cnt < MAXIMUM_WAIT_OBJECTS);
    }
    return static_cast<DWORD>(ret);
}

const ExWatch::Iomux* ExWatch::IomuxMap::search(OsaFd mux_fd) const {
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

bool ExWatch::IomuxMap::add(OsaFd mux_fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    (void)watch->enter();
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
    (void)watch->leave();
    return (r == 0);
}

bool ExWatch::IomuxMap::mod(OsaFd mux_fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    (void)watch->enter();
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        r = 0;
    } else {
        dprint1("IomuxMap::mod: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    (void)watch->leave();
    return (r == 0);
}

bool ExWatch::IomuxMap::del(OsaFd mux_fd) {
    int32 r = -1;
    (void)watch->enter();
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
    (void)watch->leave();
    return (r == 0);
}

int64 ExWatch::IomuxMap::invoke(int64 waittick) {
    DWORD nCount = setup();
    LPHANDLE pHandles = handles;
    DWORD dwMilliseconds = (DWORD)(waittick / 1000L);//INFINITE;
    DWORD dwWaitRet; // signaled number
    const uint64 tick0 = watch->tickCount; // get current tick

    watch->leave();
    //Sleep(1);
#if defined(USE_SLEEP_BUSYWAIT)
    (void)exbusywait(tick0 + (waittick % 1000L)); // busy wait for usec
#else // !USE_SLEEP_BUSYWAIT
    (void)exusleep((uint32)(waittick % 1000L)); // sleep for usec
#endif // USE_SLEEP_BUSYWAIT
#if defined(IOMUX_WAIT_NO_GWES)
    dwWaitRet = WaitForMultipleObjects(nCount, pHandles, FALSE, dwMilliseconds);
#else
    DWORD dwWakeMask = QS_ALLEVENTS;//QS_ALLINPUT;
    DWORD dwFlags = MWMO_INPUTAVAILABLE;
    dwWaitRet = MsgWaitForMultipleObjectsEx(nCount, pHandles,
                                            dwMilliseconds, dwWakeMask, dwFlags);
#endif
    watch->enter();

    if (dwWaitRet == WAIT_TIMEOUT) { // no messages are available
        dprint0("IomuxMap: nCount=%d WAIT_TIMEOUT\n", nCount);
    } else
#if !defined(IOMUX_WAIT_NO_GWES)
    if (dwWaitRet == (WAIT_OBJECT_0 + nCount)) { // got message from gwes
        dprint0("IomuxMap: nCount=%d GOT_GWES_MSG\n", nCount);
    } else
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
            epoll_event ev;
            ev.events = EPOLLIN;
            ev.data = iomux->mux_fd;
            // proc iomux handler
            exassert(iomux->notify.func);
            uint32 r = iomux->notify(&ev);
            r |= watch->getHalt();
            if (ExIsHalt(r)) {
                (void)watch->setHalt(r);
                break; // stop iomux loop
            }
            if ((r & Ex_Remove) != 0U) {
                del(iomux->mux_fd);
                dirty++;
            }
            cnt++;
        }
        dprint("IomuxMap: got input signal cnt=%d\n", cnt);
    } else {
        exerror("IomuxMap: dwWaitRet:%p GetLastError:0x%p\n", dwWaitRet, GetLastError());
    }
    watch->tickCount = ExGetTickCount(); // update tick
    return (watch->tickCount - tick0); // return elapsed tick
}

// Watch thread
//
uint64 ExWatch::tickAppLaunch = ExGetTickCount();

DWORD ExWatch::keyTlsSpecific = TLS_OUT_OF_INDEXES;

const ExWatch* ExWatch::getTlsSpecific() {
    const ExWatch* watch = nullptr;
    if (keyTlsSpecific != TLS_OUT_OF_INDEXES) {
        watch = (const ExWatch*)TlsGetValue(keyTlsSpecific);
    }
    return watch;
}

void ExWatch::setTlsSpecific(const ExWatch* watch) {
    if (keyTlsSpecific == TLS_OUT_OF_INDEXES) {
        keyTlsSpecific = TlsAlloc();
    }
    exassert(keyTlsSpecific != TLS_OUT_OF_INDEXES);
    exassert(TlsGetValue(keyTlsSpecific) == nullptr);
    TlsSetValue(keyTlsSpecific, (LPVOID)watch);
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
        //(void)leave();
        if (WaitForSingleObject(hThread, INFINITE) == WAIT_FAILED) {
            exerror("%s - WaitForSingleObject fail.\n", __func__);
            r -= 1;
        }
        //(void)enter();
        if (CloseHandle(hThread) == 0) {
            exerror("%s - CloseHandle fail.\n", __func__);
            r -= 1;
        }
        hThread = nullptr;
    }
    iomuxmap.fini();
    timerset.fini();
    evWake.fini();
    return (r == 0);
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    exassert(hThread == nullptr);
    iomuxmap.init(max_iomux);

    evWake.init();
    ioAdd(this, &ExWatch::onEvent, evWake);

    tickCount = ExGetTickCount(); // update tick

    hThread = CreateThread(nullptr, stacksize, start, this, 0, &idThread);
    dprint1("CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    exassert(hThread != nullptr);

    return (hThread != nullptr);
}

uint32 ExWatch::onEvent(const epoll_event* ev) {
    HANDLE hev = (HANDLE)ev->data;
    dprint0("%s: hev:%p\n", __func__, hev);
    exassert(evWake == hev);
    #if 1 // for manual reset
    (void)evWake.reset();
    #endif

    #if 0 // tbd - cond wait and signal
    pthread_cond_wait(&cond, &mutex);
    ...
    pthread_cond_signal(&cond);
    #endif

    return 0U;
}

#endif // WIN32
