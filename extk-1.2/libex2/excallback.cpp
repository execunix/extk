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

// class ExCallbackList
//
bool ExCallbackList::CallbackList::remove2(const ExCallback& cb) {
    for (iterator i = begin(); i != end(); ++i) {
        // Be careful not to remove items from this list within the callback.
        if ((*i).func == cb.func &&
            (*i).data == cb.data) {
            if (influx > 0U) {
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

void ExCallbackList::CallbackList::push(const Callback& cb) {
#if 0 // remove duplicate callback
    //remove(cb);
    iterator di = std::find(begin(), end(), cb);
    if (di != end()) {
        exerror("%s - remove duplicate callback.\n", _func_);
        erase(di);
    }
#endif
    for (iterator i = begin(); i != end(); ++i) {
        if (cb.prio <= (*i).prio) {
            insert(i, cb);
            if (influx > 0U) {
                change++;
                (*i).flag |= fHoldOff;
            }
            return;
        }
    }
    push_back(cb);
}

uint32 ExCallbackList::CallbackList::invoke(const void* object, const void* cbinfo) {
    uint32 r = Ex_Continue;
    influx++;
    for (iterator i = begin(); i != end();) {
        iterator it = i++;
        Callback& cb = *it;
        // Simple implementation to pursue efficiency.
        #if 1 // tbd
        // If a callback with a lower priority is added during callback execution,
        // the callback is also called at the same time.
        if (cb.flag & (fRemoved | fHoldOff)) {
            continue;
        }
        #endif

        r = cb(object, cbinfo);

        if (ExIsHalt(r)) {
            return (r | Ex_End);
        }
        // should remove by invoker ?
        if ((r & Ex_Remove) != 0U) {
            change++;
            cb.flag |= fRemoved;
        }
        // should skip remain callbacks ?
        if ((r & Ex_Break) != 0U) {
            break;
        }
    }
    influx--;
    if ((influx == 0U) && (change > 0U)) {
        for (iterator i = begin(); i != end();) {
            uint8 flag = (*i).flag;
            (*i).flag = 0U;
            if ((flag & fRemoved) != 0U) {
                i = erase(i);
            } else {
                ++i;
            }
        }
        change = 0U;
    }
    return r;
}

// class ExListenerList
//
bool ExListenerList::ListenerList::remove2(uint32 type, uint8 prio) {
    for (iterator i = begin(); i != end(); ++i) {
        // Be careful not to remove items from this list within the callback.
        if ((*i).type == type &&
            (*i).prio == prio) {
            if (influx > 0U) {
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

void ExListenerList::ListenerList::push(const Listener& cb) {
    for (iterator i = begin(); i != end(); ++i) {
        if (cb.prio <= (*i).prio) {
            insert(i, cb);
            if (influx > 0U) {
                change++;
                (*i).flag |= fHoldOff;
            }
            return;
        }
    }
    push_back(cb);
}

uint32 ExListenerList::ListenerList::invoke(uint32 type, const void* object, const void* cbinfo) {
    uint32 r = Ex_Continue;
    influx++;
    for (iterator i = begin(); i != end();) {
        iterator it = i++;
        Listener& cb = *it;
        // Simple implementation to pursue efficiency.
        #if 1 // tbd - featuring
        // If a callback with a lower priority is added during callback execution,
        // the callback is also called at the same time.
        if (cb.flag & (fRemoved | fHoldOff)) {
            continue;
        }
        #endif
        if (cb.type != type) {
            continue;
        }
        r = cb(object, cbinfo);

        if (ExIsHalt(r)) {
            return (r | Ex_End);
        }
        // should remove by invoker ?
        if ((r & Ex_Remove) != 0U) {
            change++;
            cb.flag |= fRemoved;
        }
        // should skip remain callbacks ?
        if ((r & Ex_Break) != 0U) {
            break;
        }
    }
    influx--;
    if ((influx == 0U) && (change > 0U)) {
        for (iterator i = begin(); i != end();) {
            uint8 flag = (*i).flag;
            (*i).flag = 0U;
            if ((flag & fRemoved) != 0U) {
                i = erase(i);
            } else {
                ++i;
            }
        }
        change = 0U;
    }
    return r;
}

// class ExWidget::ListenerList
//
bool ExWidget::ListenerList::remove(const uint32 type, const uint8 prio) {
    for (iterator i = begin(); i != end(); ++i) {
        // Be careful not to remove items from this list within the callback.
        if ((*i).type == type &&
            (*i).prio == prio) {
            if (influx > 0U) {
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

void ExWidget::ListenerList::push(const Listener& cb) {
    for (iterator i = begin(); i != end(); ++i) {
        if (cb.prio <= (*i).prio) {
            insert(i, cb);
            if (influx > 0U) {
                change++;
                (*i).flag |= fHoldOff;
            }
            return;
        }
    }
    push_back(cb);
}

uint32 ExWidget::ListenerList::invoke(ExWatch* watch, const uint32 type, const ExObject* object, const ExCbInfo* cbinfo) {
    uint32 r = Ex_Continue;
    influx++;
    for (iterator i = begin(); i != end();) {
        iterator it = i++;
        Listener& cb = *it;
        // Simple implementation to pursue efficiency.
        #if 1 // tbd
        // If a callback with a lower priority is added during callback execution,
        // the callback is also called at the same time.
        if (cb.flag & (fRemoved | fHoldOff)) {
            continue;
        }
        #endif
        if (cb.type != type) {
            continue;
        }
        r = cb(object, cbinfo);

        if (watch != nullptr) {
            r |= watch->getHalt();
            if (ExIsHalt(r)) {
                return watch->setHalt(r);
            }
        } else {
            if (ExIsHalt(r)) {
                return (r | Ex_End);
            }
        }
        // should remove by invoker ?
        if ((r & Ex_Remove) != 0U) {
            change++;
            cb.flag |= fRemoved;
        }
        // should skip remain callbacks ?
        if ((r & Ex_Break) != 0U) {
            break;
        }
    }
    influx--;
    if ((influx == 0U) && (change > 0U)) {
        for (iterator i = begin(); i != end();) {
            uint8 flag = (*i).flag;
            (*i).flag = 0U;
            if ((flag & fRemoved) != 0U) {
                i = erase(i);
            } else {
                ++i;
            }
        }
        change = 0U;
    }
    return r;
}

// class ExWindow::CallbackList
//
bool ExWindow::CallbackList::remove2(const ExCallback& cb) {
    for (iterator i = begin(); i != end(); ++i) {
        // Be careful not to remove items from this list within the callback.
        if ((*i).func == cb.func &&
            (*i).data == cb.data) {
            if (influx > 0U) {
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

void ExWindow::CallbackList::push(const Callback& cb) {
#if 0 // remove duplicate callback
    //remove(cb);
    iterator di = std::find(begin(), end(), cb);
    if (di != end()) {
        exerror("%s - remove duplicate callback.\n", _func_);
        erase(di);
    }
#endif
    for (iterator i = begin(); i != end(); ++i) {
        if (cb.prio <= (*i).prio) {
            insert(i, cb);
            if (influx > 0U) {
                change++;
                (*i).flag |= fHoldOff;
            }
            return;
        }
    }
    push_back(cb);
}

uint32 ExWindow::CallbackList::invoke(ExWatch* watch, const ExObject* object, const ExCbInfo* cbinfo) {
    uint32 r = Ex_Continue;
    influx++;
    for (iterator i = begin(); i != end();) {
        iterator it = i++;
        Callback& cb = *it;
        // Simple implementation to pursue efficiency.
        #if 1 // tbd
        // If a callback with a lower priority is added during callback execution,
        // the callback is also called at the same time.
        if (cb.flag & (fRemoved | fHoldOff)) {
            continue;
        }
        #endif

        r = cb(object, cbinfo);

        if (watch != nullptr) {
            r |= watch->getHalt();
            if (ExIsHalt(r)) {
                return watch->setHalt(r);
            }
        } else {
            if (ExIsHalt(r)) {
                return (r | Ex_End);
            }
        }
        // should remove by invoker ?
        if ((r & Ex_Remove) != 0U) {
            change++;
            cb.flag |= fRemoved;
        }
        // should skip remain callbacks ?
        if ((r & Ex_Break) != 0U) {
            break;
        }
    }
    influx--;
    if ((influx == 0U) && (change > 0U)) {
        for (iterator i = begin(); i != end();) {
            uint8 flag = (*i).flag;
            (*i).flag = 0U;
            if ((flag & fRemoved) != 0U) {
                i = erase(i);
            } else {
                ++i;
            }
        }
        change = 0U;
    }
    return r;
}
