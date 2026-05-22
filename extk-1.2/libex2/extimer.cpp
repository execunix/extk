/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#include "extimer.h"
#include "exwatch.h"

#include <set>

// ExWatch::TimerSet
//
bool ExWatch::TickCompare::operator () (const ExTimer* l, const ExTimer* r) const {
    exassert((l->watch != nullptr) && (l->watch == r->watch));
    uint32 tick_base = l->watch->tickCount;
    int32 ldiff = l->value - tick_base;
    int32 rdiff = r->value - tick_base;
    return (ldiff < rdiff);
}

void ExWatch::TimerSet::fini() {
    iterator i = begin();
    for (; i != end(); ++i) {
        (*i)->fActived = 0U;
    }
    clear();
}

void ExWatch::TimerSet::remove(ExTimer* timer) {
    iterator i = lower_bound(timer);
    iterator to = upper_bound(timer);
    while (i != to && (*i) != timer) {
        ++i;
    }
    if (i != to) { // (*i) == timer
        erase(i);
        timer->fActived = 0U;
    }
}

void ExWatch::TimerSet::active(ExTimer* timer) {
    timer->fActived = 1U;
    iterator i = insert(timer);
    if (i == begin()) {
        timer->watch->wakeup();
    }
}

uint32 ExWatch::TimerSet::invoke(uint32 tick_count) {
    int32 waittick;
    while (!empty()) {
        ExTimer* timer = *begin();
        waittick = timer->value - tick_count;
        if (waittick > 0) {
            if (waittick > 60000) {
                waittick = 60000;
            }
            return (uint32)waittick; // wait until next tick
        }
        erase(begin());
        timer->fActived = 0U;
        exassert(timer->callback.func);
        const void* object = timer->object ? timer->object : timer;
        ExCbInfo cbinfo(Ex_CbTimer, 0, nullptr, timer);
        uint32 r = timer->callback(object, &cbinfo);
        if ((r & Ex_Halt) != 0U) {
            timer->watch->setHalt(r);
            return 60000;
        }
        if ((r & (Ex_Break | Ex_Remove)) != 0U) { // The timer was deleted in callback.
            continue;
        }
        if (timer->repeat == 0U) { // The timer does not work repeatedly.
            continue;
        }
        if (timer->fActived != 0U) { // is restarted in callback ?
            continue;
        }
        timer->value += timer->repeat;
#if 1 // To avoid racking caused by matching breakpoints when debugging.
        if ((waittick = timer->value - tick_count) < 1) {
            //dprint("timer timeout %d\n", -waittick);
            timer->value = tick_count + 1U; // adjust interval
        }
#endif
        timer->fActived = 1U;
        insert(timer);
    }
    // no waiting timer
    return 60000;
}

#if 0 // win32 test - poor performance
static HANDLE hTimer = INVALID_HANDLE_VALUE;

static VOID CALLBACK cbTimer(PVOID lpParameter, BOOLEAN timeout) {
    exassert(lpParameter == &exTimerList);
    exassert(timeout);
    exWatchMain->enter();
    uint32 waittick = GetTickCount(); // update tick
    exTimerList.invoke(waittick);
    if (ExApp::mainWnd != nullptr) {
        ExApp::mainWnd->flush();
    }
    exWatchMain->leave();
}

bool ExFiniTimer() {
    exassert(hTimer != INVALID_HANDLE_VALUE);
    DeleteTimerQueueTimer(nullptr, hTimer, INVALID_HANDLE_VALUE);
    hTimer = INVALID_HANDLE_VALUE;
    exTimerList.clearList();
    return true;
}

bool ExInitTimer(DWORD duetime, DWORD period) {
    exassert(hTimer == INVALID_HANDLE_VALUE);
    if (!CreateTimerQueueTimer(&hTimer, nullptr, cbTimer, &exTimerList,
                               duetime, period, WT_EXECUTEDEFAULT/*WT_EXECUTEINTIMERTHREAD*/)) {
        return false;
    }
    return true;
}
#endif

// ExTimer
//
ExTimer::~ExTimer() noexcept {
    if ((watch != nullptr) &&
        (fActived != 0U)) {
        if (watch->isSelf()) {
            watch->timerset.remove(this);
        } else { // should lock
            watch->enter();
            watch->timerset.remove(this);
            watch->leave();
        }
    }
}

void ExTimer::stop() {
    exassert(watch->isSelf());
    if (fActived != 0U) {
        watch->timerset.remove(this);
    }
}

void ExTimer::start(uint32 initial) {
    exassert(watch->isSelf());
    if (fActived != 0U) { // stop()
        watch->timerset.remove(this);
    }
    value = watch->tickCount + initial;
    watch->timerset.active(this);
}

void ExTimer::stop_ex() {
    exassert(!watch->isSelf());
    watch->enter();
    if (fActived != 0U) {
        watch->timerset.remove(this);
    }
    watch->leave();
}

void ExTimer::start_ex(uint32 initial) {
    exassert(!watch->isSelf());
    watch->enter();
    if (fActived != 0U) { // stop()
        watch->timerset.remove(this);
    }
    value = watch->tickCount + initial;
    watch->timerset.active(this);
    watch->leave();
}
