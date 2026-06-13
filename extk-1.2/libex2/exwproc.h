/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwndproc_h__
#define __exwndproc_h__

#include "exwindow.h"
#include <map>

struct ExWindowMap : public std::map<const HWND, const ExWindow*> {
    bool detach(const HWND hwnd) {
        dprint("%s: hwnd=0x%p addr=0x%p\n", _func_, hwnd, (*this)[hwnd]);
        //SetWindowLong(hwnd, GWL_USERDATA, (LONG)NULL); // detach window handle
        return this->erase(hwnd) > 0;
    }
    bool attach(const HWND hwnd, const ExWindow* window) {
        exassert(this->find(hwnd) == this->end());
        dprint("%s: hwnd=0x%p addr=0x%p name=%s\n", _func_, hwnd, window, window->getName());
        //SetWindowLong(hwnd, GWL_USERDATA, (LONG)this); // attach window handle
        #if 1
        const std::pair<const_iterator, bool> pr = this->insert(value_type(hwnd, window));
        exassert(pr.second == true && pr.first->second == window);
        return pr.second;
        #else
        (*this)[hwnd] = window;
        return true;
        #endif
    }
    ExWindow* search(const HWND hwnd) const {
        const_iterator it = this->find(hwnd);
        return (it != this->end()) ? const_cast<ExWindow*>(it->second) : nullptr;
    }
};

extern ExWindowMap exWndProcMap;

uint32 ProcWndEvent(ExWindow* window, ExCbInfo* cbinfo);

#ifdef __linux__
int64 DefWndProc(ExMsg& em);
#endif // __linux__
#ifdef WIN32
LRESULT CALLBACK DefWndProc(HWND, UINT, WPARAM, LPARAM);
#endif // WIN32

#endif//__exwndproc_h__
