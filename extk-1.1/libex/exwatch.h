/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_h__
#define __exwatch_h__

#ifdef __linux__

#include "excallback.h"
#include <sys/epoll.h>
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
        mutable pthread_cond_t  cond;
        #endif
    public:
        ~IomuxMap() {
            fini();
            #if EX2CONF_ENABLE_IOMUX_LOCK
            pthread_cond_destroy(&cond);
            pthread_mutex_destroy(&mutex);
            #endif
        }
        IomuxMap(ExWatch* watch) : watch(watch), std::map<int, Iomux*>(), epfd(-1), events(NULL), maxevents(0) {
            #if EX2CONF_ENABLE_IOMUX_LOCK
            pthread_mutex_init(&mutex, NULL);
            pthread_cond_init(&cond, NULL);
            #endif
        }
    protected:
        void fini();
        void init(int max);
        #if EX2CONF_ENABLE_IOMUX_LOCK
        void enter_mux() const;
        void leave_mux() const;
        #endif
        // inherit void clear();
        // inherit iterator find(int fd);
        const Iomux* search(int fd) const;
        int probe(ExCallback& callback, void* cbinfo);
        int add(int fd, uint32_t events, const ExNotify& notify);
        int mod(int fd, uint32_t events, const ExNotify& notify);
        int del(int fd);
        int invoke(int waittick = 60000);
        friend class ExWatch;
    };
protected:
    static uint32_t getTickCount();
    static void* start(void* arg);
protected:
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    pthread_t       tid;
    int             efd;    // event fd
    int             halt;
    uint32_t        tickCount;
    mutable pthread_mutex_t mutex;
    mutable pthread_cond_t  cond;
public:
    enum { HookStart, HookTimer, HookIomux, HookClean };
    ExCallback      hooks;
public:
    virtual ~ExWatch() {
        fini();
        pthread_cond_destroy(&cond);
        pthread_mutex_destroy(&mutex);
    }
    explicit ExWatch() : iomuxmap(this), timerset(), tid(0), efd(-1), halt(0),
                         tickCount(0), hooks() {
        pthread_mutex_init(&mutex, NULL);
        pthread_cond_init(&cond, NULL);
    }
    int fini();
    int init(int max_iomux = 256, size_t stacksize = 1048576);
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
    int STDCALL onEvent(const epoll_event* event);
public:
    template <typename A>
    int ioAdd(A* d, int (STDCALL A::*f)(const epoll_event*), int fd, uint32_t events = EPOLLIN | EPOLLERR) {
        return iomuxmap.add(fd, events, ExNotify(d, f));
    }
    template <typename A>
    int ioMod(A* d, int (STDCALL A::*f)(const epoll_event*), int fd, uint32_t events = EPOLLIN | EPOLLERR) {
        return iomuxmap.mod(fd, events, ExNotify(d, f));
    }
    int ioDel(int fd) {
        return iomuxmap.del(fd);
    }
protected:
    friend class ExTimer;
};

#else // __linux__

#include "exwatch_w32.h"

#endif

extern ExWatch* exWatchGui;
extern ExWatch* exWatchDef;

#endif//__exwatch_h__
