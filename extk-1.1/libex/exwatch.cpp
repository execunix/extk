/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#ifdef __linux__
#include <time.h>
#include <pthread.h>
#include <sys/unistd.h>
#include <sys/eventfd.h>
#include <sys/epoll.h>
#include <assert.h>

#ifdef __GNUC__
#define dprint0(...)
#define dprint1(...) printf("ExWatch@" __VA_ARGS__)
#define dprintf dprint1
#endif

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

void ExWatch::IomuxMap::init(int max) {
    maxevents = max;
    epfd = epoll_create(maxevents);
    assert(epfd != -1);
    events = (epoll_event*)malloc(sizeof(epoll_event) * maxevents);
    assert(events != NULL);
}

#if EX2CONF_ENABLE_IOMUX_LOCK
void ExWatch::IomuxMap::enter_mux() const {
    pthread_mutex_lock(&mutex);
}

void ExWatch::IomuxMap::leave_mux() const {
    pthread_mutex_unlock(&mutex);
}
#endif

const ExWatch::Iomux* ExWatch::IomuxMap::search(int fd) const {
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

int ExWatch::IomuxMap::probe(ExCallback& callback, void* cbinfo) {
    int r = Ex_Continue;
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

int ExWatch::IomuxMap::add(int fd, uint32_t events, const ExNotify& notify) {
    int r = -1;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    if (size() < (size_t)maxevents) {
        Iomux* iomux = new Iomux();
        assert(iomux != NULL);
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
        dprint1("IomuxMap::add: maxevents=%d\n", maxevents);
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return r;
}

int ExWatch::IomuxMap::mod(int fd, uint32_t events, const ExNotify& notify) {
    int r = -1;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    iterator i = find(fd);
    if (i != end()) {
        Iomux* iomux = i->second;
        assert(iomux->fd == fd);
        iomux->notify = notify;
        iomux->event.events = events;
        assert(iomux->event.data.ptr == iomux);
        r = epoll_ctl(epfd, EPOLL_CTL_MOD, fd, &iomux->event);
    } else {
        dprint1("IomuxMap::mod: invalid fd=%d\n", fd);
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return r;
}

int ExWatch::IomuxMap::del(int fd) {
    int r = -1;
    #if EX2CONF_ENABLE_IOMUX_LOCK
    watch->wakeup();
    enter_mux();
    #endif
    iterator i = find(fd);
    if (i != end()) {
        Iomux* iomux = i->second;
        assert(iomux->fd == fd);
        assert(iomux->event.data.ptr == iomux);
        r = epoll_ctl(epfd, EPOLL_CTL_DEL, fd, &iomux->event);
        erase(i);
        delete iomux;
    } else {
        dprint1("IomuxMap::del: invalid fd=%d\n", fd);
    }
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    return r;
}

int ExWatch::IomuxMap::invoke(int waittick) {
    watch->leave();
    #if EX2CONF_ENABLE_IOMUX_LOCK
    enter_mux();
    #endif
    //pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
    int cnt = epoll_wait(epfd, events, maxevents, waittick);
    //pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
    #if EX2CONF_ENABLE_IOMUX_LOCK
    leave_mux();
    #endif
    watch->enter();
    watch->tickCount = getTickCount(); // update tick
    for (int i = 0; i < cnt; i++) {
        Iomux* iomux = (Iomux*)events[i].data.ptr;
        int r = iomux->notify(&events[i]);
        if (r & Ex_Halt) {
            return watch->setHalt(r);
        }
    }
    return 0;
}

// Watch thread
//
uint32_t ExWatch::getTickCount() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    uint32_t msec = (uint32_t)(ts.tv_sec * 1000);
    msec += (uint32_t)(ts.tv_nsec / 1000000);
    return msec;
}

void* ExWatch::start(void* arg) {
    ExWatch* watch = (ExWatch*)arg;
    int r = watch->proc();
    assert(r == 0);
    return NULL;
}

int ExWatch::fini() {
    int r = 0;
    if (tid != 0) {
        #if 1
        setHalt(Ex_Halt);
        #else
        r = pthread_cancel(tid);
        assert(r == 0);
        #endif
        leave();
        r = pthread_join(tid, NULL);
        enter();
        assert(r == 0);
        tid = 0;
    }
    iomuxmap.fini();
    timerset.clearAll();
    if (efd != -1) {
        close(efd);
        efd = -1;
    }
    return r;
}

int ExWatch::init(int max_iomux, size_t stacksize) {
    int r = 0;

    assert(tid == 0);
    iomuxmap.init(max_iomux);

    efd = eventfd(0, 0);
    assert(efd != -1);
    ioAdd(this, &ExWatch::onEvent, efd);

    tickCount = getTickCount(); // update tick

    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, stacksize);
    r = pthread_create(&tid, &attr, start, this);
    assert(r == 0);
    pthread_attr_destroy(&attr);

    return r;
}

int ExWatch::enter() const {
    int r = pthread_mutex_lock(&mutex);
    ; // tbd - check cond
    return r;
}

int ExWatch::leave() const {
    int r = pthread_mutex_unlock(&mutex);
    ; // tbd - check cond
    return r;
}

int ExWatch::wakeup() const {
    if (tid != pthread_self()) {
        setEvent(1);
        return 1;
    }
    return 0;
}

int ExWatch::setHalt(int r)
{
    assert((halt | r) & Ex_Halt);
    if (!(halt & 0x80000000)) {
        halt |= 0x80000000;
        setEvent(1);
    }
    return halt |= r;
}

int ExWatch::getEvent(uint64_t* u) const {
    int r = 0;
    assert(efd != -1);
    r = read(efd, u, sizeof(uint64_t));
    assert(r == sizeof(uint64_t));
    return r == sizeof(uint64_t) ? 0 : -1;
}

int ExWatch::setEvent(uint64_t u) const {
    int r = 0;
    assert(efd != -1);
    r = write(efd, &u, sizeof(uint64_t));
    assert(r == sizeof(uint64_t));
    return r == sizeof(uint64_t) ? 0 : -1;
}

int ExWatch::proc() {
    pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
    ExCbInfo cbinfo(0);
    enter();
    if (hooks)
        hooks(this, &cbinfo(HookStart));
    while (getHalt() == 0) {
        int waittick = timerset.invoke(tickCount);
        if (getHalt() != 0)
            break;
        if (hooks)
            hooks(this, &cbinfo(HookTimer));
        // blocked
        iomuxmap.invoke(waittick);
        if (getHalt() != 0)
            break;
        if (hooks)
            hooks(this, &cbinfo(HookIomux));
    }
    if (hooks)
        hooks(this, &cbinfo(HookClean));
    leave();
    return 0;
}

int ExWatch::onEvent(const epoll_event* event) {
    Iomux* iomux = (Iomux*)event->data.ptr;
    dprint0("%s: fd=%d ev=%d ptr=%p\n", __func__, iomux->fd, iomux->event.events, iomux);
    assert(efd == iomux->fd);
    uint64_t u64;
    getEvent(&u64);
    dprintf("%s: got event %lu\n", __func__, u64);

    #if 0/*EX2CONF_ENABLE_IOMUX_LOCK*/ // tbd - cond wait and signal
    pthread_cond_wait(&cond, &mutex);
    ...
    pthread_cond_signal(&cond);
    #endif

    return 0;
}

#endif // __linux__

static ExWatch exWatchMain;
ExWatch* exWatchGui = &exWatchMain;
ExWatch* exWatchDef = &exWatchMain;

