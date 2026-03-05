/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwndproc.h"
#include "exrender.h"
#include "exwatch.h"
#include "exiconv.h"
#include "exapp.h"
#include <map>

#define logdraw dprint0
#define logdra1 dprint1
#define logdra0 dprint0
#define logproc dprint
#define logpro0 dprint0

ExWatch* exWatchDisp = NULL;

// class ExWindow
//
ExWindow::~ExWindow() noexcept {
    if (canvas)
        delete canvas;
    //handlerList.clear();
    //filterList.clear();
}

ExWindow::ExWindow() noexcept
    : ExWidget()
#ifdef WIN32
    , hwnd(NULL)
    , dwStyle(0)
    , dwExStyle(0)
#endif
    , notifyFlags(0)
    , renderFlags(0)
    , wgtCapture(NULL)
    , wgtEntered(NULL)
    , wgtPressed(NULL)
    , wgtFocused(NULL)
    , flushFunc()
    , paintFunc()
    , canvas(NULL)
    , event(NULL)
    , filterList()
    , handlerList() {
    flags |= Ex_HasOwnGC;
    flushFunc = ExFlushFunc(this, &ExWindow::onExFlush);
    paintFunc = ExFlushFunc(this, &ExWindow::onWmPaint);
}

ExWidget* ExWindow::getCapture() const
{
    return wgtCapture;
}

ExWidget* ExWindow::getEntered() const
{
    return wgtEntered;
}

ExWidget* ExWindow::getPressed() const
{
    return wgtPressed;
}

ExWidget* ExWindow::getFocused() const
{
    return wgtFocused;
}

uint32 ExWindow::init(const char* name, int32 w, int32 h) {
    ExRect rc(0, 0, w, h);
    ExWidget::init(NULL/*parent*/, name, &rc);
    renderFlags |= Ex_RenderRebuild;
    return 0;
}

ExWindow* // static
ExWindow::create(const char* name, int32 w, int32 h) {
    ExWindow* window = new ExWindow();
    exassert(window != NULL);
    window->flags |= Ex_FreeMemory;
    window->init(name, w, h);
    return window;
}

uint32 ExWindow::destroy() {
    if (getFlags(Ex_Destroyed))
        return 1;

#ifdef WIN32
    HWND hwnd = this->hwnd;
#endif
    ExWidget::destroy();

    // Now, member variables are not accessible.
#ifdef WIN32
    if (hwnd != NULL) { // is not detached ?
        // detachWindowMap(hwnd);
        DestroyWindow(hwnd); // send WM_DESTROY
    }
#endif
    return 0;
}

#ifdef WIN32
bool ExWindow::showWindow(DWORD dwExStyle, DWORD dwStyle, int32 x, int32 y) {
    renderFlags |= Ex_RenderRebuild;
    this->dwExStyle = dwExStyle;
    this->dwStyle = dwStyle;

    HWND hwnd = NULL;
    HWND hwndParent = NULL;
    LPCSTR lpWindowName = name;
    HINSTANCE hInstance = ExApp::hInstance;
    //if (parent) hwndParent = parent->getWindow()->getHwnd(); // tbd
    hwnd = CreateWindowEx(dwExStyle, getClassName(), lpWindowName, dwStyle,
                          x, y, this->area.w, this->area.h,
                          hwndParent, NULL, hInstance, (PVOID)this);
    exassert(this->hwnd && this->hwnd == hwnd);
    return showWindow();
}

bool ExWindow::showWindow() {
    if (hwnd == NULL)
        return false;
    if (!ShowWindow(hwnd, (dwStyle & WS_CHILD) ? SW_SHOW : SW_SHOWNORMAL))
        return false;
    // send WM_PAINT if the window's update region is not empty
    if (!UpdateWindow(hwnd)) // can be skip
        return false;
    return true;
}

bool ExWindow::hideWindow() {
    bool r = false;
    if (hwnd != NULL) {
        r = ShowWindow(hwnd, SW_HIDE);
    }
    return r;
}
#endif

ExWidget* ExWindow::giveFocus(ExWidget* newFocus) {
    if (newFocus == wgtFocused)
        return wgtFocused;
    if (newFocus != NULL) {
        if (newFocus->getFlags(Ex_Blocked) ||
            !newFocus->isVisible())
            return wgtFocused;
    }

    ExWidgetList got;
    if (newFocus) {
        for (ExWidget* w = newFocus; w; w = w->parent)
            got.push_front(w);
        if (got.front() != this) {
            exerror("can't give focus %s to %s different parent\n", newFocus->name, name);
            return wgtFocused;
        }
    }
    ExWidgetList lost;
    if (wgtFocused) {
        for (ExWidget* w = wgtFocused; w; w = w->parent)
            lost.push_front(w);
    }

    ExWidgetList::iterator got_i = got.begin();
    ExWidgetList::iterator lost_i = lost.begin();
    while (got_i != got.end() && lost_i != lost.end()) {
        dprint("compare %s %s\n", (*got_i)->name, (*lost_i)->name);
        if (*lost_i != *got_i)
            break;
        ++lost_i;
        if (*got_i == newFocus)
            break;
        ++got_i;
    }
    lost.erase(lost.begin(), lost_i);
    got.erase(got.begin(), got_i);

    // reset focused flag
    lost_i = lost.end();
    while (lost_i != lost.begin()) {
        ExWidget* w = *--lost_i;
        w->flags &= ~Ex_Focused;
        if (w->getFlags(Ex_FocusRender))
            w->damage();
        dprint("lost focus %s\n", w->name);
    }
    got_i = got.begin();
    while (got_i != got.end()) {
        ExWidget* w = *got_i++;
        w->flags |= Ex_Focused;
        if (w->getFlags(Ex_FocusRender))
            w->damage();
        dprint("got focus %s\n", w->name);
    }

    // invoke callback
    ExCbInfo cbinfo(0, 0, NULL, newFocus);
    lost_i = lost.end();
    cbinfo.type = Ex_CbLostFocus;
    while (lost_i != lost.begin()) {
        ExWidget* w = *--lost_i;
        cbinfo.subtype = w == wgtFocused ? 1 : 0;
        w->invokeListener(Ex_CbLostFocus, &cbinfo);
    }
    wgtFocused = newFocus; // tbd - change for callback refer
    got_i = got.begin();
    cbinfo.type = Ex_CbGotFocus;
    while (got_i != got.end()) {
        ExWidget* w = *got_i++;
        cbinfo.subtype = w == wgtFocused ? 1 : 0;
        w->invokeListener(Ex_CbGotFocus, &cbinfo);
    }
    return wgtFocused;
}

ExWidget* ExWindow::moveFocus(uint32 dir) { // sample
    if (wgtFocused == NULL) {
        if (dir == Ex_DirUp || dir == Ex_DirLeft)
            return giveFocus(this);
        return giveFocus(last());
    }
    switch (dir) {
        case Ex_DirUp:
            if (wgtFocused->broPrev && wgtFocused->broPrev != wgtFocused)
                return giveFocus(wgtFocused->broPrev);
        case Ex_DirDown:
            if (wgtFocused->broNext && wgtFocused->broNext != wgtFocused)
                return giveFocus(wgtFocused->broNext);
        case Ex_DirLeft:
            if (wgtFocused->parent)
                return giveFocus(wgtFocused->parent);
        case Ex_DirRight:
            if (wgtFocused->childHead)
                return giveFocus(wgtFocused->childHead);
    }
    return wgtFocused;
}

uint32 ExWindow::render() {
#if 0
    buildExtent();
    buildRegion();
    damageRgn.setRect(extent);
    ExWidget::render(canvas);
#else
    ExRender::render(canvas, this, renderFlags);
#endif
    renderFlags = 0;
    return 0;
}

uint32 ExWindow::flush() {
    flushFunc(this, &damageRgn);
    return 0;
}

uint32 ExWindow::paint() {
    paintFunc(this, &damageRgn);
    return 0;
}

#define GDICLIP_FLUSH
#define GDICLIP_PAINT

void ExWindow::onExFlush(ExWindow* window, const ExRegion* updateRgn) {
#ifdef WIN32
    // updateRgn is filled after render call.
    this->render();

    if (!(hwnd && canvas && canvas->gc))
        return;

    HDC hdc = GetDC(hwnd);
#ifdef GDICLIP_FLUSH
    HRGN hrgn = ExRegionToGdi(hdc, updateRgn);
#endif
    BITMAPINFO bmi;
    memset(&bmi, 0, sizeof(BITMAPINFO));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = canvas->gc->width;
    bmi.bmiHeader.biHeight = -canvas->gc->height;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = canvas->gc->bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
    SetDIBitsToDevice(hdc, 0, 0, canvas->gc->width, canvas->gc->height,
                      0, 0, 0, canvas->gc->height, canvas->gc->bits, &bmi, DIB_RGB_COLORS);
#ifdef GDICLIP_FLUSH
    SelectClipRgn(hdc, NULL);
    DeleteObject(hrgn);
#endif
    ReleaseDC(hwnd, hdc);
#if 1
    ValidateRect(hwnd, NULL);
#else
    RECT clip;
    clip.left = updateRgn->extent.l;
    clip.top = updateRgn->extent.t;
    clip.right = updateRgn->extent.r;
    clip.bottom = updateRgn->extent.b;
    ValidateRect(hwnd, &clip);
#endif
#endif // WIN32
}

void ExWindow::onWmPaint(ExWindow* window, const ExRegion* updateRgn) {
#ifdef WIN32
    // updateRgn is filled after render call.
    this->render();

    exassert(hwnd && canvas && canvas->gc);

    PAINTSTRUCT ps;
    HDC hdc = BeginPaint(hwnd, &ps);
#ifdef GDICLIP_PAINT
    RECT* clip = &ps.rcPaint;
    HRGN hrgn = CreateRectRgnIndirect(clip);
    SelectClipRgn(hdc, hrgn);
    // rcPaint : Specifies a RECT structure that specifies the upper left and lower right corners
    //           of the rectangle in which the painting is requested.
    logdraw("[0x%p] WM_PAINT hdc=0x%p x=%d y=%d w=%d h=%d\n",
            hwnd, hdc, clip->left, clip->top, clip->right - clip->left, clip->bottom - clip->top);
#endif

    BITMAPINFO bmi;
    memset(&bmi, 0, sizeof(BITMAPINFO));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = canvas->gc->width;
    bmi.bmiHeader.biHeight = -canvas->gc->height;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = canvas->gc->bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
    SetDIBitsToDevice(hdc, 0, 0, canvas->gc->width, canvas->gc->height,
                      0, 0, 0, canvas->gc->height, canvas->gc->bits, &bmi, DIB_RGB_COLORS);

#ifdef GDICLIP_PAINT
    SelectClipRgn(hdc, NULL);
    DeleteObject(hrgn);
#endif
    EndPaint(hwnd, &ps);
#endif // WIN32
}

uint32 ExWindow::onRepeatBut(ExTimer* timer, ExCbInfo* cbinfo) {
    if (wgtPressed &&
        wgtPressed == wgtEntered && ++ExApp::butRepeatCnt() > 0) {
        if (!wgtPressed->listenerList.empty()) {
            cbinfo->event = event; // tbd - backup msg ?
            cbinfo->set(Ex_CbButRepeat, ExApp::butRepeatCnt());
            return wgtPressed->invokeListener(Ex_CbActivate, cbinfo);
        }
    }
    return Ex_Continue;
}

uint32 ExWindow::onRepeatKey(ExTimer* timer, ExCbInfo* cbinfo) {
    // tbd
    return Ex_Continue;
}

#ifdef WIN32
ATOM // static
ExWindow::classInit(HINSTANCE hInstance) {
    static ATOM wcid = 0;

    if (wcid == 0) {
        WNDCLASS wc;
        wc.style = /*CS_DBLCLKS | */CS_HREDRAW | CS_VREDRAW;
        wc.lpfnWndProc = (WNDPROC)SysWndProc;
        wc.cbClsExtra = 0;
        wc.cbWndExtra = 0;
        wc.hInstance = hInstance;
        wc.hIcon = 0;//LoadIcon(hInstance, MAKEINTRESOURCE(IDI_APPWGT));
        wc.hCursor = LoadCursor(NULL, IDC_ARROW);
        wc.hbrBackground = 0;//(HBRUSH)GetStockObject(HOLLOW_BRUSH);
        wc.lpszMenuName = 0;//MAKEINTRESOURCE(IDC_APPDEMO);
        wc.lpszClassName = getClassName();
        wcid = RegisterClass(&wc);
        dprint("classInit(0x%p) wcid=0x%p\n", hInstance, wcid);
    }
    return wcid;
}
#endif // WIN32

ExDrawFunc exDrawFuncTrap;
