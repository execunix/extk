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
dprint_handler(int lvl, const char* mbs) {
#ifdef WIN32
    OutputDebugStringA(mbs);
#else
    puts(mbs);
#endif
    return lvl;
}

int         dprint_verbose = 999;
int         dprint_charset = 949;
const char* dprint_appname = "[*] ";
int(*ex_dprint_handler)(int lvl, const char* mbs) = &dprint_handler;

int
debug_vprintf(int lvl, const wchar* fmt, va_list arg)
{
    if (lvl == 0) return 0;
    if (dprint_verbose < (lvl < 0 ? -lvl : lvl)) return 0;
    int r = 0;
    wchar wcs[1024 + 1];
    if (dprint_appname && lvl > 0) {
#ifdef WIN32
        r = swprintf(wcs, 1024, L"%S", dprint_appname);
#else
        r = swprintf(wcs, 1024, L"%s", dprint_appname);
#endif
        if (r < 0) r = 0;
    }
    int len = vswprintf(wcs + r, 1024 - r, fmt, arg);
    if (len < 0) len = 0;
    wcs[len += r] = 0;

    char mbs[1024 + 1];
#ifdef WIN32
    len = WideCharToMultiByte(dprint_charset, 0, wcs, len, mbs, 1024, NULL, NULL);
#else
    len = wcstombs(mbs, wcs, 1024); if (len < 0) len = 0;
#endif
    mbs[len] = 0;

    r = ex_dprint_handler(lvl, mbs);
    return r;
}

int
debug_vprintf(int lvl, const char* fmt, va_list arg)
{
    if (lvl == 0) return 0;
    if (dprint_verbose < (lvl < 0 ? -lvl : lvl)) return 0;
    int r = 0;
    char mbs[1024 + 1];
    if (dprint_appname && lvl > 0) {
        r = snprintf(mbs, 1024, "%s", dprint_appname);
        if (r < 0) r = 0;
    }
    int len = vsnprintf(mbs, 1024, fmt, arg);
    if (len < 0) len = 0;
    mbs[len += r] = 0;

    r = ex_dprint_handler(lvl, mbs);
    return r;
}

int
debug_print(int lvl, const wchar* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(lvl, fmt, arg);
    va_end(arg);
    return r;
}

int
debug_print(int lvl, const char* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(lvl, fmt, arg);
    va_end(arg);
    return r;
}

int
debug_print(const wchar* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(1, fmt, arg);
    va_end(arg);
    return r;
}

int
debug_print(const char* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(1, fmt, arg);
    va_end(arg);
    return r;
}

#ifdef _WIN32_WCE
static int _err_no_int = 0;
_CRTIMP extern int * __cdecl _errno(void) {
    return &_err_no_int;
}

errno_t __cdecl _set_errno(__in int _Value) {
    int _no = _err_no_int;
    _err_no_int = _Value;
    return _no;
}

errno_t __cdecl _get_errno(__out int * _Value) {
    *_Value = _err_no_int;
    return _err_no_int;
}

const char* strerror(int errval) { // tbd
    return "syserr";
}

const wchar* _wcserror(int errval) { // tbd
    return L"syserr";
}
#endif//_WIN32_WCE

static int
error_handler(const char* mbs) {
    dprint1("err: %s", mbs);
#ifdef WIN32
    //DebugBreak();
#endif
    return -1;
}

int(*ex_error_handler)(const char* mbs) = &error_handler;

int
exerror(const wchar* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    wchar wcs[1024 + 1];
    int len = vswprintf(wcs, 1024, fmt, arg);
    if (len < 0) len = 0;
    wcs[len] = 0;

    char mbs[1024 + 1];
#ifdef WIN32
    len = WideCharToMultiByte(dprint_charset, 0, wcs, len, mbs, 1024, NULL, NULL);
#else
    len = wcstombs(mbs, wcs, 1024); if (len < 0) len = 0;
#endif
    mbs[len] = 0;

    int r = ex_error_handler(mbs);
    va_end(arg);
    return r;
}

int
exerror(const char* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    char mbs[1024 + 1];
    int len = vsnprintf(mbs, 1024, fmt, arg);
    if (len < 0) len = 0;
    mbs[len] = 0;

    int r = ex_error_handler(mbs);
    va_end(arg);
    return r;
}
