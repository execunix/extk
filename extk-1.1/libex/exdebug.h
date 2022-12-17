/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exdebug_h__
#define __exdebug_h__

#include "extypes.h"
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
const wchar* _wcserror(int errval);

#ifdef __cplusplus
}
#endif

#endif // _WIN32_WCE

extern int         dprint_verbose; // default 999 (0:quiet)
extern int         dprint_charset; // default 949
extern const char* dprint_appname; // default "[*] "
extern int (*ex_dprint_handler)(int lvl, const char* mbs);

int debug_vprintf(int lvl, const wchar* fmt, va_list arg);
int debug_vprintf(int lvl, const char* fmt, va_list arg);

int debug_print(int lvl, const wchar* fmt, ...);
int debug_print(int lvl, const char* fmt, ...);
int debug_print(const wchar* fmt, ...);
int debug_print(const char* fmt, ...);

#if defined(_MSC_VER) && (_MSC_VER < 1400) // M$ eVC4
#define dprint0 0 && (*(int(*)(...))0)
#define dprint1 debug_print
#else // std C99
#define dprint0(...) ((void)0)
#define dprint1(...) debug_print(__VA_ARGS__)
#endif

#ifndef DPRINT
#define dprint dprint0
#else
#define dprint dprint1
#endif

/*
 * The purpose of this function is to allow the user to set a breakpoint
 * in error_handler() to generate a stack trace for when the user causes
 * exlib to detect an error.
 */
extern int (*ex_error_handler)(const char* mbs);
int exerror(const wchar* fmt, ...);
int exerror(const char* fmt, ...);

#endif//__exdebug_h__
