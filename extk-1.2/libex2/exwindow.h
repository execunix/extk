/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwindow_h__
#define __exwindow_h__

#include "exwidget.h"
#include "excanvas.h"
#include "exthread.h"
#ifdef CONF_X11
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#endif // CONF_X11

#ifdef CONF_X11 // __linux__
typedef Window HWND;
#endif

// Window constants definition
//
enum ExRenderFlags {
    Ex_RenderRebuild = 1U << 3,
    Ex_RenderDamaged = 1U << 4,
};

// class ExWindow
//
class ExWindow : public ExWidget {
protected:
    HWND        hwnd;
#ifdef WIN32
    DWORD       dwStyle;
    DWORD       dwExStyle;
#endif
    uint32      notifyFlags;    // tbd - remove
    uint32      renderFlags;    // tbd - remove
    //ExRegion    exposeAcc;  // tbd - replace Ex_RenderRebuild
    //ExRegion    opaqueAcc;
protected:
    ExWidget*   wgtCapture;
    ExWidget*   wgtEntered;
    ExWidget*   wgtPressed;
    ExWidget*   wgtFocused; // focused child
public:
    ExWidget* getCapture() const;
    ExWidget* getEntered() const;
    ExWidget* getPressed() const;
    ExWidget* getFocused() const;
    void setCapture(ExWidget* wgt) { wgtCapture = wgt; }
    void setEntered(ExWidget* wgt) { wgtEntered = wgt; }
    void setPressed(ExWidget* wgt) { wgtPressed = wgt; }
    void setFocused(ExWidget* wgt) { wgtFocused = wgt; }
public:
    ExFlushFunc flushFunc;
    ExFlushFunc paintFunc;
    ExCanvas*   canvas;
    ExEvent*    event;
#if 0 // Instance management will depend entirely on the programmer.
protected: // now allow new & delete
    static void operator delete (void* ptr) { free(ptr); }
    static void operator delete[](void* ptr) { free(ptr); }
    static void* operator new (std::size_t size) { return malloc(size); }
    static void* operator new[](std::size_t size) { return malloc(size); }
    static void operator delete (void*, void* placement) {}
    static void operator delete[](void*, void* placement) {}
    static void* operator new (std::size_t, void* placement) { return placement; }
    static void* operator new[](std::size_t, void* placement) { return placement; }
#endif
public:
    virtual ~ExWindow() noexcept;
    explicit ExWindow() noexcept;
    uint32 init(const char* name, int32 w, int32 h);
    static ExWindow* create(const char* name, int32 w, int32 h);
    virtual uint32 destroy();
#ifdef WIN32
    bool showWindow(DWORD dwExStyle, DWORD dwStyle, int32 x = CW_USEDEFAULT, int32 y = CW_USEDEFAULT);
    bool showWindow(); // ShowWindow(hwnd, SW_SHOWNORMAL); flush();
    bool hideWindow(); // ShowWindow(hwnd, SW_HIDE);
#endif
#ifdef CONF_X11 // __linux__
    bool showWindow(ulong type, int32 x = 0, int32 y = 0);
    bool showWindow(); // XMapWindow(...)
    bool hideWindow(); // XUnmapWindow(...);
#endif
protected:
    virtual uint32 getClassFlags(uint32 masks = Ex_BitTrue) const {
        return (masks & (Ex_RECTANGULAR | Ex_CONTAINER | Ex_DISJOINT));
    }
    virtual void reconstruct() {
        this->~ExWindow(); // nonvirtual explicit destructor calls
        new (this) ExWindow(); // nonvirtual explicit constructor calls
    }
    //ExThreadMutex mutex;
public:
    //void enter() { mutex.lock(); }
    //void leave() { mutex.unlock(); }
    HWND getHwnd() const { return (this != nullptr) ? hwnd : static_cast<HWND>(0); }
    void setHwnd(HWND h) { hwnd = h; }
    ExWidget* giveFocus(ExWidget* newFocus);
    ExWidget* moveFocus(uint32 dir); // sample
public:
    uint32 render(); // call drawfunc for back buffer
    uint32 flush(); // App Callback: GetDC-render-ReleaseDC
    uint32 paint(); // WM_PAINT: BeginPaint-render-EndPaint
protected: // window callback internal
    struct Callback : public ExCallback {
        uint8 prio;
        uint8 flag;
        uint16 mask; // tbd - ???
        Callback(const ExCallback& cb, const uint8 prio) noexcept
            : ExCallback(cb), prio(prio), flag(0), mask(0) {
        }
        bool operator == (const Callback& cb) const {
            return (func == cb.func && data == cb.data && prio == cb.prio);
        }
    };
    class CallbackList : public std::list<Callback> {
        uint16 influx, change; // for recurs
    public:
        CallbackList() noexcept : std::list<Callback>(), influx(0), change(0) {}
    public:
        // inherit size_type size();
        bool remove2(const ExCallback& cb);
        // inherit void remove(const Callback& cb);
        // inherit void push_back(const Callback& cb);
        // inherit void push_front(const Callback& cb);
        void push(const Callback& cb);
        uint32 invoke(ExWatch* watch, const ExObject* object, const ExCbInfo* cbinfo);
    };
    CallbackList filterList;
    CallbackList handlerList;
public: // window message callback operation (event filter and handler)
    void addFilter(uint32(*f)(void*, ExWindow*, ExCbInfo*), void* d, const uint8 prio = 5U) { // lambda
        filterList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/, typename C/*inherit ExCbInfo*/>
    void addFilter(uint32(*f)(A*, W*, C*), A* d, const uint8 prio = 5U) {
        static_assert(std::is_base_of<ExWidget, W>::value, "W must be derived from ExWidget");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        filterList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/, typename C/*inherit ExCbInfo*/>
    void addFilter(A* d, uint32(A::*f)(W*, C*), const uint8 prio = 5U) {
        static_assert(std::is_base_of<ExWidget, W>::value, "W must be derived from ExWidget");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        filterList.push(Callback(ExCallback(d, f), prio));
    }
    void addFilter(const ExCallback& cb, const uint8 prio = 5U) {
        filterList.push(Callback(cb, prio));
    }
    void removeFilter(const ExCallback& cb) {
        filterList.remove2(cb);
    }
    uint32 invokeFilter(const ExCbInfo* const cbinfo) {
        return filterList.invoke(exWatchDisp, this, cbinfo);
    }

    void addHandler(uint32(*f)(void*, ExWindow*, ExCbInfo*), void* d, const uint8 prio = 5U) { // lambda
        handlerList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/, typename C/*inherit ExCbInfo*/>
    void addHandler(uint32(*f)(A*, W*, C*), A* d, const uint8 prio = 5U) {
        static_assert(std::is_base_of<ExWidget, W>::value, "W must be derived from ExWidget");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        handlerList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/, typename C/*inherit ExCbInfo*/>
    void addHandler(A* d, uint32(A::*f)(W*, C*), const uint8 prio = 5U) {
        static_assert(std::is_base_of<ExWidget, W>::value, "W must be derived from ExWidget");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        handlerList.push(Callback(ExCallback(d, f), prio));
    }
    void addHandler(const ExCallback& cb, const uint8 prio = 5U) {
        handlerList.push(Callback(cb, prio));
    }
    void removeHandler(const ExCallback& cb) {
        handlerList.remove2(cb);
    }
    uint32 invokeHandler(const ExCbInfo* const cbinfo) {
        return handlerList.invoke(exWatchDisp, this, cbinfo);
    }
public:
    void onExFlush(ExWindow* window, const ExRegion* updateRgn);
    void onWmPaint(ExWindow* window, const ExRegion* updateRgn);
    uint32 onRepeatBut(ExTimer* timer, ExCbInfo* cbinfo);
    uint32 onRepeatKey(ExTimer* timer, ExCbInfo* cbinfo);
public:
#ifdef WIN32
    static LPCSTR getClassName() { return "ExWindow"; }
    static ATOM classInit(HINSTANCE hInstance); // customizable
#endif
public:
    friend class ExWidget;
    friend class ExApp;
public:
    Ex_DECLARE_TYPEINFO(ExWindow, ExWidget);
};

/**
ExWindow::giveFocus()
    Give focus to a widget
Description:
    This function gives focus to the specified widget.
    The event argument is a pointer to a ExCbInfo structure that describes the event
    that will be passed to the lost-focus callback of the widget losing focus and
    to the got-focus callback of the widget getting focus. If event is NULL, this
    function generates a ExCbInfo structure filled with zeros for you.
Returns:
    A pointer to the newly focused widget. This is usually the same as the widget
    argument, but it could be NULL if one of the following is true:
    - The widget argument is NULL.
    - The given widget is disjoint (e.g. a window).
    - The widget is blocked; that is, it has Ex_Blocked set in its flags resource.
    - The widget has been destroyed before the attempt to give it focus.
    This function could also return a pointer to a different widget if that widget for
    some reason refused to relinquish focus (i.e. its Ex_CbLostFocus callback returned
    Ex_TBD???). This usually happens if the requirements of an entry field haven't been
    met and must be met before any other action can be taken.
*/

extern ExDrawFunc exDrawFuncTrap;

#endif//__exwindow_h__
