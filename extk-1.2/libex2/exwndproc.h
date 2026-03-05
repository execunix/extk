/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwndproc_h__
#define __exwndproc_h__

#include "exwindow.h"

#ifdef WIN32
// custom usage:
// #pragma comment(linker, "/alternatename:customWndProc=basicWndProc")
// #pragma comment(linker, "/alternatename:defWndProc=SysWndProc")
uint32 basicWndProc(ExWindow* window, ExCbInfo* cbinfo);
LRESULT CALLBACK SysWndProc(HWND, UINT, WPARAM, LPARAM);
#endif // WIN32

#endif//__exwndproc_h__
