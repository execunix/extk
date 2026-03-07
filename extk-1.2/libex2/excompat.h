/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excompat_h__
#define __excompat_h__

#ifdef CONF_X11
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#endif // CONF_X11

#ifdef __linux__
typedef void* ATOM;
typedef void* HANDLE;
typedef ulong HWND; // XID 64bit
#ifndef CONF_X11 // __linux__
constexpr HWND None = 0UL;
#endif
typedef void* HRGN;
typedef void* HDC;
typedef uint32 UINT;
typedef uint32 DWORD;
typedef uint32 WPARAM;
typedef int64 LPARAM;
typedef int64 LRESULT;
typedef void* HINSTANCE;
#else // WIN32
constexpr HWND None = nullptr;
#endif

#endif//__excompat_h__
