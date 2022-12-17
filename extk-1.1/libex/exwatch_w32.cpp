/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifdef WIN32

#include "exwatch.h"
#include "extimer.h"
#include <assert.h>

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

int ExWatch::IomuxMap::setup() {
    if (dirty) {
        dirty = 0;
        int cnt = 0;
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
        assert(cnt < MAXIMUM_WAIT_OBJECTS);
        assert(cnt == count);
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

int ExWatch::IomuxMap::probe(const ExCallback& callback, void* cbinfo) {
    int r = Ex_Continue;
    for (iterator i = begin(); i != end(); ++i) {
        ExWatch::Iomux& input = *i;
        if (!input.fRemoved) {
            int r = callback(&input, cbinfo);
            if (r != Ex_Continue)
                break;
        }
    }
    return r;
}

int ExWatch::IomuxMap::add(HANDLE handle, const ExNotify& notify, int pos) {
    const ExWatch::Iomux* input = search(handle);
    if (input != NULL) { // Remove duplicate handle.
        input->fRemoved = 1;
        count--;
    }
    if (count >= MAXIMUM_WAIT_OBJECTS) {
        exerror("%s fail. count=%d\n", __func__, count);
        return -1;
    }
    int cnt = 0;
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
    return 0;
}

int ExWatch::IomuxMap::add(HANDLE handle, const ExNotify& notify) {
    const ExWatch::Iomux* input = search(handle);
    if (input != NULL) { // Remove duplicate handle.
        input->fRemoved = 1;
        count--;
    }
    if (count >= MAXIMUM_WAIT_OBJECTS) {
        exerror("%s fail. count=%d\n", __func__, count);
        return -1;
    }
    count++;
    dirty++;
    watch->wakeup();
    ExWatch::Iomux iomux;
    iomux.handle = handle;
    iomux.notify = notify;
    push_back(iomux);
    // Iomux* ptr = &back();
    return 0;
}

int ExWatch::IomuxMap::del(HANDLE handle) {
    for (iterator i = begin(); i != end(); ++i) {
        ExWatch::Iomux* input = &*i;
        if (input->handle == handle) {
            if (input->fRemoved) {
                exerror("%s warn. already removed\n", __func__);
                return -1;
            }
            input->fRemoved = 1;
            watch->wakeup();
            assert(count > 0);
            count--;
            dirty++;
            return 0;
        }
    }
    exerror("%s fail. invalid input\n", __func__);
    return -1;
}

int ExWatch::IomuxMap::invoke(int waittick) {
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
        return 0; // no messages are available
    }
#if !defined(EVENTPROC_HAVETHREAD)
    if (dwWaitRet == WAIT_OBJECT_0 + nCount) {
        dprint0("IomuxMap: nCount=%d GOT_GWES_MSG\n", nCount);
        return 1; // got message from gwes
    }
#endif
    if (dwWaitRet >= WAIT_OBJECT_0 &&
        dwWaitRet < (WAIT_OBJECT_0 + nCount)) {
        dprint("IomuxMap: dwWaitRet=%p nCount=%d\n", dwWaitRet, nCount);
        int cnt = 1;
        iterator i = begin();
        for (DWORD n = 0; n < nCount; n++) {
            assert(i != end());
            ExWatch::Iomux& input = *i++; // proc input handler
            assert(input.handle == pHandles[n]);
            if (input.fRemoved)
                continue; // discard
            if (input.handle != pHandles[dwWaitRet - WAIT_OBJECT_0] &&
                WaitForSingleObject(input.handle, 0) != WAIT_OBJECT_0)
                continue;
            assert(input.notify.func);
            int r = input.notify(input.handle);
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

DWORD WINAPI ExWatch::start(_In_ LPVOID arg) {
    ExWatch* watch = (ExWatch*)arg;
    int r = watch->proc();
    assert(r == 0);
    return 0;
}

int ExWatch::fini() {
    int r = 0;
    idThread = 0;
    if (hThread != NULL) {
        setHalt(Ex_Halt);
        leave();
        if (WaitForSingleObject(hThread, INFINITE) == WAIT_FAILED)
            exerror("%s - WaitForSingleObject fail.\n", __func__);
        enter();
        if (CloseHandle(hThread) == 0)
            exerror("%s - CloseHandle fail.\n", __func__);
        hThread = NULL;
    }
    iomuxmap.fini();
    timerset.clearAll();
    if (hev != NULL) {
        CloseHandle(hev);
        hev = NULL;
    }
    return r;
}

int ExWatch::init(size_t stacksize) {
    int r = 0;

    assert(hThread == NULL);
    iomuxmap.init();

    hev = CreateEvent(NULL, FALSE, FALSE, NULL);
    assert(hev != NULL);
    ioAdd(this, &ExWatch::onEvent, hev);

    tickCount = GetTickCount(); // update tick

    hThread = CreateThread(NULL, stacksize, start, this, 0, &idThread);
    dprint1("CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    assert(hThread != NULL);

    return r;
}

int ExWatch::enter() const {
    DWORD dwWaitRet;
#ifdef DEBUG
    for (int i = 0; i < 100; i++) {
        dwWaitRet = WaitForSingleObject(mutex, 3000);
        if (dwWaitRet == WAIT_OBJECT_0)
            break;
        exerror("ExWatch::enter(TID=%p) %s %d\n", GetCurrentThreadId(),
                dwWaitRet == WAIT_TIMEOUT ? "WAIT_TIMEOUT" : "WAIT_FAILED", i);
    }
#else
    dwWaitRet = WaitForSingleObject(mutex, INFINITE);
#endif
    return 0;
}

int ExWatch::leave() const {
    ReleaseMutex(mutex);
    return 0;
}

int ExWatch::wakeup() const {
    if (idThread != GetCurrentThreadId()) {
        setEvent(1);
        return 1;
    }
    return 0;
}

int ExWatch::setHalt(int r)
{
    assert((halt | r) & Ex_Halt);
    if (!(halt & 0x80000000)) {
        halt |= 0x80000000;
        setEvent(1);
    }
    return halt |= r;
}

int ExWatch::getEvent(uint64* u) const {
    return -1;
}

int ExWatch::setEvent(uint64 u) const {
    return SetEvent(hev) ? 0 : -1;
}

int ExWatch::proc() {
    ExCbInfo cbinfo(0);
    enter();
    if (hookStart)
        hookStart(this, &cbinfo(HookStart));
    while (getHalt() == 0) {
        int waittick = timerset.invoke(tickCount);
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
    return 0;
}

int ExWatch::onEvent(HANDLE handle) {
    dprint0("%s: handle=%p\n", __func__, handle);

    #if 0 // tbd - cond wait and signal
    pthread_cond_wait(&cond, &mutex);
    ...
    pthread_cond_signal(&cond);
    #endif

    return 0;
}

#endif // WIN32
