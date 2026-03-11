//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _watch_h_
#define _watch_h_

#include <exdebug.h>
#ifdef __linux__
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/eventfd.h>
#endif // __linux__
#include <fcntl.h>
#include <extimer.h>
#include <exwatch.h>
#include "event.h"
#include "tools.h"

// WatchDev
//
class WatchDev : public ExWatch { // run in watch thread
private:
    // inherit
public:
    // inherit
public:
    WatchDev() noexcept : ExWatch("Dev") {}
};

extern WatchDev gWatchDev;

// WatchMap
//
class WatchMap : public ExWatch { // run in watch thread
private:
    // inherit
public:
    bool init() {
        return ExWatch::init(16UL, 32U*1024U*1024UL);
    }
    // inherit
public:
    WatchMap() noexcept : ExWatch("Map") {}
};

extern WatchMap gWatchMap;

// WatchNet
//
class WatchNet : public ExWatch { // run in watch thread
private:
    // inherit
public:
    bool init();
    // inherit
public:
    WatchNet() noexcept : ExWatch("Net") {}
};

extern WatchNet gWatchNet;

// WatchApp
//
class WatchApp : public ExWatch { // run in main thread
private:
    bool fini() = delete;
    bool init(size_t, size_t) = delete;
#ifdef __linux__
    uint32 onEvent(const epoll_event* const ev) {
        return ExWatch::onEvent(ev);
    }
private:
    uint32 on_ev2dev(const epoll_event* const ev);
    uint32 on_cmdline(const epoll_event* const ev);
    void fini_fifo();
    void init_fifo();
    void open_fifo();
    int32 app_fifo;
    int32 fb0dev_fd;
    int32 fb1dev_fd;
    int32 ev2dev_fd;
    ExEvent def_event;
    int32 ev_serial; // for misra rules
public:
    int32 get_ev2dev_fd() const { return ev2dev_fd; }
    ExEvent* get_def_event() { return &def_event; }
#endif // __linux__
public:
    bool cleanup();
    bool startup();
    void mainloop();
    //static void dispatch(ExEvent& ev);
#ifdef __linux__
    WatchApp() noexcept : ExWatch("Gui"), app_fifo(0)
        , fb0dev_fd(0), fb1dev_fd(0), ev2dev_fd(0)
        , def_event(), ev_serial(0) {}
#else // __linux__
    WatchApp() noexcept : ExWatch("Gui") {
    }
#endif // __linux__
};

extern WatchApp gWatchApp;

extern ExCallbackList cmdline_callback_list;

int32 dprint_appinfo(char* const mbs, const int32 len);

#endif // _watch_h_
