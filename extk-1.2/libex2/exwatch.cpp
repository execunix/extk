/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#ifdef __linux__
#include <time.h>
#include <sys/unistd.h>
#include <sys/epoll.h>

#undef dprint1
#define dprint1(...) printf("ExWatch@" __VA_ARGS__)

uint64 ExGetMonoClock() {
    struct timespec ts;
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    uint64 usec = (static_cast<uint64>(ts.tv_sec) * 1000000UL);
    usec += (static_cast<uint64>(ts.tv_nsec) / 1000UL);
    return usec;
}

uint32 ExGetTickCount() {
    struct timespec ts;
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    uint64 msec = (static_cast<uint64>(ts.tv_sec) * 1000UL);
    msec += (static_cast<uint64>(ts.tv_nsec) / 1000000UL);
    return static_cast<uint32>(msec);
}

// Iomux
//
void ExWatch::IomuxMap::fini() {
    if (events != nullptr) {
        free(events);
        events = nullptr;
    }
    if (ep_fd != -1) {
        close(ep_fd);
        ep_fd = -1;
    }
    clear();
    if (maxevents != 0U) {
        maxevents = 0U;
    }
}

void ExWatch::IomuxMap::init(size_t max) {
    maxevents = max;
    ep_fd = epoll_create(maxevents);
    exassert(ep_fd != -1);
    events = (epoll_event*)malloc(sizeof(epoll_event) * maxevents);
    exassert(events != nullptr);
}

const ExWatch::Iomux* ExWatch::IomuxMap::search(int32 mux_fd) const {
    const Iomux* iomux = nullptr;
    const_iterator i = find(mux_fd);
    if (i != end()) {
        iomux = &i->second;
    }
    return iomux;
}

uint32 ExWatch::IomuxMap::probe(const ExCallback& callback, void* cbinfo) {
    uint32 r = Ex_Continue;
    for (iterator i = begin(); i != end(); ++i) {
        Iomux* iomux = &i->second;
        r = callback(iomux, cbinfo);
        if (r != Ex_Continue) {
            break;
        }
    }
    return r;
}

bool ExWatch::IomuxMap::add(int32 mux_fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    if (size() < maxevents) {
        Iomux* iomux = nullptr;
        std::pair<iterator, bool> pr;
        pr = insert(value_type(mux_fd, Iomux(mux_fd)));
        iomux = &pr.first->second;
        if (pr.second == false) {
            dprint1("IomuxMap::add: duplicate mux_fd:%zu\n", (size_t)mux_fd);
        }
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        iomux->event.events = events;
        iomux->event.data.ptr = iomux;
        r = epoll_ctl(ep_fd, EPOLL_CTL_ADD, mux_fd, &iomux->event);
    } else {
        dprint1("IomuxMap::add: maxevents:%zu\n", maxevents);
    }
    return (r == 0);
}

bool ExWatch::IomuxMap::mod(int32 mux_fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        iomux->event.events = events;
        exassert(iomux->event.data.ptr == iomux);
        r = epoll_ctl(ep_fd, EPOLL_CTL_MOD, mux_fd, &iomux->event);
    } else {
        dprint1("IomuxMap::mod: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    return (r == 0);
}

bool ExWatch::IomuxMap::del(int32 mux_fd) {
    int32 r = -1;
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        exassert(iomux->event.data.ptr == iomux);
        r = epoll_ctl(ep_fd, EPOLL_CTL_DEL, mux_fd, &iomux->event);
        erase(i);
    } else {
        dprint1("IomuxMap::del: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    return (r == 0);
}

int32 ExWatch::IomuxMap::invoke(int32 waittick) {
    const uint32 tick0 = watch->tickCount; // get current tick
    watch->leave();
    //pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, nullptr);
    const int32 cnt = epoll_wait(ep_fd, events, (int)maxevents, waittick);
    //pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, nullptr);
    watch->enter();
    for (int32 i = 0; i < cnt; i++) {
        Iomux* iomux = (Iomux*)events[i].data.ptr;
        epoll_event ev;
        ev.data.fd = iomux->mux_fd;
        ev.events = events[i].events;
        uint32 r = iomux->notify(&ev);
        r |= watch->getHalt();
        if (ExIsHalt(r)) {
            (void)watch->setHalt(r);
            break; // stop iomux loop
        }
        // tbd - manage remove flag
        // if (r & Ex_Remove) { del(iomux->mux_fd); }
    }
    if (cnt < 0) {
        exerror("IomuxMap: cnt:%d %s\n", cnt, exstrerr());
    }
    watch->tickCount = ExGetTickCount(); // update tick
    return (watch->tickCount - tick0); // return elapsed tick
}

// Watch thread
//
uint32 ExWatch::tickAppLaunch = ExGetTickCount();

pthread_key_t ExWatch::tls_key = (pthread_key_t)-1;

void ExWatch::tls_specific(const char* name)
{
    if (tls_key == (pthread_key_t)-1) {
        pthread_key_create(&tls_key, nullptr);
    }
    pthread_setspecific(tls_key, malloc(256UL));
    strcpy((char*)pthread_getspecific(tls_key), name);
}

void* ExWatch::start(void* arg) {
    ExWatch* watch = (ExWatch*)arg;
    uint32 r = watch->proc();
    exassert(r == 0);
    return nullptr;
}

bool ExWatch::fini() {
    int32 r = 0;
    if (tid != 0UL) {
        #if 1
        setHalt(Ex_Halt);
        #else
        r = pthread_cancel(tid);
        exassert(r == 0);
        #endif
        leave();
        r = pthread_join(tid, nullptr);
        enter();
        exassert(r == 0);
        tid = 0UL;
    }
    iomuxmap.fini();
    timerset.fini();
    evWake.fini();
    return (r == 0);
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    int32 r = 0;

    exassert(tid == 0UL);
    iomuxmap.init(max_iomux);

    evWake.init();
    ioAdd(this, &ExWatch::onEvent, evWake);

    tickCount = ExGetTickCount(); // update tick

    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, stacksize);
    r = pthread_create(&tid, &attr, start, this);
    exassert(r == 0);
    pthread_attr_destroy(&attr);

    return (r == 0);
}

bool ExWatch::isSelf() const {
    return ((tid == 0UL) || (tid == pthread_self()));
}

uint32 ExWatch::setHalt(uint32 r)
{
    exassert(((halt | r) & Ex_Halt) != 0U);
    if (!(halt & 0x80000000)) {
        halt |= 0x80000000;
        evWake.signal();
    }
    return (halt |= r);
}

uint32 ExWatch::onEvent(const epoll_event* const ev) {
    dprint0("%s: fd:%d ev:%d\n", __func__, ev->data.fd, ev->events);
    exassert(evWake == ev->data.fd);
    (void)evWake.reset();
    return 0U;
}

#endif // __linux__

uint32 ExWatch::proc() {
    int32 waittick = 0;
#ifdef __linux__
    pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, nullptr);
#endif // __linux__
    tls_specific(name);
    dprint("%s: tickAppLaunch=%d tickCount=%d\n", name, tickAppLaunch, tickCount);
    (void)enter();
    // seq-1 : prepare resources
    (void)procStartup(ExHookProc::Startup);
    while (getHalt() == 0U) {
        uint32 r;
        // seq-2 : dispatch event
        r = procDispatch(ExHookProc::Dispatch);
        if (ExIsHalt(r | getHalt())) {
            break;
        }
        // seq-3 : invoke timer callback
        waittick = timerset.invoke(tickCount);
        if (ExIsHalt(getHalt())) { // is halt ?
            break; // stop exmsg loop
        }
        #if 1 // adjust for internal timer callback sleep
        waittick -= (ExGetTickCount() - tickCount);
        if (waittick < 1) {
            waittick = 1;
        }
        #endif
        // seq-4 : collect resources, flush gui, ...
        r = procMaintain(ExHookProc::Maintain);
        if (ExIsHalt(r | getHalt())) {
            break;
        }
        // seq-5 : wait blocked iomux for waittick msec and update tick count
        waittick = iomuxmap.invoke(waittick); // The only waiting point.
        // seq-6 : invoked iomux callback
        #if 1 // adjust for internal epoll callback sleep
        // waittick : apply epoll callback sleep tick
        #endif
    }
    // seq-6 : cleanup resources
    (void)procCleanup(ExHookProc::Cleanup);
    (void)leave();
    return 0U;
}

static ExWatch exWatchDflt("exWatchDflt");
ExWatch* exWatchMain = &exWatchDflt;
ExWatch* exWatchLast = &exWatchDflt;
ExWatch* exWatchDisp = nullptr; // tbd - assign individual window watch
