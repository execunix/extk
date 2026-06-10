/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exthread_h__
#define __exthread_h__

#include "exevent.h"
#include "exmessage.h"
#include <list>

typedef struct {
    long tv_sec;
    long tv_usec;
} ExTimeVal;

// class ExThread
//
class ExThread {
public:
    class Mutex {
    #ifdef WIN32
    protected:
        CRITICAL_SECTION cs;
    public:
        ~Mutex() { DeleteCriticalSection(&cs); }
        Mutex() { InitializeCriticalSection(&cs); }
    public:
        void lock() { EnterCriticalSection(&cs); }
        void unlock() { LeaveCriticalSection(&cs); }
        uint tryLock() { return TryEnterCriticalSection(&cs); }
    #endif // WIN32
    };
    class Cond {
    #ifdef WIN32
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
    #endif // WIN32
    };
    struct Proc : public ExPolyFunc<int, ExThread*> {
        template <typename A>
        Proc(A* d, int (A::*f)(ExThread*)) : ExPolyFunc(d) {
            func = reinterpret_cast<ThisFunc>(f);
        }
        template <typename A>
        Proc(int (*f)(A*, ExThread*), A* d) : ExPolyFunc(d) {
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
#ifdef WIN32
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
    ExThread() : errcode(0), hThread(NULL), idThread(0U),
        joinable(false), priority(PrioNormal), userproc(), userdata(NULL) {}
public:
    int join(uint wait = 4000U/*INFINITE*/);
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
#endif // WIN32
};

// module exports
//
typedef ExThread::Mutex ExThreadMutex;
typedef ExThread::Cond  ExThreadCond;

#define ExThreadExit ExThread::exit
#define ExThreadSelf ExThread::self

// variables for the exlib
//
extern const char* exModulePath;
extern const char* exModuleName;

extern ExThread exMainThread;

// functions for the exlib
//
bool ExIsValidAddress(const void* addr, int bytes, bool readwrite = true);
void ExGetCurrentTime(ExTimeVal* result);
uint64 ExThreadGetTime();
void ExFiniProcess();
void ExInitProcess(const char* pathname = nullptr);

#endif//__exthread_h__
