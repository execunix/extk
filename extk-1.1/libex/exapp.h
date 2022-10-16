/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exapp_h__
#define __exapp_h__

#include "extypes.h"
#include "extimer.h"
#include "exevent.h"
#include "exwindow.h"

extern ulong exTickCount;

extern ulong ex_but_timer_default_initial;
extern ulong ex_but_timer_default_repeat;
extern ulong ex_key_timer_default_initial;
extern ulong ex_key_timer_default_repeat;

extern ulong ex_but_timer_instant_initial;
extern ulong ex_but_timer_instant_repeat;
extern ulong ex_key_timer_instant_initial;
extern ulong ex_key_timer_instant_repeat;

// class ExApp
//
class ExApp {
public:
    static const wchar* appName;
    static ExWindow*    mainWnd;
    static HINSTANCE    hInstance;
    static HINSTANCE    hPrevInstance;
    static LPTSTR       lpCmdLine;
    static int          nCmdShow;
    static int          retCode;                // 0:EXIT_SUCCESS,1:EXIT_FAILURE
    static ExSize       smSize;                 // SystemMetrics
    static ExEvent      event;
    static int          halt;
    static ExTimer      but_timer;
    static ExTimer      key_timer;
    static long         key_state;
    static long         button_x[2];            /* The last 2 button click positions. */
    static long         button_y[2];
    static long         double_click_distance;  /* Maximum distance between clicks in pixels */
    static long         double_click_count;
    static ulong        button_react_delay;
    static ulong        button_click_time[2];   /* The last 2 button click times. */
    static ulong        double_click_time;      /* Maximum time between clicks in msecs */
    static int          button_number[2];       /* The last 2 buttons to be pressed. */
    static ExWidget*    button_widget[2];       /* The last 2 widgets to receive button presses. */
    static ExWindow*    button_window[2];       /* The last 2 windows to receive button presses. */
    static UINT         regAppMsgIndex;
public:
    static void dispatch(MSG& msg);
    static void collect();
    static void exit(int retCode);
    static int init(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow);
public:
    static long& butRepeatCnt() { return (long&)but_timer.u64[0]; };
    static long& keyRepeatCnt() { return (long&)key_timer.u64[0]; };
public:
    friend class ExWindow;
    friend class ExWidget;
    friend class ExTimer;
};

/**
ExEventPeek()
    Provide asynchronous event notification
Description:
    This function provides an asynchronous event-notification mechanism.
Returns:
    0	no messages are available
    1	a message is available
*/
int ExEventPeek(ExEvent& event);

typedef int(*ExEventFunc)(ExEvent& event);
extern ExEventFunc exEventFunc;

void ExMainLoop();
void ExQuitMainLoop();

inline UINT ExRegAppMessage() {
    return ExApp::regAppMsgIndex++;
}

/* sample

int callback(...) {
    if (...quit...) {
        ExQuitMainLoop();
        return Ex_Halt;
    }
    return Ex_Continue;
}

void start(...) {
    ExWindow* mainWnd = new ExWindow;
    ExApp::mainWnd = mainWnd;

    ...create widgets and add callbacks...
}

void main(int argc, char* argv[]) {
    ExApp::init(argc, argv);
    start(...);
    ExMainLoop();
    // cleanup
    ExApp::exit(1);
    return ExApp::retCode;
}
*/

#endif//__exapp_h__
