/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exdebug.h"
#include <stdio.h>

#ifdef WIN32
#define swprintf _snwprintf
#define vswprintf _vsnwprintf
#endif

static int
dprint_appinfo(char* mbs, int len)
{
    return snprintf(mbs, len, "%s", "[*] ");
}

static int
dprint_handler(int lvl, const char* mbs)
{
#ifdef WIN32
    OutputDebugStringA(mbs);
#else
    dprintf(0/*stdout*/, "%s", mbs); // tbd
#endif
    return 0;
}

int dprint_charset = 949;
int dprint_verbose = 999;
int (*ex_dprint_appinfo)(char* mbs, int len) = &dprint_appinfo;
int (*ex_dprint_handler)(int lvl, const char* mbs) = &dprint_handler;

int debug_vprintf(int lvl, const wchar* fmt, va_list arg)
{
    int r = 0, n;
    char mbs[1024];
    wchar wcs[1024];

    if (dprint_verbose < (lvl < 0 ? -lvl : lvl))
        return r;

    if (lvl > 0) {
        r = ex_dprint_appinfo(mbs, 64);
        if (r < 0)
            r = 0;
    }
    n = vswprintf(wcs, 1020, fmt, arg);
    if (n < 0)
        n = 0;
    wcs[n] = 0;
#ifdef WIN32
    n = WideCharToMultiByte(dprint_charset, 0, wcs, n, mbs + r, 1020 - r, NULL, NULL);
#else
    n = wcstombs(mbs + r, wcs, 1020 - r);
#endif
    if (n < 0)
        n = 0;
    n += r;
    mbs[n] = 0;

    r = ex_dprint_handler(lvl, mbs);
    if (r < 0)
        return r;
    return n;
}

int debug_vprintf(int lvl, const char* fmt, va_list arg)
{
    int r = 0, n;
    char mbs[1024];

    if (dprint_verbose < (lvl < 0 ? -lvl : lvl))
        return r;

    if (lvl > 0) {
        r = ex_dprint_appinfo(mbs, 64);
        if (r < 0)
            r = 0;
    }
    n = vsnprintf(mbs + r, 1020 - r, fmt, arg);
    if (n < 0)
        n = 0;
    n += r;
    mbs[n] = 0;

    r = ex_dprint_handler(lvl, mbs);
    if (r < 0)
        return r;
    return n;
}

int debug_print(int lvl, const wchar* fmt, ...)
{
    int r;
    va_list arg;
    va_start(arg, fmt);
    r = debug_vprintf(lvl, fmt, arg);
    va_end(arg);
    return r;
}

int debug_print(int lvl, const char* fmt, ...)
{
    int r;
    va_list arg;
    va_start(arg, fmt);
    r = debug_vprintf(lvl, fmt, arg);
    va_end(arg);
    return r;
}

int debug_print(const wchar* fmt, ...)
{
    int r;
    va_list arg;
    va_start(arg, fmt);
    r = debug_vprintf(1, fmt, arg);
    va_end(arg);
    return r;
}

int debug_print(const char* fmt, ...)
{
    int r;
    va_list arg;
    va_start(arg, fmt);
    r = debug_vprintf(1, fmt, arg);
    va_end(arg);
    return r;
}

#ifdef _WIN32_WCE
static int _err_no_int = 0;
_CRTIMP extern int* __cdecl _errno(void)
{
    return &_err_no_int;
}

errno_t __cdecl _set_errno(__in int _Value)
{
    int _no = _err_no_int;
    _err_no_int = _Value;
    return _no;
}

errno_t __cdecl _get_errno(__out int* _Value)
{
    *_Value = _err_no_int;
    return _err_no_int;
}

const char* strerror(int errval)
{ // tbd
    return "syserr";
}

const wchar* _wcserror(int errval)
{ // tbd
    return L"syserr";
}
#endif // _WIN32_WCE

static int
error_handler(const char* mbs)
{
    dprint1("err: %s", mbs);
#ifdef WIN32
    //DebugBreak();
#endif
    return 0;
}

int (*ex_error_handler)(const char* mbs) = &error_handler;

int exerror(const wchar* fmt, ...)
{
    int r, n;
    char mbs[1024];
    wchar wcs[1024];
    va_list arg;

    va_start(arg, fmt);
    n = vswprintf(wcs, 1020, fmt, arg);
    if (n < 0)
        n = 0;
    wcs[n] = 0;

#ifdef WIN32
    n = WideCharToMultiByte(dprint_charset, 0, wcs, n, mbs, 1020, NULL, NULL);
#else
    n = wcstombs(mbs, wcs, 1020);
#endif
    if (n < 0)
        n = 0;
    mbs[n] = 0;

    r = ex_error_handler(mbs);
    va_end(arg);
    return r;
}

int exerror(const char* fmt, ...)
{
    int r, n;
    char mbs[1024];
    va_list arg;

    va_start(arg, fmt);
    n = vsnprintf(mbs, 1020, fmt, arg);
    if (n < 0)
        n = 0;
    mbs[n] = 0;

    r = ex_error_handler(mbs);
    va_end(arg);
    return r;
}
