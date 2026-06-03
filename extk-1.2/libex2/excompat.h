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
typedef uint16 WORD;
typedef uint32 UINT;
typedef uint32 DWORD;
typedef uint32 WPARAM;
typedef int64 LPARAM;
typedef int64 LRESULT;
typedef void* HINSTANCE;
#else // WIN32
constexpr HWND None = nullptr;
#endif // __linux__

#ifdef __linux__
#define LOBYTE(w)           ((uint8)(((uint64)(w)) & 0xff))
#define HIBYTE(w)           ((uint8)((((uint64)(w)) >> 8) & 0xff))
#define LOWORD(l)           ((uint16)(((uint64)(l)) & 0xffff))
#define HIWORD(l)           ((uint16)((((uint64)(l)) >> 16) & 0xffff))
#define MAKEWORD(a, b)      ((uint16)(((uint8)(((uint64)(a)) & 0xff)) | ((uint16)((uint8)(((uint64)(b)) & 0xff))) << 8))
#define MAKELONG(a, b)      ((long)(((uint16)(((uint64)(a)) & 0xffff)) | ((uint32)((uint16)(((uint64)(b)) & 0xffff))) << 16))
#define MAKEWPARAM(l, h)    ((WPARAM)(DWORD)MAKELONG(l, h))
#define MAKELPARAM(l, h)    ((LPARAM)(DWORD)MAKELONG(l, h))
#define MAKELRESULT(l, h)   ((LRESULT)(DWORD)MAKELONG(l, h))
#endif // __linux__

#endif//__excompat_h__
