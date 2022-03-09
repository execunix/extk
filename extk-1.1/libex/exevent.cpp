/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <exevent.h>
#include <exinput.h>
#include <extimer.h>
#include <exthread.h>
#include <exwindow.h>

#if defined(EX_EVENTPROC_HAVETHREAD)
 // EventThread
 //
class EventThread : public ExThread {
public:
    HANDLE hev;
    ExInput* sigTimer;
public:
    EventThread() : ExThread(), hev(NULL), sigTimer(NULL) {}
    int wakeup() {
        if (hev)
            SetEvent(hev);
        return 0;
    }
    int start();
    int stop();
    int STDCALL proc(ExThread* thread);
    int STDCALL noti(ExInput*, ExCbInfo*) {
        dprintf(L"EventThread::hev signaled...\n");
        return Ex_Continue;
    }
};

int EventThread::start() {
    hev = CreateEvent(NULL, FALSE, FALSE, NULL);
    //sigTimer = ExInput::add(hev, [](void* d, ExInput* input, ExCbInfo* cbinfo)->int {
    //    dprintf(L"EventThread::hev signaled...\n");
    //    return Ex_Continue; }, NULL);
    sigTimer = ExInput::add(hev, ExCallback(this, &EventThread::noti));
    int r = create(Proc(this, &EventThread::proc));
    return r;
}

int EventThread::stop() {
    assert(ExIsMainThread());
    idThread = 0;

    ExLeave();
    SetEvent(hev);
    join(INFINITE);
    CloseHandle(hev);
    ExEnter();

    ExInput::remove(sigTimer);

    return 0;
}

static EventThread eventThread;

int EventThread::proc(ExThread* thread) {
    assert(thread == this);

    ExEnter();
    while (idThread != 0 &&
           ExApp::getHalt() == 0) {
        ulong waittick;
        waittick = ExTimerListInvoke(exTickCount);
        dprint0(L"waittick=%d\n", waittick);
        if (ExApp::getHalt()) // is halt ?
            break; // stop event loop
        if (ExApp::mainWnd != NULL) {
            ExApp::mainWnd->flush(); // tbd
        }
        ExInput::invoke(waittick); // The only waiting point.
        if (ExApp::getHalt()) // is halt ?
            break; // stop event loop
    }
    ExLeave();
    return 0;
}
#endif

void ExWakeupEventProc() {
#if defined(EX_EVENTPROC_HAVETHREAD)
    eventThread.wakeup();
#else
    ExWakeupMainThread();
#endif
}

int ExEventProcFini() {
#if defined(EX_EVENTPROC_HAVETHREAD)
    eventThread.stop();
#endif
    ExTimerListClear();
    return 0;
}

int ExEventProcInit() {
#if defined(EX_EVENTPROC_HAVETHREAD)
    eventThread.start();
#endif
    return 0;
}

// ExEmit APIs - deprecated
//

bool ExEmitMessage(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    BOOL r = PostMessage(hwnd, message, wParam, lParam);
    return r ? true : false;
}

bool ExEmitKeyEvent(ExWidget* widget, UINT message, int virtkey, long keydata) {
    HWND hwnd;
    if (widget && widget->getFlags(Ex_Realized) &&
        (hwnd = widget->getWindow()->getHwnd()) != NULL) {
        return ExEmitMessage(hwnd, message, virtkey, keydata);
    }
    return false;
}

bool ExEmitPtrEvent(ExWidget* widget, UINT message, WPARAM wParam, int x, int y) {
    HWND hwnd;
    if (widget && widget->getFlags(Ex_Realized) &&
        (hwnd = widget->getWindow()->getHwnd()) != NULL) {
        ExPoint pt(widget->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        LPARAM lParam = MAKELPARAM(x, y);
        return ExEmitMessage(hwnd, message, wParam, lParam);
    }
    return false;
}

bool ExEmitButPress(ExWidget* widget, int x, int y) {
    return (ExEmitPtrEvent(widget, WM_MOUSEMOVE, 0, x, y) &&
            ExEmitPtrEvent(widget, WM_LBUTTONDOWN, 0, x, y));
}

bool ExEmitButRelease(ExWidget* widget, int x, int y) {
    return ExEmitPtrEvent(widget, WM_LBUTTONUP, 0, x, y);
}

