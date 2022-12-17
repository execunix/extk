/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_h__
#define __exwatch_h__

#ifdef __linux__

#include "excallback.h"
#include <sys/epoll.h>
#include <pthread.h>
#include <map>
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
        int             fd;
        ExNotify        notify;
        epoll_event     event;
        //mutable enum { NONE, ADD, MOD, DEL, RUN } status;
        Iomux() : notify() {}
    };
    class IomuxMap : protected std::map<int, Iomux*> {
    protected:
        ExWatch*        watch;
        int             epfd;   // epoll fd
        epoll_event*    events;
        int             maxevents;
        #if EX2CONF_ENABLE_IOMUX_LOCK
        mutable pthread_mutex_t mutex;
        mutable pthread_cond_t cond;
        #endif
    public:
        ~IomuxMap() {
            fini();
            #if EX2CONF_ENABLE_IOMUX_LOCK
            pthread_cond_destroy(&cond);
            pthread_mutex_destroy(&mutex);
            #endif
        }
        IomuxMap(ExWatch* watch) : std::map<int, Iomux*>(), watch(watch), epfd(-1), events(NULL), maxevents(0) {
            #if EX2CONF_ENABLE_IOMUX_LOCK
            pthread_mutex_init(&mutex, NULL);
            pthread_cond_init(&cond, NULL);
            #endif
        }
    public:
        void fini();
        void init(int max);
        #if EX2CONF_ENABLE_IOMUX_LOCK
        void enter_mux() const;
        void leave_mux() const;
        #endif
        // inherit void clear();
        // inherit iterator find(int fd);
        const Iomux* search(int fd) const;
        int probe(const ExCallback& callback, void* cbinfo);
        int add(int fd, uint32 events, const ExNotify& notify);
        int mod(int fd, uint32 events, const ExNotify& notify);
        int del(int fd);
        int invoke(int waittick = 60000);
    };
public:
    const char* name; // for debug
    static uint32 getTickCount();
    static uint32 tickAppLaunch;
protected:
    static void* start(void* arg);
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    pthread_t       tid;
    int             efd;    // event fd
    int             halt;
    uint32          tickCount;
    mutable pthread_mutex_t mutex;
    mutable pthread_cond_t  cond;
public:
    enum { HookStart, HookTimer, HookIomux, HookClean };
    ExCallback      hookStart;
    ExCallback      hookTimer;
    ExCallback      hookIomux;
    ExCallback      hookClean;

public:
    virtual ~ExWatch() {
        fini();
        pthread_cond_destroy(&cond);
        pthread_mutex_destroy(&mutex);
    }
    explicit ExWatch(const char* name) : name(name)
        , iomuxmap(this), timerset(), tid(0), efd(-1), halt(0)
        , tickCount(0), hookStart(), hookTimer(), hookIomux(), hookClean() {
        pthread_mutex_init(&mutex, NULL);
        pthread_cond_init(&cond, NULL);
        tickCount = tickAppLaunch;
    }
    int fini();
    int init(int max_iomux = 256, size_t stacksize = 1048576);
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
    int STDCALL onEvent(epoll_event* ev);
public:
    template <typename A>
    int ioAdd(A* d, int (STDCALL A::*f)(epoll_event*), int fd, uint32 events = EPOLLIN | EPOLLERR) {
        return iomuxmap.add(fd, events, ExNotify(d, f));
    }
    template <typename A>
    int ioMod(A* d, int (STDCALL A::*f)(epoll_event*), int fd, uint32 events = EPOLLIN | EPOLLERR) {
        return iomuxmap.mod(fd, events, ExNotify(d, f));
    }
    int ioDel(int fd) {
        return getHalt() ? 0 : iomuxmap.del(fd);
    }
#if 0
protected:
    // export api for inheritance
    void timerset_clearAll() { timerset.clearAll(); }
    void iomuxmap_fini() { iomuxmap.fini(); }
    void iomuxmap_init(int max) { iomuxmap.init(max); }
    int timerset_invoke(uint32 tick_count) { return timerset_invoke(tick_count); }
    int iomuxmap_invoke(int waittick = 60000) { return iomuxmap_invoke(waittick); }
#endif
protected:
    friend class ExTimer;
};

#else // __linux__

#include "exwatch_w32.h"

#endif

extern ExWatch* exWatchMain;
extern ExWatch* exWatchLast;

#endif//__exwatch_h__
