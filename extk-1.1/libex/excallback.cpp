/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <excallback.h>

// class ExWidget::CallbackList
//
void ExWidget::CallbackList::remove(int type) {
    for (iterator i = begin(); i != end(); ++i) {
        if ((*i).type == type) {
            erase(i);
            return;
        }
    }
}

void ExWidget::CallbackList::add(const Callback& cb, int pos) {
    int cnt = 0;
    for (iterator i = begin(); i != end(); ++i) {
        if (pos == cnt++) {
            insert(i, cb);
            return;
        }
    }
    push_back(cb);
}

int ExWidget::CallbackList::invoke(int type, ExObject* object, ExCbInfo* cbinfo) {
    int r = Ex_Continue;
    for (iterator i = begin(); i != end();) {
        Callback& cb = *i;
        if (cb.type != type) {
            ++i; continue;
        }
        // Simple implementation to pursue efficiency.
        // Be careful not to remove items from this list within the callback.
        r = cb(object, cbinfo);

        if (r & Ex_Halt)
            return ExApp::setHalt(r);
        // should remove by invoker ?
        if (r & Ex_Remove)
            i = erase(i);
        else
            ++i;
        // should skip remain callbacks ?
        if (r & Ex_Break)
            break;
    }
    return r;
}

// class ExWindow::MsgCallbackList
//
void ExWindow::MsgCallbackList::push(const ExCallback& cb, int pos) {
#if 0 // remove duplicate callback
    //remove(cb);
    iterator di = std::find(begin(), end(), cb);
    if (di != end()) {
        exerror("%s - remove duplicate callback.\n", __func__);
        erase(di);
    }
#endif
    int cnt = 0;
    for (iterator i = begin(); i != end(); ++i) {
        if (pos == cnt++) {
            insert(i, cb);
            return;
        }
    }
    push_back(cb);
}

int ExWindow::MsgCallbackList::invoke(ExObject* object, ExCbInfo* cbinfo) {
    int r = Ex_Continue;
    for (iterator i = begin(); i != end();) {
        ExCallback& cb = *i;

        // Simple implementation to pursue efficiency.
        // Be careful not to remove items from this list within the callback.
        r = cb(object, cbinfo);

        if (r & Ex_Halt)
            return ExApp::setHalt(r);
        // should remove by invoker ?
        if (r & Ex_Remove)
            i = erase(i);
        else
            ++i;
        // should skip remain callbacks ?
        if (r & Ex_Break)
            break;
    }
    return r;
}
