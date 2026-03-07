/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_h__
#define __exwatch_h__

#include "excallback.h"
#include "exobject.h"
#ifdef WIN32
#include "exthread.h"
#else // __linux__
#include <sys/epoll.h>
#include <pthread.h>
#endif
#include <map>
#include <set>

#define EX2CONF_ENABLE_IOMUX_LOCK 0

class ExTimer;

uint64 ExGetMonoClock(void);
uint32 ExGetTickCount(void);

// Watch thread
//
class ExWatch : public ExObject {
protected:
    // TimerSet
    struct TickCompare { // less traits
        bool operator () (const ExTimer* l, const ExTimer* r) const;
    };
    class TimerSet : public std::multiset<ExTimer*, TickCompare> {
    public:
        TimerSet() noexcept : std::multiset<ExTimer*, TickCompare>() {}
    public:
        void clearAll();
        void remove(ExTimer* timer);
        void active(ExTimer* timer);
        uint32 invoke(uint32 tick_count);
    };
    // IomuxMap
    #ifdef WIN32
    struct Iomux {
        HANDLE          handle;
        ExNotify        notify;
        //mutable enum : int32 { NONE, ADD, MOD, DEL, RUN } status;
        Iomux(HANDLE handle) noexcept : handle(handle), notify() {}
    };
    class IomuxMap : protected std::map<HANDLE, Iomux> {
    protected:
        ExWatch*        watch;
        int32           dirty;
        HANDLE          handles[MAXIMUM_WAIT_OBJECTS];
    public:
        ~IomuxMap() noexcept {
            fini();
        }
        IomuxMap(ExWatch* watch) noexcept : std::map<HANDLE, Iomux>(), watch(watch), dirty(0) {
            memset(handles, 0, sizeof(handles));
        }
    public:
        void fini();
        void init(size_t max);
        // inherit void clear();
        // inherit iterator find(int32 fd);
        DWORD setup();
        const Iomux* search(HANDLE handle) const;
        uint32 probe(const ExCallback& callback, void* cbinfo);
        bool add(HANDLE handle, const ExNotify& notify);
        bool mod(HANDLE handle, const ExNotify& notify);
        bool del(HANDLE handle);
        uint32 invoke(uint32 waittick = INFINITE);
    };
    #else // __linux__
    struct Iomux {
        int32           fd;
        ExNotify        notify;
        epoll_event     event;
        //mutable enum : int32 { NONE, ADD, MOD, DEL, RUN } status;
        Iomux() noexcept : notify() {}
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
        ~IomuxMap() noexcept {
            fini();
            #if EX2CONF_ENABLE_IOMUX_LOCK
            pthread_cond_destroy(&cond);
            pthread_mutex_destroy(&mutex);
            #endif
        }
        IomuxMap(ExWatch* watch) noexcept : std::map<int32, Iomux*>()
            , watch(watch), epfd(-1), events(NULL), maxevents(0U) {
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
    #endif
public:
    const char* name; // for debug
    static uint32 tickAppLaunch;
    #ifdef WIN32
    static DWORD tls_key;
    #else // __linux__
    static pthread_key_t tls_key;
    #endif
    static void tls_specific(const char* name); // tbd
protected:
    #ifdef WIN32
    static DWORD WINAPI start(_In_ LPVOID arg);
    #else // __linux__
    static void* start(void* arg);
    #endif
    IomuxMap        iomuxmap;
    TimerSet        timerset;
    #ifdef WIN32
    DWORD           idThread;
    HANDLE          hThread;
    HANDLE          hev;
    #else // __linux__
    pthread_t       tid;
    int32           efd;    // event fd
    #endif
    uint32          halt;
    uint32          tickCount;
    #ifdef WIN32
    mutable HANDLE  mutex;
    #else // __linux__
    mutable pthread_mutex_t mutex;
    mutable pthread_cond_t  cond;
    #endif
public:
    enum : int32 { HookReady, HookStart, HookTimer, HookIomux, HookClean };
    int32           hookPhase; // for misra rules
    ExCallback      hookStart;
    ExCallback      hookTimer;
    ExCallback      hookIomux;
    ExCallback      hookClean;

public:
    #ifdef WIN32
    virtual ~ExWatch() noexcept {
        fini();
        CloseHandle(mutex);
    }
    explicit ExWatch(const char* name) noexcept : name(name)
        , iomuxmap(this), timerset(), idThread(0), hThread(NULL), hev(NULL), halt(0), tickCount(0)
        , hookPhase(HookReady), hookStart(), hookTimer(), hookIomux(), hookClean() {
        mutex = CreateMutex(NULL, FALSE, NULL);
        tickCount = tickAppLaunch;
    }
    #else // __linux__
    virtual ~ExWatch() noexcept {
        fini();
        pthread_cond_destroy(&cond);
        pthread_mutex_destroy(&mutex);
    }
    explicit ExWatch(const char* name) noexcept : name(name)
        , iomuxmap(this), timerset(), tid(0), efd(-1), halt(0), tickCount(0)
        , hookPhase(HookReady), hookStart(), hookTimer(), hookIomux(), hookClean() {
        pthread_mutex_init(&mutex, NULL);
        pthread_cond_init(&cond, NULL);
        tickCount = tickAppLaunch;
    }
    #endif
    bool fini();
    bool init(size_t max_iomux = 256UL, size_t stacksize = 1048576UL);
    bool enter() const;
    bool leave() const;
    bool wakeup() const;
    uint32 setHalt(uint32 r = Ex_Halt);
    uint32 getHalt() const;
    uint32 getTick() const { return tickCount; }
protected:
    bool setEvent(uint64 u64) const;
    bool getEvent(uint64* u64) const;
    uint32 proc();
    #ifdef WIN32
    uint32 onEvent(HANDLE handle);
    #else // __linux__
    uint32 onEvent(const epoll_event* ev);
    #endif
public:
    #ifdef WIN32
    bool ioAdd(uint32 (*f)(void*, const HANDLE), void* d, const HANDLE handle) { // lambda
        return iomuxmap.add(handle, ExNotify(f, d));
    }
    bool ioMod(uint32 (*f)(void*, const HANDLE), void* d, const HANDLE handle) { // lambda
        return iomuxmap.mod(handle, ExNotify(f, d));
    }
    template <typename A>
    bool ioAdd(A* d, uint32 (A::*f)(const HANDLE), const HANDLE handle) {
        return iomuxmap.add(handle, ExNotify(d, f));
    }
    template <typename A>
    bool ioMod(A* d, uint32 (A::*f)(const HANDLE), const HANDLE handle) {
        return iomuxmap.mod(handle, ExNotify(d, f));
    }
    bool ioDel(const HANDLE handle) {
        return (getHalt() == 0U) ? iomuxmap.del(handle) : false;
    }
    #else // __linux__
    bool ioAdd(uint32 (*f)(void*, const epoll_event*), void* d, const int32 fd, const uint32 events = EPOLLIN | EPOLLERR) { // lambda
        return iomuxmap.add(fd, events, ExNotify(f, d));
    }
    bool ioMod(uint32 (*f)(void*, const epoll_event*), void* d, const int32 fd, const uint32 events = EPOLLIN | EPOLLERR) { // lambda
        return iomuxmap.mod(fd, events, ExNotify(f, d));
    }
    template <typename A, typename T>
    bool ioAdd(A* d, uint32 (A::*f)(T*), const int32 fd, const uint32 events = EPOLLIN | EPOLLERR) {
        static_assert(std::is_base_of<epoll_event, T>::value, "T must be derived from epoll_event");
        return iomuxmap.add(fd, events, ExNotify(d, f));
    }
    template <typename A, typename T>
    bool ioMod(A* d, uint32 (A::*f)(T*), const int32 fd, const uint32 events = EPOLLIN | EPOLLERR) {
        static_assert(std::is_base_of<epoll_event, T>::value, "T must be derived from epoll_event");
        return iomuxmap.mod(fd, events, ExNotify(d, f));
    }
    bool ioDel(const int32 fd) {
        return (getHalt() == 0U) ? iomuxmap.del(fd) : false;
    }
    #endif
protected:
#if 0 // tbd
    // export api for inheritance
    void timerset_clearAll() { timerset.clearAll(); }
    void iomuxmap_fini() { iomuxmap.fini(); }
    void iomuxmap_init(uint32 max) { iomuxmap.init(max); }
    uint32 timerset_invoke(uint32 tick_count) { return timerset.invoke(tick_count); }
    uint32 iomuxmap_invoke(uint32 waittick = 60000) { return iomuxmap.invoke(waittick); }
#endif // tbd
    friend class ExTimer;
public:
    Ex_DECLARE_TYPEINFO(ExWatch, ExObject);
};

extern ExWatch* exWatchMain;
extern ExWatch* exWatchLast;
extern ExWatch* exWatchDisp;

#endif//__exwatch_h__
