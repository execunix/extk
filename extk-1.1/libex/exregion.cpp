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

#include "exregion.h"
#include "exregion_p.h"
#include <assert.h>

#undef  ABS
#define ABS(a)                  (((a) < 0) ? -(a) : (a))

#undef  MAX
#define MAX(a, b)               (((a) > (b)) ? (a) : (b))

#undef  MIN
#define MIN(a, b)               (((a) < (b)) ? (a) : (b))

#undef  CLAMP
#define CLAMP(x, low, high)     (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

typedef void(*OverlapFunc)(ExRegion*, ExBox*, ExBox*, ExBox*, ExBox*, int16, int16);
typedef void(*NonOverlapFunc)(ExRegion*, ExBox*, ExBox*, int16, int16);

static void miRegionOp(ExRegion*, ExRegion*, const ExRegion*, OverlapFunc, NonOverlapFunc, NonOverlapFunc);

// ExRegion
//

void ExRegion::clear() {
    if (boxes != &extent)
        free(boxes);
    size = 1;
    n_boxes = 0;
    boxes = &extent;
    extent.init0();
}

/**
 * ExRegion::copy(const ExRegion& region)
 * @region: a #ExRegion
 * Copies @region.
 */
void ExRegion::copy(const ExRegion& srcrgn) {
    if (this != &srcrgn) { /* don't want to copy to itself */
        if (size < srcrgn.n_boxes) {
            if (boxes != &extent)
                free(boxes);
            size = srcrgn.n_boxes;
            boxes = (ExBox*)malloc(sizeof(ExBox) * size);
        }
        n_boxes = srcrgn.n_boxes;
        extent = srcrgn.extent;
        if (boxes != &extent)
            memcpy(boxes, srcrgn.boxes, srcrgn.n_boxes * sizeof(ExBox));
    }
}

void ExRegion::getRects(ExBox** boxes, int* n_boxes) const {
    *n_boxes = this->n_boxes;
    *boxes = (ExBox*)malloc(sizeof(ExBox) * this->n_boxes);

    for (int i = 0; i < this->n_boxes; i++)
        (*boxes)[i] = this->boxes[i];
}

void ExRegion::setRect(const ExBox& box) {
    if (box.empty()) {
        n_boxes = 0;
    } else {
        n_boxes = 1;
        extent = box;
        if (boxes != &extent)
            boxes[0] = box;
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
    ExBox *bx, *bxEnd, *extent;

    if (rgn->n_boxes == 0) {
        rgn->extent.x1 = 0;
        rgn->extent.y1 = 0;
        rgn->extent.x2 = 0;
        rgn->extent.y2 = 0;
        return;
    }
    extent = &rgn->extent;
    bx = rgn->boxes;
    bxEnd = &bx[rgn->n_boxes - 1];

    /*
     * Since pBox is the first rectangle in the region, it must have the
     * smallest y1 and since pBoxEnd is the last rectangle in the region,
     * it must have the largest y2, because of banding. Initialize x1 and
     * x2 from  pBox and pBoxEnd, resp., as good things to initialize them
     * to...
     */
    extent->x1 = bx->x1;
    extent->y1 = bx->y1;
    extent->x2 = bxEnd->x2;
    extent->y2 = bxEnd->y2;

    assert(extent->y1 < extent->y2);
    while (bx <= bxEnd) {
        if (bx->x1 < extent->x1) {
            extent->x1 = bx->x1;
        }
        if (bx->x2 > extent->x2) {
            extent->x2 = bx->x2;
        }
        bx++;
    }
    assert(extent->x1 < extent->x2);
}

void ExRegion::move(int16 dx, int16 dy) {
    if (!dx && !dy)
        return;

    ExBox* bx = boxes;
    int n_box = n_boxes;

    while (n_box--) {
        bx->x1 += dx;
        bx->x2 += dx;
        bx->y1 += dy;
        bx->y2 += dy;
        bx++;
    }
    if (boxes != &extent) {
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
            ZShiftRegion(r, -(int16)shift);
            ZOpRegion(r, s);
            dx -= shift;
            if (!dx)
                break;
        }
        t->copy(*s);
        ZShiftRegion(s, -(int16)shift);
        ZOpRegion(s, t);
        shift <<= 1;
    }
}

#undef ZShiftRegion
#undef ZOpRegion

void ExRegion::shrink(int16 dx, int16 dy)
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
                ExBox*    r1,
                ExBox*    r1End,
                ExBox*    r2,
                ExBox*    r2End,
                int16     y1,
                int16     y2)
{
    int16 x1;
    int16 x2;
    ExBox* nextRect;

    nextRect = &rgn->boxes[rgn->n_boxes];
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
            MEM_CHECK(rgn, nextRect, rgn->boxes);
            nextRect->x1 = x1;
            nextRect->y1 = y1;
            nextRect->x2 = x2;
            nextRect->y2 = y2;
            rgn->n_boxes += 1;
            nextRect++;
            assert(rgn->n_boxes <= rgn->size);
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
    if ((!(this->n_boxes)) || (!(srcrgn.n_boxes)) ||
        (!EXTENT_CHECK(&this->extent, &srcrgn.extent)))
        this->n_boxes = 0;
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
 *          - rgn->n_boxes will be decreased.
 */
static int
miCoalesce(ExRegion* rgn,       /* Region to coalesce */
           int       prevStart, /* Index of start of previous band */
           int       curStart)  /* Index of start of current band */
{
    ExBox* prevBox;             /* Current box in previous band */
    ExBox* curBox;              /* Current box in current band */
    ExBox* endBox;              /* End of region */
    int curNumRects;            /* Number of rectangles in current band */
    int prevNumRects;           /* Number of rectangles in previous band */
    int16 bandY1;               /* Y1 coordinate for current band */

    endBox = &rgn->boxes[rgn->n_boxes];

    prevBox = &rgn->boxes[prevStart];
    prevNumRects = curStart - prevStart;
    /*
     * Figure out how many rectangles are in the current band. Have to do
     * this because multiple bands could have been added in miRegionOp
     * at the end when one region has been exhausted.
     */
    curBox = &rgn->boxes[curStart];
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
        curStart = endBox - rgn->boxes;
        endBox = rgn->boxes + rgn->n_boxes;
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

            rgn->n_boxes -= curNumRects;
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
    ExBox* r1;                  /* Pointer into 1st region */
    ExBox* r2;                  /* Pointer into 2nd region */
    ExBox* r1End;               /* End of 1st region */
    ExBox* r2End;               /* End of 2nd region */
    int16 ybot;                 /* Bottom of intersection */
    int16 ytop;                 /* Top of intersection */
    ExBox* oldRects;            /* Old boxes for newrgn */
    int prevBand;               /* Index of start of previous band in newrgn */
    int curBand;                /* Index of start of current band in newrgn */
    ExBox* r1BandEnd;           /* End of current band in r1 */
    ExBox* r2BandEnd;           /* End of current band in r2 */
    int16 top;                  /* Top of non-overlapping band */
    int16 bot;                  /* Bottom of non-overlapping band */

    /*
     * Initialization:
     *   set r1, r2, r1End and r2End appropriately, preserve the important
     * parts of the destination region until the end in case it's one of
     * the two source regions, then mark the "new" region empty, allocating
     * another array of rectangles for it to use.
     */
    r1 = dstrgn->boxes;
    r2 = srcrgn->boxes;
    r1End = r1 + dstrgn->n_boxes;
    r2End = r2 + srcrgn->n_boxes;

    oldRects = newrgn->boxes;

    /*
     * Allocate a reasonable number of rectangles for the new region. The idea
     * is to allocate enough so the individual functions don't need to
     * reallocate and copy the array, which is time consuming, yet we don't
     * have to worry about using too much memory. I hope to be able to
     * nuke the Xrealloc() at the end of this function eventually.
     */
    newrgn->size = MAX(dstrgn->n_boxes, srcrgn->n_boxes) * 4;
    newrgn->boxes = (ExBox*)malloc(sizeof(ExBox) * newrgn->size);
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
        curBand = newrgn->n_boxes;
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
        if (newrgn->n_boxes != curBand) {
            prevBand = miCoalesce(newrgn, prevBand, curBand);
        }
        /*
         * Now see if we've hit an intersecting band. The two bands only
         * intersect if ybot > ytop
         */
        ybot = MIN(r1->y2, r2->y2);
        curBand = newrgn->n_boxes;
        if (ybot > ytop) {
            (*overlapFunc)(newrgn, r1, r1BandEnd, r2, r2BandEnd, ytop, ybot);
        }
        if (newrgn->n_boxes != curBand) {
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
    curBand = newrgn->n_boxes;
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

    if (newrgn->n_boxes != curBand) {
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
    if (newrgn->n_boxes < (newrgn->size >> 1)) {
        if (REGION_NOT_EMPTY(newrgn)) {
            newrgn->size = newrgn->n_boxes;
            newrgn->boxes = realloc(ExBox, newrgn->boxes, newrgn->size);
        } else {
            /*
             * No point in doing the extra work involved in an Xrealloc if
             * the region is empty
             */
            newrgn->size = 1;
            free(newrgn->boxes);
            newrgn->boxes = &newrgn->extent;
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
               ExBox*    r,
               ExBox*    rEnd,
               int16     y1,
               int16     y2)
{
    ExBox* nextRect;

    nextRect = &rgn->boxes[rgn->n_boxes];
    assert(y1 < y2);
    while (r != rEnd) {
        assert(r->x1 < r->x2);
        MEM_CHECK(rgn, nextRect, rgn->boxes);
        nextRect->x1 = r->x1;
        nextRect->y1 = y1;
        nextRect->x2 = r->x2;
        nextRect->y2 = y2;
        rgn->n_boxes += 1;
        nextRect++;
        assert(rgn->n_boxes <= rgn->size);
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
 *      Rectangles are overwritten in pReg->boxes and pReg->numRects will
 *      be changed.
 */
static void
miUnionOlap(ExRegion* rgn,
            ExBox*    r1,
            ExBox*    r1End,
            ExBox*    r2,
            ExBox*    r2End,
            int16     y1,
            int16     y2)
{
    ExBox* nextRect;

    nextRect = &rgn->boxes[rgn->n_boxes];

#define MERGE_RECT(r) \
    if ((rgn->n_boxes != 0) && \
        (nextRect[-1].y1 == y1) && \
        (nextRect[-1].y2 == y2) && \
        (nextRect[-1].x2 >= r->x1)) { \
        if (nextRect[-1].x2 < r->x2) { \
            nextRect[-1].x2 = r->x2; \
            assert(nextRect[-1].x1 < nextRect[-1].x2); \
        } \
    } else { \
        MEM_CHECK(rgn, nextRect, rgn->boxes); \
        nextRect->y1 = y1; \
        nextRect->y2 = y2; \
        nextRect->x1 = r->x1; \
        nextRect->x2 = r->x2; \
        rgn->n_boxes += 1; \
        nextRect += 1; \
    } \
    assert(rgn->n_boxes <= rgn->size); \
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
    if ((this == &srcrgn) || (!(srcrgn.n_boxes)))
        return;
    /*
     * this is empty
     */
    if (!(this->n_boxes)) {
        this->copy(srcrgn);
        return;
    }
    /*
     * this completely subsumes srcrgn
     */
    if ((this->n_boxes == 1) &&
        (this->extent.x1 <= srcrgn.extent.x1) &&
        (this->extent.y1 <= srcrgn.extent.y1) &&
        (this->extent.x2 >= srcrgn.extent.x2) &&
        (this->extent.y2 >= srcrgn.extent.y2))
        return;
    /*
     * srcrgn completely subsumes this
     */
    if ((srcrgn.n_boxes == 1) &&
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
                   ExBox*    r,
                   ExBox*    rEnd,
                   int16     y1,
                   int16     y2)
{
    ExBox* nextRect;

    nextRect = &rgn->boxes[rgn->n_boxes];
    assert(y1 < y2);
    while (r != rEnd) {
        assert(r->x1 < r->x2);
        MEM_CHECK(rgn, nextRect, rgn->boxes);
        nextRect->x1 = r->x1;
        nextRect->y1 = y1;
        nextRect->x2 = r->x2;
        nextRect->y2 = y2;
        rgn->n_boxes += 1;
        nextRect++;
        assert(rgn->n_boxes <= rgn->size);
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
               ExBox*    r1,
               ExBox*    r1End,
               ExBox*    r2,
               ExBox*    r2End,
               int16     y1,
               int16     y2)
{
    ExBox* nextRect;
    int16 x1;

    x1 = r1->x1;
    assert(y1 < y2);
    nextRect = &rgn->boxes[rgn->n_boxes];
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
                    MEM_CHECK(rgn, nextRect, rgn->boxes);
                    nextRect->x1 = x1;
                    nextRect->y1 = y1;
                    nextRect->x2 = r2->x1;
                    nextRect->y2 = y2;
                    rgn->n_boxes += 1;
                    nextRect++;
                    assert(rgn->n_boxes <= rgn->size);
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
                        MEM_CHECK(rgn, nextRect, rgn->boxes);
                        nextRect->x1 = x1;
                        nextRect->y1 = y1;
                        nextRect->x2 = r1->x2;
                        nextRect->y2 = y2;
                        rgn->n_boxes += 1;
                        nextRect++;
                        assert(rgn->n_boxes <= rgn->size);
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
        MEM_CHECK(rgn, nextRect, rgn->boxes);
        nextRect->x1 = x1;
        nextRect->y1 = y1;
        nextRect->x2 = r1->x2;
        nextRect->y2 = y2;
        rgn->n_boxes += 1;
        nextRect++;
        assert(rgn->n_boxes <= rgn->size);
        r1++;
        if (r1 != r1End) {
            x1 = r1->x1;
        }
    }
}

void ExRegion::subtract(const ExRegion& srcrgn) {
    /* check for trivial reject */
    if ((!(this->n_boxes)) || (!(srcrgn.n_boxes)) ||
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
    if (n_boxes != rgn.n_boxes) return false;
    if (n_boxes == 0) return true;
    if (extent.x1 != rgn.extent.x1) return false;
    if (extent.x2 != rgn.extent.x2) return false;
    if (extent.y1 != rgn.extent.y1) return false;
    if (extent.y2 != rgn.extent.y2) return false;
    for (int i = 0; i < n_boxes; i++) {
        if (boxes[i].x1 != rgn.boxes[i].x1) return false;
        if (boxes[i].x2 != rgn.boxes[i].x2) return false;
        if (boxes[i].y1 != rgn.boxes[i].y1) return false;
        if (boxes[i].y2 != rgn.boxes[i].y2) return false;
    }
    return true;
}

bool ExRegion::contain(int16 x, int16 y) const {
    int i;

    if (n_boxes == 0)
        return false;
    if (!IN_BOX(extent, x, y))
        return false;
    for (i = 0; i < n_boxes; i++) {
        if (IN_BOX(boxes[i], x, y))
            return true;
    }
    return false;
}

ExOverlap ExRegion::contain(const ExBox& box) const {
    ExBox* bx;
    ExBox* bxEnd;
    bool partIn, partOut;
    int16 rx, ry;

    rx = box.x1;
    ry = box.y1;

    /* this is (just) a useful optimization */
    if ((n_boxes == 0) || !EXTENT_CHECK(&extent, &box))
        return Ex_OverlapOut;

    partOut = false;
    partIn = false;

    /* can stop when both partOut and partIn are TRUE, or we reach box.y2 */
    for (bx = boxes, bxEnd = bx + n_boxes;
         bx < bxEnd; bx++)
    {
        if (bx->y2 <= ry)
            continue;           /* getting up to speed or skipping remainder of band */
        if (bx->y1 > ry) {
            partOut = true;     /* missed part of rectangle above */
            if (partIn || (bx->y1 >= box.y2))
                break;
            ry = bx->y1;       /* x guaranteed to be == box.x1 */
        }
        if (bx->x2 <= rx)
            continue;           /* not far enough over yet */
        if (bx->x1 > rx) {
            partOut = true;     /* missed part of rectangle to left */
            if (partIn)
                break;
        }
        if (bx->x1 < box.x2) {
            partIn = true;      /* definitely overlap */
            if (partOut)
                break;
        }
        if (bx->x2 >= box.x2) {
            ry = bx->y2;       /* finished with this band */
            if (ry >= box.y2)
                break;
            rx = box.x1;       /* reset x out to left again */
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
        ((ry < box.y2) ?
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
    int i;
    int16 left, right, y;
    int16 clipped_left, clipped_right;
    ExBox* bx;
    ExBox* bxEnd;

    if (!region->n_boxes)
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
        for (bx = region->boxes, bxEnd = bx + region->n_boxes;
             bx < bxEnd; bx++)
        {
            if (bx->y2 <= y)
                continue;       /* Not quite there yet */
            if (bx->y1 > y)
                break;          /* passed the spanline */
            if ((right > bx->x1) && (left < bx->x2)) {
                ExSpan out_span;
                clipped_left = MAX(left, bx->x1);
                clipped_right = MIN(right, bx->x2);
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
    int16 left, right, y;
    int16 clipped_left, clipped_right;
    ExBox* bx;
    ExBox* bxEnd;
    const ExSpan* span;
    const ExSpan* tmpspan;
    const ExSpan* endspan;

    if (!sorted) {
        enumUnsortedSpansIntersect(this, spans, n_spans, spanfunc, data);
        return;
    }

    if ((!n_boxes) || (n_spans == 0))
        return;

    /* The main method here is to step along the
     * sorted rectangles and spans in lock step, and
     * clipping the spans that are in the current
     * rectangle before going on to the next rectangle.
     */
    span = spans;
    endspan = spans + n_spans;
    bx = boxes;
    bxEnd = bx + n_boxes;
    while (bx < bxEnd) {
        while ((bx->y2 < span->y) || (span->y < bx->y1)) {
            /* Skip any rectangles that are above the current span */
            if (bx->y2 < span->y) {
                bx++;
                if (bx == bxEnd)
                    return;
            }
            /* Skip any spans that are above the current rectangle */
            if (span->y < bx->y1) {
                span++;
                if (span == endspan)
                    return;
            }
        }
        /* Ok, we got at least one span that might intersect this rectangle. */
        tmpspan = span;
        while ((tmpspan < endspan) && (tmpspan->y < bx->y2)) {
            y = tmpspan->y;
            left = tmpspan->x;
            right = left + tmpspan->w; /* right is not in the span! */

            if ((right > bx->x1) && (left < bx->x2)) {
                ExSpan out_span;
                clipped_left = MAX(left, bx->x1);
                clipped_right = MIN(right, bx->x2);
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
        bx++;
    }
}

