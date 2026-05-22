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
        char* mbs;
    };
    ~wcsconv();
    wcsconv(const wchar* src);
    wcsconv(const char* src);
    operator wchar* () { return wcs; }
    operator char* () { return mbs; }
};

class wcs2mbs {
public:
    char* mbs;
    ~wcs2mbs();
    wcs2mbs(const wchar* wcs);
    operator const char* () const { return mbs; }
};

class mbs2wcs {
public:
    wchar* wcs;
    ~mbs2wcs();
    mbs2wcs(const char* mbs);
    operator const wchar* () const { return wcs; }
};

const char* wcs2utf8(const ucs2_t* wcs); // thread un-safe
const char* wcs2utf8(const ucs4_t* wcs); // thread un-safe

int32 strsplit(char** const toc, const int tno, char* src, const char del);
char* strltrim(char* src, const char* const tch);
char* strrtrim(char* src, const char* const tch);
char* strtrim(char* const src, const char* const tch);

#endif//__exiconv_h__
