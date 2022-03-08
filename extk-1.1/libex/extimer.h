/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __extimer_h__
#define __extimer_h__

#include <exobject.h>
#include <excallback.h>

// class ExTimer
//
class ExTimer : public ExObject {
protected:
    ulong           value;      // The time, in milliseconds, reference time
    ulong           repeat;     // The time, in milliseconds, repeat period
    ExWidget*       widget;     // Pass the widget connected to the timer to the callback.
    ExCallback      callback;
private: // Modify the flags only in the ExTimerList class.
    int             fActived;   // is started and inserted ?
public:
    void*           userdata;   // Storing arbitrary user data
public:
    virtual ~ExTimer() { stop(); }
    explicit ExTimer()
        : ExObject(), value(0), repeat(0)
        , widget(NULL), callback(), fActived(0), userdata(NULL) {}
public:
    void stop(); // notes: clear fActived by remove from timerlist.
    void start(ulong initial); // notes: set fActived by insert to timerlist.
    void start(ulong initial, ulong repeat) { this->repeat = repeat; start(initial); }
    operator ulong () const { return value; }

    void setCallback(int(STDCALL *f)(void*, ExTimer*, ExCbInfo*), void* d) {
        callback = ExCallback(f, d);
        widget = NULL;
    }
    template <typename A>
    void setCallback(int(STDCALL *f)(A*, ExTimer*, ExCbInfo*), A* d) {
        callback = ExCallback(f, d);
        widget = NULL;
    }
    template <typename A>
    void setCallback(A* d, int(STDCALL A::*f)(ExTimer*, ExCbInfo*)) {
        callback = ExCallback(d, f);
        widget = NULL;
    }

    void setCallback(int(STDCALL *f)(void*, ExWidget*, ExCbInfo*), void* d, ExWidget* w) {
        callback = ExCallback(f, d);
        widget = w;
    }
    template <typename A, class W/*inherit ExWidget*/>
    void setCallback(int(STDCALL *f)(A*, W*, ExCbInfo*), A* d, W* w) {
        callback = ExCallback(f, d);
        widget = w;
    }
    template <typename A, class W/*inherit ExWidget*/>
    void setCallback(A* d, int(STDCALL A::*f)(W*, ExCbInfo*), W* w) {
        callback = ExCallback(d, f);
        widget = w;
    }
public:
    friend struct ExTimerComp;
    friend class ExTimerList;
public:
    Ex_DECLARE_TYPEINFO(ExTimer, ExObject);
};

/**
ExTimer
    A timer that invokes a callback after a given length of time
Description:
    A ExTimer invokes a callback after an initial and repeated time period,
    given in milliseconds.
    To disable the timer, set repeat to 0 or stop the timer.
    To delete the timer on callback, should return Ex_Remove.
*/

/**
usage1: create static allocated instance
    static ExTimer timer; // should be not stack but global instance
    timer.setCallback(&func, data);
    timer.start(999, 999);
    timer.stop();
usage2: create dynamic allocated instance
    ExTimer* timer = new ExTimer;
    timer->setCallback(&func, data));
    timer->start(1);
    timer->stop();
    delete timer;
*/

/**
ExTimer::start()
 - initial
    The time, in milliseconds, before the first timer callback is activated.
 - repeat
    The time, in milliseconds, for the repeat rate of the timer once
    the initial time period has expired.
*/

int ExFiniTimer();
int ExInitTimer();
#if !defined(HAVE_TIMERTHREAD)
ulong ExTimerListInvoke(ulong tickCount);
#endif

#endif//__extimer_h__
