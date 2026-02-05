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
        uint32 invoke(uint32 tick_count);
    };
    // IomuxMap
    struct Iomux {
        HANDLE          handle;
        ExNotify        notify;
        mutable int32   fRemoved;
        //mutable enum { NONE, ADD, MOD, DEL, RUN } status;
        Iomux() : handle(handle), notify(), fRemoved(0) {}
    };
    class IomuxMap : protected std::list<Iomux> {
    protected:
        ExWatch*        watch;
        int32           count;
        int32           dirty;
        HANDLE          handles[MAXIMUM_WAIT_OBJECTS];
    public:
        ~IomuxMap() { fini(); }
        IomuxMap(ExWatch* watch) : std::list<Iomux>(), watch(watch), count(0), dirty(0) {}
    public:
        void fini();
        void init();
        // inherit void clear();
        // inherit iterator find(int32 fd);
        int32 setup();
        const Iomux* search(HANDLE handle) const;
        uint32 probe(const ExCallback& callback, void* cbinfo);
        bool add(HANDLE handle, const ExNotify& notify, int32 pos);
        bool add(HANDLE handle, const ExNotify& notify);
        bool del(HANDLE handle);
        uint32 invoke(uint32 waittick = INFINITE);
    };
public:
    const char* name; // for debug
    static uint32 getTickCount();
    static uint32 tickAppLaunch;
    static DWORD tls_key;
    static void tls_specific(const char* name); // tbd
protected:
    static DWORD WINAPI start(_In_ LPVOID arg);
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    DWORD           idThread;
    HANDLE          hThread;
    HANDLE          hev;
    uint32          halt;
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
    bool fini();
    bool init(size_t stacksize = 1048576UL);
    bool enter() const;
    bool leave() const;
    bool wakeup() const;
    uint32 setHalt(uint32 r = Ex_Halt);
    uint32 getHalt() const { return halt; }
    uint32 getTick() const { return tickCount; }
protected:
    bool setEvent(uint64 u64) const;
    bool getEvent(uint64* u64) const;
    uint32 STDCALL proc();
    uint32 STDCALL onEvent(HANDLE handle);
public:
    #if EX2CONF_LAMBDA_CALLBACK
    bool ioAdd(uint32 (STDCALL *f)(void*, HANDLE handle), void* d, HANDLE handle, int32 pos = -1) {
        return iomuxmap.add(handle, ExNotify(f, d), pos);
    }
    #endif
    template <typename A>
    bool ioAdd(A* d, uint32 (STDCALL A::*f)(HANDLE handle), HANDLE handle, int32 pos) {
        return iomuxmap.add(handle, ExNotify(d, f), pos);
    }
    template <typename A>
    bool ioAdd(A* d, uint32 (STDCALL A::* f)(HANDLE handle), HANDLE handle) {
        return iomuxmap.add(handle, ExNotify(d, f));
    }
    bool ioDel(HANDLE handle) {
        return (getHalt() == 0U) ? iomuxmap.del(handle) : false;
    }
protected:
    friend class ExTimer;
};

#endif // WIN32

#endif//__exwatch_w32_h__
