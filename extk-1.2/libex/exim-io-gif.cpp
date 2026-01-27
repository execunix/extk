/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "eximage.h"
#ifdef __linux__
#include <fcntl.h>
#endif

#ifdef WIN32
int ExImage::loadGif(HANDLE hFile, const wchar* fname, bool query)
{
    // tbd
    return -1;
}
#else // compat linux
int ExImage::loadGif(int fd, const char* fname, bool query)
{
    // tbd
    return -1;
}
#endif
