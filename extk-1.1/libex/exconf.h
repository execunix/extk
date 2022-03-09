/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exconf_h__
#define __exconf_h__

#ifndef __cplusplus
#error FrameWork of the Widget requires C++ compilation (use a *.cpp suffix)
#endif

#if defined(_MSC_VER)
#define _CRT_NON_CONFORMING_SWPRINTFS
#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_DEPRECATE
#endif

#define WIN32_LEAN_AND_MEAN
#ifdef _WIN32_WCE
#define WINVER _WIN32_WCE
#include <ceconfig.h>
#else
#define EX_EVENTPROC_HAVETHREAD
#endif

#ifdef WIN32
#include <windows.h>
//#include <stddef.h>
//#include <stdio.h>
#endif

#include <limits.h>
#include <assert.h>
#include <malloc.h>
#include <memory.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>
#include <float.h>
#include <cairo.h>
#include <pixman.h>
#include <exmacro.h>
#include <exdebug.h>

#ifdef WIN32
#define STDCALL __stdcall
#else
#define STDCALL
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef             char int8;
typedef            short int16;
typedef              int int32;
typedef          __int64 int64;

typedef   signed    char sint8;
typedef   signed   short sint16;
typedef   signed     int sint32;
typedef   signed __int64 sint64;

typedef unsigned    char uint8;
typedef unsigned   short uint16;
typedef unsigned     int uint32;
typedef unsigned __int64 uint64;

typedef unsigned    char uchar;
typedef unsigned   short ushort;
typedef unsigned    long ulong;
typedef unsigned     int uint;

typedef wchar_t         wchar;

#ifdef _DEBUG
#ifndef DEBUG
#define DEBUG 1
#endif
#endif

// assertion
#ifndef DEBUG
#define exassert(expr)
#else
#define exassert(expr) { if (!(expr)) dprint1(0, \
        L"Assertion failed %s:%d (%s)\n", Ex_WCSTR(__FILE__), __LINE__, Ex_WCSTR_ARG(#expr)); }
#endif//DEBUG

#define exassertstatic(expr) \
        typedef struct { \
            char compile_time_assertion[(expr) ? 1 : -1]; \
        } Ex_PASTE_DEFS(_assert_static_, __LINE__)

#ifdef __cplusplus
}
#endif

#endif//__exconf_h__
