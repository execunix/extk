/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_w32_h__
#define __exwatch_w32_h__

#ifndef __linux__

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
    protected:
        void clearAll();
        void remove(ExTimer* timer);
        void active(ExTimer* timer);
        int  invoke(uint32_t tick_count);
        friend class ExTimer;
        friend class ExWatch;
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
    protected:
        void fini();
        void init();
        // inherit void clear();
        // inherit iterator find(int fd);
        int setup();
        const Iomux* search(HANDLE handle) const;
        int probe(ExCallback& callback, void* cbinfo);
        int add(HANDLE handle, const ExNotify& notify, int pos);
        int add(HANDLE handle, const ExNotify& notify);
        int del(HANDLE handle);
        int invoke(int waittick = INFINITE);
        friend class ExWatch;
    };
protected:
    static uint32_t getTickCount();
    static DWORD WINAPI start(_In_ LPVOID arg);
protected:
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    DWORD           idThread;
    HANDLE          hThread;
    HANDLE          hev;
    int             halt;
    uint32_t        tickCount;
    mutable HANDLE  mutex;
public:
    enum { HookStart, HookTimer, HookIomux, HookClean };
    ExCallback      hooks;
public:
    virtual ~ExWatch() {
        fini();
        CloseHandle(mutex);
    }
    explicit ExWatch() : iomuxmap(this), timerset(),
        idThread(0), hThread(NULL), hev(NULL), halt(0),
        tickCount(0), hooks() {
        mutex = CreateMutex(NULL, FALSE, NULL);
    }
    int fini();
    int init(size_t stacksize = 1048576 * 8);
    int enter() const;
    int leave() const;
    int wakeup() const;
    int setHalt(int r);
    int getHalt() const { return halt; }
    uint32_t getTick() const { return tickCount; }
protected:
    int setEvent(uint64_t u) const;
    int getEvent(uint64_t* u) const;
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
        return iomuxmap.del(handle);
    }
protected:
    friend class ExTimer;
};

#endif // __linux__

#endif//__exwatch_w32_h__
