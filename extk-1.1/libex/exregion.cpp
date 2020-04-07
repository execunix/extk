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

HRGN
ExRegionToGdi(HDC hdc, const ExRegion* srcrgn)
{
	if (srcrgn->empty())
		return NULL;
	HRGN hrgn = CreateRectRgnIndirect(srcrgn->rects[0]);
	for (int i = 1; i < srcrgn->n_rects; i++) {
		HRGN tmp_rgn = CreateRectRgnIndirect(srcrgn->rects[i]);
		CombineRgn(hrgn, hrgn, tmp_rgn, RGN_OR);
		DeleteObject(tmp_rgn);
	}
	SelectClipRgn(hdc, hrgn);
	return hrgn;
}

Bool
ExRegionToCairo(cairo_t* cr, const ExRegion* srcrgn)
{
	if (srcrgn->empty())
		return FALSE;
//	cairo_save(cr);
//	cairo_clip(cr); // all clipped out
	cairo_reset_clip(cr); // ?
	cairo_rectangle(cr,
		srcrgn->rects[0].ul.x,
		srcrgn->rects[0].ul.y,
		srcrgn->rects[0].width(),
		srcrgn->rects[0].height());
//	cairo_clip(cr); // ?
	for (int i = 1; i < srcrgn->n_rects; i++) {
		cairo_rectangle(cr,
			srcrgn->rects[i].ul.x,
			srcrgn->rects[i].ul.y,
			srcrgn->rects[i].width(),
			srcrgn->rects[i].height());
//		cairo_clip(cr);
	}
	// should call "cairo_restore(cr);" at application side
	return TRUE;
}

Bool
ExRegionToPixman(pixman_region32_t* prgn, const ExRegion* srcrgn)
{
	if (srcrgn->empty())
		return FALSE;
	// ExRect box segment are compatible with pixman_box32 { int32_t x1, y1, x2, y2; }
//	pixman_box32_t* boxes = srcrgn->rects->box32();
//	pixman_bool_t r = pixman_region32_init_rects(prgn, boxes, srcrgn->n_rects);
	pixman_bool_t r = pixman_region32_init_rects(prgn, srcrgn->rects->box32(), srcrgn->n_rects);
	return r;
}

