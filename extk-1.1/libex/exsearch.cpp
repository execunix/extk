/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exsearch.h>
#include <exdebug.h>

#ifdef _WIN32_WCE

/***
*bsearch_s.c - do a binary search
*
*   Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*   defines bsearch_s() - do a binary search an an array
*
*******************************************************************************/

/***
*char *bsearch_s() - do a binary search on an array
*
*Purpose:
*   Does a binary search of a sorted array for a key.
*
*Entry:
*   const char *key    - key to search for
*   const char *base   - base of sorted array to search
*   unsigned int num   - number of elements in array
*   unsigned int width - number of bytes per element
*   int (*compare)()   - pointer to function that compares two array
*           elements, returning neg when #1 < #2, pos when #1 > #2, and
*           0 when they are equal. Function is passed pointers to two
*           array elements, together with a pointer to a context.
*   void *context - pointer to the context in which the function is
*           called. This context is passed to the comparison function.
*
*Exit:
*   if key is found:
*           returns pointer to occurrence of key in array
*   if key is not found:
*           returns NULL
*
*Exceptions:
*       Input parameters are validated. Refer to the validation section of the function.
*
*******************************************************************************/

#if 0
#ifdef __USE_CONTEXT
#error __USE_CONTEXT should be undefined
#endif  /* __USE_CONTEXT */

#define __USE_CONTEXT
//#include "bsearch.c"
#endif

#if 1   // <crtdbg.h>
#ifndef _DEBUG
#define _ASSERT_EXPR(expr, expr_str) ((void)0)
#else  /* _DEBUG */
#define _ASSERT_EXPR(expr, msg) \
        (void) ((!!(expr)) || \
                (1 != _CrtDbgReportW(_CRT_ASSERT, _CRT_WIDE(__FILE__), __LINE__, NULL, msg)) || \
                (_CrtDbgBreak(), 0))
#endif  /* _DEBUG */
#endif  // <crtdbg.h>

/***
*bsearch.c - do a binary search
*
*   Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*   defines bsearch() - do a binary search an an array
*
*******************************************************************************/

//#include <cruntime.h>
//#include <stdlib.h>
//#include <search.h>
//#include <internal.h>
#if 1   // <internal.h>
/*
 * Assert in debug builds.
 * set errno and return
 */
#ifdef _DEBUG
#define _CALL_INVALID_PARAMETER_FUNC(funcname, expr) funcname(expr, __FUNCTIONW__, __FILEW__, __LINE__, 0)
#define _INVOKE_WATSON_IF_ERROR(expr) _invoke_watson_if_error((expr), __STR2WSTR(#expr), __FUNCTIONW__, __FILEW__, __LINE__, 0)
#define _INVOKE_WATSON_IF_ONEOF(expr, errvalue1, errvalue2) _invoke_watson_if_oneof(expr, (errvalue1), (errvalue2), __STR2WSTR(#expr), __FUNCTIONW__, __FILEW__, __LINE__, 0)
#else  /* _DEBUG */
#define _CALL_INVALID_PARAMETER_FUNC(funcname, expr) funcname(NULL, NULL, NULL, 0, 0)
#define _INVOKE_WATSON_IF_ERROR(expr) _invoke_watson_if_error(expr, NULL, NULL, NULL, 0, 0)
#define _INVOKE_WATSON_IF_ONEOF(expr, errvalue1, errvalue2) _invoke_watson_if_oneof((expr), (errvalue1), (errvalue2), NULL, NULL, NULL, 0, 0)
#endif  /* _DEBUG */

#define _INVALID_PARAMETER(expr) _CALL_INVALID_PARAMETER_FUNC(_invalid_parameter, expr)
/*
 * Assert in debug builds.
 * set errno and return value
 */
#ifndef _VALIDATE_RETURN
#define _VALIDATE_RETURN( expr, errorcode, retexpr )                           \
    {                                                                          \
        int _Expr_val=!!(expr);                                                \
        _ASSERT_EXPR( ( _Expr_val ), _CRT_WIDE(#expr) );                       \
        if ( !( _Expr_val ) )                                                  \
        {                                                                      \
            errno = errorcode;                                                 \
            _INVALID_PARAMETER(_CRT_WIDE(#expr) );                             \
            return ( retexpr );                                                \
        }                                                                      \
    }
#endif  /* _VALIDATE_RETURN */
#endif  // <internal.h>

#if defined (_M_CEE)
#define __fileDECL  __clrcall
#else  /* defined (_M_CEE) */
#define __fileDECL  __cdecl
#endif  /* defined (_M_CEE) */
/***
*char *bsearch() - do a binary search on an array
*
*Purpose:
*   Does a binary search of a sorted array for a key.
*
*Entry:
*   const char *key    - key to search for
*   const char *base   - base of sorted array to search
*   unsigned int num   - number of elements in array
*   unsigned int width - number of bytes per element
*   int (*compare)()   - pointer to function that compares two array
*           elements, returning neg when #1 < #2, pos when #1 > #2, and
*           0 when they are equal. Function is passed pointers to two
*           array elements.
*
*Exit:
*   if key is found:
*           returns pointer to occurrence of key in array
*   if key is not found:
*           returns NULL
*
*Exceptions:
*   Input parameters are validated. Refer to the validation section of the function.
*
*******************************************************************************/

#ifdef __USE_CONTEXT
#define __COMPARE(context, p1, p2) (*compare)(context, p1, p2)
#else  /* __USE_CONTEXT */
#define __COMPARE(context, p1, p2) (*compare)(p1, p2)
#endif  /* __USE_CONTEXT */

#if !defined (_M_CEE)
_CRTIMP
#endif  /* !defined (_M_CEE) */

#ifdef __USE_CONTEXT
void * __fileDECL bsearch_s (
    REG4 const void *key,
    const void *base,
    size_t num,
    size_t width,
    int (__fileDECL *compare)(void *, const void *, const void *),
    void *context
    )
#else  /* __USE_CONTEXT */
void * __fileDECL bsearch (
    REG4 const void *key,
    const void *base,
    size_t num,
    size_t width,
    int (__fileDECL *compare)(const void *, const void *)
    )
#endif  /* __USE_CONTEXT */
{
    REG1 char *lo = (char *)base;
    REG2 char *hi = (char *)base + (num - 1) * width;
    REG3 char *mid;
    size_t half;
    int result;

    /* validation section */
    _VALIDATE_RETURN(base != NULL || num == 0, EINVAL, NULL);
    _VALIDATE_RETURN(width > 0, EINVAL, NULL);
    _VALIDATE_RETURN(compare != NULL, EINVAL, NULL);

        /*
        We allow a NULL key here because it breaks some older code and because we do not dereference
        this ourselves so we can't be sure that it's a problem for the comparison function
        */

    while (lo <= hi)
    {
        if ((half = num / 2) != 0)
        {
            mid = lo + (num & 1 ? half : (half - 1)) * width;
            if (!(result = __COMPARE(context, key, mid)))
                return(mid);
            else if (result < 0)
            {
                hi = mid - width;
                num = num & 1 ? half : half-1;
            }
            else
            {
                lo = mid + width;
                num = half;
            }
        }
        else if (num)
            return (__COMPARE(context, key, lo) ? NULL : lo);
        else
            break;
    }

    return NULL;
}

#undef __fileDECL
#undef __COMPARE

#endif//_WIN32_WCE

