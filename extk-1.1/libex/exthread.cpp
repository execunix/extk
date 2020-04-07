/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exthread.h>
#include <exmemory.h>
#include <algorithm>

#ifndef TLS_OUT_OF_INDEXES
#define TLS_OUT_OF_INDEXES 0xFFFFFFFF
#endif//_WIN32_WCE

ExThread exMainThread;

static DWORD exThreadSelfTls = TLS_OUT_OF_INDEXES;
static DWORD exCondEventTls = TLS_OUT_OF_INDEXES;

static void
ExThreadFiniWin32Impl() 
{
    if (TLS_OUT_OF_INDEXES != exCondEventTls)
        TlsFree(exCondEventTls);
    if (TLS_OUT_OF_INDEXES != exThreadSelfTls)
        TlsFree(exThreadSelfTls);
}

static void
ExThreadInitWin32Impl()
{
    exThreadSelfTls = TlsAlloc();
    assert(TLS_OUT_OF_INDEXES != exThreadSelfTls);
    exCondEventTls = TlsAlloc();
    assert(TLS_OUT_OF_INDEXES != exCondEventTls);

    // init exMainThread
    ExThread* self = &exMainThread;
    self->hThread = GetCurrentThread();
    self->idThread = GetCurrentThreadId();
#ifdef _WIN32_WCE
    self->priority = CeGetThreadPriority(self->hThread); // ExThread::PrioNormal
#else
    self->priority = GetThreadPriority(self->hThread); // ExThread::PrioNormal
#endif
    self->joinable = false; // tbd
    dprint1(L"ExMainThread: hThread=%p idThread=%p priority=%d joinable=%d\n",
            self->hThread, self->idThread, self->priority, self->joinable);
    TlsSetValue(exThreadSelfTls, self);
}

static DWORD WINAPI
ExThreadProcWin32Impl(LPVOID lpParameter)
{
    DWORD dwExitCode;
    HANDLE condEvent;
    ExThread* self = (ExThread*)lpParameter;
    assert(self && self->userproc);
    if (self && self->userproc) {
        TlsSetValue(exThreadSelfTls, self);
        dwExitCode = self->userproc(self);
        condEvent = (HANDLE)TlsGetValue(exCondEventTls);
        if (condEvent) {
            CloseHandle(condEvent);
            TlsSetValue(exCondEventTls, NULL);
        }
        if (self->joinable == false) // is detached thread ?
            CloseHandle(self->hThread);
        TlsSetValue(exThreadSelfTls, NULL);
    }
    return dwExitCode;
}

// class ExThread
//
void ExThread::Cond::signal() {
    mutex.lock();
    if (!hevs.empty()) {
        SetEvent(hevs.front());
        hevs.pop_front();
    }
    mutex.unlock();
}

void ExThread::Cond::broadcast() {
    mutex.lock();
    std::list<HANDLE>::iterator it = hevs.begin();
    while (it != hevs.end()) {
        SetEvent(*it);
        ++it;
    }
    hevs.clear();
    mutex.unlock();
}

bool ExThread::Cond::timedWait(Mutex* enteredMutex, ExTimeVal* absTime) {
    assert(this != NULL);
    assert(enteredMutex != NULL);

    ulong milliseconds = INFINITE;
    if (absTime) {
        ExTimeVal currentTime;
        ExGetCurrentTime(&currentTime);
        if ((absTime->tv_sec < currentTime.tv_sec) ||
            (absTime->tv_sec == currentTime.tv_sec &&
             absTime->tv_usec <= currentTime.tv_usec)) {
            milliseconds = 0;
        } else {
            milliseconds = (absTime->tv_sec - currentTime.tv_sec) * 1000 +
                           (absTime->tv_usec - currentTime.tv_usec) / 1000;
        }
    }
    ulong retval;
    HANDLE condEvent;
    condEvent = (HANDLE)TlsGetValue(exCondEventTls);
    if (condEvent == NULL) {
        condEvent = CreateEvent(0, FALSE, FALSE, NULL);
        TlsSetValue(exCondEventTls, condEvent);
        assert(condEvent != NULL);
    }
    mutex.lock();
    retval = WaitForSingleObject(condEvent, 0);
    assert(retval == WAIT_TIMEOUT);
    hevs.push_back(condEvent);
    mutex.unlock();

    enteredMutex->unlock();
    retval = WaitForSingleObject(condEvent, milliseconds);
    assert(retval != WAIT_FAILED);
    enteredMutex->lock();
    if (retval == WAIT_TIMEOUT) {
        mutex.lock();
        hevs.erase(std::find(hevs.begin(), hevs.end(), condEvent));
        retval = WaitForSingleObject(condEvent, 0);
        assert(retval != WAIT_FAILED);
        mutex.unlock();
    }
#ifdef DEBUG // for debug...
    mutex.lock();
    assert(std::find(hevs.begin(), hevs.end(), condEvent) == hevs.end());
    mutex.unlock();
#endif
    return retval != WAIT_TIMEOUT;
}

int ExThread::join(int wait) {
    assert(this->hThread);
    if (this->joinable == false) {
        exerror(L"%s - not joinable.\n", __funcw__);
        return -1;
    }
#if 0 // tbd - here or user ?
    ExLeave();
    ExWakeupMainThread();
#endif
    if (WaitForSingleObject(this->hThread, wait) == WAIT_FAILED)
        exerror(L"%s - WaitForSingleObject fail.\n", __funcw__);
#if 0 // tbd - here or user ?
    ExEnter();
#endif
    if (CloseHandle(this->hThread) == 0)
        exerror(L"%s - CloseHandle fail.\n", __funcw__);
    this->joinable = false;
    this->hThread = NULL;
    return 0;
}

int ExThread::create(Proc& proc, bool joinable) {
    this->userproc = proc;
    this->joinable = joinable;
    hThread = CreateThread(NULL, 0, ExThreadProcWin32Impl, this, 0, &idThread);
    dprint1(L"CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    return hThread == NULL ? -1 : 0;
}

void // static
ExThread::exit(DWORD dwExitCode) {
    HANDLE condEvent;
    ExThread* self;
    self = (ExThread*)TlsGetValue(exThreadSelfTls);
    if (self) {
        condEvent = (HANDLE)TlsGetValue(exCondEventTls);
        if (condEvent) {
            CloseHandle(condEvent);
            TlsSetValue(exCondEventTls, NULL);
        }
        if (self->joinable == false) // is detached thread ?
            CloseHandle(self->hThread);
        TlsSetValue(exThreadSelfTls, NULL);
    }
    ExitThread(dwExitCode);
}

ExThread* // static
ExThread::self() {
    return (ExThread*)TlsGetValue(exThreadSelfTls);
}

// variables for the exlib
//
const wchar* exModulePath = NULL;
const wchar* exModuleName = NULL;

HANDLE exLibMutex = NULL;

// functions for the exlib
//
void
ExLeave()
{
    ReleaseMutex(exLibMutex);
}

void
ExEnter()
{
    DWORD dwWaitRet;
    for (int i = 0; i < 100; i++) {
        dwWaitRet = WaitForSingleObject(exLibMutex, 3000);
        if (dwWaitRet == WAIT_OBJECT_0)
            break;
        exerror(L"ExEnter(TID=%p) %s %d\n", GetCurrentThreadId(),
                dwWaitRet == WAIT_TIMEOUT ? L"WAIT_TIMEOUT" : L"WAIT_FAILED", i);
    }
}

bool
ExTryEnter()
{
    DWORD dwWaitRet;
    dwWaitRet = WaitForSingleObject(exLibMutex, 0);
    if (dwWaitRet == WAIT_OBJECT_0)
        return true;
    return false;
}

bool
ExIsValidAddress(const void* addr, int bytes, bool readwrite)
{
    //static const char __func__[] = "ExIsValidAddress";
    // simple version using Win-32 APIs for pointer validation.
    return (addr != NULL && !IsBadReadPtr(addr, bytes) &&
           (!readwrite || !IsBadWritePtr((LPVOID)addr, bytes)));
}

void
ExGetCurrentTime(ExTimeVal* result)
{
    FILETIME ft;
    uint64* time64 = (uint64*)&ft;
#ifdef _WIN32_WCE
    SYSTEMTIME st;
    GetSystemTime(&st);
    SystemTimeToFileTime(&st, &ft);
#else//_WIN32_WCE
    GetSystemTimeAsFileTime(&ft);
#endif//_WIN32_WCE
    *time64 -= 116444736000000000ULL;
    *time64 /= 10;
    result->tv_sec = (long)(*time64 / 1000000);
    result->tv_usec = (long)(*time64 % 1000000);
}

uint64
ExThreadGetTime()
{
    uint64 v;
    // Returns 100s of nanoseconds since start of 1601
#ifdef _WIN32_WCE
    SYSTEMTIME st;
    GetSystemTime(&st);
    SystemTimeToFileTime(&st, (FILETIME*)&v);
#else//_WIN32_WCE
    GetSystemTimeAsFileTime((FILETIME*)&v);
#endif//_WIN32_WCE
    // Offset to Unix epoch
    v -= 116444736000000000ULL;
    // Convert to nanoseconds
    v *= 100;
    return v;
}

void
ExFiniProcess()
{
    ExThreadFiniWin32Impl();
    dprint1(L"ExFiniProcess(%s\\%s) %p\n", exModulePath, exModuleName, exLibMutex);
    ExLeave();
    CloseHandle(exLibMutex);
    assert(exModulePath != NULL);
    assert(exModuleName != NULL);
    free((void*)exModuleName);
    free((void*)exModulePath);
    exModulePath = NULL;
    exModuleName = NULL;
}

void
ExInitProcess()
{
    exLibMutex = CreateMutex(NULL, FALSE, L"exLibMutex");
    assert(exModulePath == NULL);
    assert(exModuleName == NULL);
    wchar buf[256];
    int len = GetModuleFileName(NULL, buf, 256);
    while (len > 0 && buf[len] != '\\')
        len--;
    buf[len] = 0;
    exModulePath = exwcsdup(buf);
    exModuleName = exwcsdup(buf + len + 1);
    ExEnter();
    dprint1(L"ExInitProcess(%s\\%s) %p\n", exModulePath, exModuleName, exLibMutex);
    ExThreadInitWin32Impl();
}

