/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"
#include "exgeomet.h"

// WM_GWES 0x0000~0x03FF : Messages reserved for use by the system
// WM_USER 0x0400~0x7FFF : Integer messages for use by private window classes
// WM_APP  0x8000~0xBFFF : Messages available for use by applications

#define WM_CbRemove     0xBFFD // (WM_APP+0x3FFD)
#define WM_ExEvEmit     0xBFFE // (WM_APP+0x3FFE)
#define WM_ExEvWake     0xBFFF // (WM_APP+0x3FFF)

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

    ExEvent() {}
    ExEvent(HWND hwnd) : hwnd(hwnd), message(0), wParam(0), lParam(0), lResult(0) {
        memset(&msg, 0, sizeof(msg));
    }
};
#endif
#ifdef __linux__
struct ExEvent {
    void*       hwnd;
    int32       message;
    int32       wParam;
    int64       lParam;
    int32       lResult;
    uint32      tick;
    ExObject*   emitter;
    ExObject*   collector;
    union MSG {
        void*   data[1];
        uint64  u64[1];
        ExPoint pt;
        ExSize  sz;
        MSG() {}
        // MSG& operator = (const MSG&) = default;
        // MSG() { memset(u64, 0, sizeof(u64)); }
        // MSG(const MSG& m) { memcpy(&u64[0], &m.u64[0], sizeof(u64)); }
        MSG& operator = (const MSG& m) { memcpy(&u64[0], &m.u64[0], sizeof(u64)); return *this; }
    } msg;
    ExEvent() {}
    ExEvent(void* hwnd)
        : hwnd(hwnd), message(0), wParam(0), lParam(0)
        , lResult(0), tick(0), emitter(nullptr), collector(nullptr), msg() {
        memset(msg.u64, 0, sizeof(msg.u64));
    }
    ExEvent(const ExEvent&) = default;
    ExEvent& set(int32 msg, int32 wpa, int64 lpa) {
        message = msg; wParam = wpa; lParam = lpa;
        return *this;
    }
    void setHwnd(void* ptr) {
        this->hwnd = ptr;
    }
};
#endif

// ExEmit APIs - deprecated => Call the callback function directly.
//
#ifdef WIN32
bool ExEmitMessage(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
bool ExEmitKeyEvent(ExWidget* widget, UINT message, int32 virtkey, long keydata);
bool ExEmitPtrEvent(ExWidget* widget, UINT message, WPARAM wParam, int32 x, int32 y);
bool ExEmitButPress(ExWidget* widget, int32 x, int32 y);
bool ExEmitButRelease(ExWidget* widget, int32 x, int32 y);
#endif
#ifdef __linux__
bool ExEmitMessage(const int32 type, const int32 message, const int32 wParam, const int64 lParam);
#endif

#endif//__exevent_h__
