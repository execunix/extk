/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#ifdef __linux__
#include <time.h>
#include <sys/unistd.h>
#include <sys/eventfd.h>
#include <sys/epoll.h>

#undef dprint1
#define dprint1(...) printf("ExWatch@" __VA_ARGS__)

// Iomux
//
void ExWatch::IomuxMap::fini() {
    if (events != NULL) {
        free(events);
        events = NULL;
    }
    if (epfd != -1) {
        close(epfd);
        epfd = -1;
    }
    iterator i = begin();
    for (; i != end(); ++i)
        delete i->second;
    clear();
    if (maxevents != 0) {
        maxevents = 0;
    }
}

void ExWatch::IomuxMap::init(size_t max) {
    maxevents = max;
    epfd = epoll_create(maxevents);
    exassert(epfd != -1);
    events = (epoll_event*)malloc(sizeof(epoll_event) * maxevents);
    exassert(events != NULL);
}

#if EX2CONF_ENABLE_IOMUX_LOCK
void ExWatch::IomuxMap::enter_mux() const {
    pthread_mutex_lock(&mutex);
}

void ExWatch::IomuxMap::leave_mux() const {
    pthread_mutex_unlock(&mutex);
}
#endif

const ExWatch::Iomux* ExWatch::IomuxMap::search(int32 fd) const {
    const Iomux* iomux = NULL;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    const_iterator i = find(fd);
    if (i != end())
        iomux = i->second;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return iomux;
}

uint32 ExWatch::IomuxMap::probe(const ExCallback& callback, void* cbinfo) {
    uint32 r = Ex_Continue;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    for (iterator i = begin(); i != end(); ++i) {
        Iomux* iomux = i->second;
        r = callback(iomux, cbinfo);
        if (r != Ex_Continue)
            break;
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return r;
}

bool ExWatch::IomuxMap::add(int32 fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    if (size() < maxevents) {
        Iomux* iomux = new Iomux();
        exassert(iomux != NULL);
        std::pair<iterator, bool> pr;
        pr = insert(value_type(fd, iomux));
        if (pr.second == false) {
            dprint1("IomuxMap::add: duplicated fd=%d\n", fd);
            delete iomux;
            iomux = pr.first->second;
        }
        iomux->fd = fd;
        iomux->notify = notify;
        iomux->event.events = events;
        iomux->event.data.ptr = iomux;
        r = epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &iomux->event);
    } else {
        dprint1("IomuxMap::add: maxevents=%lu\n", maxevents);
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return (r == 0);
}

bool ExWatch::IomuxMap::mod(int32 fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    iterator i = find(fd);
    if (i != end()) {
        Iomux* iomux = i->second;
        exassert(iomux->fd == fd);
        iomux->notify = notify;
        iomux->event.events = events;
        exassert(iomux->event.data.ptr == iomux);
        r = epoll_ctl(epfd, EPOLL_CTL_MOD, fd, &iomux->event);
    } else {
        dprint1("IomuxMap::mod: invalid fd=%d\n", fd);
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return (r == 0);
}

bool ExWatch::IomuxMap::del(int32 fd) {
    int32 r = -1;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    iterator i = find(fd);
    if (i != end()) {
        Iomux* iomux = i->second;
        exassert(iomux->fd == fd);
        exassert(iomux->event.data.ptr == iomux);
        r = epoll_ctl(epfd, EPOLL_CTL_DEL, fd, &iomux->event);
        erase(i);
        delete iomux;
    } else {
        dprint1("IomuxMap::del: invalid fd=%d\n", fd);
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return (r == 0);
}

uint32 ExWatch::IomuxMap::invoke(uint32 waittick) {
    watch->leave();
    #if EX2CONF_ENABLE_IOMUX_LOCK
    enter_mux();
    #endif
    //pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
    int32 cnt = epoll_wait(epfd, events, (int)maxevents, (int)waittick);
    //pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    watch->enter();
    watch->tickCount = getTickCount(); // update tick
    for (int32 i = 0; i < cnt; i++) {
        Iomux* iomux = (Iomux*)events[i].data.ptr;
        epoll_event ev;
        ev.data.fd = iomux->fd;
        ev.events = events[i].events;
        uint32 r = iomux->notify(&ev);
        if (r & Ex_Halt) {
            return watch->setHalt(r);
        }
    }
    return 0;
}

// Watch thread
//
uint32 ExWatch::getTickCount() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    uint32 msec = (uint32)(ts.tv_sec * 1000);
    msec += (uint32)(ts.tv_nsec / 1000000);
    return msec;
}

uint32 ExWatch::tickAppLaunch = ExWatch::getTickCount();

pthread_key_t ExWatch::tls_key = (pthread_key_t)-1;

void ExWatch::tls_specific(const char_t* name)
{
    if (tls_key == (pthread_key_t)-1)
        pthread_key_create(&tls_key, NULL);
    pthread_setspecific(tls_key, malloc(256));
    strcpy((char_t*)pthread_getspecific(tls_key), name);
}

void* ExWatch::start(void* arg) {
    ExWatch* watch = (ExWatch*)arg;
    uint32 r = watch->proc();
    exassert(r == 0);
    return NULL;
}

bool ExWatch::fini() {
    int32 r = 0;
    if (tid != 0) {
        #if 1
        setHalt(Ex_Halt);
        #else
        r = pthread_cancel(tid);
        exassert(r == 0);
        #endif
        leave();
        r = pthread_join(tid, NULL);
        enter();
        exassert(r == 0);
        tid = 0;
    }
    iomuxmap.fini();
    timerset.clearAll();
    if (efd != -1) {
        close(efd);
        efd = -1;
    }
    return (r == 0);
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    int32 r = 0;

    exassert(tid == 0);
    iomuxmap.init(max_iomux);

    efd = eventfd(0U, 0);
    exassert(efd != -1);
    ioAdd(this, &ExWatch::onEvent, efd);

    tickCount = getTickCount(); // update tick

    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, stacksize);
    r = pthread_create(&tid, &attr, start, this);
    exassert(r == 0);
    pthread_attr_destroy(&attr);

    return (r == 0);
}

bool ExWatch::enter() const {
    int32 r = pthread_mutex_lock(&mutex);
    ; // tbd - check cond
    return (r == 0);
}

bool ExWatch::leave() const {
    int32 r = pthread_mutex_unlock(&mutex);
    ; // tbd - check cond
    return (r == 0);
}

bool ExWatch::wakeup() const {
    if (tid != pthread_self()) {
        setEvent(1UL);
        return true;
    }
    return false;
}

uint32 ExWatch::setHalt(uint32 r)
{
    exassert((halt | r) & Ex_Halt);
    if (!(halt & 0x80000000)) {
        halt |= 0x80000000;
        setEvent(1UL);
    }
    return (halt |= r);
}

bool ExWatch::getEvent(uint64* u64) const {
    ssize_t r = 0;
    exassert(efd != -1);
    r = read(efd, u64, sizeof(u64));
    exassert(r == ssizeof(u64));
    return (r == ssizeof(u64));
}

bool ExWatch::setEvent(uint64 u64) const {
    ssize_t r = 0;
    exassert(efd != -1);
    r = write(efd, &u64, sizeof(u64));
    exassert(r == ssizeof(u64));
    return (r == ssizeof(u64));
}

uint32 ExWatch::proc() {
    pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
    tls_specific(name);
    dprint("%s: tickAppLaunch=%d tickCount=%d\n", name, tickAppLaunch, tickCount);
    ExCbInfo cbinfo(0);
    enter();
    if (hookStart)
        hookStart(this, &cbinfo(HookStart));
    while (getHalt() == 0) {
        uint32 waittick = timerset.invoke(tickCount);
        if (getHalt() != 0)
            break;
        if (hookTimer)
            hookTimer(this, &cbinfo(HookTimer));
        // blocked
        iomuxmap.invoke(waittick);
        if (getHalt() != 0)
            break;
        if (hookIomux)
            hookIomux(this, &cbinfo(HookIomux));
    }
    if (hookClean)
        hookClean(this, &cbinfo(HookClean));
    leave();
    return 0U;
}

uint32 ExWatch::onEvent(epoll_event* ev) {
    dprint0("%s: fd=%d ev=%d\n", __func__, ev->data.fd, ev->events);
    exassert(efd == ev->data.fd);
    uint64 u64 = 0UL;
    if (getEvent(&u64))
        dprint0("%s: got event %lu\n", __func__, u64);
    else
        dprint1("%s: got event fail.\n", __func__);

    return 0U;
}

#endif // __linux__

static ExWatch exWatchDflt("exWatchDflt");
ExWatch* exWatchMain = &exWatchDflt;
ExWatch* exWatchLast = &exWatchDflt;
