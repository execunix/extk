/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exdebug.h"
#include <stdio.h>
#include <errno.h>

#ifdef WIN32
#define swprintf _snwprintf
#define vswprintf _vsnwprintf
#endif

static int32
dprint_appinfo(mbyte* mbs, int32 len)
{
    return snprintf(mbs, len, "%s", "[*] ");
}

static int32
dprint_handler(int32 lvl, const mbyte* mbs)
{
#ifdef WIN32
    OutputDebugStringA(mbs);
#else
    #if 1
    printf("%s", mbs);
    #else
    dprintf(0/*stdout*/, "%s", mbs); // tbd
    #endif
#endif
    return 0;
}

int32 dprint_charset = 949;
int32 dprint_verbose = 999;
int32 (*ex_dprint_appinfo)(mbyte* mbs, int32 len) = &dprint_appinfo;
int32 (*ex_dprint_handler)(int32 lvl, const mbyte* mbs) = &dprint_handler;

int32 debug_vprintf(int32 lvl, const wchar* fmt, va_list arg)
{
    int32 r = 0, n;
    mbyte mbs[1024];
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

int32 debug_vprintf(int32 lvl, const mbyte* fmt, va_list arg)
{
    int32 r = 0, n;
    mbyte mbs[1024];

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

void debug_print(int32 lvl, const wchar* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    debug_vprintf(lvl, fmt, arg);
    va_end(arg);
}

void debug_print(int32 lvl, const mbyte* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    debug_vprintf(lvl, fmt, arg);
    va_end(arg);
}

void debug_print(const wchar* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    debug_vprintf(1, fmt, arg);
    va_end(arg);
}

void debug_print(const mbyte* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    debug_vprintf(1, fmt, arg);
    va_end(arg);
}

#ifdef _WIN32_WCE
static int32 _err_no_int = 0;
_CRTIMP extern int32* __cdecl _errno(void)
{
    return &_err_no_int;
}

errno_t __cdecl _set_errno(__in int32 _Value)
{
    int32 _no = _err_no_int;
    _err_no_int = _Value;
    return _no;
}

errno_t __cdecl _get_errno(__out int32* _Value)
{
    *_Value = _err_no_int;
    return _err_no_int;
}

const mbyte* strerror(int32 errval)
{ // tbd
    return "syserr";
}

const wchar* _wcserror(int32 errval)
{ // tbd
    return L"syserr";
}
#endif // _WIN32_WCE

static int32
error_handler(const mbyte* mbs)
{
    dprint1("err: %s", mbs);
#ifdef WIN32
    //DebugBreak();
#endif
    return 0;
}

int32 (*ex_error_handler)(const mbyte* mbs) = &error_handler;

int32 exerror(const wchar* fmt, ...)
{
    int32 r, n;
    mbyte mbs[1024];
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

int32 exerror(const mbyte* fmt, ...)
{
    int32 r, n;
    mbyte mbs[1024];
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

const char_t* exstrerr()
{
    return strerror(errno);
}
