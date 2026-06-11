/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exthread_h__
#define __exthread_h__

#include "exevent.h"
#include "exobject.h"
#include "exmessage.h"
#include <list>

typedef struct {
    long tv_sec;
    long tv_usec;
} ExTimeVal;

// class ExThread
//
class ExThread : public ExObject {
public:
#ifdef WIN32
    static DWORD keyTlsSelf;
#endif // WIN32
#ifdef __linux__
    static pthread_key_t keyTlsSelf;
#endif // __linux__
    static ExThread* getTlsSelf();
    static void setTlsSelf(ExThread* self);

public:
    class Mutex {
    protected:
#ifdef WIN32
        mutable CRITICAL_SECTION cs;
#endif // WIN32
#ifdef __linux__
        mutable pthread_mutex_t mtx;
#endif // __linux__
    public:
        ~Mutex() noexcept;
        Mutex() noexcept;
    public:
        bool lock() const noexcept;
        bool unlock() const noexcept;
        bool trylock() const noexcept;
    };
#ifdef WIN32
    static DWORD WINAPI start(_In_ LPVOID arg);
#endif // WIN32
#ifdef __linux__
    static void* start(void* arg);
#endif // __linux__
    struct Proc : public ExPolyFunc<uint32, const void*> {
        template <typename A, typename B>
        Proc(A* d, uint32 (A::*f)(B*)) noexcept : ExPolyFunc(d) {
            func = reinterpret_cast<ThisFunc>(f);
        }
        template <typename A, typename B>
        Proc(uint32 (*f)(A*, B*), A* d) noexcept : ExPolyFunc(d) {
            vfunc = reinterpret_cast<FuncPtr>(f);
            #if EX2CONF_DISABLE_STDCALL
            invoker = &funcptr;
            #endif
        }
        Proc(const Proc& cb) noexcept : ExPolyFunc(cb) {}
        Proc() noexcept : ExPolyFunc() {}
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
#endif // WIN32
#ifdef __linux__
    enum Prio {
        PrioLow,
        PrioNormal, // Normal Thread: SCHED_OTHER, SCHED_BATCH (+19 ~ -20)
        PrioHigh,   // Real-Time Thread: SCHED_FIFO, SCHED_RR (+1 ~ +99)
        PrioUrgent,
    };
#endif // __linux__
public:
    const char* name; // for debug
protected:
#ifdef WIN32
    DWORD       idThread;
    HANDLE      hThread;
#endif // WIN32
#ifdef __linux__
    pthread_t   tid;
#endif // __linux__
    bool        joinable;
    int32       priority;
    Proc        userproc;
    void*       userdata;
public:
#ifdef WIN32
    explicit ExThread(const char* name) noexcept : ExObject()
        , name(name), idThread(0U), hThread(nullptr)
        , joinable(false), priority(PrioNormal), userproc(), userdata(nullptr) {}
#endif // WIN32
#ifdef __linux__
    explicit ExThread(const char* name) noexcept : ExObject()
        , name(name), tid(0U)
        , joinable(false), priority(PrioNormal), userproc(), userdata(nullptr) {}
#endif // __linux__
public:
    bool join(uint wait = 4000U/*INFINITE*/);
    bool create(const Proc& proc, size_t stacksize = 1048576UL, bool joinable = true);
#ifdef WIN32
#ifdef _WIN32_WCE
    int32 getPriority() { return (hThread) ? CeGetThreadPriority(hThread) : -1; }
    int32 setPriority(int32 priority) { return (hThread && CeSetThreadPriority(hThread, priority)) ? 0 : -1; }
#else // _WIN32_WCE
    int32 getPriority() { return (hThread) ? GetThreadPriority(hThread) : -1; }
    int32 setPriority(int32 priority) { return (hThread && SetThreadPriority(hThread, priority)) ? 0 : -1; }
#endif // _WIN32_WCE
#endif // WIN32
public:
#ifdef WIN32
    static void exit(DWORD dwExitCode);
#endif // WIN32
#ifdef __linux__
    static void exit(void* retval);
#endif // __linux__
    static ExThread* self() { return getTlsSelf(); }
public:
    friend class ExMutex;
    friend class ExWatch;
public:
    Ex_DECLARE_TYPEINFO(ExThread, ExObject);
};

// module exports
//
typedef ExThread::Mutex ExThreadMutex;

#define ExThreadExit ExThread::exit
#define ExThreadSelf ExThread::self

// variables for the exlib
//
extern const char* exModulePath;
extern const char* exModuleName;

extern ExThread exMainThread;

// functions for the exlib
//
bool ExIsValidAddress(const void* addr, int32 bytes, bool readwrite = true);
void ExGetCurrentTime(ExTimeVal* result);
uint64 ExThreadGetTime();
void ExFiniProcess();
void ExInitProcess(const char* pathname = nullptr);

#endif//__exthread_h__
