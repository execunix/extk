/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exregion_h__
#define __exregion_h__

#include "exgeomet.h"
//#include "exmemory.h"

enum ExOverlap {
    Ex_OverlapIn,               // rectangle is in region
    Ex_OverlapOut,              // rectangle in not in region
    Ex_OverlapPart,             // rectangle in partially in region
};

typedef void(*ExSpanFunc)(ExSpan* span, void* data);

#if 0 // tbd
enum ExFillRule {
    Ex_EvenOddRule,
    Ex_WindingRule,
};

ExRegion* ExRegionPolygon(const ExPoint* pts, int n_pts, ExFillRule fillrule);
#endif

// ExRegion
//
struct ExRegion {
    int size;
    int n_boxes;
    ExBox* boxes;
    ExBox extent;

    /**
     * ~ExRegion()
     * Destroys a #ExRegion.
     */
    ~ExRegion() {
        if (boxes != &extent)
            free(boxes);
    }
    /**
     * ExRegion()
     * Creates a new empty #ExRegion.
     */
    explicit ExRegion()
        : size(1), n_boxes(0), boxes(&extent), extent(0) {}
    /**
     * ExRegion(const ExBox& box)
     * Creates a new region containing the area @box.
     */
    explicit ExRegion(const ExBox& box)
        : size(1), n_boxes(0), boxes(&extent), extent(box) {
        if (!box.empty())
            n_boxes = 1;
    }
    /**
     * ExRegion(const ExRegion& region)
     * Copies @region, creating an identical new region.
     */
    explicit ExRegion(const ExRegion& srcrgn)
        : size(1), n_boxes(0), boxes(&extent) {
        copy(srcrgn);
    }

    ExRegion& operator = (const ExRegion& srcrgn) { copy(srcrgn); return *this; }
    //operator int () const { return n_boxes; }

    void clear();
    void copy(const ExRegion& srcrgn);
    /**
     * ExRegion::getClipRect(ExBox& box)
     * @box: return location for the clipbox
     * Obtains the smallest rectangle which includes the entire #ExRegion.
     */
    void getClipRect(ExBox& box) const {
        box = extent;
    }
    /**
     * ExRegion::getRects(ExBox** boxes, int* n_boxes):
     * @boxes: return location for an array of rectangles
     * @n_boxes: length of returned array
     * Obtains the area covered by the region as a list of rectangles.
     * The array returned in @rectangles must be freed with free().
     */
    void getRects(ExBox** boxes, int* n_boxes) const;
    void setRect(const ExBox& box);
    void setEmpty() {
        n_boxes = 0;
    }
    /**
     * ExRegion::move(int16 dx, int16 dy)
     * @dx: the distance to move the region horizontally
     * @dy: the distance to move the region vertically
     * Moves a region the specified distance.
     */
    void move(int16 dx, int16 dy);
    void move(const ExPoint& pt) {
        move(pt.x, pt.y);
    }
    /**
     * ExRegion::shrink(int16 dx, int16 dy)
     * @dx: the number of pixels to shrink the region horizontally
     * @dy: the number of pixels to shrink the region vertically
     * Resizes a region by the specified amount.
     * Positive values shrink the region. Negative values expand it.
     */
    void shrink(int16 dx, int16 dy);
    void shrink(const ExPoint& pt) {
        shrink(pt.x, pt.y);
    }
    /**
     * ExRegion::combine(const ExRegion& srcrgn)
     * @srcrgn: a #ExRegion
     * Sets the area of @this to the union of the areas of @this and @srcrgn.
     * The resulting area is the set of pixels contained in either @this or @srcrgn.
     */
    void combine(const ExRegion& srcrgn);
    /**
     * ExRegion::combine(const ExBox& box)
     * @box: a #ExBox.
     * Sets the area of @this to the union of the areas of @this and @box.
     * The resulting area is the set of pixels contained in either @this or @box.
     */
    void combine(const ExBox& box) {
        if (!box.empty())
            combine(ExRegion(box));
    }
    /**
     * ExRegion::intersect(const ExRegion& srcrgn)
     * @srcrgn: another #ExRegion
     * Sets the area of @this to the intersection of the areas of @this @srcrgn.
     * The resulting area is the set of pixels contained in both @this and @srcrgn.
     */
    void intersect(const ExRegion& srcrgn);
    void intersect(const ExBox& box) {
        box.empty() ? setEmpty() : intersect(ExRegion(box));
    }
    /**
     * ExRegion::subtract(const ExRegion& srcrgn)
     * @srcrgn: another #ExRegion
     * Subtracts the area of @srcrgn from the area @this. The resulting
     * area is the set of pixels contained in @this but not in @srcrgn.
     */
    void subtract(const ExRegion& srcrgn);
    void subtract(const ExBox& box) {
        if (!box.empty())
            subtract(ExRegion(box));
    }
    /**
     * ExRegion::x_or(const ExRegion& srcrgn)
     * @srcrgn: another #ExRegion
     * Sets the area of @this to the exclusive-OR of the areas of @this and @srcrgn.
     * The resulting area is the set of pixels contained in one or the other of the two sources but not in both.
     */
    void x_or(const ExRegion& srcrgn);
    /**
     * ExRegion::empty()
     * Finds out if the #ExRegion is empty.
     * Returns: %TRUE if @region is empty.
     */
    bool empty() const { return (n_boxes == 0); }
    /**
     * ExRegion::equal(const ExRegion& rgn)
     * Finds out if the two regions are the same.
     * Returns: %TRUE if @this and @rgn are equal.
     */
    bool equal(const ExRegion& rgn) const;
    bool operator == (const ExRegion& rgn) const { return equal(rgn); }
    bool operator == (const ExBox& box) const { return (n_boxes == 1 && extent == box); }
    /**
     * ExRegion::contain(int16 x, int16 y)
     * @x: the x coordinate of a point
     * @y: the y coordinate of a point
     * Finds out if a point is in a region.
     * Returns: %TRUE if the point is in @region.
     */
    bool contain(int16 x, int16 y) const;
    /**
     * ExRegion::contain(const ExBox& box)
     * @box: a #ExBox.
     * Tests whether a rectangle is within a region.
     * Returns: %Ex_OverlapIn, %Ex_OverlapOut, or %Ex_OverlapPart,
     *   depending on whether the rectangle is inside, outside,
     *   or partly inside the #ExRegion, respectively.
     */
    ExOverlap contain(const ExBox& box) const;
    /**
     * ExRegion::enumSpansintersect()
     * @spans: an array of #ExSpan
     * @n_spans: the length of @spans
     * @sorted: %TRUE if @spans is sorted wrt. the y coordinate
     * @spanfunc: function to call on each span in the intersection
     * @data: data to pass to @function
     * Calls a function on each span in the intersection of @this and @spans.
     */
    void enumSpansintersect(const ExSpan* spans,
                            int           n_spans,
                            bool          sorted,
                            ExSpanFunc    spanfunc,
                            void*         data);
};

inline void ExRegion:: x_or(const ExRegion& srcrgn) {
    ExRegion tmprgn(srcrgn);
    tmprgn.subtract(*this);
    this->subtract(srcrgn);
    this->combine(tmprgn);
}

#endif//__exregion_h__
