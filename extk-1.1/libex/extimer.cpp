/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <extimer.h>
#include <set>

// ExTimerComp
//
struct ExTimerComp { // less traits
    bool operator () (const ExTimer* l, const ExTimer* r) const {
        long ldiff = l->value - exTickCount;
        long rdiff = r->value - exTickCount;
        return (ldiff < rdiff);
    }
};

// ExTimerList
//
class ExTimerList : public std::multiset<ExTimer*, ExTimerComp> {
public:
    ExTimerList() : std::multiset<ExTimer*, ExTimerComp>() {}
public:
    void  clearList();
    void  remove(ExTimer* timer);
    void  active(ExTimer* timer);
    ulong invoke(ulong tick_count);
};

void ExTimerList::clearList() {
    iterator i = begin();
    for (; i != end(); ++i)
        (*i)->fActived = 0;
    clear();
}

void ExTimerList::remove(ExTimer* timer) {
    iterator i = lower_bound(timer);
    iterator to = upper_bound(timer);
    for (; i != to; ++i) {
        if ((*i) == timer) {
            timer->fActived = 0;
            i = erase(i);
            break;
        }
    }
}

void ExTimerList::active(ExTimer* timer) {
    timer->fActived = 1;
    if (insert(timer) == begin())
        ExWakeupMainThread();
}

ulong ExTimerList::invoke(ulong tick_count) {
    long waittick;
    while (!empty()) {
        ExTimer* timer = *begin();
        waittick = timer->value - tick_count;
        if (waittick > 0) {
            if (waittick > 60000)
                waittick = 60000;
            return (ulong)waittick; // wait until next tick
        }
        erase(begin());
        timer->fActived = 0;
        assert(timer->callback.func);
        void* object = timer->widget ? (void*)timer->widget : (void*)timer;
        int r = timer->callback(object, &ExCbInfo(Ex_CbTimer, 0, NULL, timer));
        if (r & Ex_Halt) {
            ExApp::setHalt(r);
            return 60000;
        }
        if (r & Ex_Remove) // The timer was deleted in callback.
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

static ExTimerList exTimerList;

ulong ExTimerListInvoke(ulong tickCount) {
    return exTimerList.invoke(tickCount);
}

void ExTimerListClear() {
    exTimerList.clearList();
}

// ExTimer
//
void ExTimer::stop() {
    if (fActived)
        exTimerList.remove(this);
}

void ExTimer::start(ulong initial) {
    stop();
    assert(callback.func);
    this->value = exTickCount + initial;
    exTimerList.active(this);
}
