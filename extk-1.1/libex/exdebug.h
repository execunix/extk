/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exdebug_h__
#define __exdebug_h__

#include "exconfig.h"
#include <stdarg.h>

#ifndef _WIN32_WCE
#include <errno.h>
#else // _WIN32_WCE

#ifdef __cplusplus
extern "C" {
#endif

/* declare reference to errno */
#ifndef _CRT_ERRNO_DEFINED
#define _CRT_ERRNO_DEFINED
_CRTIMP extern int * __cdecl _errno(void);
#define errno   (*_errno())
errno_t __cdecl _set_errno(__in int _Value);
errno_t __cdecl _get_errno(__out int * _Value);
#endif//_CRT_ERRNO_DEFINED
/* Error Codes */
#define EPERM           1
#define ENOENT          2
#define ESRCH           3
#define EINTR           4
#define EIO             5
#define ENXIO           6
#define E2BIG           7
#define ENOEXEC         8
#define EBADF           9
#define ECHILD          10
#define EAGAIN          11
#define ENOMEM          12
#define EACCES          13
#define EFAULT          14
#define EBUSY           16
#define EEXIST          17
#define EXDEV           18
#define ENODEV          19
#define ENOTDIR         20
#define EISDIR          21
#define ENFILE          23
#define EMFILE          24
#define ENOTTY          25
#define EFBIG           27
#define ENOSPC          28
#define ESPIPE          29
#define EROFS           30
#define EMLINK          31
#define EPIPE           32
#define EDOM            33
#define EDEADLK         36
#define ENAMETOOLONG    38
#define ENOLCK          39
#define ENOSYS          40
#define ENOTEMPTY       41
/* Error codes used in the Secure CRT functions */
#ifndef RC_INVOKED
#if !defined(_SECURECRT_ERRCODE_VALUES_DEFINED)
#define _SECURECRT_ERRCODE_VALUES_DEFINED
#define EINVAL          22
#define ERANGE          34
#define EILSEQ          42
#define STRUNCATE       80
#endif//_SECURECRT_ERRCODE_VALUES_DEFINED
#endif//RC_INVOKED
/* Support EDEADLOCK for compatibiity with older MS-C versions. */
#define EDEADLOCK       EDEADLK

const char* strerror(int errval);
const wchar_t* _wcserror(int errval);

#ifdef __cplusplus
}
#endif

#endif//_WIN32_WCE

extern int            dprintf_verbose; // default 999
extern int            dprintf_charset; // default 949
extern const wchar_t* dprintf_appname; // default L"[*] "
extern int(*ex_debug_handler)(int lvl, const wchar_t* str);

#ifndef __GNUC__
#define __attribute__(x)
#endif//__GNUC__
int debug_printf(int lvl, const wchar_t* fmt, ...) __attribute__((format(printf, 2, 3)));
int debug_printf(int lvl, const char* fmt, ...) __attribute__((format(printf, 2, 3)));
int debug_printf(const wchar_t* fmt, ...) __attribute__((format(printf, 1, 2)));
int debug_printf(const char* fmt, ...) __attribute__((format(printf, 1, 2)));

#if defined(_MSC_VER) && (_MSC_VER < 1400) // M$ eVC4
#define dprint0 0 && (*(int(*)(...))0)
#define dprint1 debug_printf
#else // std C99
#define dprint0(...) ((void)0)
#define dprint1(...) debug_printf(__VA_ARGS__)
#endif

#ifndef DPRINTF
#define dprintf dprint0
#else
#define dprintf dprint1
#endif

/*
 * The purpose of this function is to allow the user to set a breakpoint
 * in error_handler() to generate a stack trace for when the user causes
 * exlib to detect an error.
 */
extern int(*ex_error_handler)(const wchar_t* msg);
int exerror(const wchar_t* fmt, ...);
int exerror(const char* fmt, ...);

#endif//__exdebug_h__
