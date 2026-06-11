/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exthread.h"
#include "exmemory.h"
#include <algorithm>
#include <assert.h>

#ifndef TLS_OUT_OF_INDEXES
#define TLS_OUT_OF_INDEXES 0xFFFFFFFF
#endif//_WIN32_WCE

#ifdef WIN32

static DWORD exThreadSelfTls = TLS_OUT_OF_INDEXES;
static DWORD exCondEventTls = TLS_OUT_OF_INDEXES;

static void ExThreadFiniWin32Impl()
{
    if (TLS_OUT_OF_INDEXES != exCondEventTls)
        TlsFree(exCondEventTls);
    if (TLS_OUT_OF_INDEXES != exThreadSelfTls)
        TlsFree(exThreadSelfTls);
}

static void ExThreadInitWin32Impl()
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
    dprint1("ExMainThread: hThread=%p idThread=%p priority=%d joinable=%d\n",
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

    uint32 milliseconds = INFINITE;
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
    uint32 retval;
    HANDLE condEvent;
    condEvent = (HANDLE)TlsGetValue(exCondEventTls);
    if (condEvent == NULL) {
        condEvent = CreateEvent(0, FALSE, FALSE, NULL);
        TlsSetValue(exCondEventTls, condEvent);
        assert(condEvent != NULL);
    }
    mutex.lock();
    retval = WaitForSingleObject(condEvent, 0U);
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
        retval = WaitForSingleObject(condEvent, 0U);
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

int ExThread::join(uint wait) {
    assert(this->hThread);
    if (this->joinable == false) {
        exerror("%s - not joinable.\n", _func_);
        return -1;
    }
    if (WaitForSingleObject(this->hThread, wait) == WAIT_FAILED) {
        exerror("%s - WaitForSingleObject fail.\n", _func_);
    }
    if (CloseHandle(this->hThread) == 0) {
        exerror("%s - CloseHandle fail.\n", _func_);
    }
    this->joinable = false;
    this->hThread = NULL;
    return 0;
}

int ExThread::create(Proc& proc, bool joinable) {
    this->userproc = proc;
    this->joinable = joinable;
    hThread = CreateThread(NULL, 0, ExThreadProcWin32Impl, this, 0, &idThread);
    dprint1("CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    return hThread == NULL ? -1 : 0;
}

void ExThread::exit(DWORD dwExitCode) { // static
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

ExThread* ExThread::self() { // static
    return (ExThread*)TlsGetValue(exThreadSelfTls);
}

#endif // WIN32

// variables for the exlib
//
const char* exModulePath = NULL;
const char* exModuleName = NULL;

ExThread exMainThread;

// functions for the exlib
//
bool ExIsValidAddress(const void* addr, int bytes, bool readwrite)
{
#ifdef WIN32
    //static const char _func_[] = "ExIsValidAddress";
    // simple version using Win-32 APIs for pointer validation.
    return (addr != NULL && !IsBadReadPtr(addr, bytes) &&
           (!readwrite || !IsBadWritePtr((LPVOID)addr, bytes)));
#endif // WIN32
#ifdef __linux__
    return true; // tbd
#endif // __linux__
}

void ExGetCurrentTime(ExTimeVal* result)
{
#ifdef WIN32
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
#endif // WIN32
#ifdef __linux__
    // tbd
#endif // __linux__
}

uint64 ExThreadGetTime()
{
#ifdef WIN32
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
#endif // WIN32
#ifdef __linux__
    return 0UL; // tbd
#endif // __linux__
}

void ExFiniProcess()
{
#ifdef WIN32
    ExThreadFiniWin32Impl();
#endif // WIN32
#ifdef __linux__
    // tbd - ExThreadFiniWin32Impl();
#endif // __linux__
    dprint1("%s(%s\\%s)\n", _func_, exModulePath, exModuleName);
    assert(exModulePath != nullptr);
    assert(exModuleName != nullptr);
    free((void*)exModuleName);
    free((void*)exModulePath);
    exModulePath = nullptr;
    exModuleName = nullptr;
}

void ExInitProcess(const char* pathname)
{
    assert(exModulePath == nullptr);
    assert(exModuleName == nullptr);
    char buf[256];
#ifdef WIN32
    int len = GetModuleFileName(nullptr, buf, 256);
    while (len > 0 && buf[len] != '\\') {
        len--;
    }
#endif // WIN32
#ifdef __linux__
    int len = snprintf(buf, 256UL, "%s", pathname);
    while (len > 0 && buf[len] != '/') {
        len--;
    }
#endif // __linux__
    buf[len] = '\0';
    exModulePath = exstrdup(buf);
    exModuleName = exstrdup(buf + len + 1);
    dprint1("%s(%s\\%s)\n", _func_, exModulePath, exModuleName);
#ifdef WIN32
    ExThreadInitWin32Impl();
#endif // WIN32
#ifdef __linux__
    // tbd - ExThreadInitWin32Impl();
#endif // __linux__
}
