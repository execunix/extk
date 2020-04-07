/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exsearch_h__
#define __exsearch_h__

#if _MSC_VER > 1000
#pragma once
#endif  /* _MSC_VER > 1000 */

#define _M_ARM4

#ifdef _WIN32_WCE//cruntime.h

/***
*cruntime.h - definitions specific to the target operating system and hardware
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       This header file contains widely used definitions specific to the
*       host operating system and hardware. It is included by every C source
*       and most every other header file.
*
*       [Internal]
*
****/

#if 0
#ifndef _CRTBLD
/*
 * This is an internal C runtime header file. It is used when building
 * the C runtimes only. It is not to be used as a public header file.
 */
#error ERROR: Use of C runtime library internal header file.
#endif  /* _CRTBLD */

#if defined (_SYSCRT) && defined (_WIN64)
#define _USE_OLD_STDCPP 1
#endif  /* defined (_SYSCRT) && defined (_WIN64) */

#if !defined (UNALIGNED)
#if defined (_M_IA64) || defined (_M_AMD64)
#define UNALIGNED __unaligned
#else  /* defined (_M_IA64) || defined (_M_AMD64) */
#define UNALIGNED
#endif  /* defined (_M_IA64) || defined (_M_AMD64) */
#endif  /* !defined (UNALIGNED) */
#endif

#ifdef _M_IX86
/*
 * 386/486
 */
#define REG1    register
#define REG2    register
#define REG3    register
#define REG4
#define REG5
#define REG6
#define REG7
#define REG8
#define REG9

#elif defined (_M_IA64) || defined (_M_AMD64)
/*
 * IA64
 */
#define REG1    register
#define REG2    register
#define REG3    register
#define REG4    register
#define REG5    register
#define REG6    register
#define REG7    register
#define REG8    register
#define REG9    register

#elif defined (_M_ARM4) || defined (_M_ARM5)
/*
 * ARM4
 */
#define REG1    register
#define REG2    register
#define REG3    register
#define REG4    register
#define REG5    register
#define REG6    register
#define REG7    register
#define REG8    register
#define REG9    register

#else  /* defined (_M_IA64) || defined (_M_AMD64) */

#pragma message ("Machine register set not defined")

/*
 * Unknown machine
 */

#define REG1
#define REG2
#define REG3
#define REG4
#define REG5
#define REG6
#define REG7
#define REG8
#define REG9

#endif  /* defined (_M_IA64) || defined (_M_AMD64) */

/*
 * Are the macro definitions below still needed in this file?
 */

#endif//_WIN32_WCE:cruntime.h

#ifdef _WIN32_WCE//search.h

/***
*search.h - declarations for searcing/sorting routines
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       This file contains the declarations for the sorting and
*       searching routines.
*       [System V]
*
*       [Public]
*
****/

#include <crtdefs.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/* Function prototypes */

#ifndef _CRT_ALGO_DEFINED
#define _CRT_ALGO_DEFINED
#if __STDC_WANT_SECURE_LIB__
_CRTIMP __checkReturn void * __cdecl bsearch_s(__in const void * _Key, __in_bcount(_NumOfElements * _SizeOfElements) const void * _Base,
        __in rsize_t _NumOfElements, __in rsize_t _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
#endif  /* __STDC_WANT_SECURE_LIB__ */
_CRTIMP __checkReturn void * __cdecl bsearch(__in const void * _Key, __in_bcount(_NumOfElements * _SizeOfElements) const void * _Base,
        __in size_t _NumOfElements, __in size_t _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(const void *, const void *));

#if __STDC_WANT_SECURE_LIB__
_CRTIMP void __cdecl qsort_s(__inout_bcount(_NumOfElements* _SizeOfElements) void * _Base,
        __in rsize_t _NumOfElements, __in rsize_t _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(void *, const void *, const void *), void *_Context);
#endif  /* __STDC_WANT_SECURE_LIB__ */
_CRTIMP void __cdecl qsort(__inout_bcount(_NumOfElements * _SizeOfElements) void * _Base,
        __in size_t _NumOfElements, __in size_t _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(const void *, const void *));
#endif  /* _CRT_ALGO_DEFINED */

_CRTIMP __checkReturn void * __cdecl _lfind_s(__in const void * _Key, __in_bcount((*_NumOfElements) * _SizeOfElements) const void * _Base,
        __inout unsigned int * _NumOfElements, __in size_t _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
_CRTIMP __checkReturn void * __cdecl _lfind(__in const void * _Key, __in_bcount((*_NumOfElements) * _SizeOfElements) const void * _Base,
        __inout unsigned int * _NumOfElements, __in unsigned int _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(const void *, const void *));

_CRTIMP __checkReturn void * __cdecl _lsearch_s(__in const void * _Key, __inout_bcount((*_NumOfElements ) * _SizeOfElements) void  * _Base,
        __inout unsigned int * _NumOfElements, __in size_t _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
_CRTIMP __checkReturn void * __cdecl _lsearch(__in const void * _Key, __inout_bcount((*_NumOfElements ) * _SizeOfElements) void  * _Base,
        __inout unsigned int * _NumOfElements, __in unsigned int _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(const void *, const void *));

#if _MSC_VER >= 1400 && defined(__cplusplus) && defined(_M_CEE)
/*
 * Managed search routines. Note __cplusplus, this is because we only support
 * managed C++.
 */
extern "C++"
{

#if __STDC_WANT_SECURE_LIB__
__checkReturn void * __clrcall bsearch_s(__in const void * _Key, __in_bcount(_NumOfElements*_SizeOfElements) const void * _Base,
        __in rsize_t _NumOfElements, __in rsize_t _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
#endif  /* __STDC_WANT_SECURE_LIB__ */
__checkReturn void * __clrcall bsearch(__in const void * _Key, __in_bcount(_NumOfElements*_SizeOfElements) const void * _Base,
        __in size_t _NumOfElements, __in size_t _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(const void *, const void *));

__checkReturn void * __clrcall _lfind_s(__in const void * _Key, __in_bcount(_NumOfElements*_SizeOfElements) const void * _Base,
        __inout unsigned int * _NumOfElements, __in size_t _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
__checkReturn void * __clrcall _lfind(__in const void * _Key, __in_bcount((*_NumOfElements)*_SizeOfElements) const void * _Base,
        __inout unsigned int * _NumOfElements, __in unsigned int _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(const void *, const void *));

__checkReturn void * __clrcall _lsearch_s(__in const void * _Key, __in_bcount((*_NumOfElements)*_SizeOfElements) void * _Base,
        __in unsigned int * _NumOfElements, __in size_t _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
__checkReturn void * __clrcall _lsearch(__in const void * _Key, __inout_bcount((*_NumOfElements)*_SizeOfElements) void * _Base,
        __inout unsigned int * _NumOfElements, __in unsigned int _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(const void *, const void *));

#if __STDC_WANT_SECURE_LIB__
void __clrcall qsort_s(__inout_bcount_full(_NumOfElements*_SizeOfElements) void * _Base,
        __in rsize_t _NumOfElements, __in rsize_t _SizeOfElment,
        __in int (__clrcall * _PtFuncCompare)(void *, const void *, const void *), void * _Context);
#endif  /* __STDC_WANT_SECURE_LIB__ */
void __clrcall qsort(__inout_bcount_full(_NumOfElements*_SizeOfElements) void * _Base,
        __in size_t _NumOfElements, __in size_t _SizeOfElements,
        __in int (__clrcall * _PtFuncCompare)(const void *, const void *));

}
#endif  /* _MSC_VER >= 1400 && defined(__cplusplus) && defined(_M_CEE) */

#if !__STDC__
/* Non-ANSI names for compatibility */

_CRTIMP _CRT_NONSTDC_DEPRECATE(_lfind) __checkReturn void * __cdecl lfind(__in const void * _Key, __in_bcount((*_NumOfElements) * _SizeOfElements) const void * _Base,
        __inout unsigned int * _NumOfElements, __in unsigned int _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(const void *, const void *));
_CRTIMP _CRT_NONSTDC_DEPRECATE(_lsearch) __checkReturn void * __cdecl lsearch(__in const void * _Key, __inout_bcount((*_NumOfElements) * _SizeOfElements) void  * _Base,
        __inout unsigned int * _NumOfElements, __in unsigned int _SizeOfElements,
        __in int (__cdecl * _PtFuncCompare)(const void *, const void *));

#endif  /* !__STDC__ */

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif//_WIN32_WCE:search.h

#endif//__exsearch_h__
