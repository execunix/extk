/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "exapp.h"

// app private variables
//
uint32 ex_but_timer_default_initial = 250;
uint32 ex_but_timer_default_repeat = 100;
uint32 ex_key_timer_default_initial = 250;
uint32 ex_key_timer_default_repeat = 100;

uint32 ex_but_timer_instant_initial = 0;
uint32 ex_but_timer_instant_repeat = 0;
uint32 ex_key_timer_instant_initial = 0;
uint32 ex_key_timer_instant_repeat = 0;

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
const char*  ExApp::appName = "ExApp";
ExWindow*    ExApp::mainWnd = nullptr;
#ifdef WIN32
HINSTANCE    ExApp::hInstance = 0;
HINSTANCE    ExApp::hPrevInstance = 0;
LPSTR        ExApp::lpCmdLine = NULL;
int32        ExApp::nCmdShow = 0;
#endif
#ifdef CONF_X11
ExApp::EnvX11 ExApp::x11 = {
    .wm_atom = { None },
    .display = nullptr,
    .visual = nullptr,
    .screen = -1,
    .depth = 0,
    .root = None,
    .ximg = nullptr,
};
#endif // CONF_X11
int32        ExApp::retCode = 0;                // 0:EXIT_SUCCESS,1:EXIT_FAILURE
ExSize       ExApp::smSize(0);                  // SystemMetrics
ExTimer      ExApp::but_timer;
ExTimer      ExApp::key_timer;
uint64       ExApp::key_flags = 0UL;
uint32       ExApp::key_state = 0U;
int32        ExApp::button_x[2];                /* The last 2 button click positions. */
int32        ExApp::button_y[2];
uint32       ExApp::double_click_distance;      /* Maximum distance between clicks in pixels */
uint32       ExApp::double_click_count;
uint32       ExApp::button_react_delay;
uint32       ExApp::button_click_time[2];       /* The last 2 button click times. */
uint32       ExApp::double_click_time;          /* Maximum time between clicks in msecs */
uint32       ExApp::button_number[2];           /* The last 2 buttons to be pressed. */
ExWidget*    ExApp::button_widget[2];           /* The last 2 widgets to receive button presses. */
ExWindow*    ExApp::button_window[2];           /* The last 2 windows to receive button presses. */
#ifdef OSAL_WIN32
uint32       ExApp::regAppMsgIndex = 0x8000U;   // WM_APP 0x8000
#endif

#ifdef WIN32
// ExModalCtrl - tbd
//
struct ExModalCtrl {
    uint32          flags;
    void*           result;
    ExThreadCond*   cond;
    ExModalCtrl**   prev;
    ExModalCtrl*    next;
};

static ExModalCtrl exModalMain;

int32 ExModalUnblock(ExModalCtrl* ctrl, void* result);
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
int32 ExModalUnblock(ExModalCtrl* ctrl, void* result)
{
    exassert(ctrl->flags & 0x80000000);
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
void* ExModalBlock(ExModalCtrl* ctrl, long flags)
{
#if 0 // tbd
    MSG msg;
    uint32 waittick;
    ctrl->flags = flags | 0x80000000;
    ctrl->result = NULL;
    ctrl->cond = NULL;
    ctrl->prev = NULL;
    ctrl->next = NULL;
    while ((exWatchDisp->getHalt() == 0U) && (ctrl->flags & 0x80000000)) {
        waittick = ExTimerListInvoke(exWatchDisp->getTick());
        dprint0("waittick=%d\n", waittick);
        if (exWatchDisp->getHalt() != 0U) // is halt ?
            break; // stop exmsg loop
        if (ExApp::mainWnd != nullptr)
            ExApp::mainWnd->flush();
        ExInput::invoke(waittick); // The only waiting point.
        if (exWatchDisp->getHalt() != 0U) // is halt ?
            break; // stop exmsg loop
        while ((ctrl->flags & 0x80000000) &&
            ExEventPeek(msg) == true) { // is message available ?
            if (msg.message == WM_ExEvWake) {
                dprint("message == WM_ExEvWake\n");
                break;
            }
            if (msg.message == WM_QUIT) { // WM_DESTROY => PostQuitMessage
                dprint("message == WM_QUIT tick=%d\n", exWatchDisp->getTick());
                ExApp::retCode = (int32)msg.wParam; // cause DestroyWindow
                exWatchDisp->setHalt(Ex_Halt); // stop exmsg loop
                break;
            }
            //exWatchDisp->leave(); // tbd ctrl->leave()
            ExApp::dispatch(msg);
            //exWatchDisp->enter(); // tbd ctrl->enter()
            ExApp::collect();
        }
    }
    ExApp::collect();
#endif
    return ctrl->result;
}
#endif

/**
ExMainLoop()
    Implement an application main loop
Description:
    This is a convenience function that implements an application main loop using
    ExEventNext() and ExEventHandler().
*/
void ExMainLoop()
{
#ifdef WIN32
    MSG msg;
    exassert(exWatchDisp->isEntered());
    while ((exWatchDisp->getHalt() == 0U) &&
           (ExEventPeek(msg) == true)) { // is message available ?
        if (msg.message == WM_ExEvWake) {
            dprint("message == WM_ExEvWake\n");
            continue;
        }
        if (msg.message == WM_QUIT) { // WM_DESTROY => PostQuitMessage
            dprint("message == WM_QUIT tick=%d\n", exWatchDisp->getTick());
            ExApp::retCode = (int32)msg.wParam; // cause DestroyWindow
            exWatchDisp->setHalt(Ex_Halt); // stop exmsg loop
            break;
        }
        ExApp::dispatch(msg);
        ExApp::collect();
    }
    ExApp::collect();
#endif
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
void ExQuitMainLoop()
{
#ifdef WIN32
    PostQuitMessage(0);
#endif
}

#ifdef WIN32
void ExApp::dispatch(MSG& msg)
{
    exWatchDisp->leave();
    TranslateMessage(&msg);
    DispatchMessage(&msg);
    exWatchDisp->enter();
}
#endif
#ifdef __linux__
void ExApp::dispatch(ExMsg& em)
{
}
#endif

typedef std::list<ExWidget*> ExWidgetList;
typedef std::list<ExWindow*> ExWindowList;

static ExWidgetList deleteWidgetList;
static ExWindowList detachWindowList;

static void collectWidget() {
    while (!deleteWidgetList.empty()) {
        ExWidget* w = deleteWidgetList.front();
        deleteWidgetList.pop_front();

        dprint1("collectWidget %s\n", w->getName());
        delete w;
        //
        // After destroy, can't access callback list...
        // Be careful not to access member variables any more.
        //
    }
}

static void collectWindow() {
    while (!detachWindowList.empty()) {
        ExWindow* w = detachWindowList.front();
        detachWindowList.pop_front();

        dprint1("collectWindow %s\n", w->getName());
        w->destroy();
    }
}

void ExApp::addCollectWidget(ExWidget* widget)
{
    deleteWidgetList.push_back(widget);
}

void ExApp::addCollectWindow(ExWindow* window)
{
    detachWindowList.push_back(window);
}

void ExApp::collect()
{
    // If some objects are deleted inside the dispatch function,
    // we will have a problem, so clean up here.

    collectWindow();
    collectWidget();
    //collectTimer();
    // tbd etc...
}

void ExApp::exit(int32 retCode)
{
    dprint("%s(%d)\n", __func__, retCode);
#ifdef WIN32
    if (!ExIsMainThread()) {
        dprint("pause main thread\n");
    }
    // When the system window manager closed the app, mainWnd was destroyed.
#if 1 // It's not essential, but it's better to keep it clean.
    if (ExApp::mainWnd != nullptr) { // When the halt flag is set inside the app.
        ExApp::mainWnd->destroy();
        ExApp::collect();
    }
#endif
    ExFiniProcess();
    ExitProcess(retCode);
#endif
#ifdef __linux__
    ::exit(retCode);
#endif
}

#ifdef WIN32
bool ExApp::init(HINSTANCE hInstance,
                 HINSTANCE hPrevInstance,
                 LPSTR lpCmdLine,
                 int32 nCmdShow)
{
    // init lib
    ExInitProcess();

    // init args
    ExApp::hInstance = hInstance;
    ExApp::hPrevInstance = hPrevInstance;
    ExApp::lpCmdLine = lpCmdLine;
    ExApp::nCmdShow = nCmdShow;

    // init vars
    ExApp::retCode = EXIT_FAILURE;
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

    if (ExWindow::initClass(hInstance) != 0) {
        retCode = EXIT_SUCCESS;
    }
    return (retCode == EXIT_SUCCESS);
}
#endif // WIN32

#ifdef __linux
bool ExApp::init(int argc, char* argv[])
{
    // init vars
    ExApp::retCode = EXIT_FAILURE;

    return (retCode == EXIT_SUCCESS);
}
#endif // __linux

#ifdef CONF_X11
static uint32 onXevent(void* data, const epoll_event* const ev);

static int32 x_error_handler(Display* d, XErrorEvent* e)
{
    char buffer[256];
    XGetErrorText(d, e->error_code, buffer, 256);
    dprint("X-ERR %d: %s\n", e->type, buffer);
    return 0;
}

bool ExApp::initX11(ExWatch* watch)
{
    int32 r = -1;
    button_click_time[0] = ExGetTickCount();
    button_click_time[1] = ExGetTickCount();
    do {
        XSetErrorHandler(x_error_handler);

        // connect to the display
        const char* const disp = getenv("DISPLAY");
        x11.display = XOpenDisplay((disp == nullptr) ? ":0.0" : disp);
        dprint("XOpenDisplay(0)=0x%p\n", x11.display);
        if (x11.display == nullptr) {
            break;
        }
        // get display info : "$ xwininfo"
        x11.screen = XDefaultScreen(x11.display);
        dprint("XDefaultScreen()=%d\n", x11.screen);
        x11.depth = XDefaultDepth(x11.display, x11.screen);
        dprint("XDefaultDepth()=%d\n", x11.depth);
        if (!(x11.depth == 32 || x11.depth == 24)) {
            dprint("Check your X Server Configuration!!!\n");
            dprint("This program requires 32bit-color-depth of Screen.\n");
            break;
        }
        x11.visual = XDefaultVisual(x11.display, x11.screen);
        dprint("visual=0x%p, visual_class=%d\n", x11.visual, x11.visual->c_class);
        if (x11.visual->c_class != TrueColor) {
            dprint("Check your X Server Configuration!!!\n");
            dprint("This program requires TrueColor Visual Type.\n");
            break;
        }
        // get root window
        x11.root = XDefaultRootWindow(x11.display);
        dprint("XDefaultRootWindow()=%ld\n", x11.root);
        if (x11.root == None) {
            dprint("Cannot find root window.\n");
            break;
        }
        x11.wm_atom[ExApp::WM_PROTOCOLS] = XInternAtom(ExApp::x11.display, "WM_PROTOCOLS", True);
        x11.wm_atom[ExApp::WM_TAKE_FOCUS] = XInternAtom(ExApp::x11.display, "WM_TAKE_FOCUS", True);
        x11.wm_atom[ExApp::WM_SAVE_YOURSELF] = XInternAtom(ExApp::x11.display, "WM_SAVE_YOURSELF", True); // deprecated
        x11.wm_atom[ExApp::WM_DELETE_WINDOW] = XInternAtom(ExApp::x11.display, "WM_DELETE_WINDOW", True);
        // x11.fb0_w = x11.sm_w;
        // x11.fb0_h = x11.sm_h;
        // x11.fb0_rotate = 0;
        const int32 xd_fd = ConnectionNumber(x11.display);
        if (watch->ioAdd(&onXevent, watch, xd_fd)) {
            r = 0;
        }
    } while (false);
    return (r == 0);
}

bool ExApp::finiX11(ExWatch* watch)
{
    ExApp::EnvX11& x11 = ExApp::x11;
    const int32 xd_fd = ConnectionNumber(x11.display);
    (void)watch->ioDel(xd_fd);
    if (x11.display != nullptr) {
        XCloseDisplay(x11.display);
        x11.display = nullptr;
    }
    return true;
}

uint32 onXevent(void* data, const epoll_event* const ev)
{
    ExApp::EnvX11& x11 = ExApp::x11;
    ExWatch* watch = static_cast<ExWatch*>(data);
    const int32 xd_fd = ConnectionNumber(x11.display);
    dprint0("%s: xd_fd=%d\n", __func__, xd_fd);
    exassert(ev->data.fd == xd_fd);

    while (XPending(x11.display)) {
        XEvent e;
        XNextEvent(x11.display, &e);
        switch (e.type) {
            case ClientMessage: {
                if ((e.xclient.message_type == x11.wm_atom[ExApp::WM_PROTOCOLS]) &&
                    (e.xclient.format == 32)) {
                    Atom protocol = e.xclient.data.l[0];
                    if (protocol == x11.wm_atom[ExApp::WM_DELETE_WINDOW]) {
                        dprint("ClientMessage.WM_DELETE_WINDOW\n");
                        #if 1
                        watch->setHalt();
                        #else
                        (void)XDestroyWindow(x11.display, env.top);
                        dprint("XDestroyWindow()\n");
                        #endif
                    }
                    if (protocol == x11.wm_atom[ExApp::WM_TAKE_FOCUS]) {
                        dprint("ClientMessage.WM_TAKE_FOCUS\n");
                    }
                }
            } break;
            case DestroyNotify: {
                dprint("DestroyNotify\n");
            } break;
            case CreateNotify: {
                dprint("CreateNotify\n");
            } break;
            case ButtonPress: {
                dprint0("ButtonPress state:%d button:%d pos:%d,%d\n", e.xbutton.state, e.xbutton.button, e.xbutton.x, e.xbutton.y);
                (void)ExEmitPtrMsg(WM_LBUTTONDOWN, e.xbutton.x, e.xbutton.y);
            } break;
            case ButtonRelease: {
                dprint0("ButtonRelease state:%d button:%d pos:%d,%d\n", e.xbutton.state, e.xbutton.button, e.xbutton.x, e.xbutton.y);
                (void)ExEmitPtrMsg(WM_LBUTTONUP, e.xbutton.x, e.xbutton.y);
            } break;
            case MotionNotify: {
                dprint0("MotionNotify state:%d button:%d pos:%d,%d\n", e.xbutton.state, e.xbutton.button, e.xbutton.x, e.xbutton.y);
                (void)ExEmitPtrMsg(WM_MOUSEMOVE, e.xbutton.x, e.xbutton.y);
            } break;
            case EnterNotify: {
                dprint("EnterNotify\n");
            } break;
            case LeaveNotify: {
                dprint("LeaveNotify\n");
            } break;
            case KeyPress: {
                dprint("KeyPress\n");
                //uint32 state = e.xkey.state;
                uint32 keycode = e.xkey.keycode; // KeyCode: uint32
                int32 keysyms_per_keycode = 0;
                KeySym* keysym = XGetKeyboardMapping(x11.display, keycode, 1, &keysyms_per_keycode);
                switch (*keysym) {
                    case XK_Escape: {
                        watch->setHalt(); //XDestroyWindow(x11.display, env.top);
                    } break;
                    case XK_Return: break;
                    case XK_BackSpace: break;
                    case XK_0: break;
                    case XK_1: break;
                    case XK_2: break;
                    case XK_3: break;
                    case XK_4: break;
                    case XK_5: break;
                    case XK_6: break;
                    case XK_7: break;
                    case XK_8: break;
                    case XK_9: break;
                }
                XFree(keysym);
            } break;
            case KeyRelease: {
                dprint("KeyRelease\n");
            } break;
            case FocusIn: {
                dprint("FocusIn\n");
            } break;
            case FocusOut: {
                dprint("FocusOut\n");
            } break;
            case Expose: {
                dprint("Expose count:%d\n", e.xexpose.count);
            } break;
            case GraphicsExpose: {
                dprint("GraphicsExpose count:%d\n", e.xgraphicsexpose.count);
            } break;
            case ResizeRequest: {
                dprint("ResizeRequest\n");
            } break;
            case MapNotify: {
                dprint("MapNotify\n");
            } break;
            case UnmapNotify: {
                dprint("UnmapNotify\n");
            } break;
            default: {
                dprint("Unhandled XEvent.type=%d\n", e.type);
            } break;
        }
    }
    return 0U;
}
#else // CONF_X11
bool ExApp::initX11(ExWatch* watch)
{
    return true;
}

bool ExApp::finiX11(ExWatch* watch)
{
    return true;
}
#endif // CONF_X11
