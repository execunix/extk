/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exiconv_h__
#define __exiconv_h__

#include "extypes.h"

#if defined(__GNUC__)
#define _strdup strdup
#define _wcsdup wcsdup
#endif

extern uint32 iconv_charset; // default 949

// classes
//
class wcsconv {
public:
    union {
        wchar* wcs;
        mbyte* mbs;
    };
    ~wcsconv() {
        if (wcs) free(wcs);
    }
    wcsconv(const wchar* src) {
#ifdef WIN32
        int32 len = (int)wcslen(src);
#else
        size_t len = wcslen(src);
#endif
        if ((mbs = (mbyte*)malloc((len + 1) * 2)) == NULL)
            return;
#ifdef WIN32
        len = WideCharToMultiByte(dprint_charset, 0, src, len, mbs, len * 2, NULL, NULL);
#else
        len = wcstombs(mbs, src, len * 2); if (len < 0) len = 0;
#endif // WIN32
        mbs[len] = 0;
    }
    wcsconv(const mbyte* src) {
#ifdef WIN32
        int32 len = (int)strlen(src);
#else
        size_t len = strlen(src);
#endif
        if ((wcs = (wchar*)malloc((len + 1) * 2)) == NULL)
            return;
#ifdef WIN32
        len = MultiByteToWideChar(dprint_charset, 0, src, len, wcs, len * 2);
#else
        len = mbstowcs(wcs, src, len * 2); if (len < 0) len = 0;
#endif // WIN32
        wcs[len] = 0;
    }
    operator wchar* () { return wcs; }
    operator mbyte* () { return mbs; }
};

class wcs2mbs {
public:
    mbyte* mbs;
    ~wcs2mbs() {
        if (mbs) free(mbs);
    }
    wcs2mbs(const wchar* wcs) : mbs(NULL) {
#ifdef WIN32
        int32 len = (int)wcslen(wcs);
#else
        size_t len = wcslen(wcs);
#endif
        if ((mbs = (mbyte*)malloc(len * 2 + 1)) == NULL) {
            mbs = _strdup("(emem)");
            return;
        }
#ifdef WIN32
        len = WideCharToMultiByte(iconv_charset, 0, wcs, len, mbs, len * 2, NULL, NULL);
#else
        len = wcstombs(mbs, wcs, len * 2); if (len < 0) len = 0;
#endif // WIN32
        mbs[len] = 0;
    }
    operator const mbyte* () const { return mbs; }
};

class mbs2wcs {
public:
    wchar* wcs;
    ~mbs2wcs() {
        if (wcs) free(wcs);
    }
    mbs2wcs(const mbyte* mbs) : wcs(NULL) {
#ifdef WIN32
        int32 len = (int)strlen(mbs);
#else
        size_t len = strlen(mbs);
#endif
        if ((wcs = (wchar*)malloc(len * 2 + 2)) == NULL) {
            wcs = _wcsdup(L"(emem)");
            return;
        }
#ifdef WIN32
        len = MultiByteToWideChar(iconv_charset, 0, mbs, len, wcs, len * 2);
#else
        len = mbstowcs(wcs, mbs, len * 2); if (len < 0) len = 0;
#endif // WIN32
        wcs[len] = 0;
    }
    operator const wchar* () const { return wcs; }
};

#endif//__exiconv_h__
