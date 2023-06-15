/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exiconv_h__
#define __exiconv_h__

#include "extypes.h"

extern uint32 iconv_charset; // default 949

// classes
//
class wcsconv {
public:
    union {
        wchar* wcs;
        mbyte* mbs;
    };
    ~wcsconv();
    wcsconv(const wchar* src);
    wcsconv(const mbyte* src);
    operator wchar* () { return wcs; }
    operator mbyte* () { return mbs; }
};

class wcs2mbs {
public:
    mbyte* mbs;
    ~wcs2mbs();
    wcs2mbs(const wchar* wcs);
    operator const mbyte* () const { return mbs; }
};

class mbs2wcs {
public:
    wchar* wcs;
    ~mbs2wcs();
    mbs2wcs(const mbyte* mbs);
    operator const wchar* () const { return wcs; }
};

#endif//__exiconv_h__
