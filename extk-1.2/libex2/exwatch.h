/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwatch_h__
#define __exwatch_h__

#include "excallback.h"
#include "exobject.h"
#include "exevent.h"
#ifdef __linux__
#include <sys/poll.h>
#include <sys/epoll.h>
#endif // __linux__
#include <list>
#include <map>
#include <set>

#ifdef __linux__
//#define IOMUX_PPOLL
#endif // __linux__

// OsaFd: OS Adaptation File Descriptor
#ifdef WIN32
typedef HANDLE  OsaFd;
#else // __linux__
typedef int32   OsaFd;
#endif

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
    struct Iomux {
        ExNotify        notify;
        OsaFd           mux_fd;
        epoll_event     arg_ev;
        Iomux(OsaFd mux_fd) noexcept : notify(), mux_fd(mux_fd), arg_ev{0U,} {}
        //mutable enum : int32 { NONE, ADD, MOD, DEL, RUN } status;
    };
    class IomuxMap : protected std::map<OsaFd, Iomux> {
    protected:
        ExWatch*        watch;
#ifdef WIN32
        int32           dirty;
        OsaFd           handles[MAXIMUM_WAIT_OBJECTS];
#else // __linux__
        #if defined(IOMUX_PPOLL)
        int32           dirty;
        pollfd*         fds;
        #else // !IOMUX_PPOLL
        int32           ep_fd;  // epoll fd
        epoll_event*    evrepo;
        #endif // IOMUX_PPOLL
        size_t          max_fds;
#endif
    public:
        ~IomuxMap() noexcept {
            fini();
        }
#ifdef WIN32
        IomuxMap(ExWatch* watch) noexcept : std::map<OsaFd, Iomux>()
            , watch(watch), dirty(0) {
            memset(handles, 0, sizeof(handles));
        }
#else // __linux__
        #if defined(IOMUX_PPOLL)
        IomuxMap(ExWatch* watch) noexcept : std::map<OsaFd, Iomux>()
            , watch(watch), dirty(0), fds(nullptr), max_fds(0U) {
        }
        #else // !IOMUX_PPOLL
        IomuxMap(ExWatch* watch) noexcept : std::map<OsaFd, Iomux>()
            , watch(watch), ep_fd(-1), evrepo(nullptr), max_fds(0U) {
        }
        #endif // IOMUX_PPOLL
#endif
    public:
        void fini();
        void init(size_t max);
        // inherit void clear();
        // inherit iterator find(OsaFd mux_fd);
        #ifdef WIN32
        DWORD setup();
        #endif
        #if defined(IOMUX_PPOLL)
        nfds_t setup();
        #endif // IOMUX_PPOLL
        const Iomux* search(OsaFd mux_fd) const;
        uint32 probe(const ExCallback& callback, void* cbinfo);
        bool add(OsaFd mux_fd, uint32 events, const ExNotify& notify);
        bool mod(OsaFd mux_fd, uint32 events, const ExNotify& notify);
        bool del(OsaFd mux_fd);
        int64 invoke(int64 waittick = 60000000L);
    };
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
    DWORD id() const noexcept { return idThread; }
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
    pthread_t id() const noexcept { return tid; }
    #endif
    bool fini();
    bool init(size_t max_iomux = 256UL, size_t stacksize = 1048576UL);
    bool leave() const { return mutex.unlock(); }
    bool enter() const { return mutex.lock(); }
    bool wakeup() const { return evWake.signal(); }
    uint32 setHalt(uint32 r = Ex_Halt);
    uint32 getHalt() const { return halt; }
    uint64 getTick() const { return tickCount; }
    uint32 getTickMs() const { return static_cast<uint32>(tickCount / 1000U); }
public:
    uint32 onEvent(const epoll_event* ev);
    uint32 proc();
    uint32 process(uint32 hook = ExHookProc::Process);
    uint32 guiloop(uint32 hook = ExHookProc::Process);
    void* dispatch(ExModalCtrl* const ctrl);
    void* modalBlock(ExModalCtrl* const ctrl);
    void modalUnblock(ExModalCtrl* const ctrl, void* result = nullptr);
public:
    bool ioAdd(uint32 (*f)(void*, const epoll_event*), void* d, const OsaFd mux_fd, const uint32 events = EPOLLIN | EPOLLERR) { // lambda
        return iomuxmap.add(mux_fd, events, ExNotify(f, d));
    }
    bool ioMod(uint32 (*f)(void*, const epoll_event*), void* d, const OsaFd mux_fd, const uint32 events = EPOLLIN | EPOLLERR) { // lambda
        return iomuxmap.mod(mux_fd, events, ExNotify(f, d));
    }
    template <typename A, typename T>
    bool ioAdd(A* d, uint32 (A::*f)(T*), const OsaFd mux_fd, const uint32 events = EPOLLIN | EPOLLERR) {
        static_assert(std::is_base_of<epoll_event, T>::value, "T must be derived from epoll_event");
        return iomuxmap.add(mux_fd, events, ExNotify(d, f));
    }
    template <typename A, typename T>
    bool ioMod(A* d, uint32 (A::*f)(T*), const OsaFd mux_fd, const uint32 events = EPOLLIN | EPOLLERR) {
        static_assert(std::is_base_of<epoll_event, T>::value, "T must be derived from epoll_event");
        return iomuxmap.mod(mux_fd, events, ExNotify(d, f));
    }
    bool ioDel(const OsaFd mux_fd) {
        return (getHalt() == 0U) ? iomuxmap.del(mux_fd) : false;
    }
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

class AutoLockAnoWatch {
    ExWatch* watch;
public:
    ~AutoLockAnoWatch() {
        (void)watch->leave();
    }
    explicit AutoLockAnoWatch(ExWatch* watch) : watch(watch) {
        (void)watch->enter();
    }
};

extern ExWatch* exWatchMain;
extern ExWatch* exWatchLast;
extern ExWatch* exWatchDisp;

#endif//__exwatch_h__
