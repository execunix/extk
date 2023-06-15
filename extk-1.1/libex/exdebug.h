/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exdebug_h__
#define __exdebug_h__

#include "exconfig.h"
#include <stdarg.h>

extern int32 dprint_charset; // default 949
extern int32 dprint_verbose; // default 999 (0:quiet)
extern int32 (*ex_dprint_appinfo)(mbyte* mbs, int32 len); // default "[*] "
extern int32 (*ex_dprint_handler)(int32 lvl, const mbyte* mbs);

int32 debug_vprintf(int32 lvl, const wchar* fmt, va_list arg);
int32 debug_vprintf(int32 lvl, const mbyte* fmt, va_list arg);

void debug_print(int32 lvl, const wchar* fmt, ...);
void debug_print(int32 lvl, const mbyte* fmt, ...);
void debug_print(const wchar* fmt, ...);
void debug_print(const mbyte* fmt, ...);

#if defined(_MSC_VER) && (_MSC_VER < 1400) // M$ eVC4
#define dprint0 0 && (*(int32(*)(...))0)
#define dprint1 debug_print
#elif defined(__GNUC__)
#define dprint0(...)
#define dprint1      debug_print
#else // std C99
#define dprint0(...) ((void)0)
#define dprint1(...) debug_print(__VA_ARGS__)
#endif

#ifndef DPRINT
#define dprint dprint0
#else
#define dprint dprint1
#endif
// WIN32 : dprint(7, L"%s %S", L"App", "Test");
// LINUX : dprint(7, L"%ls %s", L"App", "Test");

// customizing usage:
// 	#undef dprint1
// 	#define dprint1(...) printf("ExLib@" __VA_ARGS__)

// assertion
#ifndef DEBUG
#define exassert(expr) ( static_cast<bool>(expr) ? void(0) : debug_print(9, \
        "Assertion failed %s:%d (%s)\n", __FILE__, __LINE__, #expr))
#else
#define exassert(expr) ( static_cast<bool>(expr) ? void(0) : debug_print(0, \
        "Assertion failed %s:%d (%s)\n", __FILE__, __LINE__, #expr))
#endif//DEBUG

#define exassertstatic(expr) \
        typedef struct { \
            char compile_time_assertion[(expr) ? 1 : -1]; \
        } Ex_PASTE_DEFS(_assert_static_, __LINE__)

/*
 * The purpose of this function is to allow the user to set a breakpoint
 * in error_handler() to generate a stack trace for when the user causes
 * exlib to detect an error.
 */
extern int32 (*ex_error_handler)(const mbyte* mbs);
int32 exerror(const wchar* fmt, ...);
int32 exerror(const mbyte* fmt, ...);

const char_t* exstrerr();

#endif//__exdebug_h__
