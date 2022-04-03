/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "excallback.h"
#include "exwindow.h"
#include "exwatch.h"

enum CallbackFlags {
    fRemoved = 1 << 0,
    fHoldOff = 1 << 1,
};

// class ExWidget::CallbackList
//
bool ExWidget::CallbackList::remove(int type, uint8 prio) {
    for (iterator i = begin(); i != end(); ++i) {
        // Be careful not to remove items from this list within the callback.
        if ((*i).type == type &&
            (*i).prio == prio) {
            if (influx > 0) {
                change++;
                (*i).flag |= fRemoved;
            } else {
                erase(i);
            }
            return true; // tbd - all ?
        }
    }
    return false;
}

void ExWidget::CallbackList::push(const Callback& cb) {
    for (iterator i = begin(); i != end(); ++i) {
        if (cb.prio <= (*i).prio) {
            insert(i, cb);
            if (influx > 0) {
                change++;
                (*i).flag |= fHoldOff;
            }
            return;
        }
    }
    push_back(cb);
}

int ExWidget::CallbackList::invoke(int type, ExObject* object, ExCbInfo* cbinfo) {
    int r = Ex_Continue;
    influx++;
    for (iterator i = begin(); i != end();) {
        iterator it = i++;
        Callback& cb = *it;
        // Simple implementation to pursue efficiency.
        #if 1 // tbd
        // If a callback with a lower priority is added during callback execution,
        // the callback is also called at the same time.
        if (cb.flag & (fRemoved | fHoldOff))
            continue;
        #endif
        if (cb.type != type)
            continue;

        r = cb(object, cbinfo);

        if (exWatchGui->getHalt() || (r & Ex_Halt))
            return exWatchGui->setHalt(r);
        // should remove by invoker ?
        if (r & Ex_Remove) {
            change++;
            cb.flag |= fRemoved;
        }
        // should skip remain callbacks ?
        if (r & Ex_Break)
            break;
    }
    influx--;
    if (influx == 0 && change > 0) {
        for (iterator i = begin(); i != end();) {
            uint8 flag = (*i).flag;
            (*i).flag = 0;
            if (flag & fRemoved)
                i = erase(i);
            else
                ++i;
        }
        change = 0;
    }
    return r;
}

// class ExWindow::MsgCallbackList
//
bool ExWindow::MsgCallbackList::remove2(ExCallback& cb) {
    for (iterator i = begin(); i != end(); ++i) {
        // Be careful not to remove items from this list within the callback.
        if ((*i).func == cb.func &&
            (*i).data == cb.data) {
            if (influx > 0) {
                change++;
                (*i).flag |= fRemoved;
            } else {
                erase(i);
            }
            return true; // tbd - all ?
        }
    }
    return false;
}

void ExWindow::MsgCallbackList::push(const Callback& cb) {
#if 0 // remove duplicate callback
    //remove(cb);
    iterator di = std::find(begin(), end(), cb);
    if (di != end()) {
        exerror("%s - remove duplicate callback.\n", __func__);
        erase(di);
    }
#endif
    for (iterator i = begin(); i != end(); ++i) {
        if (cb.prio <= (*i).prio) {
            insert(i, cb);
            if (influx > 0) {
                change++;
                (*i).flag |= fHoldOff;
            }
            return;
        }
    }
    push_back(cb);
}

int ExWindow::MsgCallbackList::invoke(ExObject* object, ExCbInfo* cbinfo) {
    int r = Ex_Continue;
    influx++;
    for (iterator i = begin(); i != end();) {
        iterator it = i++;
        Callback& cb = *it;
        // Simple implementation to pursue efficiency.
        #if 1 // tbd
        // If a callback with a lower priority is added during callback execution,
        // the callback is also called at the same time.
        if (cb.flag & (fRemoved | fHoldOff))
            continue;
        #endif

        r = cb(object, cbinfo);

        if (exWatchGui->getHalt() || (r & Ex_Halt))
            return exWatchGui->setHalt(r);
        // should remove by invoker ?
        if (r & Ex_Remove) {
            change++;
            cb.flag |= fRemoved;
        }
        // should skip remain callbacks ?
        if (r & Ex_Break)
            break;
    }
    influx--;
    if (influx == 0 && change > 0) {
        for (iterator i = begin(); i != end();) {
            uint8 flag = (*i).flag;
            (*i).flag = 0;
            if (flag & fRemoved)
                i = erase(i);
            else
                ++i;
        }
        change = 0;
    }
    return r;
}
