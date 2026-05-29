/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exiconv_h__
#define __exiconv_h__

#include "extypes.h"

#ifdef __linux__
#define CP_UTF8     65001
#define CP_ACP      0
#endif

// classes
//
class ExCPACP0 {
public:
    union {
        char* mbs;
        wchar* wcs;
    };
    ~ExCPACP0();
    ExCPACP0(const char* src);
    ExCPACP0(const wchar* src);
    operator char* () { return mbs; }
    operator wchar* () { return wcs; }
};

class ExCPUTF8 {
public:
    union {
        char* mbs;
        wchar* wcs;
    };
    ~ExCPUTF8();
    ExCPUTF8(const char* src);
    ExCPUTF8(const wchar* src);
    operator char* () { return mbs; }
    operator wchar* () { return wcs; }
};

// funcs
//
int32 mbs2wcs(wchar* wcs, int wcslen, const char* src, int srclen, uint codepage);
int32 wcs2mbs(char* mbs, int mbslen, const wchar* src, int srclen, uint codepage);
const char* wcs2utf8(const ucs2_t* wcs); // thread un-safe
const char* wcs2utf8(const ucs4_t* wcs); // thread un-safe

int32 strsplit(char** const toc, const int tno, char* src, const char del);
char* strltrim(char* src, const char* const tch);
char* strrtrim(char* src, const char* const tch);
char* strtrim(char* const src, const char* const tch);

#endif//__exiconv_h__
