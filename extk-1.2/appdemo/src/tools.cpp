//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <stdlib.h>
#include <assert.h>
#include "tools.h"

bool system1(const char* const command)
{
    int32 r;

    r = system(command); // slm-5024 stdlib
    dprint("=> %d: %s\n", r, command);
    return (r == 0);
}

const char* wcs2utf8(const ucs2_t* wcs)
{
    static char buf[1024];
    char* dp2 = buf + 1020;
    char* dp = buf;

    while ((*wcs != 0U) && (dp < dp2)) {
        const ucs2_t ch = *wcs++;

        if (ch < 0x80U) {
            *dp++ = (static_cast<char>(ch));
        } else if (ch < 0x800U) {
            *dp++ = (static_cast<char>(192U + (ch / 64U)));
            *dp++ = (static_cast<char>(128U + (ch % 64U)));
        } else {
            *dp++ = (static_cast<char>(224U + (ch / 4096U)));
            *dp++ = (static_cast<char>(128U + ((ch / 64U) % 64U)));
            *dp++ = (static_cast<char>(128U + (ch % 64U)));
        }
    }
    *dp = '\0';
    return buf;
}

const char* wcs2utf8(const ucs4_t* wcs)
{
    static char buf[1024];
    char* dp2 = buf + 1016;
    char* dp = buf;

    while ((*wcs != 0) && (dp < dp2)) {
        const ucs4_t ch = *wcs++;

        if (ch < 0x80) { // 0XXX XXXX one byte
            *dp++ = (static_cast<char>(ch));
        } else if (ch < 0x800) { // 110X XXXX tow bytes
            *dp++ = (static_cast<char>(0xC0 | (ch >> 6)));
            *dp++ = (static_cast<char>(0x80 | (ch & 0x3F)));
        } else if (ch < 0x10000) { // 1110 XXXX three bytes
            *dp++ = (static_cast<char>(0xE0 | (ch >> 12)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 6) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | (ch & 0x3F)));
        } else if (ch < 0x200000) { // 1111 0XXX four bytes
            *dp++ = (static_cast<char>(0xF0 | (ch >> 18)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 12) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 6) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | (ch & 0x3F)));
        } else if (ch < 0x4000000) { // 1111 10XX five bytes
            *dp++ = (static_cast<char>(0xF8 | (ch >> 24)));
            *dp++ = (static_cast<char>(0x80 | (ch >> 18)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 12) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 6) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | (ch & 0x3F)));
        } else if (ch < 0x8000000) { // 1111 110X six bytes
            *dp++ = (static_cast<char>(0xFC | (ch >> 30)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 24) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 18) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 12) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | ((ch >> 6) & 0x3F)));
            *dp++ = (static_cast<char>(0x80 | (ch & 0x3F)));
        } else {
            ; // error
        }
    }
    *dp = '\0';
    return buf;
}

// split string
// [Parameters]
//  - toc: tocken pointer array
//  - tno: tocken pointer number
//  - src: source string (input)
//  - del: delimiter (input)
// [Return Values]
//  - return tocken count
//
int32 strsplit(char** const toc, const int tno, char* src, const char del)
{
    exassert(src != nullptr);
    int32 cnt = 0; // tocken counter
    while (cnt < tno) {
        toc[cnt++] = src; // store tocken pointer
        while ((*src != '\0') && (*src != del)) {
            src++; // found delimiter
        }
        if (*src == '\0') {
            break; // stop split
        }
        *src++ = '\0'; // cut string
    }
    return cnt;
}

// trim left side...
char* strltrim(char* src, const char* const tch)
{
    while ((*src != '\0') && (nullptr != strchr(tch, *src))) {
        src++; // skip trim char...
    }
    return src;
}

// trim right side...
char* strrtrim(char* src, const char* const tch)
{
    char* const begin = src;
    while (*src != '\0') {
        src++; // goto end char...
    }
    while ((src > begin) && (nullptr != strchr(tch, *(src - 1)))) {
        src--; // skip trim char...
    }
    *src = 0; // cut string
    return begin;
}

// trim left and right
char* strtrim(char* src, const char* const tch)
{
    return strltrim(strrtrim(src, tch), tch);
}

TouchRecordStack touch_ic_overheat_dataset;
