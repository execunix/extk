/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "exwproc.h"
#include "exapp.h"
#ifdef __linux__
#include <time.h>
#include <sys/unistd.h>
#include <sys/epoll.h>

// #undef dprint1
// #define dprint1(...) printf("ExWatch@" __VA_ARGS__)

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

pthread_key_t ExWatch::keyTlsSpecific = (pthread_key_t)-1;

const ExWatch* ExWatch::getTlsSpecific() {
    const ExWatch* watch = nullptr;
    if (keyTlsSpecific != (pthread_key_t)-1) {
        watch = (const ExWatch*)pthread_getspecific(keyTlsSpecific);
    }
    return watch;
}

void ExWatch::setTlsSpecific(const ExWatch* watch) {
    if (keyTlsSpecific == (pthread_key_t)-1) {
        pthread_key_create(&keyTlsSpecific, nullptr);
    }
    exassert(keyTlsSpecific != (pthread_key_t)-1);
    exassert(pthread_getspecific(keyTlsSpecific) == nullptr);
    pthread_setspecific(keyTlsSpecific, watch);
}

void* ExWatch::start(void* arg) {
    ExWatch* watch = (ExWatch*)arg;
    uint32 r = watch->proc();
    exassert(r == 0U);
    return nullptr;
}

bool ExWatch::fini() {
    int32 r = 0;
    if (tid != 0U) {
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
        tid = 0U;
    }
    iomuxmap.fini();
    timerset.fini();
    evWake.fini();
    return (r == 0);
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    int32 r = 0;

    exassert(tid == 0U);
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
    return ((tid == 0U) || (tid == pthread_self()));
}

uint32 ExWatch::onEvent(const epoll_event* const ev) {
    dprint0("%s: fd:%d ev:%d\n", __func__, ev->data.fd, ev->events);
    exassert(evWake == ev->data.fd);
    (void)evWake.reset();
    return 0U;
}

#endif // __linux__

uint32 ExWatch::setHalt(uint32 r) {
    exassert(((halt | r) & Ex_Halt) != 0U);
    halt |= (r | 0x01100000U);
    evWake.signal();
    return halt;
}

uint32 ExWatch::proc() {
#ifdef __linux__
    pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, nullptr);
#endif // __linux__
    setTlsSpecific(this);
    dprint("ExWatch::proc(%s) tickAppLaunch=%d tickCount=%d\n", name, tickAppLaunch, tickCount);
    (void)enter();
    // seq-1 : prepare resources
    (void)hookStartup(ExHookProc::Startup);
    // seq-2 : dispatch... ~ seq-5 : wait blocked iomux...
    (void)hookProcess(ExHookProc::Process);
    // seq-6 : cleanup resources
    (void)hookCleanup(ExHookProc::Cleanup);
    (void)leave();
    dprint("ExWatch::proc(%s) done... tickCount=%d\n", name, tickCount);
    return 0U;
}

uint32 ExWatch::process(uint32 hook) {
    int32 waittick = 0;
    exassert(isEntered());
    while (!ExIsHalt(getHalt())) {
        // seq-2 : dispatch event
        // n/a
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
        // n/a
        // seq-5 : wait blocked iomux for waittick msec and update tick count
        waittick = iomuxmap.invoke(waittick); // The only waiting point.
        // seq-6 : invoked iomux callback
        #if 1 // adjust for internal epoll callback sleep
        // waittick : apply epoll callback sleep tick
        #endif
    }
    return 0U;
}

uint32 ExWatch::guiloop(uint32 hook) {
    ExModalCtrl ctrl;
    (void)modalBlock(&ctrl);
    return 0U;
}

void* ExWatch::dispatch(ExModalCtrl* const ctrl) {
    #ifdef __linux__
    ExMsg msg(None);
    #else // WIN32
    MSG msg;
    #endif
    do {
        if (ExPeekMessage(&msg) == nullptr) {
            break;
        }
        if ((msg.message == WM_NULL) || (msg.message == WM_ExEvWake)) {
            dprint("skip message: 0x%04x\n", msg.message);
            continue;
        }
        // message is available
        if (msg.message == WM_QUIT) { // WM_DESTROY => PostQuitMessage
            dprint("WM_QUIT tick=%d\n", getTick());
            ExApp::retCode = (int32)msg.wParam; // cause DestroyWindow
            (void)setHalt(Ex_Halt); // stop exmsg loop
            break;
        }
        leave();
        #ifdef __linux__
        (void)DefWndProc(msg); // dispatch message to window procedure
        #else // WIN32
        TranslateMessage(&msg);
        DispatchMessage(&msg);
        #endif
        enter();
    } while (!ExIsHalt(ctrl->flags | getHalt()));
    return ctrl->result;
}

void* ExWatch::modalBlock(ExModalCtrl* const ctrl) {
    int32 waittick = 0;
    exassert(isEntered());
    mclist.push_front(ctrl);
    exassert(ctrl->flags == Ex_Continue);
    while (!ExIsHalt(ctrl->flags | getHalt())) {
        // seq-2 : dispatch event
        (void)dispatch(ctrl);
        if (ExIsHalt(ctrl->flags | getHalt())) {
            break;
        }
        // seq-3 : invoke timer callback
        waittick = timerset.invoke(tickCount);
        if (ExIsHalt(ctrl->flags | getHalt())) { // is halt ?
            break; // stop exmsg loop
        }
        #if 1 // adjust for internal timer callback sleep
        waittick -= (ExGetTickCount() - tickCount);
        if (waittick < 1) {
            waittick = 1;
        }
        #endif
        // seq-4 : collect resources, flush gui, ...
        if (ExApp::mainWnd != nullptr) {
            ExApp::mainWnd->flush();
            ExApp::collect();
        }
        if (ExIsHalt(ctrl->flags | getHalt())) {
            break;
        }
        // seq-5 : wait blocked iomux for waittick msec and update tick count
        waittick = iomuxmap.invoke(waittick); // The only waiting point.
        // seq-6 : invoked iomux callback
        #if 1 // adjust for internal epoll callback sleep
        // waittick : apply epoll callback sleep tick
        #endif
    }
    void* result = ctrl->result;
    if (ctrl->flags == Ex_Continue) {
        modalUnblock(ctrl, ctrl->result);
    }
    ExApp::collect(); // invalidate ctrl
    return result;
}

void ExWatch::modalUnblock(ExModalCtrl* const ctrl, void* result) {
    exassert(isEntered());
    auto front = mclist.front();
    exassert(front == ctrl);
    front->flags |= Ex_Halt;
    front->result = result;
    mclist.pop_front();
    evWake.signal();
}

static ExWatch exWatchDflt("exWatchDflt");
ExWatch* exWatchMain = &exWatchDflt;
ExWatch* exWatchLast = &exWatchDflt;
ExWatch* exWatchDisp = nullptr; // tbd - assign individual window watch
