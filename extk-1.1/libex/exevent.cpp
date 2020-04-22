/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exevent.h>
#include <exthread.h>
#include <exwindow.h>

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
        ExPoint pt(widget->getDrawRect().center());
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

