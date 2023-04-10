/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifdef WIN32

#include "exwatch.h"
#include "extimer.h"

#define EVENTPROC_HAVETHREAD

// Iomux
//
void ExWatch::IomuxMap::fini() {
    count = 0;
    dirty = 0;
    clear();
}

void ExWatch::IomuxMap::init() {
    ;
}

int32 ExWatch::IomuxMap::setup() {
    if (dirty) {
        dirty = 0;
        int32 cnt = 0;
        iterator i = begin();
        while (i != end()) {
            Iomux& input = *i;
            if (input.fRemoved) {
                i = erase(i);
            } else {
                handles[cnt++] = input.handle;
                ++i;
            }
        }
        exassert(cnt < MAXIMUM_WAIT_OBJECTS);
        exassert(cnt == count);
    }
    return count;
}

const ExWatch::Iomux* ExWatch::IomuxMap::search(HANDLE handle) const {
    for (const_iterator i = begin(); i != end(); ++i) {
        const ExWatch::Iomux& input = *i;
        if (input.handle == handle &&
            !input.fRemoved) {
            return &input;
        }
    }
    return NULL;
}

uint32 ExWatch::IomuxMap::probe(const ExCallback& callback, void* cbinfo) {
    uint32 r = Ex_Continue;
    for (iterator i = begin(); i != end(); ++i) {
        ExWatch::Iomux& input = *i;
        if (!input.fRemoved) {
            uint32 r = callback(&input, cbinfo);
            if (r != Ex_Continue)
                break;
        }
    }
    return r;
}

bool ExWatch::IomuxMap::add(HANDLE handle, const ExNotify& notify, int32 pos) {
    const ExWatch::Iomux* input = search(handle);
    if (input != NULL) { // Remove duplicate handle.
        input->fRemoved = 1;
        count--;
    }
    if (count >= MAXIMUM_WAIT_OBJECTS) {
        exerror("%s fail. count=%d\n", __func__, count);
        return false;
    }
    int32 cnt = 0;
    iterator i = begin();
    for (; i != end(); ++i) {
        if (!(*i).fRemoved && pos == cnt)
            break;
        ++cnt;
    }
    count++;
    dirty++;
    watch->wakeup();
    ExWatch::Iomux iomux;
    iomux.handle = handle;
    iomux.notify = notify;
    i = std::list<ExWatch::Iomux>::insert(i, iomux);
    // Iomux* ptr = &*i;
    return true;
}

bool ExWatch::IomuxMap::add(HANDLE handle, const ExNotify& notify) {
    const ExWatch::Iomux* input = search(handle);
    if (input != NULL) { // Remove duplicate handle.
        input->fRemoved = 1;
        count--;
    }
    if (count >= MAXIMUM_WAIT_OBJECTS) {
        exerror("%s fail. count=%d\n", __func__, count);
        return false;
    }
    count++;
    dirty++;
    watch->wakeup();
    ExWatch::Iomux iomux;
    iomux.handle = handle;
    iomux.notify = notify;
    push_back(iomux);
    // Iomux* ptr = &back();
    return true;
}

bool ExWatch::IomuxMap::del(HANDLE handle) {
    for (iterator i = begin(); i != end(); ++i) {
        ExWatch::Iomux* input = &*i;
        if (input->handle == handle) {
            if (input->fRemoved) {
                exerror("%s warn. already removed\n", __func__);
                return false;
            }
            input->fRemoved = 1;
            watch->wakeup();
            exassert(count > 0);
            count--;
            dirty++;
            return true;
        }
    }
    exerror("%s fail. invalid input\n", __func__);
    return false;
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
    if (dwWaitRet >= WAIT_OBJECT_0 &&
        dwWaitRet < (WAIT_OBJECT_0 + nCount)) {
        dprint("IomuxMap: dwWaitRet=%p nCount=%d\n", dwWaitRet, nCount);
        uint32 cnt = 1;
        iterator i = begin();
        for (DWORD n = 0; n < nCount; n++) {
            exassert(i != end());
            ExWatch::Iomux& input = *i++; // proc input handler
            exassert(input.handle == pHandles[n]);
            if (input.fRemoved)
                continue; // discard
            if (input.handle != pHandles[dwWaitRet - WAIT_OBJECT_0] &&
                WaitForSingleObject(input.handle, 0) != WAIT_OBJECT_0)
                continue;
            exassert(input.notify.func);
            uint32 r = input.notify(input.handle);
            if (r & Ex_Halt) {
                return watch->setHalt(r);
            }
            if ((r & Ex_Remove) && !input.fRemoved) {
                input.fRemoved = 1;
                count--;
                dirty++;
            }
            cnt++;
        }
        return cnt; // got input signal
    }
    exerror("IomuxMap: dwWaitRet=%p GetLastError=0x%p\n", dwWaitRet, GetLastError());
    return -1; // error
}

// Watch thread
//
uint32 ExWatch::getTickCount() {
    uint32 msec;
    msec = GetTickCount();
    return msec;
}

uint32 ExWatch::tickAppLaunch = ExWatch::getTickCount();

DWORD ExWatch::tls_key = TLS_OUT_OF_INDEXES;

void ExWatch::tls_specific(const char_t* name)
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

bool ExWatch::init(size_t stacksize) {
    exassert(hThread == NULL);
    iomuxmap.init();

    hev = CreateEvent(NULL, FALSE, FALSE, NULL);
    exassert(hev != NULL);
    ioAdd(this, &ExWatch::onEvent, hev);

    tickCount = getTickCount(); // update tick

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
        if (dwWaitRet == WAIT_OBJECT_0)
            break;
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
    if (hookStart)
        hookStart(this, &cbinfo(HookStart));
    while (getHalt() == 0) {
        uint32 waittick = timerset.invoke(tickCount);
        if (getHalt() != 0) // is halt ?
            break; // stop event loop
        if (hookTimer)
            hookTimer(this, &cbinfo(HookTimer));
        // blocked
        iomuxmap.invoke(waittick); // The only waiting point.
        if (getHalt() != 0) // is halt ?
            break; // stop event loop
        if (hookIomux)
            hookIomux(this, &cbinfo(HookIomux));
    }
    if (hookClean)
        hookClean(this, &cbinfo(HookClean));
    leave();
    return 0U;
}

uint32 ExWatch::onEvent(HANDLE handle) {
    dprint0("%s: handle=%p\n", __func__, handle);
    #if 0 // for manual reset
    uint64 u64 = 0UL;
    if (getEvent(&u64))
        dprint0("%s: got event %lu\n", __func__, u64);
    else
        dprint1("%s: got event fail.\n", __func__);
    #endif
    #if 0 // tbd - cond wait and signal
    pthread_cond_wait(&cond, &mutex);
    ...
    pthread_cond_signal(&cond);
    #endif

    return 0U;
}

#endif // WIN32
