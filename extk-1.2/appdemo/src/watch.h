//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _watch_h_
#define _watch_h_

#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/eventfd.h>
#include <fcntl.h>
#include <extimer.h>
#include <exwatch.h>
#include "osal/event.h"
//#include "tools.h"

#if 0
// WatchDev
//
class WatchDev : public ExWatch { // run in watch thread
protected:
    // inherit
public:
    // inherit
public:
    WatchDev() : ExWatch("Dev") {}
};

extern WatchDev gWatchDev;

// WatchMap
//
class WatchMap : public ExWatch { // run in watch thread
protected:
    // inherit
public:
    int init() {
        return ExWatch::init(16, 1024*1024*1024);
    }
    // inherit
public:
    WatchMap() : ExWatch("Map") {}
};

extern WatchMap gWatchMap;

// WatchNet
//
class WatchNet : public ExWatch { // run in watch thread
protected:
    // inherit
public:
    int init();
    // inherit
public:
    WatchNet() : ExWatch("Net") {}
};

extern WatchNet gWatchNet;

// WatchApp
//
class WatchApp : public ExWatch { // run in main thread
protected:
    bool fini() = delete;
    bool init(size_t, size_t) = delete;
    uint32 onEvent(const epoll_event* ev) {
        return ExWatch::onEvent(ev);
    }
protected:
    uint32 on_ev2dev(const epoll_event* ev);
    uint32 on_cmdline(const epoll_event* ev);
    int fini_fifo();
    int init_fifo();
    int app_fifo;
public:
    int fb0dev_fd;
    int fb1dev_fd;
    int ev2dev_fd;
    Event event;
public:
    int cleanup();
    int startup();
    int mainloop();
    //static void dispatch(Event& ev);
    WatchApp() : ExWatch("Gui"), app_fifo(0)
        , fb0dev_fd(0), fb1dev_fd(0)
        , ev2dev_fd(0), event() {}
};

extern WatchApp gWatchApp;
#else
extern ExWatch gWatchApp;
#endif

extern ExCallbackList cmdline_callback_list;

int dprint_appinfo(char* mbs, int len);

#endif // _watch_h_
