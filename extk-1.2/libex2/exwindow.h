/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwindow_h__
#define __exwindow_h__

#include "exwidget.h"
#include "excanvas.h"
#ifdef WIN32
#include "exthread.h"
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
#ifdef WIN32
    HWND        hwnd;
    DWORD       dwStyle;
    DWORD       dwExStyle;
#endif
    uint32      notifyFlags;    // tbd - remove
    uint32      renderFlags;    // tbd - remove
    //ExRegion    exposeAcc;  // tbd - replace Ex_RenderRebuild
    //ExRegion    opaqueAcc;
public:
    ExWidget*   wgtCapture;
    ExWidget*   wgtEntered;
    ExWidget*   wgtPressed;
    ExWidget*   wgtFocused; // focused child
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
    virtual ~ExWindow();
    explicit ExWindow();
    uint32 init(const char* name, int32 w, int32 h);
    static ExWindow* create(const char* name, int32 w, int32 h);
    virtual uint32 destroy();
#ifdef WIN32
    bool showWindow(DWORD dwExStyle, DWORD dwStyle, int32 x = CW_USEDEFAULT, int32 y = CW_USEDEFAULT);
    bool showWindow(); // ShowWindow(hwnd, SW_SHOWNORMAL); flush();
    bool hideWindow(); // ShowWindow(hwnd, SW_HIDE);
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
#ifdef WIN32
    HWND getHwnd() const { return this ? hwnd : NULL; }
#endif
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
        Callback(const ExCallback& cb, uint8 prio)
            : ExCallback(cb), prio(prio), flag(0), mask(0) {
        }
        bool operator == (const Callback& cb) const {
            return (func == cb.func && data == cb.data && prio == cb.prio);
        }
    };
    class CallbackList : public std::list<Callback> {
        uint16 influx, change; // for recurs
    public:
        CallbackList() : std::list<Callback>(), influx(0), change(0) {}
    public:
        // inherit size_type size();
        bool remove2(const ExCallback& cb);
        // inherit void remove(const Callback& cb);
        // inherit void push_back(const Callback& cb);
        // inherit void push_front(const Callback& cb);
        void push(const Callback& cb);
        uint32 invoke(ExWatch* watch, ExObject* object, ExCbInfo* cbinfo);
    };
    CallbackList filterList;
    CallbackList handlerList;
public: // window message callback operation (event filter and handler)
    void addFilter(uint32(STDCALL *f)(void*, ExWindow*, ExCbInfo*), void* d, uint8 prio = 5) {
        filterList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addFilter(uint32(STDCALL *f)(A*, W*, ExCbInfo*), A* d, uint8 prio = 5) {
        filterList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addFilter(A* d, uint32(STDCALL A::*f)(W*, ExCbInfo*), uint8 prio = 5) {
        filterList.push(Callback(ExCallback(d, f), prio));
    }
    void removeFilter(const ExCallback& cb) {
        filterList.remove2(cb);
    }
    uint32 invokeFilter(ExCbInfo* cbinfo) {
        return filterList.invoke(exWatchDisp, this, cbinfo);
    }

    void addHandler(uint32(STDCALL *f)(void*, ExWindow*, ExCbInfo*), void* d, uint8 prio = 5) {
        handlerList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addHandler(uint32(STDCALL *f)(A*, W*, ExCbInfo*), A* d, uint8 prio = 5) {
        handlerList.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addHandler(A* d, uint32(STDCALL A::*f)(W*, ExCbInfo*), uint8 prio = 5) {
        handlerList.push(Callback(ExCallback(d, f), prio));
    }
    void removeHandler(const ExCallback& cb) {
        handlerList.remove2(cb);
    }
    uint32 invokeHandler(ExCbInfo* cbinfo) {
        return handlerList.invoke(exWatchDisp, this, cbinfo);
    }
public:
    void STDCALL onExFlush(ExWindow* window, const ExRegion* updateRgn);
    void STDCALL onWmPaint(ExWindow* window, const ExRegion* updateRgn);
    uint32 STDCALL onRepeatBut(ExTimer* timer, ExCbInfo* cbinfo);
    uint32 STDCALL onRepeatKey(ExTimer* timer, ExCbInfo* cbinfo);
protected:
    virtual uint32 basicWndProc(ExCbInfo* cbinfo);
#ifdef WIN32
    static LRESULT CALLBACK sysWndProc(HWND, UINT, WPARAM, LPARAM);
    static LPCSTR getClassName() { return "ExWindow"; }
    static ATOM classInit(HINSTANCE hInstance);
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
