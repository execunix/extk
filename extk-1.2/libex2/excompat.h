/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excompat_h__
#define __excompat_h__

#include "exconfig.h"

#ifdef __linux__
typedef void* ATOM;
typedef void* HANDLE;
typedef void* HWND;
typedef void* HRGN;
typedef void* HDC;
typedef uint UINT;
typedef ulong DWORD;
typedef int64 WPARAM;
typedef int64 LPARAM;
typedef int64 LRESULT;
typedef void* HINSTANCE;
#endif

#endif//__excompat_h__
