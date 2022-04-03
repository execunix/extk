/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exgeomet.h"

bool /*static*/
ExBox::isIntersect(const ExBox& b1, const ExBox& b2) {
    return (!b1.empty() && !b2.empty() &&
            b1.l < b2.r && b2.l < b1.r &&
            b1.t < b2.b && b2.t < b1.b);
}

bool ExBox::intersect(const ExBox& bx) {
    if (!empty() && !bx.empty() &&
        l < bx.r && bx.l < r &&
        t < bx.b && bx.t < b) {
        if (l < bx.l) l = bx.l;
        if (t < bx.t) t = bx.t;
        if (r > bx.r) r = bx.r;
        if (b > bx.b) b = bx.b;
        return true;
    }
    r = l;
    return false;
}

bool ExBox::intersect(const ExBox& b1, const ExBox& b2) {
    if (!b1.empty() && !b2.empty() &&
        b1.l < b2.r && b2.l < b1.r &&
        b1.t < b2.b && b2.t < b1.b) {
        l = b1.l > b2.l ? b1.l : b2.l;
        t = b1.t > b2.t ? b1.t : b2.t;
        r = b1.r < b2.r ? b1.r : b2.r;
        b = b1.b < b2.b ? b1.b : b2.b;
        return true;
    }
    r = l;
    return false;
}

void ExBox::join(const ExBox& bx) {
    if (bx.empty())
        return;
    if (empty()) {
        l = bx.l;
        t = bx.t;
        r = bx.r;
        b = bx.b;
    } else {
        if (l > bx.l) l = bx.l;
        if (t > bx.t) t = bx.t;
        if (r < bx.r) r = bx.r;
        if (b < bx.b) b = bx.b;
    }
}
