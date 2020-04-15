/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

/************************************************************************

Copyright 1987, 1988, 1998  The Open Group

Permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of The Open Group shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from The Open Group.


Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Digital not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.

DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.

************************************************************************/
/* $XFree86: xc/lib/X11/ExRegion.c,v 1.11 2006/01/09 14:58:33 dawes Exp $ */
/*
 * The functions in this file implement the ExRegion abstraction, similar to one
 * used in the X11 sample server. A ExRegion is simply an area, as the name
 * implies, and is implemented as a "y-x-banded" array of rectangles. To
 * explain: Each ExRegion is made up of a certain number of rectangles sorted
 * by y coordinate first, and then by x coordinate.
 *
 * Furthermore, the rectangles are banded such that every rectangle with a
 * given upper-left y coordinate (y1) will have the same lower-right y
 * coordinate (y2) and vice versa. If a rectangle has scanlines in a band, it
 * will span the entire vertical distance of the band. This means that some
 * areas that could be merged into a taller rectangle will be represented as
 * several shorter rectangles to account for shorter rectangles to its left
 * or right but within its "vertical scope".
 *
 * An added constraint on the rectangles is that they must cover as much
 * horizontal area as possible. E.g. no two rectangles in a band are allowed
 * to touch.
 *
 * Whenever possible, bands will be merged together to cover a greater vertical
 * distance (and thus reduce the number of rectangles). Two bands can be merged
 * only if the bottom of one touches the top of the other and they have
 * rectangles in the same places (of the same width, of course). This maintains
 * the y-x-banding that's so nice to have...
 */

#include <exregion.h>
#include "exregion_p.h"

#undef  ABS
#define ABS(a)                  (((a) < 0) ? -(a) : (a))

#undef  MAX
#define MAX(a, b)               (((a) > (b)) ? (a) : (b))

#undef  MIN
#define MIN(a, b)               (((a) < (b)) ? (a) : (b))

#undef  CLAMP
#define CLAMP(x, low, high)     (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

typedef void(*OverlapFunc)(ExRegion*, ExRect*, ExRect*, ExRect*, ExRect*, int, int);
typedef void(*NonOverlapFunc)(ExRegion*, ExRect*, ExRect*, int, int);

static void miRegionOp(ExRegion*, ExRegion*, const ExRegion*, OverlapFunc, NonOverlapFunc, NonOverlapFunc);

// ExRegion
//

void ExRegion::clear() {
    if (rects != &extent)
        free(rects);
    size = 1;
    n_rects = 0;
    rects = &extent;
    extent.init0();
}

/**
 * ExRegion::copy(const ExRegion& region)
 * @region: a #ExRegion
 * Copies @region.
 */
void ExRegion::copy(const ExRegion& srcrgn) {
    if (this != &srcrgn) { /* don't want to copy to itself */
        if (size < srcrgn.n_rects) {
            if (rects != &extent)
                free(rects);
            size = srcrgn.n_rects;
            rects = (ExRect*)malloc(sizeof(ExRect) * size);
        }
        n_rects = srcrgn.n_rects;
        extent = srcrgn.extent;
        if (rects != &extent)
            memcpy(rects, srcrgn.rects, srcrgn.n_rects * sizeof(ExRect));
    }
}

void ExRegion::getRects(ExRect** rects, int* n_rects) const {
    *n_rects = this->n_rects;
    *rects = (ExRect*)malloc(sizeof(ExRect) * this->n_rects);

    for (int i = 0; i < this->n_rects; i++)
        (*rects)[i] = this->rects[i];
}

void ExRegion::setRect(const ExRect& rect) {
    if (rect.empty()) {
        n_rects = 0;
    } else {
        n_rects = 1;
        extent = rect;
        if (rects != &extent)
            rects[0] = rect;
    }
}

/*
 * miSetExtents
 *      Reset the extents of a region to what they should be. Called by
 *      miSubtract and miIntersect b/c they can't figure it out along the
 *      way or do so easily, as miUnion can.
 * Results:
 *      None.
 * Side Effects:
 *      The region's 'extent' structure is overwritten.
 */
static void
miSetExtents(ExRegion* rgn)
{
    ExRect *box, *boxEnd, *extent;

    if (rgn->n_rects == 0) {
        rgn->extent.x1 = 0;
        rgn->extent.y1 = 0;
        rgn->extent.x2 = 0;
        rgn->extent.y2 = 0;
        return;
    }
    extent = &rgn->extent;
    box = rgn->rects;
    boxEnd = &box[rgn->n_rects - 1];

    /*
     * Since pBox is the first rectangle in the region, it must have the
     * smallest y1 and since pBoxEnd is the last rectangle in the region,
     * it must have the largest y2, because of banding. Initialize x1 and
     * x2 from  pBox and pBoxEnd, resp., as good things to initialize them
     * to...
     */
    extent->x1 = box->x1;
    extent->y1 = box->y1;
    extent->x2 = boxEnd->x2;
    extent->y2 = boxEnd->y2;

    assert(extent->y1 < extent->y2);
    while (box <= boxEnd) {
        if (box->x1 < extent->x1) {
            extent->x1 = box->x1;
        }
        if (box->x2 > extent->x2) {
            extent->x2 = box->x2;
        }
        box++;
    }
    assert(extent->x1 < extent->x2);
}

void ExRegion::move(int dx, int dy) {
    if (!dx && !dy)
        return;

    ExRect* box = rects;
    int n_box = n_rects;

    while (n_box--) {
        box->x1 += dx;
        box->x2 += dx;
        box->y1 += dy;
        box->y2 += dy;
        box++;
    }
    if (rects != &extent) {
        extent.x1 += dx;
        extent.x2 += dx;
        extent.y1 += dy;
        extent.y2 += dy;
    }
}

/*
   Utility procedure miCompress:
   Replace r by the region r', where
     p in r' iff (Quantifer m <= dx) (p + m in r), and
     Quantifier is Exists if grow is TRUE, For all if grow is FALSE, and
     (x,y) + m = (x+m,y) if xdir is TRUE; (x,y+m) if xdir is FALSE.

   Thus, if xdir is TRUE and grow is FALSE, r is replaced by the region
   of all points p such that p and the next dx points on the same
   horizontal scan line are all in r.  We do this using by noting
   that p is the head of a run of length 2^i + k iff p is the head
   of a run of length 2^i and p+2^i is the head of a run of length
   k. Thus, the loop invariant: s contains the region corresponding
   to the runs of length shift.  r contains the region corresponding
   to the runs of length 1 + dxo & (shift-1), where dxo is the original
   value of dx.  dx = dxo & ~(shift-1).  As parameters, s and t are
   scratch regions, so that we don't have to allocate them on every
   call.
*/

#define ZOpRegion(a, b)     if (grow) a->combine(*b); \
                            else      a->intersect(*b)
#define ZShiftRegion(a, b)  if (xdir) a->move(b, 0); \
                            else      a->move(0, b)

static void
miCompress(ExRegion* r,
           ExRegion* s,
           ExRegion* t,
           uint      dx,
           bool      xdir,
           bool      grow)
{
    uint shift = 1;

    s->copy(*r);
    while (dx) {
        if (dx & shift) {
            ZShiftRegion(r, -(int)shift);
            ZOpRegion(r, s);
            dx -= shift;
            if (!dx)
                break;
        }
        t->copy(*s);
        ZShiftRegion(s, -(int)shift);
        ZOpRegion(s, t);
        shift <<= 1;
    }
}

#undef ZShiftRegion
#undef ZOpRegion

void ExRegion::shrink(int dx, int dy)
{
    if (!dx && !dy)
        return;

    bool grow;
    ExRegion s;
    ExRegion t;

    grow = (dx < 0);
    if (grow)
        dx = -dx;
    if (dx)
        miCompress(this, &s, &t, (uint)(2 * dx), true, grow);

    grow = (dy < 0);
    if (grow)
        dy = -dy;
    if (dy)
        miCompress(this, &s, &t, (uint)(2 * dy), false, grow);

    this->move(dx, dy);
}

/************************************************************************
 * Region Intersection
 ************************************************************************/
/*
 * miIntersectOlap
 *      Handle an overlapping band for miIntersect.
 * Results:
 *      None.
 * Side Effects:
 *      Rectangles may be added to the region.
 */
static void
miIntersectOlap(ExRegion* rgn,
                ExRect*   r1,
                ExRect*   r1End,
                ExRect*   r2,
                ExRect*   r2End,
                int       y1,
                int       y2)
{
    int x1;
    int x2;
    ExRect* nextRect;

    nextRect = &rgn->rects[rgn->n_rects];
    while ((r1 != r1End) && (r2 != r2End)) {
        x1 = MAX(r1->x1, r2->x1);
        x2 = MIN(r1->x2, r2->x2);
        /*
         * If there's any overlap between the two rectangles, add that
         * overlap to the new region.
         * There's no need to check for subsumption because the only way
         * such a need could arise is if some region has two rectangles
         * right next to each other. Since that should never happen...
         */
        if (x1 < x2) {
            assert(y1 < y2);
            MEM_CHECK(rgn, nextRect, rgn->rects);
            nextRect->x1 = x1;
            nextRect->y1 = y1;
            nextRect->x2 = x2;
            nextRect->y2 = y2;
            rgn->n_rects += 1;
            nextRect++;
            assert(rgn->n_rects <= rgn->size);
        }
        /*
         * Need to advance the pointers. Shift the one that extends
         * to the right the least, since the other still has a chance to
         * overlap with that region's next rectangle, if you see what I mean.
         */
        if (r1->x2 < r2->x2) {
            r1++;
        } else
            if (r2->x2 < r1->x2) {
                r2++;
            } else {
                r1++;
                r2++;
            }
    }
}

void ExRegion::intersect(const ExRegion& srcrgn) {
    /* check for trivial reject */
    if ((!(this->n_rects)) || (!(srcrgn.n_rects)) ||
        (!EXTENT_CHECK(&this->extent, &srcrgn.extent)))
        this->n_rects = 0;
    else
        miRegionOp(this, this, &srcrgn, miIntersectOlap, (NonOverlapFunc)NULL, (NonOverlapFunc)NULL);
    /*
     * Can't alter this's extents before miRegionOp depends on the
     * extents of the regions being unchanged. Besides, this way there's
     * no checking against rectangles that will be nuked due to
     * coalescing, so we have to examine fewer rectangles.
     */
    miSetExtents(this);
}

/************************************************************************
 * Generic Region Operator
 ************************************************************************/
/*
 * miCoalesce
 *      Attempt to merge the boxes in the current band with those in the
 *      previous one. Used only by miRegionOp.
 * Results:
 *      The new index for the previous band.
 * Side Effects:
 *      If coalescing takes place:
 *          - rectangles in the previous band will have their y2 fields
 *            altered.
 *          - rgn->n_rects will be decreased.
 */
static int
miCoalesce(ExRegion* rgn,       /* Region to coalesce */
           int       prevStart, /* Index of start of previous band */
           int       curStart)  /* Index of start of current band */
{
    ExRect* prevBox;            /* Current box in previous band */
    ExRect* curBox;             /* Current box in current band */
    ExRect* endBox;             /* End of region */
    int curNumRects;            /* Number of rectangles in current band */
    int prevNumRects;           /* Number of rectangles in previous band */
    int bandY1;                 /* Y1 coordinate for current band */

    endBox = &rgn->rects[rgn->n_rects];

    prevBox = &rgn->rects[prevStart];
    prevNumRects = curStart - prevStart;
    /*
     * Figure out how many rectangles are in the current band. Have to do
     * this because multiple bands could have been added in miRegionOp
     * at the end when one region has been exhausted.
     */
    curBox = &rgn->rects[curStart];
    bandY1 = curBox->y1;
    for (curNumRects = 0;
        (curBox != endBox) && (curBox->y1 == bandY1);
         curNumRects++) {
        curBox++;
    }
    if (curBox != endBox) {
        /*
         * If more than one band was added, we have to find the start
         * of the last band added so the next coalescing job can start
         * at the right place... (given when multiple bands are added,
         * this may be pointless -- see above).
         */
        endBox--;
        while (endBox[-1].y1 == endBox->y1) {
            endBox--;
        }
        curStart = endBox - rgn->rects;
        endBox = rgn->rects + rgn->n_rects;
    }

    if ((curNumRects == prevNumRects) && (curNumRects != 0)) {
        curBox -= curNumRects;
        /*
         * The bands may only be coalesced if the bottom of the previous
         * matches the top scanline of the current.
         */
        if (prevBox->y2 == curBox->y1) {
            /*
             * Make sure the bands have boxes in the same places. This
             * assumes that boxes have been added in such a way that they
             * cover the most area possible. I.e. two boxes in a band must
             * have some horizontal space between them.
             */
            do {
                if ((prevBox->x1 != curBox->x1) ||
                    (prevBox->x2 != curBox->x2)) {
                    /*
                     * The bands don't line up so they can't be coalesced.
                     */
                    return (curStart);
                }
                prevBox++;
                curBox++;
                prevNumRects -= 1;
            } while (prevNumRects != 0);

            rgn->n_rects -= curNumRects;
            curBox -= curNumRects;
            prevBox -= curNumRects;
            /*
             * The bands may be merged, so set the bottom y of each box
             * in the previous band to that of the corresponding box in
             * the current band.
             */
            do {
                prevBox->y2 = curBox->y2;
                prevBox++;
                curBox++;
                curNumRects -= 1;
            } while (curNumRects != 0);
            /*
             * If only one band was added to the region, we have to backup
             * curStart to the start of the previous band.
             *
             * If more than one band was added to the region, copy the
             * other bands down. The assumption here is that the other bands
             * came from the same region as the current one and no further
             * coalescing can be done on them since it's all been done
             * already... curStart is already in the right place.
             */
            if (curBox == endBox) {
                curStart = prevStart;
            } else {
                do {
                    *prevBox++ = *curBox++;
                } while (curBox != endBox);
            }
        }
    }
    return curStart;
}

/*
 * miRegionOp
 *      Apply an operation to two regions. Called by miUnion, miInverse,
 *      miSubtract, miIntersect...
 * Results:
 *      None.
 * Side Effects:
 *      The new region is overwritten.
 * Notes:
 *      The idea behind this function is to view the two regions as sets.
 *      Together they cover a rectangle of area that this function divides
 *      into horizontal bands where points are covered only by one region
 *      or by both. For the first case, the nonOverlapFunc is called with
 *      each the band and the band's upper and lower extents. For the
 *      second, the overlapFunc is called to process the entire band. It
 *      is responsible for clipping the rectangles in the band, though
 *      this function provides the boundaries.
 *      At the end of each band, the new region is coalesced, if possible,
 *      to reduce the number of rectangles in the region.
 */
static void
miRegionOp(ExRegion*       newrgn,          /* New region */
           ExRegion*       dstrgn,          /* 1st region */
           const ExRegion* srcrgn,          /* 2nd region */
           OverlapFunc     overlapFunc,     /* Function to call for overlapping bands */
           NonOverlapFunc  nonOverlap1Func, /* Function to call for non-overlapping bands in region 1 */
           NonOverlapFunc  nonOverlap2Func) /* Function to call for non-overlapping bands in region 2 */
{
    ExRect* r1;                 /* Pointer into 1st region */
    ExRect* r2;                 /* Pointer into 2nd region */
    ExRect* r1End;              /* End of 1st region */
    ExRect* r2End;              /* End of 2nd region */
    int ybot;                   /* Bottom of intersection */
    int ytop;                   /* Top of intersection */
    ExRect* oldRects;           /* Old rects for newrgn */
    int prevBand;               /* Index of start of previous band in newrgn */
    int curBand;                /* Index of start of current band in newrgn */
    ExRect* r1BandEnd;          /* End of current band in r1 */
    ExRect* r2BandEnd;          /* End of current band in r2 */
    int top;                    /* Top of non-overlapping band */
    int bot;                    /* Bottom of non-overlapping band */

    /*
     * Initialization:
     *   set r1, r2, r1End and r2End appropriately, preserve the important
     * parts of the destination region until the end in case it's one of
     * the two source regions, then mark the "new" region empty, allocating
     * another array of rectangles for it to use.
     */
    r1 = dstrgn->rects;
    r2 = srcrgn->rects;
    r1End = r1 + dstrgn->n_rects;
    r2End = r2 + srcrgn->n_rects;

    oldRects = newrgn->rects;

    /*
     * Allocate a reasonable number of rectangles for the new region. The idea
     * is to allocate enough so the individual functions don't need to
     * reallocate and copy the array, which is time consuming, yet we don't
     * have to worry about using too much memory. I hope to be able to
     * nuke the Xrealloc() at the end of this function eventually.
     */
    newrgn->size = MAX(dstrgn->n_rects, srcrgn->n_rects) * 4;
    newrgn->rects = (ExRect*)malloc(sizeof(ExRect) * newrgn->size);
    EMPTY_REGION(newrgn);

    /*
     * Initialize ybot and ytop.
     * In the upcoming loop, ybot and ytop serve different functions depending
     * on whether the band being handled is an overlapping or non-overlapping
     * band.
     *   In the case of a non-overlapping band (only one of the regions
     * has points in the band), ybot is the bottom of the most recent
     * intersection and thus clips the top of the rectangles in that band.
     * ytop is the top of the next intersection between the two regions and
     * serves to clip the bottom of the rectangles in the current band.
     *   For an overlapping band (where the two regions intersect), ytop clips
     * the top of the rectangles of both regions and ybot clips the bottoms.
     */
    if (dstrgn->extent.y1 < srcrgn->extent.y1)
        ybot = dstrgn->extent.y1;
    else
        ybot = srcrgn->extent.y1;

    /*
     * prevBand serves to mark the start of the previous band so rectangles
     * can be coalesced into larger rectangles. qv. miCoalesce, above.
     * In the beginning, there is no previous band, so prevBand == curBand
     * (curBand is set later on, of course, but the first band will always
     * start at index 0). prevBand and curBand must be indices because of
     * the possible expansion, and resultant moving, of the new region's
     * array of rectangles.
     */
    prevBand = 0;

    do {
        curBand = newrgn->n_rects;
        /*
         * This algorithm proceeds one source-band (as opposed to a
         * destination band, which is determined by where the two regions
         * intersect) at a time. r1BandEnd and r2BandEnd serve to mark the
         * rectangle after the last one in the current band for their
         * respective regions.
         */
        r1BandEnd = r1;
        while ((r1BandEnd != r1End) && (r1BandEnd->y1 == r1->y1)) {
            r1BandEnd++;
        }
        r2BandEnd = r2;
        while ((r2BandEnd != r2End) && (r2BandEnd->y1 == r2->y1)) {
            r2BandEnd++;
        }
        /*
         * First handle the band that doesn't intersect, if any.
         *
         * Note that attention is restricted to one band in the
         * non-intersecting region at once, so if a region has n
         * bands between the current position and the next place it overlaps
         * the other, this entire loop will be passed through n times.
         */
        if (r1->y1 < r2->y1) {
            top = MAX(r1->y1, ybot);
            bot = MIN(r1->y2, r2->y1);
            if ((top != bot) && (nonOverlap1Func != (NonOverlapFunc)NULL)) {
                (*nonOverlap1Func)(newrgn, r1, r1BandEnd, top, bot);
            }
            ytop = r2->y1;
        } else
            if (r2->y1 < r1->y1) {
                top = MAX(r2->y1, ybot);
                bot = MIN(r2->y2, r1->y1);
                if ((top != bot) && (nonOverlap2Func != (NonOverlapFunc)NULL)) {
                    (*nonOverlap2Func)(newrgn, r2, r2BandEnd, top, bot);
                }
                ytop = r1->y1;
            } else {
                ytop = r1->y1;
            }
            /*
             * If any rectangles got added to the region, try and coalesce them
             * with rectangles from the previous band. Note we could just do
             * this test in miCoalesce, but some machines incur a not
             * inconsiderable cost for function calls, so...
             */
        if (newrgn->n_rects != curBand) {
            prevBand = miCoalesce(newrgn, prevBand, curBand);
        }
        /*
         * Now see if we've hit an intersecting band. The two bands only
         * intersect if ybot > ytop
         */
        ybot = MIN(r1->y2, r2->y2);
        curBand = newrgn->n_rects;
        if (ybot > ytop) {
            (*overlapFunc)(newrgn, r1, r1BandEnd, r2, r2BandEnd, ytop, ybot);
        }
        if (newrgn->n_rects != curBand) {
            prevBand = miCoalesce(newrgn, prevBand, curBand);
        }
        /*
         * If we've finished with a band (y2 == ybot) we skip forward
         * in the region to the next band.
         */
        if (r1->y2 == ybot) {
            r1 = r1BandEnd;
        }
        if (r2->y2 == ybot) {
            r2 = r2BandEnd;
        }
    } while ((r1 != r1End) && (r2 != r2End));

    /*
     * Deal with whichever region still has rectangles left.
     */
    curBand = newrgn->n_rects;
    if (r1 != r1End) {
        if (nonOverlap1Func != (NonOverlapFunc)NULL) {
            do {
                r1BandEnd = r1;
                while ((r1BandEnd < r1End) && (r1BandEnd->y1 == r1->y1)) {
                    r1BandEnd++;
                }
                (*nonOverlap1Func)(newrgn, r1, r1BandEnd, MAX(r1->y1, ybot), r1->y2);
                r1 = r1BandEnd;
            } while (r1 != r1End);
        }
    } else
        if ((r2 != r2End) && (nonOverlap2Func != (NonOverlapFunc)NULL)) {
            do {
                r2BandEnd = r2;
                while ((r2BandEnd < r2End) && (r2BandEnd->y1 == r2->y1)) {
                    r2BandEnd++;
                }
                (*nonOverlap2Func)(newrgn, r2, r2BandEnd, MAX(r2->y1, ybot), r2->y2);
                r2 = r2BandEnd;
            } while (r2 != r2End);
        }

    if (newrgn->n_rects != curBand) {
        (void)miCoalesce(newrgn, prevBand, curBand);
    }

    /*
     * A bit of cleanup. To keep regions from growing without bound,
     * we shrink the array of rectangles to match the new number of
     * rectangles in the region. This never goes to 0, however...
     *
     * Only do this stuff if the number of rectangles allocated is more than
     * twice the number of rectangles in the region (a simple optimization...).
     */
#if 0 // tbd
    if (newrgn->n_rects < (newrgn->size >> 1)) {
        if (REGION_NOT_EMPTY(newrgn)) {
            newrgn->size = newrgn->n_rects;
            newrgn->rects = realloc(ExRect, newrgn->rects, newrgn->size);
        } else {
            /*
             * No point in doing the extra work involved in an Xrealloc if
             * the region is empty
             */
            newrgn->size = 1;
            free(newrgn->rects);
            newrgn->rects = &newrgn->extent;
        }
    }
#endif
    if (oldRects != &newrgn->extent)
        free(oldRects);
}

/************************************************************************
 * Region Union
 ************************************************************************/
/*
 * miUnionNonOlap
 *      Handle a non-overlapping band for the union operation. Just
 *      Adds the rectangles into the region. Doesn't have to check for
 *      subsumption or anything.
 * Results:
 *      None.
 * Side Effects:
 *      pReg->numRects is incremented and the final rectangles overwritten
 *      with the rectangles we're passed.
 */
static void
miUnionNonOlap(ExRegion* rgn,
               ExRect*   r,
               ExRect*   rEnd,
               int       y1,
               int       y2)
{
    ExRect* nextRect;

    nextRect = &rgn->rects[rgn->n_rects];
    assert(y1 < y2);
    while (r != rEnd) {
        assert(r->x1 < r->x2);
        MEM_CHECK(rgn, nextRect, rgn->rects);
        nextRect->x1 = r->x1;
        nextRect->y1 = y1;
        nextRect->x2 = r->x2;
        nextRect->y2 = y2;
        rgn->n_rects += 1;
        nextRect++;
        assert(rgn->n_rects <= rgn->size);
        r++;
    }
}

/*
 * miUnionOlap
 *      Handle an overlapping band for the union operation. Picks the
 *      left-most rectangle each time and merges it into the region.
 * Results:
 *      None.
 * Side Effects:
 *      Rectangles are overwritten in pReg->rects and pReg->numRects will
 *      be changed.
 */
static void
miUnionOlap(ExRegion* rgn,
            ExRect*   r1,
            ExRect*   r1End,
            ExRect*   r2,
            ExRect*   r2End,
            int       y1,
            int       y2)
{
    ExRect* nextRect;

    nextRect = &rgn->rects[rgn->n_rects];

#define MERGE_RECT(r) \
    if ((rgn->n_rects != 0) && \
        (nextRect[-1].y1 == y1) && \
        (nextRect[-1].y2 == y2) && \
        (nextRect[-1].x2 >= r->x1)) { \
        if (nextRect[-1].x2 < r->x2) { \
            nextRect[-1].x2 = r->x2; \
            assert(nextRect[-1].x1 < nextRect[-1].x2); \
        } \
    } else { \
        MEM_CHECK(rgn, nextRect, rgn->rects); \
        nextRect->y1 = y1; \
        nextRect->y2 = y2; \
        nextRect->x1 = r->x1; \
        nextRect->x2 = r->x2; \
        rgn->n_rects += 1; \
        nextRect += 1; \
    } \
    assert(rgn->n_rects <= rgn->size); \
    r++;

    assert(y1 < y2);
    while ((r1 != r1End) && (r2 != r2End)) {
        if (r1->x1 < r2->x1) {
            MERGE_RECT(r1);
        } else {
            MERGE_RECT(r2);
        }
    }
    if (r1 != r1End) {
        do {
            MERGE_RECT(r1);
        } while (r1 != r1End);
    } else {
        while (r2 != r2End) {
            MERGE_RECT(r2);
        }
    }
}

void ExRegion::combine(const ExRegion& srcrgn) {
    /* checks all the simple cases */

    /*
     * this and srcrgn are the same or srcrgn is empty
     */
    if ((this == &srcrgn) || (!(srcrgn.n_rects)))
        return;
    /*
     * this is empty
     */
    if (!(this->n_rects)) {
        this->copy(srcrgn);
        return;
    }
    /*
     * this completely subsumes srcrgn
     */
    if ((this->n_rects == 1) &&
        (this->extent.x1 <= srcrgn.extent.x1) &&
        (this->extent.y1 <= srcrgn.extent.y1) &&
        (this->extent.x2 >= srcrgn.extent.x2) &&
        (this->extent.y2 >= srcrgn.extent.y2))
        return;
    /*
     * srcrgn completely subsumes this
     */
    if ((srcrgn.n_rects == 1) &&
        (srcrgn.extent.x1 <= this->extent.x1) &&
        (srcrgn.extent.y1 <= this->extent.y1) &&
        (srcrgn.extent.x2 >= this->extent.x2) &&
        (srcrgn.extent.y2 >= this->extent.y2)) {
        this->copy(srcrgn);
        return;
    }

    miRegionOp(this, this, &srcrgn, miUnionOlap, miUnionNonOlap, miUnionNonOlap);

    this->extent.x1 = MIN(this->extent.x1, srcrgn.extent.x1);
    this->extent.y1 = MIN(this->extent.y1, srcrgn.extent.y1);
    this->extent.x2 = MAX(this->extent.x2, srcrgn.extent.x2);
    this->extent.y2 = MAX(this->extent.y2, srcrgn.extent.y2);
}

/************************************************************************
 * Region Subtraction
 ************************************************************************/
/*
 * miSubtractNonOlap1
 *      Deal with non-overlapping band for subtraction. Any parts from
 *      region 2 we discard. Anything from region 1 we add to the region.
 * Results:
 *      None.
 * Side Effects:
 *      pReg may be affected.
 */
static void
miSubtractNonOlap1(ExRegion* rgn,
                   ExRect*   r,
                   ExRect*   rEnd,
                   int       y1,
                   int       y2)
{
    ExRect* nextRect;

    nextRect = &rgn->rects[rgn->n_rects];
    assert(y1 < y2);
    while (r != rEnd) {
        assert(r->x1 < r->x2);
        MEM_CHECK(rgn, nextRect, rgn->rects);
        nextRect->x1 = r->x1;
        nextRect->y1 = y1;
        nextRect->x2 = r->x2;
        nextRect->y2 = y2;
        rgn->n_rects += 1;
        nextRect++;
        assert(rgn->n_rects <= rgn->size);
        r++;
    }
}

/*
 * miSubtractOlap
 *      Overlapping band subtraction. x1 is the left-most point not yet
 *      checked.
 * Results:
 *      None.
 * Side Effects:
 *      pReg may have rectangles added to it.
 */
static void
miSubtractOlap(ExRegion* rgn,
               ExRect*   r1,
               ExRect*   r1End,
               ExRect*   r2,
               ExRect*   r2End,
               int       y1,
               int       y2)
{
    ExRect* nextRect;
    int x1;

    x1 = r1->x1;
    assert(y1 < y2);
    nextRect = &rgn->rects[rgn->n_rects];
    while ((r1 != r1End) && (r2 != r2End)) {
        if (r2->x2 <= x1) {
            /*
             * Subtrahend missed the boat: go to next subtrahend.
             */
            r2++;
        } else
            if (r2->x1 <= x1) {
                /*
                 * Subtrahend preceeds minuend: nuke left edge of minuend.
                 */
                x1 = r2->x2;
                if (x1 >= r1->x2) {
                    /*
                     * Minuend completely covered: advance to next minuend and
                     * reset left fence to edge of new minuend.
                     */
                    r1++;
                    if (r1 != r1End)
                        x1 = r1->x1;
                } else {
                    /*
                     * Subtrahend now used up since it doesn't extend beyond minuend.
                     */
                    r2++;
                }
            } else
                if (r2->x1 < r1->x2) {
                    /*
                     * Left part of subtrahend covers part of minuend: add uncovered
                     * part of minuend to region and skip to next subtrahend.
                     */
                    assert(x1 < r2->x1);
                    MEM_CHECK(rgn, nextRect, rgn->rects);
                    nextRect->x1 = x1;
                    nextRect->y1 = y1;
                    nextRect->x2 = r2->x1;
                    nextRect->y2 = y2;
                    rgn->n_rects += 1;
                    nextRect++;
                    assert(rgn->n_rects <= rgn->size);
                    x1 = r2->x2;
                    if (x1 >= r1->x2) {
                        /*
                         * Minuend used up: advance to new...
                         */
                        r1++;
                        if (r1 != r1End)
                            x1 = r1->x1;
                    } else {
                        /*
                         * Subtrahend used up
                         */
                        r2++;
                    }
                } else {
                    /*
                     * Minuend used up: add any remaining piece before advancing.
                     */
                    if (r1->x2 > x1) {
                        MEM_CHECK(rgn, nextRect, rgn->rects);
                        nextRect->x1 = x1;
                        nextRect->y1 = y1;
                        nextRect->x2 = r1->x2;
                        nextRect->y2 = y2;
                        rgn->n_rects += 1;
                        nextRect++;
                        assert(rgn->n_rects <= rgn->size);
                    }
                    r1++;
                    if (r1 != r1End)
                        x1 = r1->x1;
                }
    }

    /*
     * Add remaining minuend rectangles to region.
     */
    while (r1 != r1End) {
        assert(x1 < r1->x2);
        MEM_CHECK(rgn, nextRect, rgn->rects);
        nextRect->x1 = x1;
        nextRect->y1 = y1;
        nextRect->x2 = r1->x2;
        nextRect->y2 = y2;
        rgn->n_rects += 1;
        nextRect++;
        assert(rgn->n_rects <= rgn->size);
        r1++;
        if (r1 != r1End) {
            x1 = r1->x1;
        }
    }
}

void ExRegion::subtract(const ExRegion& srcrgn) {
    /* check for trivial reject */
    if ((!(this->n_rects)) || (!(srcrgn.n_rects)) ||
        (!EXTENT_CHECK(&this->extent, &srcrgn.extent)))
        return;

    miRegionOp(this, this, &srcrgn, miSubtractOlap, miSubtractNonOlap1, (NonOverlapFunc)NULL);
    /*
     * Can't alter this's extents before we call miRegionOp because miRegionOp
     * depends on the extents of those regions being the unaltered. Besides, this
     * way there's no checking against rectangles that will be nuked
     * due to coalescing, so we have to examine fewer rectangles.
     */
    miSetExtents(this);
}

bool ExRegion::equal(const ExRegion& rgn) const {
    if (n_rects != rgn.n_rects) return false;
    if (n_rects == 0) return true;
    if (extent.x1 != rgn.extent.x1) return false;
    if (extent.x2 != rgn.extent.x2) return false;
    if (extent.y1 != rgn.extent.y1) return false;
    if (extent.y2 != rgn.extent.y2) return false;
    for (int i = 0; i < n_rects; i++) {
        if (rects[i].x1 != rgn.rects[i].x1) return false;
        if (rects[i].x2 != rgn.rects[i].x2) return false;
        if (rects[i].y1 != rgn.rects[i].y1) return false;
        if (rects[i].y2 != rgn.rects[i].y2) return false;
    }
    return true;
}

bool ExRegion::contain(int x, int y) const {
    int i;

    if (n_rects == 0)
        return false;
    if (!IN_BOX(extent, x, y))
        return false;
    for (i = 0; i < n_rects; i++) {
        if (IN_BOX(rects[i], x, y))
            return true;
    }
    return false;
}

ExOverlap ExRegion::contain(const ExRect& rect) const {
    ExRect* box;
    ExRect* boxEnd;
    bool partIn, partOut;
    int rx, ry;

    rx = rect.x1;
    ry = rect.y1;

    /* this is (just) a useful optimization */
    if ((n_rects == 0) || !EXTENT_CHECK(&extent, &rect))
        return Ex_OverlapOut;

    partOut = false;
    partIn = false;

    /* can stop when both partOut and partIn are TRUE, or we reach rect.y2 */
    for (box = rects, boxEnd = box + n_rects;
         box < boxEnd; box++)
    {
        if (box->y2 <= ry)
            continue;           /* getting up to speed or skipping remainder of band */
        if (box->y1 > ry) {
            partOut = true;     /* missed part of rectangle above */
            if (partIn || (box->y1 >= rect.y2))
                break;
            ry = box->y1;       /* x guaranteed to be == rect.x1 */
        }
        if (box->x2 <= rx)
            continue;           /* not far enough over yet */
        if (box->x1 > rx) {
            partOut = true;     /* missed part of rectangle to left */
            if (partIn)
                break;
        }
        if (box->x1 < rect.x2) {
            partIn = true;      /* definitely overlap */
            if (partOut)
                break;
        }
        if (box->x2 >= rect.x2) {
            ry = box->y2;       /* finished with this band */
            if (ry >= rect.y2)
                break;
            rx = rect.x1;       /* reset x out to left again */
        } else {
            /*
             * Because boxes in a band are maximal width, if the first box
             * to overlap the rectangle doesn't completely cover it in that
             * band, the rectangle must be partially out, since some of it
             * will be uncovered in that band. partIn will have been set true
             * by now...
             */
            break;
        }
    }

    return (partIn ?
        ((ry < rect.y2) ?
         Ex_OverlapPart : Ex_OverlapIn) :
            Ex_OverlapOut);
}

static void
enumUnsortedSpansIntersect(ExRegion*     region,
                           const ExSpan* spans,
                           int           n_spans,
                           ExSpanFunc    spanfunc,
                           void*         data)
{
    int i, left, right, y;
    int clipped_left, clipped_right;
    ExRect* box;
    ExRect* boxEnd;

    if (!region->n_rects)
        return;

    for (i = 0; i < n_spans; i++)
    {
        y = spans[i].y;
        left = spans[i].x;
        right = left + spans[i].w; /* right is not in the span! */

        if (!((region->extent.y1 <= y) &&
            (region->extent.y2 > y) &&
              (region->extent.x1 < right) &&
              (region->extent.x2 > left)))
            continue;

        /* can stop when we passed y */
        for (box = region->rects, boxEnd = box + region->n_rects;
             box < boxEnd; box++)
        {
            if (box->y2 <= y)
                continue;       /* Not quite there yet */
            if (box->y1 > y)
                break;          /* passed the spanline */
            if ((right > box->x1) && (left < box->x2)) {
                ExSpan out_span;
                clipped_left = MAX(left, box->x1);
                clipped_right = MIN(right, box->x2);
                out_span.y = y;
                out_span.x = clipped_left;
                out_span.w = clipped_right - clipped_left;
                (*spanfunc)(&out_span, data);
            }
        }
    }
}

void ExRegion::enumSpansintersect(const ExSpan* spans,
                                  int           n_spans,
                                  bool          sorted,
                                  ExSpanFunc    spanfunc,
                                  void*         data) {
    int left, right, y;
    int clipped_left, clipped_right;
    ExRect* box;
    ExRect* boxEnd;
    const ExSpan* span;
    const ExSpan* tmpspan;
    const ExSpan* endspan;

    if (!sorted) {
        enumUnsortedSpansIntersect(this, spans, n_spans, spanfunc, data);
        return;
    }

    if ((!n_rects) || (n_spans == 0))
        return;

    /* The main method here is to step along the
     * sorted rectangles and spans in lock step, and
     * clipping the spans that are in the current
     * rectangle before going on to the next rectangle.
     */
    span = spans;
    endspan = spans + n_spans;
    box = rects;
    boxEnd = box + n_rects;
    while (box < boxEnd) {
        while ((box->y2 < span->y) || (span->y < box->y1)) {
            /* Skip any rectangles that are above the current span */
            if (box->y2 < span->y) {
                box++;
                if (box == boxEnd)
                    return;
            }
            /* Skip any spans that are above the current rectangle */
            if (span->y < box->y1) {
                span++;
                if (span == endspan)
                    return;
            }
        }
        /* Ok, we got at least one span that might intersect this rectangle. */
        tmpspan = span;
        while ((tmpspan < endspan) && (tmpspan->y < box->y2)) {
            y = tmpspan->y;
            left = tmpspan->x;
            right = left + tmpspan->w; /* right is not in the span! */

            if ((right > box->x1) && (left < box->x2)) {
                ExSpan out_span;
                clipped_left = MAX(left, box->x1);
                clipped_right = MIN(right, box->x2);
                out_span.y = y;
                out_span.x = clipped_left;
                out_span.w = clipped_right - clipped_left;
                (*spanfunc)(&out_span, data);
            }
            tmpspan++;
        }
        /* Finished this rectangle.
         * The spans could still intersect the next one
         */
        box++;
    }
}

