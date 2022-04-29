/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#include "extimer.h"
#include "exwatch.h"

#include <set>
#include <assert.h>

// ExWatch::TimerSet
//
bool ExWatch::TickCompare::operator () (const ExTimer* l, const ExTimer* r) const {
    assert(l->watch != NULL && l->watch == r->watch);
    uint32_t tick_base = l->watch->tickCount;
    int32_t ldiff = l->value - tick_base;
    int32_t rdiff = r->value - tick_base;
    return (ldiff < rdiff);
}

void ExWatch::TimerSet::clearAll() {
    iterator i = begin();
    for (; i != end(); ++i)
        (*i)->fActived = 0;
    clear();
}

void ExWatch::TimerSet::remove(ExTimer* timer) {
    iterator i = lower_bound(timer);
    iterator to = upper_bound(timer);
    while (i != to && (*i) != timer)
        ++i;
    if (i != to) { // (*i) == timer
        erase(i);
        timer->fActived = 0;
    }
}

void ExWatch::TimerSet::active(ExTimer* timer) {
    timer->fActived = 1;
    iterator i = insert(timer);
    if (i == begin()) {
        timer->watch->wakeup();
    }
}

int ExWatch::TimerSet::invoke(uint32_t tick_count) {
    int waittick;
    while (!empty()) {
        ExTimer* timer = *begin();
        waittick = timer->value - tick_count;
        if (waittick > 0) {
            if (waittick > 60000)
                waittick = 60000;
            return waittick; // wait until next tick
        }
        erase(begin());
        timer->fActived = 0;
        assert(timer->callback.func);
        void* object = timer->object ? timer->object : timer;
        ExCbInfo cbinfo(Ex_CbTimer, 0, NULL, timer);
        int r = timer->callback(object, &cbinfo);
        if (r & Ex_Halt) {
            timer->watch->setHalt(r);
            return 60000;
        }
        if (r & (Ex_Break | Ex_Remove)) // The timer was deleted in callback.
            continue;
        if (timer->repeat == 0) // The timer does not work repeatedly.
            continue;
        if (timer->fActived != 0) // is restarted in callback ?
            continue;
        timer->value += timer->repeat;
#if 1 // To avoid racking caused by matching breakpoints when debugging.
        if ((waittick = timer->value - tick_count) < 1) {
            //dprintf(L"timer timeout %d\n", -waittick);
            timer->value = tick_count + 1; // adjust interval
        }
#endif
        timer->fActived = 1;
        insert(timer);
    }
    // no waiting timer
    return 60000;
}

#if 0 // win32 test - poor performance
static HANDLE hTimer = INVALID_HANDLE_VALUE;

static VOID CALLBACK cbTimer(PVOID lpParameter, BOOLEAN timeout) {
    assert(lpParameter == &exTimerList);
    assert(timeout);
    exWatchMain->enter();
    exTickCount = GetTickCount(); // update tick
    exTimerList.invoke(exTickCount);
    if (ExApp::mainWnd != NULL) {
        ExApp::mainWnd->flush();
    }
    exWatchMain->leave();
}

int ExFiniTimer() {
    assert(hTimer != INVALID_HANDLE_VALUE);
    DeleteTimerQueueTimer(NULL, hTimer, INVALID_HANDLE_VALUE);
    hTimer = INVALID_HANDLE_VALUE;
    exTimerList.clearList();
    return 0;
}

int ExInitTimer(DWORD duetime, DWORD period) {
    assert(hTimer == INVALID_HANDLE_VALUE);
    if (!CreateTimerQueueTimer(&hTimer, NULL, cbTimer, &exTimerList,
                               duetime, period, WT_EXECUTEDEFAULT/*WT_EXECUTEINTIMERTHREAD*/))
        return -1;
    return 0;
}
#endif

// ExTimer
//
void ExTimer::stop() {
    if (fActived)
        watch->timerset.remove(this);
}

void ExTimer::start(uint32_t initial) {
    stop();
    value = watch->tickCount + initial;
    watch->timerset.active(this);
}

int ExTimer::enter() const {
    return watch->enter();
}

int ExTimer::leave() const {
    return watch->leave();
}

