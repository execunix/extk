/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exinput_h__
#define __exinput_h__

#include <excallback.h>
#include <exobject.h>

// ExInput
//
struct ExInput {
    HANDLE      handle;
    ExCallback  callback;
    int         fRemoved;

    ExInput(HANDLE handle, const ExCallback& callback)
        : handle(handle), callback(callback), fRemoved(0) {}

    static int ExInput::invoke(ulong waittick);
    static void ExInput::remove(ExInput* input);
    static void ExInput::enumerate(ExCallback& callback, ExCbInfo* cbinfo); // broadcasting
    static ExInput* ExInput::find(HANDLE handle);
    static ExInput* ExInput::add(HANDLE handle, ExCallback& callback); // deprecated

    static ExInput* ExInput::add(HANDLE handle, int(STDCALL *f)(void*, ExInput*, ExCbInfo*), void* d) {
        return ExInput::add(handle, ExCallback(f, d));
    }
    template <typename A>
    static ExInput* ExInput::add(HANDLE handle, int(STDCALL *f)(A*, ExInput*, ExCbInfo*), A* d) {
        return ExInput::add(handle, ExCallback(f, d));
    }
    template <typename A>
    static ExInput* ExInput::add(HANDLE handle, A* d, int(STDCALL A::*f)(ExInput*, ExCbInfo*)) {
        return ExInput::add(handle, ExCallback(f, d));
    }
};

#endif//__exinput_h__
