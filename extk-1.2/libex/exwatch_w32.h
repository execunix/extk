/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_w32_h__
#define __exwatch_w32_h__

#ifdef WIN32

#include "excallback.h"
#include "exthread.h"
#include <list>
#include <set>

#define EX2CONF_ENABLE_IOMUX_LOCK 0

class ExTimer;

// Watch thread
//
class ExWatch {
protected:
    // TimerSet
    struct TickCompare { // less traits
        bool operator () (const ExTimer* l, const ExTimer* r) const;
    };
    class TimerSet : public std::multiset<ExTimer*, TickCompare> {
    public:
        TimerSet() : std::multiset<ExTimer*, TickCompare>() {}
    public:
        void clearAll();
        void remove(ExTimer* timer);
        void active(ExTimer* timer);
        int  invoke(uint32 tick_count);
    };
    // IomuxMap
    struct Iomux {
        HANDLE          handle;
        ExNotify        notify;
        mutable int     fRemoved;
        Iomux() : handle(handle), notify(), fRemoved(0) {}
    };
    class IomuxMap : protected std::list<Iomux> {
    protected:
        ExWatch*        watch;
        int             count;
        int             dirty;
        HANDLE          handles[MAXIMUM_WAIT_OBJECTS];
    public:
        ~IomuxMap() { fini(); }
        IomuxMap(ExWatch* watch) : std::list<Iomux>(), watch(watch), count(0), dirty(0) {}
    public:
        void fini();
        void init();
        // inherit void clear();
        // inherit iterator find(int fd);
        int setup();
        const Iomux* search(HANDLE handle) const;
        int probe(const ExCallback& callback, void* cbinfo);
        int add(HANDLE handle, const ExNotify& notify, int pos);
        int add(HANDLE handle, const ExNotify& notify);
        int del(HANDLE handle);
        int invoke(int waittick = INFINITE);
    };
public:
    const char* name; // for debug
    static uint32 getTickCount();
    static uint32 tickAppLaunch;
protected:
    static DWORD WINAPI start(_In_ LPVOID arg);
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    DWORD           idThread;
    HANDLE          hThread;
    HANDLE          hev;
    int             halt;
    uint32          tickCount;
    mutable HANDLE  mutex;
public:
    enum { HookStart, HookTimer, HookIomux, HookClean };
    ExCallback      hookStart;
    ExCallback      hookTimer;
    ExCallback      hookIomux;
    ExCallback      hookClean;

public:
    virtual ~ExWatch() {
        fini();
        CloseHandle(mutex);
    }
    explicit ExWatch(const char* name) : name(name)
        , iomuxmap(this), timerset(), idThread(0), hThread(NULL), hev(NULL), halt(0)
        , tickCount(0), hookStart(), hookTimer(), hookIomux(), hookClean() {
        mutex = CreateMutex(NULL, FALSE, NULL);
        tickCount = tickAppLaunch;
    }
    int fini();
    int init(size_t stacksize = 1048576 * 8);
    int enter() const;
    int leave() const;
    int wakeup() const;
    int setHalt(int r = Ex_Halt);
    int getHalt() const { return halt; }
    uint32 getTick() const { return tickCount; }
protected:
    int setEvent(uint64 u) const;
    int getEvent(uint64* u) const;
    int STDCALL proc();
    int STDCALL onEvent(HANDLE handle);
public:
    #if EX2CONF_LAMBDA_CALLBACK
    int ioAdd(int (STDCALL *f)(void*, HANDLE handle), void* d, HANDLE handle, int pos = -1) {
        return iomuxmap.add(handle, ExNotify(f, d), pos);
    }
    #endif
    template <typename A>
    int ioAdd(A* d, int (STDCALL A::*f)(HANDLE handle), HANDLE handle, int pos) {
        return iomuxmap.add(handle, ExNotify(d, f), pos);
    }
    template <typename A>
    int ioAdd(A* d, int (STDCALL A::* f)(HANDLE handle), HANDLE handle) {
        return iomuxmap.add(handle, ExNotify(d, f));
    }
    int ioDel(HANDLE handle) {
        return getHalt() ? 0 : iomuxmap.del(handle);
    }
protected:
    friend class ExTimer;
};

#endif // WIN32

#endif//__exwatch_w32_h__
