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

// #undef dprint1
// #define dprint1(...) printf("ExWatch@" __VA_ARGS__)

int32 exmsleep(const uint32 msec) {
    #ifdef _POSIX_TIMERS
    struct timespec req;
    req.tv_sec = (long)msec / 1000L;
    req.tv_nsec = ((long)msec % 1000L) * 1000000L;
    return nanosleep(&req, nullptr);
    #else
    return usleep(msec * 1000UL);
    #endif
}

int32 exusleep(const uint32 usec) {
    #ifdef _POSIX_TIMERS
    struct timespec req;
    req.tv_sec = (long)usec / 1000000L;
    req.tv_nsec = ((long)usec % 1000000L) * 1000L;
    return nanosleep(&req, nullptr);
    #else
    return usleep(usec);
    #endif
}

uint64 ExGetTickCount() {
    struct timespec ts;
    (void)clock_gettime(CLOCK_MONOTONIC, &ts);
    uint64 usec = (static_cast<uint64>(ts.tv_sec) * 1000000UL);
    usec += (ts.tv_nsec / 1000L);
    return usec;
}

// Iomux
//
void ExWatch::IomuxMap::fini() {
    #if defined(IOMUX_PPOLL)
    if (fds != nullptr) {
        free(fds);
        fds = nullptr;
    }
    dirty = 0;
    #else // !IOMUX_PPOLL
    if (evrepo != nullptr) {
        free(evrepo);
        evrepo = nullptr;
    }
    if (ep_fd != -1) {
        close(ep_fd);
        ep_fd = -1;
    }
    #endif // IOMUX_PPOLL
    clear();
    if (max_fds != 0U) {
        max_fds = 0U;
    }
}

void ExWatch::IomuxMap::init(size_t max) {
    max_fds = max;
    #if defined(IOMUX_PPOLL)
    fds = (pollfd*)malloc(sizeof(pollfd) * max_fds);
    exassert(fds != nullptr);
    #else // !IOMUX_PPOLL
    ep_fd = epoll_create(max_fds);
    exassert(ep_fd != -1);
    evrepo = (epoll_event*)malloc(sizeof(epoll_event) * max_fds);
    exassert(evrepo != nullptr);
    #endif // IOMUX_PPOLL
}

#if defined(IOMUX_PPOLL)
nfds_t ExWatch::IomuxMap::setup() {
    size_t ret = size();
    if (dirty > 0) {
        size_t cnt = 0U;
        for (const_iterator i = begin(); i != end(); ++i) {
            const Iomux& iomux = i->second;
            pollfd* pfd = &fds[cnt++];
            pfd->fd = iomux.mux_fd;
            pfd->events = (short)(iomux.arg_ev.events & 0xFFFFU);
            pfd->revents = 0;
        }
        exassert(cnt == ret);
        dirty = 0;
    }
    return static_cast<nfds_t>(ret);
}
#endif // IOMUX_PPOLL

const ExWatch::Iomux* ExWatch::IomuxMap::search(ExOsFd mux_fd) const {
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

bool ExWatch::IomuxMap::add(ExOsFd mux_fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    (void)watch->enter();
    if (size() < max_fds) {
        Iomux* iomux = nullptr;
        std::pair<iterator, bool> pr;
        pr = insert(value_type(mux_fd, Iomux(mux_fd)));
        iomux = &pr.first->second;
        if (pr.second == false) {
            dprint1("IomuxMap::add: duplicate mux_fd:%zu\n", (size_t)mux_fd);
        }
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        iomux->arg_ev.events = events;
        iomux->arg_ev.data.ptr = iomux;
        #if defined(IOMUX_PPOLL)
        dirty++;
        #else // !IOMUX_PPOLL
        r = epoll_ctl(ep_fd, EPOLL_CTL_ADD, mux_fd, &iomux->arg_ev);
        #endif // IOMUX_PPOLL
    } else {
        dprint1("IomuxMap::add: max_fds:%zu\n", max_fds);
    }
    (void)watch->leave();
    return (r == 0);
}

bool ExWatch::IomuxMap::mod(ExOsFd mux_fd, uint32 events, const ExNotify& notify) {
    int32 r = -1;
    (void)watch->enter();
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        iomux->notify = notify;
        iomux->arg_ev.events = events;
        exassert(iomux->arg_ev.data.ptr == iomux);
        #if defined(IOMUX_PPOLL)
        dirty++;
        #else // !IOMUX_PPOLL
        r = epoll_ctl(ep_fd, EPOLL_CTL_MOD, mux_fd, &iomux->arg_ev);
        #endif // IOMUX_PPOLL
    } else {
        dprint1("IomuxMap::mod: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    (void)watch->leave();
    return (r == 0);
}

bool ExWatch::IomuxMap::del(ExOsFd mux_fd) {
    int32 r = -1;
    (void)watch->enter();
    iterator i = find(mux_fd);
    if (i != end()) {
        Iomux* iomux = &i->second;
        exassert(iomux->mux_fd == mux_fd);
        #if defined(IOMUX_PPOLL)
        dirty++;
        #else // !IOMUX_PPOLL
        exassert(iomux->arg_ev.data.ptr == iomux);
        r = epoll_ctl(ep_fd, EPOLL_CTL_DEL, mux_fd, &iomux->arg_ev);
        #endif // IOMUX_PPOLL
        erase(i);
    } else {
        dprint1("IomuxMap::del: invalid mux_fd:%zu\n", (size_t)mux_fd);
    }
    (void)watch->leave();
    return (r == 0);
}

int64 ExWatch::IomuxMap::invoke(int64 waittick) {
    const int64 tick0 = watch->tickCount; // get current tick
    #if defined(IOMUX_PPOLL)
    nfds_t nfds = setup();
    #endif // IOMUX_PPOLL
    (void)watch->leave();
    //pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, nullptr);
    #if defined(IOMUX_PPOLL) || defined(IOMUX_EPOLL2)
    timespec ts;
    ts.tv_sec = waittick / 1000000000L;
    ts.tv_nsec = waittick % 1000000000L;
    #endif
    #if defined(IOMUX_PPOLL)
    int32 cnt = ppoll(fds, nfds, &ts, nullptr); // sleep for nsec
    #else // !IOMUX_PPOLL
    #if defined(IOMUX_EPOLL2)
    int32 cnt = epoll_pwait2(ep_fd, evrepo, (int)max_fds, &ts, nullptr); // sleep for msec
    #else // !IOMUX_EPOLL2
    //waittick -= (waittick > 900L) ? 900L : 0L;
    int32 cnt = epoll_wait(ep_fd, evrepo, (int)max_fds, (int)(waittick / 1000L)); // sleep for msec
    #endif // IOMUX_EPOLL2
    #endif // IOMUX_PPOLL
    //pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, nullptr);
    (void)watch->enter();
    #if !defined(IOMUX_PPOLL)
    for (int32 i = 0; i < cnt; i++) {
        const Iomux* iomux = (const Iomux*)evrepo[i].data.ptr;
        epoll_event ev;
        ev.data.fd = iomux->mux_fd;
        ev.events = evrepo[i].events;
        uint32 r = iomux->notify(&ev);
        r |= watch->getHalt();
        if (ExIsHalt(r)) {
            (void)watch->setHalt(r);
            break; // stop iomux loop
        }
        // tbd - manage remove flag
        // if (r & Ex_Remove) { del(iomux->mux_fd); }
    }
    #endif // IOMUX_PPOLL
    if (cnt < 0) {
        exerror("IomuxMap: cnt:%d %s\n", cnt, exstrerr());
        cnt = 0; // reset count
    }
    #if defined(IOMUX_PPOLL)
    for (nfds_t i = 0UL; (i < nfds) && (cnt > 0); i++) {
        pollfd* pfd = &fds[i];
        if (pfd->revents == 0) {
            continue; // skip non-signaled fd
        }
        cnt--; // decrease count
        const Iomux* iomux = search(pfd->fd);
        if (iomux != nullptr) {
            epoll_event ev;
            ev.data.fd = iomux->mux_fd;
            ev.events = (uint32)pfd->revents;
            pfd->revents = 0; // reset revents for next loop
            uint32 r = iomux->notify(&ev);
            r |= watch->getHalt();
            if (ExIsHalt(r)) {
                (void)watch->setHalt(r);
                break; // stop iomux loop
            }
            if ((r & Ex_Remove) != 0U) {
                del(iomux->mux_fd);
                dirty++;
            }
        } else {
            dprint1("IomuxMap::invoke: invalid mux_fd:%zu\n", (size_t)pfd->fd);
        }
    }
    #endif // IOMUX_PPOLL
    watch->tickCount = ExGetTickCount(); // update tick
    return (watch->tickCount - tick0); // return elapsed tick
}

// Watch thread
//
uint64 ExWatch::tickAppLaunch = ExGetTickCount();

bool ExWatch::fini() {
    bool ret = false;
    if (tid != 0U) {
        #if 1
        setHalt(Ex_Halt);
        #else
        int32 r;
        r = pthread_cancel(tid);
        exassert(r == 0);
        #endif
        //(void)leave();
        ret = join();
        //(void)enter();
    }
    iomuxmap.fini();
    timerset.fini();
    evWake.fini();
    return ret;
}

bool ExWatch::init(size_t max_iomux, size_t stacksize) {
    exassert(tid == 0U);
    iomuxmap.init(max_iomux);

    (void)evWake.init();
    (void)ioAdd(this, &ExWatch::onEvent, evWake);

    tickCount = ExGetTickCount(); // update tick

    return create(Proc(this, &ExWatch::proc));
}

uint32 ExWatch::onEvent(const epoll_event* const ev) {
    dprint0("%s: fd:%d ev:%d\n", _func_, ev->data.fd, ev->events);
    exassert(evWake == ev->data.fd);
    (void)evWake.reset();
    return 0U;
}

#endif // __linux__

uint32 ExWatch::setHalt(uint32 r) {
    exassert(((halt | r) & Ex_Halt) != 0U);
    halt |= (r | 0x01100000U);
    if (r == Ex_Halt) { // is wakeup as trigger ?
        #ifdef DEBUG // for debug
        if (evWake.u64 > 1UL) { // is already signaled ?
            dprint("ExWatch::setHalt: u64=%lu\n", evWake.u64);
        }
        #endif
        (void)wakeup();
    }
    return halt;
}

uint32 ExWatch::proc(const ExWatch* const self) {
#ifdef __linux__
    pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, nullptr);
#endif // __linux__
    dprint("ExWatch::proc(%s) tickAppLaunch=%lu tickCount=%lu\n", name, tickAppLaunch, tickCount);
    (void)enter();
    // seq-1 : prepare resources
    (void)hookStartup(ExHookProc::Startup);
    // seq-2 : dispatch... ~ seq-5 : wait blocked iomux...
    (void)hookProcess(ExHookProc::Process);
    // seq-6 : cleanup resources
    (void)hookCleanup(ExHookProc::Cleanup);
    (void)leave();
    dprint("ExWatch::proc(%s) done... tickCount=%lu\n", name, tickCount);
    return 0U;
}

uint32 ExWatch::process(uint32 hook) {
    int64 waittick = 0L;
    exassert(mutex.isowner());
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
        if (waittick < 1L) {
            waittick = 1L;
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
    uintptr_t val = reinterpret_cast<uintptr_t>(ctrl.result);
    return static_cast<uint32>(val);
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
            exassert(msg.wParam == EXIT_SUCCESS);
            dprint("WM_QUIT tick=%lu\n", getTick());
            ctrl->result = reinterpret_cast<void*>(msg.wParam); // cause DestroyWindow
            (void)setHalt(Ex_Halt); // stop exmsg loop
            break;
        }
        //leave();
        #ifdef __linux__
        (void)DefWndProc(msg); // dispatch message to window procedure
        #else // WIN32
        TranslateMessage(&msg);
        DispatchMessage(&msg);
        #endif
        //enter();
    } while (!ExIsHalt(ctrl->flags | getHalt()));
    return ctrl->result;
}

void* ExWatch::modalBlock(ExModalCtrl* const ctrl) {
    int64 waittick = 0L;
    mclist.push_front(ctrl);
    exassert(mutex.isowner());
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
        if (waittick < 1L) {
            waittick = 1L;
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
        modalUnblock(ctrl, result);
    }
    ExApp::collect(); // invalidate ctrl
    return result;
}

void ExWatch::modalUnblock(ExModalCtrl* const ctrl, void* result) {
    exassert(ctrl == mclist.front());
    exassert(mutex.isowner());
    ctrl->flags |= Ex_Halt;
    ctrl->result = result;
    mclist.pop_front();
    (void)wakeup();
}

static ExWatch exWatchDflt("exWatchDflt");
ExWatch* exWatchMain = &exWatchDflt;
ExWatch* exWatchLast = &exWatchDflt;
ExWatch* exWatchDisp = nullptr; // tbd - assign individual window watch
