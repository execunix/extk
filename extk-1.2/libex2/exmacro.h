/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exmacro_h__
#define __exmacro_h__

#define Ex_STRINGIFY_ARG(contents)      #contents
#define Ex_STRINGIFY(macro_or_string)   Ex_STRINGIFY_ARG(macro_or_string)

#define Ex_WSTRINGIFY_ARG(contents)     L##contents
#define Ex_WSTRINGIFY(macro_or_string)  Ex_WSTRINGIFY_ARG(macro_or_string)

#define Ex_PASTE_ARGS(identifier1,identifier2)  identifier1 ## identifier2
#define Ex_PASTE_DEFS(identifier1,identifier2)  Ex_PASTE_ARGS(identifier1, identifier2)

#if 0//defined(__GNUC__)
# define __func__       ((const mbyte*)(__PRETTY_FUNCTION__))
# define __funcw__      ((const wchar*)(__PRETTY_FUNCTIONW__))
#elif defined(__STDC_VERSION__) && __STDC_VERSION__ >= 19901L
# define __func__       ((const mbyte*)(__func__))
# define __funcw__      ((const wchar*)Ex_WSTRINGIFY(__func__))
#else
# define __func__       ((const mbyte*)(__FUNCTION__))
# define __funcw__      ((const wchar*)Ex_WSTRINGIFY(__FUNCTION__))
#endif

/* Provide a string identifying the current code position */
#if defined(__GNUC__) && (__GNUC__ < 3) && !defined(__cplusplus)
# define Ex_STRLOC      __FILE__ ":" Ex_STRINGIFY(__LINE__) ":" __PRETTY_FUNCTION__ "()"
# define Ex_WCSLOC      Ex_WSTRINGIFY(__FILE__) L":" Ex_WSTRINGIFY(__LINE__) L":" __PRETTY_FUNCTIONW__ L"()"
#else
# define Ex_STRLOC      __FILE__ ":" Ex_STRINGIFY(__LINE__)
# define Ex_WCSLOC      Ex_WSTRINGIFY(__FILE__) L":" Ex_WSTRINGIFY(__LINE__)
#endif

#ifndef NULL
#ifdef __cplusplus
#define NULL (0L)
#else//!__cplusplus
#define NULL ((void*)0)
#endif//__cplusplus
#endif

#define Ex_PTR_TO_SIZE(p)                   ((size_t)(p))
#define Ex_SIZE_TO_PTR(s)                   ((void*)(size_t)(s))
#define Ex_NUM_ELEMENTS(a)                  (sizeof(a)/sizeof((a)[0]))
#define Ex_STRUCT_OFFSET(type, member)      ((long)((int8*)&((type*)0)->member))
#define Ex_STRUCT_MEMBER_P(ptr, offset)     ((void*)((int8*)(ptr) + (long)(offset)))
#define Ex_STRUCT_MEMBER(member_type, p, o) (*(member_type*)Ex_STRUCT_MEMBER_P((p), (o)))

#endif//__exmacro_h__
