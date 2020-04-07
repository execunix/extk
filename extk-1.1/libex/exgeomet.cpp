/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exgeomet.h>

bool /*static*/
ExRect::isIntersect(const ExRect& r1, const ExRect& r2) {
    return (!r1.empty() && !r2.empty() &&
            r1.l < r2.r && r2.l < r1.r &&
            r1.t < r2.b && r2.t < r1.b);
}

bool ExRect::intersect(const ExRect& rc) {
    if (!empty() && !rc.empty() &&
        l < rc.r && rc.l < r &&
        t < rc.b && rc.t < b) {
        if (l < rc.l) l = rc.l;
        if (t < rc.t) t = rc.t;
        if (r > rc.r) r = rc.r;
        if (b > rc.b) b = rc.b;
        return true;
    }
    r = l;
    return false;
}

bool ExRect::intersect(const ExRect& r1, const ExRect& r2) {
    if (!r1.empty() && !r2.empty() &&
        r1.l < r2.r && r2.l < r1.r &&
        r1.t < r2.b && r2.t < r1.b) {
        l = r1.l > r2.l ? r1.l : r2.l;
        t = r1.t > r2.t ? r1.t : r2.t;
        r = r1.r < r2.r ? r1.r : r2.r;
        b = r1.b < r2.b ? r1.b : r2.b;
        return true;
    }
    r = l;
    return false;
}

void ExRect::join(const ExRect& rc) {
    if (rc.empty())
        return;
    if (empty()) {
        l = rc.l;
        t = rc.t;
        r = rc.r;
        b = rc.b;
    } else {
        if (l > rc.l) l = rc.l;
        if (t > rc.t) t = rc.t;
        if (r < rc.r) r = rc.r;
        if (b < rc.b) b = rc.b;
    }
}
