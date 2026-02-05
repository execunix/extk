/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "eximage.h"
#ifdef __linux__
#include <fcntl.h>
#endif

#ifdef WIN32
bool ExImage::loadGif(HANDLE hFile, const char* fname, bool query)
{
    // tbd
    return false;
}
#else // compat linux
bool ExImage::loadGif(int32 fd, const char* fname, bool query)
{
    // tbd
    return false;
}
#endif
