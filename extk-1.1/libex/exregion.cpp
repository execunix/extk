/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exregion.h>
#include "exregion_p.h"

ExRegion::ExRegion(int size) : n_rects(0), extent(0, 0, 0, 0) {
    this->size = size;
    rects = (ExRect*)malloc(sizeof(ExRect) * size);
}

