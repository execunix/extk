/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exthread_h__
#define __exthread_h__

#include "extypes.h"
#include "excallback.h"
#include <list>

typedef struct {
    long tv_sec;
    long tv_usec;
} ExTimeVal;

// class ExSignal
//
class ExSignal {
protected:
    HANDLE hSignal;
public:
    ~ExSignal() { CloseHandle(hSignal); }
    ExSignal() { hSignal = CreateEvent(NULL, TRUE, FALSE, NULL); }
public:
    void reset() { ResetEvent(hSignal); }
    void signal() { SetEvent(hSignal); }
    bool isSignaled() {
        return (WaitForSingleObject(hSignal, 0) != WAIT_TIMEOUT);
    }
};

// class ExThread
//
class ExThread {
public:
    class Mutex {
    protected:
        CRITICAL_SECTION cs;
    public:
        ~Mutex() { DeleteCriticalSection(&cs); }
        Mutex() { InitializeCriticalSection(&cs); }
    public:
        void lock() { EnterCriticalSection(&cs); }
        void unlock() { LeaveCriticalSection(&cs); }
        uint tryLock() { return TryEnterCriticalSection(&cs); }
    };
    class Cond {
    protected:
        std::list<HANDLE> hevs;
        Mutex mutex;
    public:
        ~Cond() {}
        Cond() : mutex() {}
    public:
        void signal();
        void broadcast();
        bool timedWait(Mutex* enteredMutex, ExTimeVal* absTime);
        void wait(Mutex* enteredMutex) { timedWait(enteredMutex, NULL); }
    };
    struct Proc : public ExPolyFunc<int, ExThread*> {
        template <typename A>
        Proc(A* d, int (STDCALL A::*f)(ExThread*)) : ExPolyFunc(d) {
            func = reinterpret_cast<ThisFunc>(f);
        }
        template <typename A>
        Proc(int (STDCALL *f)(A*, ExThread*), A* d) : ExPolyFunc(d) {
            vfunc = reinterpret_cast<FuncPtr>(f);
#if EX2CONF_DISABLE_STDCALL
            invoker = &funcptr;
#endif
        }
        Proc(const Proc& cb) : ExPolyFunc(cb) {}
        Proc() : ExPolyFunc() {}
    };
    enum Attr {
        Detached = 0,
        Joinable = 1,
    };
    enum Prio {
        PrioLow = THREAD_PRIORITY_BELOW_NORMAL,
        PrioNormal = THREAD_PRIORITY_NORMAL,
        PrioHigh = THREAD_PRIORITY_ABOVE_NORMAL,
        PrioUrgent = THREAD_PRIORITY_HIGHEST,
    };
public:
    long        errcode;
    HANDLE      hThread;
    DWORD       idThread;
    bool        joinable;
    int         priority;
    Proc        userproc;
    void*       userdata;
public:
    ExThread() : errcode(0), hThread(NULL), idThread(0),
        joinable(false), priority(PrioNormal), userproc(), userdata(NULL) {}
public:
    int join(int wait = 4000/*INFINITE*/);
    int create(Proc& proc, bool joinable = true);
#ifdef _WIN32_WCE
    int getPriority() { return (hThread) ? CeGetThreadPriority(hThread) : -1; }
    int setPriority(int priority) { return (hThread && CeSetThreadPriority(hThread, priority)) ? 0 : -1; }
#else//_WIN32_WCE
    int getPriority() { return (hThread) ? GetThreadPriority(hThread) : -1; }
    int setPriority(int priority) { return (hThread && SetThreadPriority(hThread, priority)) ? 0 : -1; }
#endif//_WIN32_WCE
public:
    static void exit(DWORD dwExitCode);
    static ExThread* self();
};

typedef ExThread::Mutex ExThreadMutex;
typedef ExThread::Cond  ExThreadCond;

#define ExThreadExit ExThread::exit
#define ExThreadSelf ExThread::self

// module exports
//
extern const wchar* exModulePath;
extern const wchar* exModuleName;

extern ExThread exMainThread;

inline bool ExIsMainThread() {
    return (ExThreadSelf() == &exMainThread);
}

// WM_GWES 0x0000~0x03FF : Messages reserved for use by the system
// WM_USER 0x0400~0x7FFF : Integer messages for use by private window classes
// WM_APP  0x8000~0xBFFF : Messages available for use by applications

#define WM_CbRemove     0xBFFD // (WM_APP+0x3FFD)
#define WM_ExEvEmit     0xBFFE // (WM_APP+0x3FFE)
#define WM_ExEvWake     0xBFFF // (WM_APP+0x3FFF)

inline void ExWakeupMainThread() {
    if (!ExIsMainThread())
        PostThreadMessage(exMainThread.idThread, WM_ExEvWake, 0, 0); // wakeup
}

void ExLeave();
void ExEnter();
bool ExTryEnter();

bool ExIsValidAddress(const void* addr, int bytes, bool readwrite = true);
void ExGetCurrentTime(ExTimeVal* result);
uint64 ExThreadGetTime();
void ExFiniProcess();
void ExInitProcess();

#endif//__exthread_h__
