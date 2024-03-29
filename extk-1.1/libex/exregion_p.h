/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

/************************************************************************

Copyright 1987, 1998  The Open Group

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


Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.

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

#ifndef __exregion_p_h__
#define __exregion_p_h__

/* Xutil.h contains the declaration:
 * typedef struct _XRegion *XRegion;
 */

/*  1 if two BOXs overlap.
 *  0 if two BOXs do not overlap.
 *  Remember, x2 and y2 are not in the region
 */
#define EXTENT_CHECK(r1, r2)    \
        ((r1)->x2 > (r2)->x1 && \
         (r1)->x1 < (r2)->x2 && \
         (r1)->y2 > (r2)->y1 && \
         (r1)->y1 < (r2)->y2)

/*
 *  update region extents
 */
#define EXTENTS(r, id_rgn) {               \
        if ((r)->x1 < (id_rgn)->extent.x1) \
            (id_rgn)->extent.x1 = (r)->x1; \
        if ((r)->y1 < (id_rgn)->extent.y1) \
            (id_rgn)->extent.y1 = (r)->y1; \
        if ((r)->x2 > (id_rgn)->extent.x2) \
            (id_rgn)->extent.x2 = (r)->x2; \
        if ((r)->y2 > (id_rgn)->extent.y2) \
            (id_rgn)->extent.y2 = (r)->y2; \
    }

#define GROW_REGION(rgn, nbxes) {                                                      \
        if ((nbxes) == 0) {                                                            \
            if ((rgn)->boxes != &(rgn)->extent) {                                      \
                free((rgn)->boxes);                                                    \
                (rgn)->boxes = &(rgn)->extent;                                         \
            }                                                                          \
        } else                                                                         \
        if ((rgn)->boxes == &(rgn)->extent) {                                          \
            (rgn)->boxes = (ExBox*)malloc(sizeof(ExBox) * nbxes);                      \
            (rgn)->boxes[0] = (rgn)->extent;                                           \
        } else {                                                                       \
            ExBox* tmpboxes = (ExBox*)malloc(sizeof(ExBox) * nbxes);                   \
            for (int i = 0; i < (rgn)->n_boxes; i++)                                   \
                tmpboxes[i] = (rgn)->boxes[i];                                         \
            free((rgn)->boxes);                                                        \
            (rgn)->boxes = tmpboxes;                                                   \
            /* warning: non-trivially */                                               \
            /* (rgn)->boxes = (ExBox*)realloc((rgn)->boxes, sizeof(ExBox) * nbxes); */ \
        }                                                                              \
        (rgn)->size = (nbxes);                                                         \
    }

/*
 *   Check to see if there is enough memory in the present region.
 */
#define MEM_CHECK(rgn, box, firstrect) {           \
        if ((rgn)->n_boxes >= ((rgn)->size - 1)) { \
            GROW_REGION(rgn, 4 * (rgn)->size);     \
            (box) = &(firstrect)[(rgn)->n_boxes];  \
        }                                          \
    }

/*  this routine checks to see if the previous rectangle is the same
 *  or subsumes the new rectangle to add.
 */
#define CHECK_PREV(rgn, r, rx1, ry1, rx2, ry2) \
        (!(((rgn)->n_boxes > 0) &&             \
           ((r-1)->y1 == (ry1)) &&             \
           ((r-1)->y2 == (ry2)) &&             \
           ((r-1)->x1 <= (rx1)) &&             \
           ((r-1)->x2 >= (rx2))))

/*  add a rectangle to the given region */
#define ADD_RECT(rgn, r, rx1, ry1, rx2, ry2) {                    \
        if (((rx1) < (rx2)) && ((ry1) < (ry2)) &&                 \
            CHECK_PREV((rgn), (r), (rx1), (ry1), (rx2), (ry2))) { \
            (r)->x1 = (rx1);                                      \
            (r)->y1 = (ry1);                                      \
            (r)->x2 = (rx2);                                      \
            (r)->y2 = (ry2);                                      \
            EXTENTS((r), (rgn));                                  \
            (rgn)->n_boxes++;                                     \
            (r)++;                                                \
        }                                                         \
    }

/*  add a rectangle to the given region */
#define ADD_RECT_NOX(rgn, r, rx1, ry1, rx2, ry2) {                \
        if ((rx1 < rx2) && (ry1 < ry2) &&                         \
            CHECK_PREV((rgn), (r), (rx1), (ry1), (rx2), (ry2))) { \
            (r)->x1 = (rx1);                                      \
            (r)->y1 = (ry1);                                      \
            (r)->x2 = (rx2);                                      \
            (r)->y2 = (ry2);                                      \
            (rgn)->n_boxes++;                                     \
            (r)++;                                                \
        }                                                         \
    }

#define EMPTY_REGION(rgn) rgn->n_boxes = 0

#define REGION_NOT_EMPTY(rgn) rgn->n_boxes

#define IN_BOX(r, x, y)     \
        ((((r).x2 > x)) &&  \
         (((r).x1 <= x)) && \
         (((r).y2 > y)) &&  \
         (((r).y1 <= y)))

/*
 * number of points to buffer before sending them off
 * to scanlines() :  Must be an even number
 */
#define NUMPTSTOBUFFER 200

/*
 * used to allocate buffers for points and link
 * the buffers together
 */
typedef struct _POINTBLOCK {
    ExPoint pts[NUMPTSTOBUFFER];
    struct _POINTBLOCK* next;
} POINTBLOCK;

#endif//__exregion_p_h__
