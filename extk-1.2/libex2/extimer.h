/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __extimer_h__
#define __extimer_h__

#include "excallback.h"
#include "exobject.h"
#include "exwatch.h"

// class ExWatch;
// extern ExWatch* exWatchLast;

// class ExTimer
//
class ExTimer : public ExObject {
protected:
    ExWatch*    watch;
    uint64      value;          // The time, in milliseconds, reference time
    uint64      repeat;         // The time, in milliseconds, repeat period
    ExCallback  callback;
private: // Modify the flags only in the ExWatch::TimerSet class.
    mutable uint32 fActived;    // is started and inserted ?
    uint32      _ra_1;          // reserved for align
    class AutoLockWatch {
        ExWatch* watch;
        bool is_lock;
    public:
        ~AutoLockWatch();
        explicit AutoLockWatch(ExWatch* watch);
    };
public:
    const void* object;         // Pass the object linked to the timer
    union {                     // Storing arbitrary user data : 32 bytes
        mutable uint64 u64[4];
        mutable uint32 u32[8];
        mutable void*  ptr[4];
    } /*userdata*/;
    // usage: Type* t = timer->userdata_of<Type>();
    template <typename T> T& userdata_of() const { T* t = (T*)u64; return *t; }
public:
    virtual ~ExTimer() noexcept;
    explicit ExTimer() noexcept : ExObject()
        , watch(nullptr), value(0UL), repeat(0UL), callback(), fActived(0U)
        , object(nullptr), u64 { 0ull, } {}
public:
    void setup(ExWatch* watch, const ExCallback& callback, const void* object = nullptr) {
        this->watch = (watch != nullptr) ? watch : exWatchLast;
        this->callback = callback;
        this->object = object;
    }
public:
    void init(ExWatch* watch, uint32(*f)(void*, ExWidget*, ExCbInfo*), void* d, const ExWidget* widget) { // lambda
        setup(watch, ExCallback(f, d), widget);
    }
    void init(ExWatch* watch, uint32(*f)(void*, ExTimer*, ExCbInfo*), void* d) { // lambda
        setup(watch, ExCallback(f, d), nullptr);
    }
    template <typename A, typename B, typename C>
    void init(ExWatch* watch, uint32 (*f)(A*, B*, C*), A* d, B* obj = nullptr) {
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        setup(watch, ExCallback(f, d), obj);
    }
    template <typename A, typename B, typename C>
    void init(ExWatch* watch, A* d, uint32 (A::*f)(B*, C*), B* obj = nullptr) {
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        setup(watch, ExCallback(d, f), obj);
    }
    void stop(); // notes: clear fActived by remove from timerlist.
    void start(uint32 initial, uint32 repeat = 0U); // notes: set fActived by insert to timerlist.
    bool enter_watch() const { return ((watch == nullptr) || watch->isSelf()) ? false : watch->enter(); }
    bool leave_watch(bool is_lock) const { return (is_lock == false) ? false : watch->leave(); }
    uint64 tick() const { return watch->getTick(); }
    operator uint64 () const { return value; }
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
