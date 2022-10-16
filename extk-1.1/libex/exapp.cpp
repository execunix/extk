/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "exapp.h"
#include <assert.h>

// app private variables
//
ulong exTickCount = 0;

ulong ex_but_timer_default_initial = 250;
ulong ex_but_timer_default_repeat = 100;
ulong ex_key_timer_default_initial = 250;
ulong ex_key_timer_default_repeat = 100;

ulong ex_but_timer_instant_initial = 0;
ulong ex_but_timer_instant_repeat = 0;
ulong ex_key_timer_instant_initial = 0;
ulong ex_key_timer_instant_repeat = 0;

// app private functions
//

// app APIs
//

// app context variables
//

// app context functions
//

// app message constants
//

// class ExApp
//
const wchar* ExApp::appName = L"ExApp";
ExWindow*    ExApp::mainWnd = NULL;
HINSTANCE    ExApp::hInstance = 0;
HINSTANCE    ExApp::hPrevInstance = 0;
LPTSTR       ExApp::lpCmdLine = NULL;
int          ExApp::nCmdShow = 0;
int          ExApp::retCode = 0;             // 0:EXIT_SUCCESS,1:EXIT_FAILURE
ExSize       ExApp::smSize; // SystemMetrics
ExEvent      ExApp::event;

int          ExApp::halt = 0;
ExTimer      ExApp::but_timer;
ExTimer      ExApp::key_timer;
long         ExApp::key_state = 0;
long         ExApp::button_x[2];             /* The last 2 button click positions. */
long         ExApp::button_y[2];
long         ExApp::double_click_distance;   /* Maximum distance between clicks in pixels */
long         ExApp::double_click_count;
ulong        ExApp::button_react_delay;
ulong        ExApp::button_click_time[2];    /* The last 2 button click times. */
ulong        ExApp::double_click_time;       /* Maximum time between clicks in msecs */
int          ExApp::button_number[2];        /* The last 2 buttons to be pressed. */
ExWidget*    ExApp::button_widget[2];        /* The last 2 widgets to receive button presses. */
ExWindow*    ExApp::button_window[2];        /* The last 2 windows to receive button presses. */
UINT         ExApp::regAppMsgIndex = WM_APP;

int ExEventPeek(ExEvent& event) {
    BOOL bRet;

    exWatchDisp->leave();
    if ((bRet = GetMessage(&event.msg, NULL, 0, 0)) != TRUE) {
        assert(event.msg.message == WM_QUIT);
        // WM_DESTROY => PostQuitMessage
        bRet = TRUE;
    }
    exWatchDisp->enter();

    return bRet;
}

ExEventFunc exEventFunc = &ExEventPeek;

// ExModalCtrl - tbd
//
struct ExModalCtrl {
    int             flags;
    void*           result;
    ExThreadCond*   cond;
    ExModalCtrl**   prev;
    ExModalCtrl*    next;
};

static ExModalCtrl exModalMain;

int   ExModalUnblock(ExModalCtrl* ctrl, void* result);
void* ExModalBlock(ExModalCtrl* ctrl, long flags);

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
int ExModalUnblock(ExModalCtrl* ctrl, void* result) {
    assert(ctrl->flags & 0x80000000);
    ctrl->flags = 0;
    ctrl->result = result;
    ExWakeupMainThread();
    //PostThreadMessage(exMainThread.idThread, WM_ExEvWake, 0, 1); // wakeup
    return 0;
}

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
void* ExModalBlock(ExModalCtrl* ctrl, long flags) {
#if 0 // tbd
    ulong waittick;
    ExEvent& event = ExApp::event;
    ctrl->flags = flags | 0x80000000;
    ctrl->result = NULL;
    ctrl->cond = NULL;
    ctrl->prev = NULL;
    ctrl->next = NULL;
    while (exWatchDisp->getHalt() == 0 && (ctrl->flags & 0x80000000)) {
        waittick = ExTimerListInvoke(exTickCount);
        dprint0("waittick=%d\n", waittick);
        if (exWatchDisp->getHalt()) // is halt ?
            break; // stop event loop
        if (ExApp::mainWnd != NULL)
            ExApp::mainWnd->flush();
        ExInput::invoke(waittick); // The only waiting point.
        if (exWatchDisp->getHalt()) // is halt ?
            break; // stop event loop
        while ((ctrl->flags & 0x80000000) &&
            exEventFunc(event) > 0) { // is message available ?
            if (event.msg.message == WM_ExEvWake)
                break;
            if (event.msg.message == WM_QUIT) { // WM_DESTROY => PostQuitMessage
                dprint("message == WM_QUIT tick=%d\n", exTickCount);
                ExApp::retCode = (int)event.msg.wParam; // cause DestroyWindow
                exWatchDisp->setHalt(Ex_Halt); // stop event loop
                break;
            }
            //exWatchDisp->leave(); // tbd ctrl->leave()
            ExApp::dispatch(event.msg);
            //exWatchDisp->enter(); // tbd ctrl->enter()
            ExApp::collect();
        }
    }
    ExApp::collect();
#endif
    return ctrl->result;
}

/**
ExMainLoop()
    Implement an application main loop
Description:
    This is a convenience function that implements an application main loop using
    ExEventNext() and ExEventHandler().
*/
void ExMainLoop() {
    ExEvent& event = ExApp::event;

    while (exWatchDisp->getHalt() == 0 &&
           exEventFunc(event) > 0) { // is message available ?
        if (event.msg.message == WM_ExEvWake)
            continue;
        if (event.msg.message == WM_QUIT) { // WM_DESTROY => PostQuitMessage
            dprint("message == WM_QUIT tick=%d\n", exTickCount);
            ExApp::retCode = (int)event.msg.wParam; // cause DestroyWindow
            exWatchDisp->setHalt(Ex_Halt); // stop event loop
            break;
        }
        ExApp::dispatch(event.msg);
        ExApp::collect();
    }
    ExApp::collect();
}

/**
ExQuitMainLoop()
    Cause ExMainLoop() in the calling thread to return
Description:
    This function causes ExMainLoop() in the calling thread to return right after in finishes
    processing the current event.
Returns:
    0	Success.
    -1	The thread has already called ExQuitMainLoop().
*/
void ExQuitMainLoop() {
    PostQuitMessage(0);
}

void ExApp::dispatch(MSG& msg) {
    exWatchDisp->leave();
    TranslateMessage(&msg);
    DispatchMessage(&msg);
    exWatchDisp->enter();
}

void collectWindow();
void collectWidget();

void ExApp::collect() {
    // If some objects are deleted inside the dispatch function,
    // we will have a problem, so clean up here.

    collectWindow();
    collectWidget();
    //collectTimer();
    // tbd etc...
}

void ExApp::exit(int retCode) {
    dprint("%s(%d)\n", __func__, retCode);
    if (!ExIsMainThread()) {
        dprint("pause main thread\n");
    }
    // When the system window manager closed the app, mainWnd was destroyed.
#if 1 // It's not essential, but it's better to keep it clean.
    if (ExApp::mainWnd != NULL) { // When the halt flag is set inside the app.
        ExApp::mainWnd->destroy();
        ExApp::collect();
    }
#endif
    ExFiniProcess();
    ExitProcess(retCode);
}

int ExApp::init(HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPTSTR lpCmdLine,
    int nCmdShow) {

    // init lib
    ExInitProcess();

    // init args
    ExApp::hInstance = hInstance;
    ExApp::hPrevInstance = hPrevInstance;
    ExApp::lpCmdLine = lpCmdLine;
    ExApp::nCmdShow = nCmdShow;
    ExApp::retCode = EXIT_FAILURE;

    // init vars
    exTickCount = GetTickCount();
    memset(&event, 0, sizeof(ExEvent));
#if 1
    smSize.w = GetSystemMetrics(SM_CXSCREEN);
    smSize.h = GetSystemMetrics(SM_CYSCREEN);
#else
    HDC hdc = GetDC(GetDesktopWindow());
    if (hdc != NULL) {
        smSize.w = GetDeviceCaps(hdc, HORZRES);
        smSize.h = GetDeviceCaps(hdc, VERTRES);
    }
#endif
    dprint("%s() width=%d height=%d\n", __func__, smSize.w, smSize.h);

    if (ExWindow::classInit(hInstance) != Ex_Continue)
        return retCode;

    retCode = EXIT_SUCCESS;

    return retCode;
}
