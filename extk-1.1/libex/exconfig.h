/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exconfig_h__
#define __exconfig_h__

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
#endif

#ifdef WIN32
#include <windows.h>
//#include <stddef.h>
//#include <stdlib.h>
//#include <stdio.h>
#include <limits.h>
#include <malloc.h>
#include <memory.h>
#include <float.h>
#else // linux
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#endif
#include <string.h>
#include <wchar.h>

#ifdef WIN32
#include <cairo.h>
#include <pixman.h>
#else // linux
#include <cairo/cairo.h>
#endif

#ifndef STDCALL
#if defined(_MSC_VER)
#define STDCALL __stdcall
#else //  __GNUC__
#define STDCALL //__attribute__((stdcall)) /* ignored by modern gcc*/
#endif
#endif /* STDCALL */

#define EX2CONF_LAMBDA_CALLBACK 1
#if defined(_MSC_VER) || defined(STDCPP_EABI)
#define EX2CONF_DISABLE_STDCALL 0
#else
#define EX2CONF_DISABLE_STDCALL 1
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if defined(_MSC_VER)
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
#else
typedef           int8_t int8;
typedef          int16_t int16;
typedef          int32_t int32;
typedef          int64_t int64;

typedef           int8_t sint8;
typedef          int16_t sint16;
typedef          int32_t sint32;
typedef          int64_t sint64;

typedef          uint8_t uint8;
typedef         uint16_t uint16;
typedef         uint32_t uint32;
typedef         uint64_t uint64;
#endif
typedef unsigned    char uchar;
typedef unsigned   short ushort;
typedef unsigned    long ulong;
typedef unsigned     int uint;

typedef wchar_t         wchar;

#if defined(_MSC_VER)
//typedef float floatt;
#else // compat linux
typedef double floatt;
#endif

#ifdef _DEBUG
#ifndef DEBUG
#define DEBUG 1
#endif
#else
#ifdef _DISABLE_STD_ASSERTION
#define NDEBUG 1
#endif
#endif

#if 0//def __GNUC__
#define dprint0(...)
#define dprint1(...) printf("ExLib@" __VA_ARGS__)
#define exerror dprint1
#define dprint dprint1
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

#endif//__exconfig_h__
