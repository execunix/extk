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
        uint32 invoke(uint32 tick_count);
    };
    // IomuxMap
    struct Iomux {
        int32           fd;
        ExNotify        notify;
        epoll_event     event;
        //mutable enum { NONE, ADD, MOD, DEL, RUN } status;
        Iomux() : notify() {}
    };
    class IomuxMap : protected std::map<int32, Iomux*> {
    protected:
        ExWatch*        watch;
        int32           epfd;   // epoll fd
        epoll_event*    events;
        size_t          maxevents;
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
        IomuxMap(ExWatch* watch) : std::map<int32, Iomux*>(), watch(watch), epfd(-1), events(NULL), maxevents(0) {
            #if EX2CONF_ENABLE_IOMUX_LOCK
            pthread_mutex_init(&mutex, NULL);
            pthread_cond_init(&cond, NULL);
            #endif
        }
    public:
        void fini();
        void init(size_t max);
        #if EX2CONF_ENABLE_IOMUX_LOCK
        void enter_mux() const;
        void leave_mux() const;
        #endif
        // inherit void clear();
        // inherit iterator find(int32 fd);
        const Iomux* search(int32 fd) const;
        uint32 probe(const ExCallback& callback, void* cbinfo);
        bool add(int32 fd, uint32 events, const ExNotify& notify);
        bool mod(int32 fd, uint32 events, const ExNotify& notify);
        bool del(int32 fd);
        uint32 invoke(uint32 waittick = 60000);
    };
public:
    const char* name; // for debug
    static uint32 getTickCount();
    static uint32 tickAppLaunch;
    static pthread_key_t tls_key;
    static void tls_specific(const char* name); // tbd
protected:
    static void* start(void* arg);
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    pthread_t       tid;
    int32           efd;    // event fd
    uint32          halt;
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
    bool fini();
    bool init(size_t max_iomux = 256UL, size_t stacksize = 1048576UL);
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
    uint32 STDCALL onEvent(epoll_event* ev);
public:
    template <typename A>
    bool ioAdd(A* d, uint32 (STDCALL A::*f)(epoll_event*), int32 fd, uint32 events = EPOLLIN | EPOLLERR) {
        return iomuxmap.add(fd, events, ExNotify(d, f));
    }
    template <typename A>
    bool ioMod(A* d, uint32 (STDCALL A::*f)(epoll_event*), int32 fd, uint32 events = EPOLLIN | EPOLLERR) {
        return iomuxmap.mod(fd, events, ExNotify(d, f));
    }
    bool ioDel(int32 fd) {
        return (getHalt() == 0U) ? iomuxmap.del(fd) : false;
    }
#if 0
protected:
    // export api for inheritance
    void timerset_clearAll() { timerset.clearAll(); }
    void iomuxmap_fini() { iomuxmap.fini(); }
    void iomuxmap_init(uint32 max) { iomuxmap.init(max); }
    uint32 timerset_invoke(uint32 tick_count) { return timerset.invoke(tick_count); }
    uint32 iomuxmap_invoke(uint32 waittick = 60000) { return iomuxmap.invoke(waittick); }
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
