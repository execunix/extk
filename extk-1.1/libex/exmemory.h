/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exmemory_h__
#define __exmemory_h__

#include "extypes.h"

inline void
bcopy(const void* src_ptr, void* dst_ptr, size_t n_bytes) {
    char* dst = (char*)dst_ptr;
    char* dst_end = dst + n_bytes;
    const char* src = (const char*)src_ptr;
    while (dst < dst_end)
        *(dst++) = *(src++);
}

inline void
exmemmove(void* dst_ptr, const void* src_ptr, size_t n_bytes) {
    char* dst = (char*)dst_ptr;
    char* dst_end = dst + n_bytes;
    const char* src = (const char*)src_ptr;
    const char* src_end = src + n_bytes;
    if (src_end < dst ||
        dst_end < src) {
        while (dst < dst_end)
            *dst++ = *src++;
    } else if (dst <= src) {
        while (dst < dst_end)
            *dst++ = *src++;
    } else {
        while (dst < dst_end)
            *--dst_end = *--src_end;
    }
}

inline void*
exmemdup(const void* mem, size_t n_bytes) {
    void* dup = malloc(n_bytes);
    if (dup) memcpy(dup, mem, n_bytes);
    return dup;
}

inline char*
exstrdup(const char* str) {
    if (str == NULL) return NULL;
    return (char*)exmemdup(str, strlen(str) + 1);
}

inline wchar_t*
exwcsdup(const wchar_t* wcs) {
    if (wcs == NULL) return NULL;
    return (wchar_t*)exmemdup(wcs, (wcslen(wcs) + 1) * sizeof(wchar_t));
}

inline void*
exmemset4(void* dst_ptr, uint32 set_val, size_t n_bytes) {
    uint32* dst = (uint32*)dst_ptr;
    uint32* dst_end = dst + n_bytes / sizeof(uint32);
    while (dst < dst_end)
        *dst++ = set_val;
    return dst_ptr;
}

inline void*
exmemcpy4(void* dst_ptr, const void* src_ptr, size_t n_bytes) {
    uint32* dst = (uint32*)dst_ptr;
    uint32* dst_end = dst + n_bytes / sizeof(uint32);
    const uint32* src = (const uint32*)src_ptr;
    while (dst < dst_end)
        *dst++ = *src++;
    return dst_ptr;
}

inline void*
exmemmov4(void* dst_ptr, const void* src_ptr, size_t n_bytes) {
    uint32* dst_end;
    const uint32* src_end;
    if (dst_ptr <= src_ptr)
        return exmemcpy4(dst_ptr, src_ptr, n_bytes);
    n_bytes /= sizeof(uint32);
    dst_end = (uint32*)dst_ptr + n_bytes;
    src_end = (const uint32*)src_ptr + n_bytes;
    while (dst_ptr < dst_end)
        *--dst_end = *--src_end;
    return dst_ptr;
}

inline int
exmemcmp4(const void* buf1, const void* buf2, size_t n_bytes) {
    int r = 0;
    const uint32* p1 = (const uint32*)buf1;
    const uint32* p2 = (const uint32*)buf2;
    const uint32* p1_end = p1 + n_bytes / sizeof(uint32);
    while (p1 < p1_end) {
        if ((r = *p1 - *p2) != 0)
            break;
        p1++;
        p2++;
    }
    return r;
}

inline uint32
exmemsum4(const void* data, size_t n_bytes) {
    uint32 sum4 = 0;
    const uint32* src = (const uint32*)data;
    const uint32* src_end = src + n_bytes / sizeof(uint32);
    while (src < src_end)
        sum4 += *src++;
    return sum4;
}

inline unsigned char
exmemsum(const void* data, size_t n_bytes) {
    unsigned char sum = 0;
    const unsigned char* src = (const unsigned char*)data;
    const unsigned char* src_end = src + n_bytes;
    while (src < src_end)
        sum += *src++;
    return sum;
}

/*
ExShmemCreate()
    Create a block of shared memory
Description:
    This function creates a block of shared memory. The size argument determines the
    size of the block.
    If you pass name as NULL, this function generates a unique name in the form Pg########;
    this is the preferred mode of operation. If you pass a name, make sure that it isn't
    already in use.
*/

/*
ExShmemDestroy()
    Remove a block of shared memory
*/

void* ExShmemCreate(size_t size, const wchar* name);
int   ExShmemDestroy(void* addr);

// tbd - add open/close api

#endif//__exmemory_h__
