/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exapp_h__
#define __exapp_h__

#include "extypes.h"
#include "extimer.h"
#include "exevent.h"
#include "exmessage.h"
#include "exwindow.h"

extern uint32 ex_but_timer_default_initial;
extern uint32 ex_but_timer_default_repeat;
extern uint32 ex_key_timer_default_initial;
extern uint32 ex_key_timer_default_repeat;

extern uint32 ex_but_timer_instant_initial;
extern uint32 ex_but_timer_instant_repeat;
extern uint32 ex_key_timer_instant_initial;
extern uint32 ex_key_timer_instant_repeat;

// class ExApp
//
class ExApp {
public:
    static const char*  appName;
    static ExWindow*    mainWnd;
#ifdef WIN32
    static HINSTANCE    hInstance;
    static HINSTANCE    hPrevInstance;
    static LPSTR        lpCmdLine;
    static int32        nCmdShow;
#endif
#ifdef CONF_X11
    enum : int32 {
        WM_PROTOCOLS,
        WM_TAKE_FOCUS,
        WM_SAVE_YOURSELF,
        WM_DELETE_WINDOW,
        WM_MAX
    };
    struct EnvX11 {
        Atom            wm_atom[WM_MAX];
        Display*        display;
        Visual*         visual;
        int32           screen;
        int32           depth;
        Window          root;
        XImage*         ximg;
    };
    static EnvX11       x11;
#endif // CONF_X11
    static int32        retCode;                    // 0:EXIT_SUCCESS,1:EXIT_FAILURE
    static ExSize       smSize;                     // SystemMetrics
    static ExTimer      but_timer;
    static ExTimer      key_timer;
    static uint64       key_flags;
    static uint32       key_state;
    static int32        button_x[2];                /* The last 2 button click positions. */
    static int32        button_y[2];
    static uint32       double_click_distance;      /* Maximum distance between clicks in pixels */
    static uint32       double_click_count;
    static uint32       button_react_delay;
    static uint32       button_click_time[2];       /* The last 2 button click times. */
    static uint32       double_click_time;          /* Maximum time between clicks in msecs */
    static uint32       button_number[2];           /* The last 2 buttons to be pressed. */
    static ExWidget*    button_widget[2];           /* The last 2 widgets to receive button presses. */
    static ExWindow*    button_window[2];           /* The last 2 windows to receive button presses. */
#ifdef OSAL_WIN32
    static uint32       regAppMsgIndex;
#endif
public:
    static void addCollectWidget(ExWidget* widget);
    static void addCollectWindow(ExWindow* window);
    static void collect();
    static void exit(int32 retCode);
#ifdef WIN32
    static bool init(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int32 nCmdShow);
#endif
#ifdef __linux__
    static bool init(int argc, char* argv[]);
#endif
    static bool initX11(ExWatch* watch);
    static bool finiX11(ExWatch* watch);
public:
    static uint32 btnClickTime() { return button_click_time[1]; }
    static uint32& butRepeatCnt() { return but_timer.u32[0]; };
    static uint32& keyRepeatCnt() { return key_timer.u32[0]; };
public:
    friend class ExWindow;
    friend class ExWidget;
    friend class ExTimer;
};

/**
ExModalBlock()
    Start a modal loop
Description:
    ExModalBlock() implements a modal loop.
    ExModalBlock() doesn't return until ExModalUnblock() is called with the same
    value of its ctrl argument. The structure pointed to by ctrl doesn't need to
    be initialized in any special way.
Returns:
    NULL on error, or the value passed as the second argument to ExModalUnblock()
    (don't use NULL or you won't be able to recognize a failure).
*/
void* ExModalBlock(ExModalCtrl* const ctrl);

/**
ExModalUnblock()
    stop a modal loop
Description:
    ExModalUnblock() causes the corresponding ExModalBlock() call to return the
    value passed to the result argument. If you call PtModalUnblock() more than
    once before PtModalBlock() returns, only the first call matters; don't call
    PtModalUnblock() after PtModalBlock() has returned.
Returns:
    0	Success.
    -1	An error occurred.
*/
void ExModalUnblock(ExModalCtrl* const ctrl, void* result);

void ExMainLoop();
void ExQuitMainLoop();

#ifdef OSAL_WIN32
inline uint32 ExRegAppMessage() {
    return ExApp::regAppMsgIndex++;
}
#endif

/* sample

uint32 callback(...) {
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

int main(int argc, char* argv[]) {
    ExApp::init(argc, argv);
    start(...);
    ExMainLoop();
    // cleanup
    ExApp::exit(1);
    return ExApp::retCode;
}
*/

#endif//__exapp_h__
