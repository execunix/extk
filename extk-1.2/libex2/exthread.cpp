/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exthread.h"
#include "exmemory.h"
#include "exwatch.h"
#ifdef __linux__
#include <sys/prctl.h>
#endif // __linux__
#include <algorithm>
#include <assert.h>

#ifndef TLS_OUT_OF_INDEXES
#define TLS_OUT_OF_INDEXES 0xFFFFFFFFU
#endif // _WIN32_WCE

#ifdef WIN32
DWORD ExThread::keyTlsSelf = TLS_OUT_OF_INDEXES;
#endif // WIN32
#ifdef __linux__
pthread_key_t ExThread::keyTlsSelf = (pthread_key_t)-1;
#endif // __linux__

ExThread* ExThread::getTlsSelf()
{
#ifdef WIN32
    ExThread* self = nullptr;
    if (TLS_OUT_OF_INDEXES != keyTlsSelf) {
        self = (ExThread*)TlsGetValue(keyTlsSelf);
    }
    return self;
#endif // WIN32
#ifdef __linux__
    ExThread* self = nullptr;
    if ((pthread_key_t)-1 != keyTlsSelf) {
        self = (ExThread*)pthread_getspecific(keyTlsSelf);
    }
    return self;
#endif // __linux__
}

void ExThread::setTlsSelf(ExThread* self)
{
#ifdef WIN32
    if (TLS_OUT_OF_INDEXES == keyTlsSelf) {
        keyTlsSelf = TlsAlloc();
    }
    exassert(TLS_OUT_OF_INDEXES != keyTlsSelf);
    void* prev = TlsGetValue(keyTlsSelf);
    if (prev == self) {
        dprint1("%s: duplicate %p\n", _func_, self);
    } else {
        dprint1("%s: %p to %p\n", _func_, prev, self);
        (void)TlsSetValue(keyTlsSelf, (LPVOID)self);
    }
#endif // WIN32
#ifdef __linux__
    if ((pthread_key_t)-1 == keyTlsSelf) {
        (void)pthread_key_create(&keyTlsSelf, nullptr);
    }
    exassert((pthread_key_t)-1 != keyTlsSelf);
    void* prev = pthread_getspecific(keyTlsSelf);
    if (prev == self) {
        dprint1("%s: duplicate %p\n", _func_, self);
    } else {
        dprint1("%s: %p to %p\n", _func_, prev, self);
        (void)pthread_setspecific(keyTlsSelf, (void*)self);
    }
#endif // __linux__
}

// class Mutex
//
ExThread::Mutex::~Mutex() noexcept
{
#ifdef WIN32
    DeleteCriticalSection(&cs);
#endif // WIN32
#ifdef __linux__
    (void)pthread_mutex_destroy(&mtx);
#endif // __linux__
}

ExThread::Mutex::Mutex() noexcept
{
#ifdef WIN32
    InitializeCriticalSection(&cs);
#endif // WIN32
#ifdef __linux__
    pthread_mutexattr_t attr;
    (void)pthread_mutexattr_init(&attr);
    (void)pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    (void)pthread_mutex_init(&mtx, &attr);
    (void)pthread_mutexattr_destroy(&attr);
#endif // __linux__
}

bool ExThread::Mutex::lock() const noexcept
{
#ifdef WIN32
    EnterCriticalSection(&cs);
    return true;
#endif // WIN32
#ifdef __linux__
    return (0 == pthread_mutex_lock(&mtx));
#endif // __linux__
}

bool ExThread::Mutex::unlock() const noexcept
{
#ifdef WIN32
    LeaveCriticalSection(&cs);
    return true;
#endif // WIN32
#ifdef __linux__
    return (0 == pthread_mutex_unlock(&mtx));
#endif // __linux__
}

bool ExThread::Mutex::trylock() const noexcept
{
#ifdef WIN32
    return TryEnterCriticalSection(&cs);
#endif // WIN32
#ifdef __linux__
    return (0 == pthread_mutex_trylock(&mtx));
#endif // __linux__
}

// class ExThread
//
#ifdef WIN32
DWORD WINAPI ExThread::start(_In_ LPVOID lpParameter)
{
    DWORD dwExitCode;
    ExThread* self = (ExThread*)lpParameter;
    assert(self && self->userproc);
    ExThread::setTlsSelf(self);
    dwExitCode = self->userproc(self);
    exassert(dwExitCode == 0U);
    if (self->joinable == false) { // is detached thread ?
        dprint("finish detached thread...\n");
        CloseHandle(self->hThread);
    }
    ExThread::setTlsSelf(nullptr);
    return dwExitCode;
}
#endif // WIN32
#ifdef __linux__
void* ExThread::start(void* arg)
{
    uint32 ret;
    ExThread* self = (ExThread*)arg;
    assert(self && self->userproc);
    //prctl(PR_SET_TIMERSLACK, 1); // tbd
    ExThread::setTlsSelf(self);
    ret = self->userproc(self);
    exassert(ret == 0U);
    if (self->joinable == false) { // is detached thread ?
        dprint("finish detached thread...\n");
    }
    ExThread::setTlsSelf(nullptr);
    return nullptr; // tbd
}
#endif // __linux__

bool ExThread::join(uint wait)
{
    int32 ret = 0;

    if (joinable == false) {
        ret--;
        exerror("%s - not joinable.\n", _func_);
        goto end_join;
    }
#ifdef WIN32
    exassert(hThread != nullptr);
    if (WaitForSingleObject(hThread, wait) == WAIT_FAILED) {
        exerror("%s - WaitForSingleObject fail.\n", _func_);
        ret--;
    }
    if (CloseHandle(hThread) == 0) {
        exerror("%s - CloseHandle fail.\n", _func_);
        ret--;
    }
    hThread = nullptr;
#endif // WIN32
#ifdef __linux__
    exassert(tid != 0U);
    ret = pthread_join(tid, nullptr);
    tid = 0U;
#endif // __linux__
    joinable = false;
end_join:
    exassert(ret == 0);
    return (ret == 0);
}

bool ExThread::create(const Proc& proc, size_t stacksize, bool joinable)
{
    userproc = proc;
    this->joinable = joinable;
#ifdef WIN32
    hThread = CreateThread(nullptr, stacksize, &ExThread::start, this, 0U, &idThread);
    dprint1("CreateThread: hThread=%p idThread=%p\n", hThread, idThread);
    exassert(hThread != nullptr);
    return (hThread != nullptr);
#endif // WIN32
#ifdef __linux__
    int32 ret;
    pthread_attr_t attr;
    (void)pthread_attr_init(&attr);
    (void)pthread_attr_setstacksize(&attr, stacksize);
    // tbd - set prio
    if (joinable == false) { // is detached thread ?
        (void)pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    }
    ret = pthread_create(&tid, &attr, &ExThread::start, this);
    (void)pthread_attr_destroy(&attr);
    exassert(ret == 0);
    return (ret == 0);
#endif // __linux__
}

#ifdef WIN32
void ExThread::exit(DWORD dwExitCode) { // static
    ExThread* self = getTlsSelf();
    if (self != nullptr) {
        if (self->joinable == false) { // is detached thread ?
            dprint("exit detached thread...\n");
            CloseHandle(self->hThread);
        }
        setTlsSelf(nullptr);
    }
    ExitThread(dwExitCode);
}
#endif // WIN32
#ifdef __linux__
void ExThread::exit(void* retval) { // static
    ExThread* self = getTlsSelf();
    if (self != nullptr) {
        if (self->joinable == false) { // is detached thread ?
            dprint("exit detached thread...\n");
        }
        setTlsSelf(nullptr);
    }
    pthread_exit(retval);
}
#endif // __linux__

// variables for the exlib
//
const char* exModulePath = NULL;
const char* exModuleName = NULL;

// functions for the exlib
//
bool ExIsValidAddress(const void* addr, int32 bytes, bool readwrite)
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
#else // _WIN32_WCE
    GetSystemTimeAsFileTime(&ft);
#endif // _WIN32_WCE
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
#else // _WIN32_WCE
    GetSystemTimeAsFileTime((FILETIME*)&v);
#endif // _WIN32_WCE
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
    dprint1("%s(%s\\%s)\n", _func_, exModulePath, exModuleName);
    assert(exModulePath != nullptr);
    assert(exModuleName != nullptr);
    free((void*)exModuleName);
    free((void*)exModulePath);
    exModulePath = nullptr;
    exModuleName = nullptr;
#ifdef WIN32
    exassert(TLS_OUT_OF_INDEXES != ExThread::keyTlsSelf);
    (void)TlsFree(ExThread::keyTlsSelf);
#endif // WIN32
#ifdef __linux__
    exassert((pthread_key_t)-1 != ExThread::keyTlsSelf);
    (void)pthread_key_delete(ExThread::keyTlsSelf);
#endif // __linux__
}

void ExInitProcess(ExWatch* self, const char* pathname)
{
    // init exWatchMain
    if (self == nullptr) {
        self = exWatchMain; // default
    } else {
        exWatchMain = self;
    }
    exWatchLast = self;
    exWatchDisp = self;

    self->joinable = false; // tbd
#ifdef WIN32
    self->hThread = GetCurrentThread();
    self->idThread = GetCurrentThreadId();
    #ifdef _WIN32_WCE
    self->priority = CeGetThreadPriority(self->hThread); // ExThread::PrioNormal
    #else
    self->priority = GetThreadPriority(self->hThread); // ExThread::PrioNormal
    #endif
    dprint1("ExMainThread: hThread=%p idThread=%p priority=%d joinable=%d\n",
            self->hThread, self->idThread, self->priority, self->joinable);
#endif // WIN32
#ifdef __linux__
    self->tid = pthread_self();
    // self->priority = 0;
    dprint1("ExMainThread: tid=%p priority=%d joinable=%d\n",
             self->tid, self->priority, self->joinable);
#endif // __linux__
    ExThread::setTlsSelf(self);

    assert(exModulePath == nullptr);
    assert(exModuleName == nullptr);
    char buf[256];
#ifdef WIN32
    DWORD len = GetModuleFileName(nullptr, buf, 256);
    while (len > 0U && buf[len] != '\\') {
        len--;
    }
#endif // WIN32
#ifdef __linux__
    int32 len = snprintf(buf, 256UL, "%s", pathname);
    while (len > 0 && buf[len] != '/') {
        len--;
    }
#endif // __linux__
    buf[len] = '\0';
    exModulePath = exstrdup(buf);
    exModuleName = exstrdup(buf + len + 1);
    dprint1("%s(%s\\%s)\n", _func_, exModulePath, exModuleName);
}
