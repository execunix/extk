/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#ifdef WIN32
//#include "extimer.h"

#define EVENTPROC_HAVETHREAD

uint64 ExGetMonoClock(void)
{
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
    max = max;
}

DWORD ExWatch::IomuxMap::setup() {
    size_t ret = size();
    if (dirty) {
        dirty = 0;
        int32 cnt = 0U;
        for (const_iterator i = begin(); i != end(); ++i) {
            const Iomux& iomux = i->second;
            handles[cnt++] = iomux.handle;
        }
        exassert(cnt < MAXIMUM_WAIT_OBJECTS);
    }
    return static_cast<DWORD>(ret);
}

const ExWatch::Iomux* ExWatch::IomuxMap::search(HANDLE handle) const {
    const Iomux* iomux = NULL;
    const_iterator i = find(handle);
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

bool ExWatch::IomuxMap::add(HANDLE handle, const ExNotify& notify) {
    int32 r = -1;
    if (size() < MAXIMUM_WAIT_OBJECTS) {
        Iomux* iomux = nullptr;
        std::pair<iterator, bool> pr;
        pr = insert(value_type(handle, Iomux(handle)));
        iomux = &pr.first->second;
        if (pr.second == false) {
            dprint1("IomuxMap::add: duplicate handle:%p\n", handle);
        }
        exassert(iomux->handle == handle);
        iomux->notify = notify;
        dirty++;
        r = 0;
    } else {
        dprint1("IomuxMap::add: size:%zu\n", size());
    }
    return (r == 0);
}

bool ExWatch::IomuxMap::mod(HANDLE handle, const ExNotify& notify) {
    int32 r = -1;
    iterator i = find(handle);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->handle == handle);
        iomux->notify = notify;
        r = 0;
    } else {
        dprint1("IomuxMap::mod: invalid handle:%p\n", handle);
    }
    return (r == 0);
}

bool ExWatch::IomuxMap::del(HANDLE handle) {
    int32 r = -1;
    iterator i = find(handle);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->handle == handle);
        erase(i);
        dirty++;
        r = 0;
    } else {
        dprint1("IomuxMap::del: invalid handle:%p\n", handle);
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
                dprint("IomuxMap: handle:%p removed\n", iomux->handle);
                continue; // discard
            }
            // check handle is signaled
            if ((n != (dwWaitRet - WAIT_OBJECT_0)) &&
                (WaitForSingleObject(iomux->handle, 0U) != WAIT_OBJECT_0)) {
                continue; // not signaled
            }
            // proc iomux handler
            exassert(iomux->notify.func);
            uint32 r = iomux->notify(iomux->handle);
            if (r & Ex_Halt) {
                return watch->setHalt(r);
            }
            if ((r & Ex_Remove) != 0U) {
                del(iomux->handle);
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
    exassert(TlsGetValue(tls_key) == NULL);
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
    idThread = 0;
    if (hThread != NULL) {
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
        hThread = NULL;
    }
    iomuxmap.fini();
    timerset.clearAll();
    if (hev != NULL) {
        CloseHandle(hev);
        hev = NULL;
    }
    return (r == 0);
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    exassert(hThread == NULL);
    iomuxmap.init(max_iomux);

    hev = CreateEvent(NULL, FALSE, FALSE, NULL);
    exassert(hev != NULL);
    ioAdd(this, &ExWatch::onEvent, hev);

    tickCount = GetTickCount(); // update tick

    hThread = CreateThread(NULL, stacksize, start, this, 0, &idThread);
    dprint1("CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    exassert(hThread != NULL);

    return (hThread != NULL);
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

bool ExWatch::wakeup() const {
    if (idThread != GetCurrentThreadId()) {
        setEvent(1UL);
        return true;
    }
    return false;
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

uint32 ExWatch::getHalt() const
{
    return halt;
}

bool ExWatch::getEvent(uint64* u64) const {
    u64 = u64;
    BOOL ret = ResetEvent(hev);
    return (ret != 0);
}

bool ExWatch::setEvent(uint64 u64) const {
    u64 = u64;
    BOOL ret = SetEvent(hev);
    return (ret != 0);
}

uint32 ExWatch::proc() {
    tls_specific(name);
    dprint("%s: tickAppLaunch=%d tickCount=%d\n", name, tickAppLaunch, tickCount);
    ExCbInfo cbinfo(0);
    enter();
    if (hookStart) {
        hookStart(this, &cbinfo(HookStart));
    }
    while (getHalt() == 0U) {
        uint32 waittick = timerset.invoke(tickCount);
        if (getHalt() != 0U) { // is halt ?
            break; // stop event loop
        }
        if (hookTimer) {
            hookTimer(this, &cbinfo(HookTimer));
        }
        // blocked
        iomuxmap.invoke(waittick); // The only waiting point.
        if (getHalt() != 0U) { // is halt ?
            break; // stop event loop
        }
        if (hookIomux) {
            hookIomux(this, &cbinfo(HookIomux));
        }
    }
    if (hookClean) {
        hookClean(this, &cbinfo(HookClean));
    }
    leave();
    return 0U;
}

uint32 ExWatch::onEvent(HANDLE handle) {
    dprint0("%s: handle:%p\n", __func__, handle);

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
