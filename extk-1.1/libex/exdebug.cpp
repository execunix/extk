/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exdebug.h>
#include <stdio.h>

#define vdprintf debug_vprintf

int debug_vprintf(int lvl, const wchar_t* fmt, va_list arg);
int debug_vprintf(int lvl, const char* fmt, va_list arg);

static int
debug_handler(int lvl, const wchar_t* str) {
    OutputDebugString(str);
    return lvl;
}

int            dprintf_verbose = 999;
int            dprintf_charset = 949;
const wchar_t* dprintf_appname = L"[*] ";
int(*ex_debug_handler)(int lvl, const wchar_t* str) = &debug_handler;

int
debug_vprintf(int lvl, const wchar_t* fmt, va_list arg)
{
    if (lvl == 0) return 0;
    if (dprintf_verbose < (lvl < 0 ? -lvl : lvl)) return 0;
    int r = 0;
    wchar_t buf[1024 + 1];
    if (dprintf_appname && lvl > 0) {
        r = _snwprintf(buf, 1024, L"%s", dprintf_appname);
        if (r < 0) r = 0;
    }
    int len = _vsnwprintf(buf + r, 1024 - r, fmt, arg);
    if (len < 0) len = 0;
    buf[len += r] = 0;
    r = ex_debug_handler(lvl, buf);
    return r;
}

int
debug_vprintf(int lvl, const char* fmt, va_list arg)
{
    if (lvl == 0) return 0;
    if (dprintf_verbose < (lvl < 0 ? -lvl : lvl)) return 0;
    char buf[1024 + 1];
    int len = _vsnprintf(buf, 1024, fmt, arg);
    if (len < 0) len = 0;
    buf[len] = 0;
    wchar_t wcs[1024 + 1];
    len = MultiByteToWideChar(dprintf_charset, 0, buf, len, wcs, 1024);
//	len = mbstowcs(wcs, buf, 1024); if (len < 0) len = 0;
    wcs[len] = 0;
    return debug_printf(lvl, wcs);
}

int
debug_printf(int lvl, const wchar_t* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(lvl, fmt, arg);
    va_end(arg);
    return r;
}

int
debug_printf(int lvl, const char* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(lvl, fmt, arg);
    va_end(arg);
    return r;
}

int
debug_printf(const wchar_t* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    int r = debug_vprintf(1, fmt, arg);
    va_end(arg);
    return r;
}

int
debug_printf(const char* fmt, ...)
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

const wchar_t* _wcserror(int errval) { // tbd
    return L"syserr";
}
#endif//_WIN32_WCE

static int
error_handler(const wchar_t* msg)
{
    dprint1(0, L"[ExErr] %s", msg);
    //DebugBreak();
    return -1;
}

int(*ex_error_handler)(const wchar_t* msg) = &error_handler;

int
exerror(const wchar_t* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    wchar_t buf[1024 + 1];
    int len = _vsnwprintf(buf, 1024, fmt, arg);
    if (len < 0) len = 0;
    buf[len] = 0;
    int r = ex_error_handler(buf);
    va_end(arg);
    return r;
}

int
exerror(const char* fmt, ...)
{
    va_list arg;
    va_start(arg, fmt);
    char buf[1024 + 1];
    int len = _vsnprintf(buf, 1024, fmt, arg);
    if (len < 0) len = 0;
    buf[len] = 0;
    wchar_t wcs[1024 + 1];
    len = MultiByteToWideChar(dprintf_charset, 0, buf, len, wcs, 1024);
    wcs[len] = 0;
    int r = ex_error_handler(wcs);
    va_end(arg);
    return r;
}

