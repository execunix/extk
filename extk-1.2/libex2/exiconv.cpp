/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exiconv.h"
#include <stdio.h>

#if defined(__GNUC__)
#define _strdup strdup
#define _wcsdup wcsdup
#endif

uint32 iconv_charset = 949; // default 949

// wcsconv
//
wcsconv::~wcsconv()
{
    if (wcs != NULL) {
        free(wcs);
    }
}

wcsconv::wcsconv(const wchar* src)
{
    size_t len = wcslen(src);
    mbs = (mbyte*)malloc((len + 1) * sizeof(wchar));
    if (mbs == NULL) {
        return;
    }
#ifdef WIN32
    int32 n = static_cast<int32>(len);
    len = WideCharToMultiByte(iconv_charset, 0, src, n, mbs, n * 2, NULL, NULL);
#else
    len = wcstombs(mbs, src, len * sizeof(wchar));
    if (len == static_cast<size_t>(-1)) {
        len = 0U;
    }
#endif // WIN32
    mbs[len] = 0;
}

wcsconv::wcsconv(const mbyte* src)
{
    size_t len = strlen(src);
    wcs = (wchar*)malloc((len + 1) * sizeof(wchar));
    if (wcs == NULL) {
        return;
    }
#ifdef WIN32
    int32 n = static_cast<int32>(len);
    len = MultiByteToWideChar(iconv_charset, 0, src, n, wcs, n * 2);
#else
    len = mbstowcs(wcs, src, len * sizeof(wchar));
    if (len == static_cast<size_t>(-1)) {
        len = 0U;
    }
#endif // WIN32
    wcs[len] = 0;
}

// wcs2mbs
//
wcs2mbs::~wcs2mbs()
{
    if (mbs != NULL) {
        free(mbs);
    }
}

wcs2mbs::wcs2mbs(const wchar* wcs) : mbs(NULL)
{
    size_t len = wcslen(wcs);
    mbs = (mbyte*)malloc((len + 1) * sizeof(wchar));
    if (mbs == NULL) {
        mbs = _strdup("(emem)");
        return;
    }
#ifdef WIN32
    int32 n = static_cast<int32>(len);
    len = WideCharToMultiByte(iconv_charset, 0, wcs, n, mbs, n * 2, NULL, NULL);
#else
    len = wcstombs(mbs, wcs, len * sizeof(wchar));
    if (len == static_cast<size_t>(-1)) {
        len = 0U;
    }
#endif // WIN32
    mbs[len] = 0;
}

// mbs2wcs
//
mbs2wcs::~mbs2wcs()
{
    if (wcs != NULL) {
        free(wcs);
    }
}

mbs2wcs::mbs2wcs(const mbyte* mbs) : wcs(NULL)
{
    size_t len = strlen(mbs);
    wcs = (wchar*)malloc((len + 1) * sizeof(wchar));
    if (wcs == NULL) {
        wcs = _wcsdup(L"(emem)");
        return;
    }
#ifdef WIN32
    int32 n = static_cast<int32>(len);
    len = MultiByteToWideChar(iconv_charset, 0, mbs, n, wcs, n * 2);
#else
    len = mbstowcs(wcs, mbs, len * sizeof(wchar));
    if (len == static_cast<size_t>(-1)) {
        len = 0U;
    }
#endif // WIN32
    wcs[len] = 0;
}
