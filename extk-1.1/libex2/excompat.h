/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excompat_h__
#define __excompat_h__

#include "exconfig.h"

#ifdef __linux__
typedef void* ATOM;
typedef void* HWND;
typedef void* HRGN;
typedef void* HDC;
typedef uint UINT;
typedef uint DWORD;
typedef uint WPARAM;
typedef uint LPARAM;
typedef long LRESULT;
typedef void* HINSTANCE;
typedef char_t* LPSTR;
typedef ucs2_t* LPTSTR;
typedef const char_t* LPCSTR;
typedef const ucs2_t* LPCTSTR;
#define CALLBACK
#define CW_USEDEFAULT -1
#define DestroyWindow(...) ((void)0)
#define CreateWindowEx(...) NULL
#define ShowWindow(...) 1
#define UpdateWindow(...) 1
#endif

#endif//__excompat_h__
