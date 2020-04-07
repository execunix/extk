/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwindow_h__
#define __exwindow_h__

#include <exwidget.h>
#include <excanvas.h>

// Window constants definition
//
enum ExRenderFlags {
    Ex_RenderRebuild = 1 << 3,
    Ex_RenderDamaged = 1 << 4,
};

// class ExWindow
//
class ExWindow : public ExWidget {
protected:
    HWND        hwnd;
    DWORD       dwStyle;
    DWORD       dwExStyle;
    int         notifyFlags;    // EventPending,...
    int         renderFlags;
    ExRegion    opaqueAcc;
    ExRegion    mergedRgn;
    ExRegion    updateRgn;
public:
    ExWidget*   wgtCapture;
    ExWidget*   wgtEntered; // cause event broken
    ExWidget*   wgtPressed; // cause event broken
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
    int init(const wchar* name, const ExArea* area);
    static ExWindow* create(const wchar* name, const ExArea* area);
    int init(LPCTSTR lpWindowName, DWORD dwExStyle, DWORD dwStyle, const ExArea* area);
    static ExWindow* create(LPCTSTR lpWindowName, DWORD dwExStyle, DWORD dwStyle, const ExArea* area);
    virtual int destroy();
    int showWindow(); // ShowWindow(hwnd, SW_SHOWNORMAL); flush();
    int hideWindow(); // ShowWindow(hwnd, SW_HIDE);
protected:
    virtual int getClassFlags(int masks = Ex_BitTrue) const {
        return (masks & (Ex_RECTANGULAR | Ex_CONTAINER | Ex_DISJOINT));
    }
    virtual void reconstruct() {
        this->ExWindow::~ExWindow(); // nonvirtual explicit destructor calls
        this->ExWindow::ExWindow(); // nonvirtual explicit constructor calls
    }
    ExThreadMutex mutex;
public:
    void enter() { mutex.lock(); }
    void leave() { mutex.unlock(); }
    HWND getHwnd() const { return this ? hwnd : NULL; }
    ExWidget* giveFocus(ExWidget* newly);
    ExWidget* moveFocus(int dir); // sample
    bool hasPendingUpdate() {
        return (renderFlags & (Ex_RenderRebuild | Ex_RenderDamaged)) != 0;
    }
protected:
    //int STDCALL test1(ExWidget* widget, ExCbInfo* cbinfo);
    int checkExtentRebuild();
    int setupVisibleRegion();
    int mergeDamagedRegion();
    int clearPendingUpdate();
    int summarize();
public:
    int render(); // call drawfunc for back buffer
    int flush(); // App Callback: GetDC-render-ReleaseDC
    int paint(); // WM_PAINT: BeginPaint-render-EndPaint
protected: // window callback internal
    class MsgCallbackList : public std::list<ExCallback> {
    public:
        MsgCallbackList() : std::list<ExCallback>() {}
    public:
        // inherit size_type size();
        // inherit void remove(const ExCallback& cb);
        // inherit void push_back(const ExCallback& cb);
        // inherit void push_front(const ExCallback& cb);
        void append(const ExCallback& cb) { push_back(cb); }
        void add(const ExCallback& cb) { push_front(cb); }
        void add(const ExCallback& cb, int pos);
        int invoke(ExObject* object, ExCbInfo* cbinfo);
    };
    MsgCallbackList filterList;
    MsgCallbackList handlerList;
public: // window message callback operation (event filter and handler)
    void addFilter(int(STDCALL *f)(void*, ExWindow*, ExCbInfo*), void* d) {
        filterList.add(ExCallback(f, d));
    }
    void addFilter(int(STDCALL *f)(void*, ExWindow*, ExCbInfo*), void* d, int pos) {
        filterList.add(ExCallback(f, d), pos);
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addFilter(A* d, int(STDCALL A::*f)(W*, ExCbInfo*)) {
        filterList.add(ExCallback(d, f));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addFilter(A* d, int(STDCALL A::*f)(W*, ExCbInfo*), int pos) {
        filterList.add(ExCallback(d, f), pos);
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addFilter(int(STDCALL *f)(A*, W*, ExCbInfo*), A* d) {
        filterList.add(ExCallback(f, d));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addFilter(int(STDCALL *f)(A*, W*, ExCbInfo*), A* d, int pos) {
        filterList.add(ExCallback(f, d), pos);
    }
    void removeFilter(ExCallback& cb) {
        filterList.remove(cb);
    }
    int invokeFilter(ExCbInfo* cbinfo) {
        return filterList.invoke(this, cbinfo);
    }

    void addHandler(int(STDCALL *f)(void*, ExWindow*, ExCbInfo*), void* d) {
        handlerList.add(ExCallback(f, d));
    }
    void addHandler(int(STDCALL *f)(void*, ExWindow*, ExCbInfo*), void* d, int pos) {
        handlerList.add(ExCallback(f, d), pos);
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addHandler(A* d, int(STDCALL A::*f)(W*, ExCbInfo*)) {
        handlerList.add(ExCallback(d, f));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addHandler(A* d, int(STDCALL A::*f)(W*, ExCbInfo*), int pos) {
        handlerList.add(ExCallback(d, f), pos);
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addHandler(int(STDCALL *f)(A*, W*, ExCbInfo*), void* d) {
        handlerList.add(ExCallback(f, d));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addHandler(int(STDCALL *f)(A*, W*, ExCbInfo*), void* d, int pos) {
        handlerList.add(ExCallback(f, d), pos);
    }
    void removeHandler(ExCallback& cb) {
        handlerList.remove(cb);
    }
    int invokeHandler(ExCbInfo* cbinfo) {
        return handlerList.invoke(this, cbinfo);
    }
public:
    void STDCALL onExFlush(ExWindow* window, const ExRegion* updateRgn);
    void STDCALL onWmPaint(ExWindow* window, const ExRegion* updateRgn);
    int STDCALL onRepeatBut(ExTimer* timer, ExCbInfo* cbinfo);
    int STDCALL onRepeatKey(ExTimer* timer, ExCbInfo* cbinfo);
protected:
    virtual int basicWndProc(ExCbInfo* cbinfo);
    static LRESULT CALLBACK sysWndProc(HWND, UINT, WPARAM, LPARAM);
    static LPCTSTR getClassName() { return *getStaticTypeInfo(); }
    static ATOM classInit(HINSTANCE hInstance);
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
