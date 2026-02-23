/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exevent.h"
#include "extimer.h"
#include "exwatch.h"
#include "exwindow.h"

// ExEmit APIs - deprecated
//

#ifdef WIN32
bool ExEmitMessage(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    BOOL r = PostMessage(hwnd, message, wParam, lParam);
    return r ? true : false;
}

bool ExEmitKeyEvent(ExWidget* widget, UINT message, int32 virtkey, long keydata) {
    HWND hwnd;
    if (widget && widget->getFlags(Ex_Realized) &&
        (hwnd = widget->getWindow()->getHwnd()) != NULL) {
        return ExEmitMessage(hwnd, message, virtkey, keydata);
    }
    return false;
}

bool ExEmitPtrEvent(ExWidget* widget, UINT message, WPARAM wParam, int32 x, int32 y) {
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

bool ExEmitButPress(ExWidget* widget, int32 x, int32 y) {
    return (ExEmitPtrEvent(widget, WM_MOUSEMOVE, 0, x, y) &&
            ExEmitPtrEvent(widget, WM_LBUTTONDOWN, 0, x, y));
}

bool ExEmitButRelease(ExWidget* widget, int32 x, int32 y) {
    return ExEmitPtrEvent(widget, WM_LBUTTONUP, 0, x, y);
}
#endif

#ifdef __linux__
bool ExEmitMessage(const int32 type, const int32 message, const int32 wParam, const int64 lParam) {
    return false;
}
#endif
