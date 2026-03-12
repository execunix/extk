/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "extools.h"
#include <fstream>

bool system1(const char* const command)
{
    int32 r;

    r = system(command); // slm-5024 stdlib
    dprint("=> %d: %s\n", r, command);

    return (r == 0);
}
