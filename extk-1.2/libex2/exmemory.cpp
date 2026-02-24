/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exmemory.h"

void* ExHeapAllocate(size_t size)
{
    return malloc(size);
}

void ExHeapDeallocate(void* ptr)
{
    free(ptr);
}

#ifdef WIN32

typedef struct {
    HANDLE hmap;
    size_t size;
    long refcnt;
    long spare1;
} Shmem;

void*
ExShmemCreate(size_t size, const char* name) {
    uchar* addr;
    HANDLE hmap;
    Shmem* shmem;
    hmap = CreateFileMapping(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0, sizeof(Shmem) + size, name);
    if (hmap == NULL) {
        exerror("%s(%d,%s) - CreateFileMapping fail.\n", __func__, size, name);
        return NULL;
    }
    addr = (uchar*)MapViewOfFile(hmap, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(Shmem) + size);
    if (addr == NULL) {
        exerror("%s(%d,%s) - MapViewOfFile fail.\n", __func__, size, name);
        CloseHandle(hmap);
        return NULL;
    }
    shmem = (Shmem*)addr;
    shmem->hmap = hmap;
    shmem->size = size;
    shmem->refcnt = 0;
    addr += sizeof(Shmem);
    return addr;
}

int32
ExShmemDestroy(void* addr) {
    HANDLE hmap;
    Shmem* shmem;
    if (!addr)
        return -1;
    shmem = (Shmem*)((uchar*)addr - sizeof(Shmem));
    exassert(shmem->hmap && !shmem->refcnt); // TBD
    hmap = shmem->hmap;
    UnmapViewOfFile(shmem);
    CloseHandle(hmap);
    return 0;
}

#endif

char* exstrcpy(char* __restrict __dest, const char* __restrict __src)
{
    return strcpy(__dest, __src);
}

char* exstrncpy(char* __restrict __dest, const char* __restrict __src, size_t __n)
{
    return strncpy(__dest, __src, __n);
}

extern int exstrcmp(const char* __s1, const char* __s2)
{
    return strcmp(__s1, __s2);
}

extern int exstrncmp(const char* __s1, const char* __s2, size_t __n)
{
    return strncmp(__s1, __s2, __n);
}

void
exmemory_apitest() {
    char src_buf[256];
    char dst_buf[256];
    exmemset4(src_buf, 0, 256);
    exmemcpy4(dst_buf, src_buf, 256);
    exmemmov4(dst_buf, src_buf, 256);
    exmemcmp4(dst_buf, src_buf, 256);
    exmemsum4(dst_buf, 256 - 4);
    char* mbs = exstrdup("exstrdup");
    free(mbs);
    wchar* wcs = exwcsdup(L"exwcsdup");
    free(wcs);
}
