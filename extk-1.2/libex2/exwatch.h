/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_h__
#define __exwatch_h__

#include "excallback.h"
#include "exobject.h"
#include "exevent.h"
#include <list>
#include <map>
#include <set>

class ExTimer;

// ExModalCtrl - tbd
//
struct ExModalCtrl {
    uint32          flags;
    void*           result;
    //ExThreadCond*   cond;
    ExModalCtrl() noexcept : flags(Ex_Continue), result(nullptr) {}
};

typedef std::list<ExModalCtrl*> ExModalCtrlList;

// Watch thread hook proc
//
struct ExHookProc : public ExPolyFunc<uint32, uint32> {
    template <typename A>
    ExHookProc(A* d, uint32 (A::*f)(uint32)) noexcept // look like data->func(...)
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A>
    ExHookProc(uint32 (*f)(A*, uint32), A* d) noexcept // look like func(data, ...)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExHookProc(const ExHookProc& cb) noexcept
        : ExPolyFunc(cb) {}
    ExHookProc() noexcept
        : ExPolyFunc() {}

    enum : uint32 {
        Startup,
        Process,
        Cleanup,
    };
    template <typename... Arg>
    uint32 operator () (Arg... arg) const {
        uint32 r;
        if (func != nullptr) {
            #if EX2CONF_DISABLE_STDCALL
            r = (*invoker)(*this, arg...);
            #else
            r = (((Any*)data)->*func)(arg...);
            #endif
        } else {
            r = Ex_Continue;
        }
        return r;
    }
};

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
        void fini();
        void remove(ExTimer* timer);
        void active(ExTimer* timer);
        int64 invoke(uint64 tick_count);
    };
    // IomuxMap
    #ifdef WIN32
    struct Iomux {
        HANDLE          mux_fd;
        ExNotify        notify;
        //mutable enum : int32 { NONE, ADD, MOD, DEL, RUN } status;
        Iomux(HANDLE mux_fd) noexcept : mux_fd(mux_fd), notify() {}
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
        // inherit iterator find(int32 mux_fd);
        DWORD setup();
        const Iomux* search(HANDLE mux_fd) const;
        uint32 probe(const ExCallback& callback, void* cbinfo);
        bool add(HANDLE mux_fd, const ExNotify& notify);
        bool mod(HANDLE mux_fd, const ExNotify& notify);
        bool del(HANDLE mux_fd);
        int64 invoke(int64 waittick = 60000000L);
    };
    #else // __linux__
    struct Iomux {
        int32           mux_fd;
        ExNotify        notify;
        epoll_event     event;
        //mutable enum : int32 { NONE, ADD, MOD, DEL, RUN } status;
        Iomux(int32 mux_fd) noexcept : mux_fd(mux_fd), notify(), event{0U,} {}
    };
    class IomuxMap : protected std::map<int32, Iomux> {
    protected:
        ExWatch*        watch;
        int32           ep_fd;  // epoll fd
        epoll_event*    events;
        size_t          maxevents;
    public:
        ~IomuxMap() noexcept {
            fini();
        }
        IomuxMap(ExWatch* watch) noexcept : std::map<int32, Iomux>()
            , watch(watch), ep_fd(-1), events(nullptr), maxevents(0U) {
        }
    public:
        void fini();
        void init(size_t max);
        // inherit void clear();
        // inherit iterator find(int32 mux_fd);
        const Iomux* search(int32 mux_fd) const;
        uint32 probe(const ExCallback& callback, void* cbinfo);
        bool add(int32 mux_fd, uint32 events, const ExNotify& notify);
        bool mod(int32 mux_fd, uint32 events, const ExNotify& notify);
        bool del(int32 mux_fd);
        int64 invoke(int64 waittick = 60000000L);
    };
    #endif
public:
    const char* name; // for debug
    static uint64 tickAppLaunch;
    #ifdef WIN32
    static DWORD keyTlsSpecific;
    #else // __linux__
    static pthread_key_t keyTlsSpecific;
    #endif
    static const ExWatch* getTlsSpecific();
    static void setTlsSpecific(const ExWatch* watch);
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
    #else // __linux__
    pthread_t       tid;
    #endif
    ExEvent         evWake; // event to wakeup this watch
    uint32          halt;
    uint32          __pad00;
    uint64          tickCount;
    ExMutex         mutex;
    #ifdef __linux__
    mutable pthread_cond_t  cond;
    #endif
    ExModalCtrlList mclist;
public:
    ExHookProc      hookStartup;    // startup
    ExHookProc      hookProcess;    // process
    ExHookProc      hookCleanup;    // cleanup
public:
    #ifdef WIN32
    virtual ~ExWatch() noexcept {
        fini();
    }
    explicit ExWatch(const char* name) noexcept : name(name)
        , iomuxmap(this), timerset(), idThread(0U), hThread(nullptr)
        , evWake(), halt(0U), tickCount(0UL), mutex(), mclist()
        , hookStartup(), hookProcess(this, &ExWatch::process), hookCleanup() {
        tickCount = tickAppLaunch;
    }
    #else // __linux__
    virtual ~ExWatch() noexcept {
        fini();
        pthread_cond_destroy(&cond);
    }
    explicit ExWatch(const char* name) noexcept : name(name)
        , iomuxmap(this), timerset(), tid(0U)
        , evWake(), halt(0U), tickCount(0UL), mutex(), mclist()
        , hookStartup(), hookProcess(this, &ExWatch::process), hookCleanup() {
        pthread_cond_init(&cond, nullptr);
        tickCount = tickAppLaunch;
    }
    #endif
    bool fini();
    bool init(size_t max_iomux = 256UL, size_t stacksize = 1048576UL);
    bool leave() const { return mutex.unlock(); }
    bool enter() const { return mutex.lock(); }
    bool isSelf() const;
    bool wakeup() const { return isSelf() ? false : evWake.signal(); }
    bool isEntered() const { return mutex.islock(); }
    uint32 setHalt(uint32 r = Ex_Halt);
    uint32 getHalt() const { return halt; }
    uint64 getTick() const { return tickCount; }
public:
    #ifdef WIN32
    uint32 onEvent(HANDLE hev);
    #else // __linux__
    uint32 onEvent(const epoll_event* ev);
    #endif
    uint32 proc();
    uint32 process(uint32 hook = ExHookProc::Process);
    uint32 guiloop(uint32 hook = ExHookProc::Process);
    void* dispatch(ExModalCtrl* const ctrl);
    void* modalBlock(ExModalCtrl* const ctrl);
    void modalUnblock(ExModalCtrl* const ctrl, void* result = nullptr);
public:
    #ifdef WIN32
    bool ioAdd(uint32 (*f)(void*, const HANDLE), void* d, const HANDLE mux_fd) { // lambda
        return iomuxmap.add(mux_fd, ExNotify(f, d));
    }
    bool ioMod(uint32 (*f)(void*, const HANDLE), void* d, const HANDLE mux_fd) { // lambda
        return iomuxmap.mod(mux_fd, ExNotify(f, d));
    }
    template <typename A>
    bool ioAdd(A* d, uint32 (A::*f)(const HANDLE), const HANDLE mux_fd) {
        return iomuxmap.add(mux_fd, ExNotify(d, f));
    }
    template <typename A>
    bool ioMod(A* d, uint32 (A::*f)(const HANDLE), const HANDLE mux_fd) {
        return iomuxmap.mod(mux_fd, ExNotify(d, f));
    }
    bool ioDel(const HANDLE mux_fd) {
        return (getHalt() == 0U) ? iomuxmap.del(mux_fd) : false;
    }
    #else // __linux__
    bool ioAdd(uint32 (*f)(void*, const epoll_event*), void* d, const int32 mux_fd, const uint32 events = EPOLLIN | EPOLLERR) { // lambda
        return iomuxmap.add(mux_fd, events, ExNotify(f, d));
    }
    bool ioMod(uint32 (*f)(void*, const epoll_event*), void* d, const int32 mux_fd, const uint32 events = EPOLLIN | EPOLLERR) { // lambda
        return iomuxmap.mod(mux_fd, events, ExNotify(f, d));
    }
    template <typename A, typename T>
    bool ioAdd(A* d, uint32 (A::*f)(T*), const int32 mux_fd, const uint32 events = EPOLLIN | EPOLLERR) {
        static_assert(std::is_base_of<epoll_event, T>::value, "T must be derived from epoll_event");
        return iomuxmap.add(mux_fd, events, ExNotify(d, f));
    }
    template <typename A, typename T>
    bool ioMod(A* d, uint32 (A::*f)(T*), const int32 mux_fd, const uint32 events = EPOLLIN | EPOLLERR) {
        static_assert(std::is_base_of<epoll_event, T>::value, "T must be derived from epoll_event");
        return iomuxmap.mod(mux_fd, events, ExNotify(d, f));
    }
    bool ioDel(const int32 mux_fd) {
        return (getHalt() == 0U) ? iomuxmap.del(mux_fd) : false;
    }
    #endif
protected:
#if 0 // tbd
    // export api for inheritance
    void timerset_fini() { timerset.fini(); }
    void iomuxmap_fini() { iomuxmap.fini(); }
    void iomuxmap_init(uint32 max) { iomuxmap.init(max); }
    int64 timerset_invoke(uint64 tick_count) { return timerset.invoke(tick_count); }
    int64 iomuxmap_invoke(int64 waittick = 60000000L) { return iomuxmap.invoke(waittick); }
#endif // tbd
    friend void ExMainLoop();
    friend class ExMutex;
    friend class ExTimer;
public:
    Ex_DECLARE_TYPEINFO(ExWatch, ExObject);
};

extern ExWatch* exWatchMain;
extern ExWatch* exWatchLast;
extern ExWatch* exWatchDisp;

#endif//__exwatch_h__
