/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __extimer_h__
#define __extimer_h__

#include "excallback.h"
#include "exobject.h"

class ExWatch;
extern ExWatch* exWatchLast;

// class ExTimer
//
class ExTimer : public ExObject {
protected:
    ExWatch*    watch;
    uint32      value;      // The time, in milliseconds, reference time
    uint32      repeat;     // The time, in milliseconds, repeat period
    ExCallback  callback;
private: // Modify the flags only in the ExWatch::TimerSet class.
    mutable int fActived;   // is started and inserted ?
    int         _ra_1;      // reserved for align
public:
    ExObject*   object;     // Pass the object linked to the timer
    union {                 // Storing arbitrary user data : 32 bytes
        mutable uint64 u64[4];
        mutable uint32 u32[8];
        mutable void*  ptr[4];
    } /*userdata*/;
    // usage: Type& t = timer->of<Type>();
    template <typename T> T& of() { return (T&)u64; }
public:
    virtual ~ExTimer() { stop(); }
    explicit ExTimer()
        : ExObject(), watch(NULL), value(0), repeat(0), callback(), fActived(0)
        , object(NULL), u64 { 0ull, } {}
protected:
    void setup(ExWatch* watch, const ExCallback& callback, ExObject* object = NULL) {
        this->watch = watch ? watch : exWatchLast;
        this->callback = callback;
        this->object = object;
    }
public:
    #if EX2CONF_LAMBDA_CALLBACK
    void init(ExWatch* watch, int (STDCALL *f)(void*, ExTimer*, ExCbInfo*), void* d) {
        setup(watch, ExCallback(f, d), NULL);
    }
    void init(ExWatch* watch, int (STDCALL* f)(void*, ExWidget*, ExCbInfo*), void* d, ExWidget* w) {
        setup(watch, ExCallback(f, d), (ExObject*)w);
    }
    #endif
    template <typename A, typename B>
    void init(ExWatch* watch, int (STDCALL *f)(A*, B*, ExCbInfo*), A* d, B* obj) {
        setup(watch, ExCallback(f, d), obj);
    }
    template <typename A, typename B>
    void init(ExWatch* watch, A* d, int (STDCALL A::*f)(B*, ExCbInfo*), B* obj) {
        setup(watch, ExCallback(d, f), obj);
    }
    template <typename A>
    void init(ExWatch* watch, A* d, int (STDCALL A::*f)(ExTimer*, ExCbInfo*)) {
        setup(watch, ExCallback(d, f));
    }
    void stop(); // notes: clear fActived by remove from timerlist.
    void start(uint32 initial); // notes: set fActived by insert to timerlist.
    void start(uint32 initial, uint32 repeat) { this->repeat = repeat; start(initial); }
    operator uint32 () const { return value; }
    int enter() const;
    int leave() const;
protected:
    friend class ExWatch;
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
    timer.init(watch, callback);
    timer.start(999, 999);
    timer.stop();
usage2: create dynamic allocated instance
    ExTimer* timer = new ExTimer;
    timer->init(watch, callback);
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

#endif//__extimer_h__
