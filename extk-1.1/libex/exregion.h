/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exregion_h__
#define __exregion_h__

#include <exgeomet.h>
#include <exmemory.h>

#ifndef Bool
#define Bool int
#endif

#ifndef False
#define False (0)
#endif

#ifndef True
#define True (!False)
#endif

#undef  ABS
#define ABS(a)                  (((a) < 0) ? -(a) : (a))

#undef  MAX
#define MAX(a, b)               (((a) > (b)) ? (a) : (b))

#undef  MIN
#define MIN(a, b)               (((a) < (b)) ? (a) : (b))

#undef  CLAMP
#define CLAMP(x, low, high)     (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

enum ExFillRule
{
	Ex_EvenOddRule,
	Ex_WindingRule,
};

enum ExOverlap
{
	Ex_OverlapIn,				// rectangle is in region
	Ex_OverlapOut,				// rectangle in not in region
	Ex_OverlapPart,				// rectangle in partially in region
};

typedef void (*ExSpanFunc) (ExSpan* span, void* data);

ExRegion* ExRegionNew           (void);
ExRegion* ExRegionRect          (const ExRect* rect);
ExRegion* ExRegionCopy          (const ExRegion* srcrgn);
ExRegion* ExRegionPolygon       (const ExPoint* pts, int n_pts, ExFillRule fillrule);
void      ExRegionDestroy       (ExRegion* region);
void      ExRegionGetClipRect   (const ExRegion* region, ExRect* rect);
void      ExRegionGetRects      (const ExRegion* region, ExRect** rects, int* n_rects);

Bool      ExRegionIsEmpty       (const ExRegion* region);
Bool      ExRegionIsEqual       (const ExRegion* rgn1, const ExRegion* rgn2);
Bool      ExRegionIsPointIn     (const ExRegion* region, int x, int y);
ExOverlap ExRegionIsRectIn      (const ExRegion* region, const ExRect* rect);

void      ExRegionOffset        (ExRegion* region, int dx, int dy);
void      ExRegionShrink        (ExRegion* region, int dx, int dy);
void      ExRegionUnionWithRect (ExRegion* dstrgn, const ExRect* rect);
void      ExRegionUnion         (ExRegion* dstrgn, const ExRegion* srcrgn);
void      ExRegionIntersect     (ExRegion* dstrgn, const ExRegion* srcrgn);
void      ExRegionSubtract      (ExRegion* dstrgn, const ExRegion* srcrgn);
void      ExRegionXor           (ExRegion* dstrgn, const ExRegion* srcrgn);

void ExRegionSpansIntersectForeach (ExRegion* region, const ExSpan* spans, int n_spans,
									Bool sorted, ExSpanFunc spanfunc, void* data);

/////////////////////////////////////////////////////////////////////////////
// ExRegion : clip region

#ifndef __cplusplus
typedef struct _Region {
	short size;
	short n_rects;
	ExRect* rects;
	ExRect extent;
} ExRegion;
#else
struct ExRegion
{
	short size;
	short n_rects;
	ExRect* rects;
	ExRect extent;

	~ExRegion() { if (rects != &extent) free(rects); }
    explicit ExRegion() : size(1), n_rects(0), rects(&extent), extent(0, 0, 0, 0) {}
    explicit ExRegion(int size); // reserve rects
	explicit ExRegion(const ExRect& rect) : size(1), n_rects(1), rects(&extent), extent(rect) {}
	explicit ExRegion(const ExRegion& srcrgn) : size(1), n_rects(0), rects(&extent) { copy(srcrgn); }
	ExRegion& operator = (const ExRegion& srcrgn) { copy(srcrgn); return *this; }
//	operator int () { return n_rects; }

    void init0() { size = 1; n_rects = 0; rects = &extent; /*extent.init0();*/ }
	void clear() { if (rects != &extent) free(rects); init0(); }
	void getClipRect(ExRect& rect) { rect = extent; }
	void getRects(ExRect** rects, int* n_rects) { ExRegionGetRects(this, rects, n_rects); }
	void setEmpty() { n_rects = 0; /*extent.init0();*/ }
	void setRect(const ExRect& rect);
	void copy(const ExRegion& srcrgn);
	void offset(int dx, int dy) { ExRegionOffset(this, dx, dy); }
	void shrink(int dx, int dy) { ExRegionShrink(this, dx, dy); }
	void offset(const ExPoint& pt) { ExRegionOffset(this, pt.x, pt.y); }
	void shrink(const ExPoint& pt) { ExRegionShrink(this, pt.x, pt.y); }
	void intersect(const ExRegion& srcrgn) { ExRegionIntersect(this, &srcrgn); }
	void intersect(const ExRect& rect) { rect.empty() ? setEmpty() : intersect(ExRegion(rect)); }
	void subtract(const ExRegion& srcrgn) { ExRegionSubtract(this, &srcrgn); }
	void subtract(const ExRect& rect) { if (!rect.empty()) subtract(ExRegion(rect)); }
	void combine(const ExRegion& srcrgn) { ExRegionUnion(this, &srcrgn); }
	void combine(const ExRect& rect) { if (!rect.empty()) combine(ExRegion(rect)); }
	void xor(const ExRegion& srcrgn);
	bool empty() const { return (n_rects == 0); }
	bool equal(const ExRegion& rgn) const { return (ExRegionIsEqual(this, &rgn) == TRUE); }
	bool operator == (const ExRegion& rgn) const { return (ExRegionIsEqual(this, &rgn) == TRUE); }
	bool operator == (const ExRect& rect) const { return (n_rects == 1 && extent == rect); }
	Bool      contain(int x, int y)       const { return ExRegionIsPointIn(this, x, y); }
	ExOverlap contain(const ExRect& rect) const { return ExRegionIsRectIn(this, &rect); }
};

inline void
ExRegion::setRect(const ExRect& rect)
{
	if (rect.empty()) {
		setEmpty();
	} else {
		n_rects = 1;
		extent = rect;
		if (rects != &extent)
			rects[0] = rect;
	}
}

inline void
ExRegion::copy(const ExRegion& srcrgn)
{
	if (this != &srcrgn) {
		if (size < srcrgn.n_rects) {
			if (rects != &extent)
				free(rects);
#if 1 // TBD
			size = (((srcrgn.n_rects-1)>>2)+1)<<2;
			rects = (ExRect*)malloc(sizeof(ExRect) * size);
#else
			rects = (ExRect*)malloc(sizeof(ExRect) * srcrgn.n_rects);
			size = srcrgn.n_rects;
#endif
		}
		n_rects = srcrgn.n_rects;
		extent = srcrgn.extent;
		if (rects != &extent)
			memcpy(rects, srcrgn.rects, srcrgn.n_rects*sizeof(ExRect));
	}
}

inline void
ExRegion::xor(const ExRegion& srcrgn)
{
	ExRegion tmprgn(srcrgn);
	tmprgn.subtract(*this);
	this->subtract(srcrgn);
	this->combine(tmprgn);
}
#endif//__cplusplus

#endif//__exregion_h__
