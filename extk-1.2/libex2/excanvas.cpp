/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "excanvas.h"
#include "exwindow.h"
#include <ft2build.h>
#include <cairo-ft.h>
#include "exapp.h"

// class ExCanvas
//
ExCanvas::~ExCanvas() {
    deleteMemGC();
}

ExCanvas::ExCanvas()
    : ExObject()
    , origin(0)
    , update()
    , opaque()
    , gc()
#ifdef WIN32
    , dc(NULL)
#endif
    , cr(NULL) {
    memset(&fe, 0, sizeof(fe));
}

bool ExCanvas::init(ExWidget* widget) {
    ExSize sz = (widget != nullptr) ? widget->area.u.sz : ExApp::smSize;
    return init(sz.w, sz.h);
}

bool ExCanvas::init(int32 w, int32 h) {
    //if (ftLib == NULL &&
    //    FT_Init_FreeType(&ftLib))
    //    dprint1("FT_Init_FreeType fail.");
    return createMemGC(w, h);
}

bool ExCanvas::resize(int32 w, int32 h) {
    deleteMemGC();
    return createMemGC(w, h);
}

void ExCanvas::deleteMemGC() {
    if (cr) {
        cairo_destroy(cr);
        cr = NULL;
    }
    gc.clear();
}

bool ExCanvas::createMemGC(int32 width, int32 height) {
    deleteMemGC();
    if (gc.init(width, height, Ex_IMAGE_DIRECT_8888) != true) {
        dprint1("%s(%d,%d) %s\n", _func_, width, height, "ExImage::create fail");
        return false;
    }
    cairo_status_t status;
    cairo_format_t format = CAIRO_FORMAT_ARGB32;
    int32 stride = cairo_format_stride_for_width(format, gc.width);
    gc.crs = cairo_image_surface_create_for_data(gc.bits, format, gc.width, gc.height, stride);
    exassert(stride == gc.bpl);
    //static const cairo_user_data_key_t key;
    //cairo_surface_set_user_data(gc.crs, &key, gc.bits, (cairo_destroy_func_t)free);
    //cairo_content_t crc_image = cairo_surface_get_content(gc.crs);
    //exassert(crc_image == CAIRO_CONTENT_COLOR_ALPHA);
    status = cairo_surface_status(gc.crs);
    if (status == CAIRO_STATUS_SUCCESS) {
        cr = cairo_create(gc.crs);
        status = cairo_status(cr);
    }
#ifdef WIN32x
    cairo_surface_destroy(gc.crs); // unref
#endif
    if (status == CAIRO_STATUS_SUCCESS) {
        update.combine(ExBox(0, 0, gc.width, gc.height)); // add gc box
        return true;
    }
    dprint1("%s(%d,%d) %s\n", _func_, width, height, cairo_status_to_string(status));
    deleteMemGC();
    return false;
}

#ifdef WIN32
ExTripleCanvas::~ExTripleCanvas() {
}

ExTripleCanvas::ExTripleCanvas()
    : ExCanvas() {
    gcBuf[0] = gcBuf[1] = gcBuf[2] = NULL;
    crBuf[0] = crBuf[1] = crBuf[2] = NULL;
}

HRGN
ExRegionToGdi(HDC hdc, const ExRegion* srcrgn)
{
    if (srcrgn->empty())
        return NULL;
#if 1
    RECT r;
    r.left = srcrgn->extent.l;
    r.top = srcrgn->extent.t;
    r.right = srcrgn->extent.r;
    r.bottom = srcrgn->extent.b;
    HRGN hrgn = CreateRectRgnIndirect(&r);
#else
    RECT r;
    r.left = srcrgn->boxes[0].l;
    r.top = srcrgn->boxes[0].t;
    r.right = srcrgn->boxes[0].r;
    r.bottom = srcrgn->boxes[0].b;
    HRGN hrgn = CreateRectRgnIndirect(&r);
    for (int32 i = 1; i < srcrgn->n_boxes; i++) {
        r.left = srcrgn->boxes[i].l;
        r.top = srcrgn->boxes[i].t;
        r.right = srcrgn->boxes[i].r;
        r.bottom = srcrgn->boxes[i].b;
        HRGN tmp_rgn = CreateRectRgnIndirect(&r);
        CombineRgn(hrgn, hrgn, tmp_rgn, RGN_OR);
        DeleteObject(tmp_rgn);
    }
#endif
    SelectClipRgn(hdc, hrgn);
    return hrgn;
}
#endif // WIN32
