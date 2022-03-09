/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include <extype.h>

// ExEvent
//
struct ExEvent {
    HWND        hwnd;
    UINT        message;
    WPARAM      wParam;
    LPARAM      lParam;
    LRESULT     lResult;
    MSG         msg;

    ExEvent() : hwnd(0), message(0), wParam(0), lParam(0), lResult(0) {}
};

// Callback Info
//
struct ExCbInfo {
    int         type;
    int         subtype;
    ExEvent*    event; // A pointer to a ExEvent structure that describes the event
                       //   that caused this callback to be invoked.
    void*       data;  // A pointer to callback-specific data.

    ExCbInfo(int t, int s = 0, ExEvent* e = NULL, void* d = NULL)
        : type(t), subtype(s), event(e), data(d) {}
    ExCbInfo* set(int t, int s = 0) { type = t; subtype = s; return this; }
};

// ExEmit APIs - deprecated => Call the callback function directly.
//
bool ExEmitMessage(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
bool ExEmitKeyEvent(ExWidget* widget, UINT message, int virtkey, long keydata);
bool ExEmitPtrEvent(ExWidget* widget, UINT message, WPARAM wParam, int x, int y);
bool ExEmitButPress(ExWidget* widget, int x, int y);
bool ExEmitButRelease(ExWidget* widget, int x, int y);

void ExWakeupEventProc();

int ExEventProcFini();
int ExEventProcInit();

#endif//__exevent_h__
