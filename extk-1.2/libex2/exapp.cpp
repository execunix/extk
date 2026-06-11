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
#ifdef __linux__
int32        ExApp::argc = 0;
char**       ExApp::argv = nullptr;
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
uint64       ExApp::button_click_time[2];       /* The last 2 button click times. */
uint32       ExApp::double_click_time;          /* Maximum time between clicks in msecs */
uint32       ExApp::button_number[2];           /* The last 2 buttons to be pressed. */
ExWidget*    ExApp::button_widget[2];           /* The last 2 widgets to receive button presses. */
ExWindow*    ExApp::button_window[2];           /* The last 2 windows to receive button presses. */
#ifdef OSAL_WIN32
uint32       ExApp::regAppMsgIndex = 0x8000U;   // WM_APP 0x8000
#endif

void* ExModalBlock(ExModalCtrl* const ctrl)
{
    return exWatchDisp->modalBlock(ctrl);
}

void ExModalUnblock(ExModalCtrl* const ctrl, void* result)
{
    exWatchDisp->modalUnblock(ctrl, result);
}

/**
ExMainLoop()
    Implement an application main loop
Description:
    This is a convenience function that implements an application main loop using
    ExEventNext() and ExEventHandler().
*/
int32 ExMainLoop()
{
    return (int32)exWatchDisp->guiloop(ExHookProc::Process);
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
    PostQuitMessage(EXIT_SUCCESS);
#else
    (void)ExEmitMessage(WM_QUIT, EXIT_SUCCESS); // stop main loop
#endif
}

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

void ExApp::fini(int32 retCode)
{
    dprint("%s(%d)\n", _func_, retCode);
    exassert2(ExThreadSelf() == exWatchMain, _fileline_); // trap
#ifdef WIN32
    // When the system window manager closed the app, mainWnd was destroyed.
    #if 1 // It's not essential, but it's better to keep it clean.
    if (ExApp::mainWnd != nullptr) { // When the halt flag is set inside the app.
        ExApp::mainWnd->destroy();
        ExApp::collect();
    }
    #endif
    ExFiniProcess();
    ExitProcess(retCode);
#endif // WIN32
#ifdef __linux__
    ExFiniProcess();
    exit(retCode);
#endif // __linux__
}

#ifdef WIN32
void ExApp::init(ExWatch* self,
                 HINSTANCE hInstance,
                 HINSTANCE hPrevInstance,
                 LPSTR lpCmdLine,
                 int32 nCmdShow)
{
    // init lib
    ExInitProcess(self);

    // init args
    ExApp::hInstance = hInstance;
    ExApp::hPrevInstance = hPrevInstance;
    ExApp::lpCmdLine = lpCmdLine;
    ExApp::nCmdShow = nCmdShow;

    // init vars
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
    dprint("%s() width=%d height=%d\n", _func_, smSize.w, smSize.h);

    if (ExWindow::initClass(hInstance) == 0) {
        dprint1("%s() initClass(0x%p) failed.\n", _func_, hInstance);
    }
}
#endif // WIN32

#ifdef __linux
void ExApp::init(ExWatch* self, int argc, char* argv[])
{
    // init lib
    ExInitProcess(self, argv[0]);

    // init args
    ExApp::argc = argc;
    ExApp::argv = argv;

    // init vars
    smSize.w = 0; // tbd
    smSize.h = 0; // tbd

    dprint("%s() width=%d height=%d\n", _func_, smSize.w, smSize.h);
}
#endif // __linux

#ifdef CONF_X11
uint32 onXeventSample(void* data, const epoll_event* const ev);

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
    if (!XInitThreads()) {
        dprint("XInitThreads() failed\n");
    }
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
        #if 0 // move to WatchDev::startup()
        const int32 xd_fd = ConnectionNumber(x11.display);
        if (watch->ioAdd(&onXeventSample, watch, xd_fd)) {
            r = 0;
        }
        #else
        r = 0;
        #endif
    } while (false);
    return (r == 0);
}

bool ExApp::finiX11(ExWatch* watch)
{
    ExApp::EnvX11& x11 = ExApp::x11;
    #if 0 // move to WatchDev::cleanup()
    const int32 xd_fd = ConnectionNumber(x11.display);
    (void)watch->ioDel(xd_fd);
    #endif
    if (x11.display != nullptr) {
        XCloseDisplay(x11.display);
        x11.display = nullptr;
    }
    return true;
}

uint32 onXeventSample(void* data, const epoll_event* const ev)
{
    ExApp::EnvX11& x11 = ExApp::x11;
    ExWatch* watch = static_cast<ExWatch*>(data);
    const int32 xd_fd = ConnectionNumber(x11.display);
    dprint0("%s: xd_fd=%d\n", _func_, xd_fd);
    exassert(ev->data.fd == xd_fd);

    //XLockDisplay(x11.display);
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
                        ExQuitMainLoop();
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
                    case XK_BackSpace: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_BACK, 0LL);
                    } break;
                    case XK_Tab: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_TAB, 0LL);
                    } break;
                    case XK_Return: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_RETURN, 0LL);
                    } break;
                    case XK_Escape: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_ESCAPE, 0LL);
                        // ExQuitMainLoop();
                        // watch->setHalt(); //XDestroyWindow(x11.display, env.top);
                    } break;
                    case XK_Home: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_HOME, 0LL);
                    } break;
                    case XK_Left: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_LEFT, 0LL);
                    } break;
                    case XK_Up: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_UP, 0LL);
                    } break;
                    case XK_Right: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_RIGHT, 0LL);
                    } break;
                    case XK_Down: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_DOWN, 0LL);
                    } break;
                    case XK_End: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_END, 0LL);
                    } break;
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
                    case XK_KP_Space: {
                        PostMessage(ExApp::mainWnd->getHwnd(), WM_KEYDOWN, VK_SPACE, 0LL);
                    } break;
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
                XClearWindow(x11.display, ExApp::mainWnd->getHwnd());
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
    //XUnlockDisplay(x11.display);
    return 0U;
}
#else // !CONF_X11
bool ExApp::initX11(ExWatch* watch)
{
    return true;
}

bool ExApp::finiX11(ExWatch* watch)
{
    return true;
}
#endif // CONF_X11
