/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"
#include "exgeomet.h"

// ExEvent
//
#ifdef WIN32
struct ExEvent {
    HWND        hwnd;
    UINT        message;
    WPARAM      wParam;
    LPARAM      lParam;
    LRESULT     lResult;
    MSG         msg;

    ExEvent() : hwnd(0), message(0), wParam(0), lParam(0), lResult(0) {}
};
#endif
#ifdef __linux__
struct ExEvent {
    void*       hwnd;
    int         message;
    int         wParam;
    int64       lParam;
    int         lResult;
    uint32      tick;
    void*       emitter;
    void*       collector;
    union MSG { // 32 bytes
        void*   data[4];
        uint64  u64[4];
        ExPoint pt;
        ExSize  sz;
        MSG() { memset(u64, 0, sizeof(u64)); }
        MSG(const MSG& m) { memcpy(u64, m.u64, sizeof(u64)); }
        MSG& operator = (const MSG& m) { memcpy(u64, m.u64, sizeof(u64)); return *this; }
    } msg;

    ExEvent()
        : hwnd(0), message(0), wParam(0), lParam(0)
        , lResult(0), tick(0), emitter(0), collector(0), msg() {}
#if 0
    // move constructor
    ExEvent(ExEvent&& ev)
        : hwnd(ev.hwnd), message(ev.message), wParam(ev.wParam), lParam(ev.lParam)
        , lResult(ev.lResult), tick(ev.tick), emitter(ev.emitter), collector(ev.collector), msg(ev.msg) {}
    ExEvent& operator = (ExEvent&& ev) {
        hwnd = ev.hwnd; message = ev.message; wParam = ev.wParam; lParam = ev.lParam;
        lResult = ev.lResult; tick = ev.tick; emitter = ev.emitter; collector = ev.collector; msg = ev.msg;
        return *this;
    }
#endif
    // copy constructor
    ExEvent(const ExEvent& ev)
        : hwnd(ev.hwnd), message(ev.message), wParam(ev.wParam), lParam(ev.lParam)
        , lResult(ev.lResult), tick(ev.tick), emitter(ev.emitter), collector(ev.collector), msg(ev.msg) {}
    ExEvent& operator = (const ExEvent& ev) {
        hwnd = ev.hwnd; message = ev.message; wParam = ev.wParam; lParam = ev.lParam;
        lResult = ev.lResult; tick = ev.tick; emitter = ev.emitter; collector = ev.collector; msg = ev.msg;
        return *this;
    }

    ExEvent& set(int msg, int wpa, int64 lpa) {
        message = msg; wParam = wpa; lParam = lpa;
        return *this;
    }
};
#endif

// ExEmit APIs - deprecated => Call the callback function directly.
//
#ifdef WIN32
bool ExEmitMessage(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
bool ExEmitKeyEvent(ExWidget* widget, UINT message, int virtkey, long keydata);
bool ExEmitPtrEvent(ExWidget* widget, UINT message, WPARAM wParam, int x, int y);
bool ExEmitButPress(ExWidget* widget, int x, int y);
bool ExEmitButRelease(ExWidget* widget, int x, int y);
#endif
#ifdef __linux__
bool ExEmitMessage(int type, int message, int wParam, int64 lParam);
#endif

#endif//__exevent_h__
