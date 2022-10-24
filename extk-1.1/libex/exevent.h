/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"

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
    int         type;
    int         message;
    int         wparam;
    int         lparam;
    void*       data;
    void*       emitter;
    void*       collector;
    int         status;
    int         result;

    ExEvent() : type(0), message(0), wparam(0), lparam(0),
                data(0), emitter(0), collector(0), status(0), result(0) {}
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
bool ExEmitMessage(int type, int message, int wParam, int lParam);
#endif

#endif//__exevent_h__
