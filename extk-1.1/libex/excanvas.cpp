/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exapp.h"
#include "excanvas.h"
#include "exwindow.h"
#include <ft2build.h>
#include <cairo-ft.h>
#include FT_FREETYPE_H
#include <assert.h>

//static FT_Library ftLib;
//static FT_Face ftFace[8];
//
//static int refcnt = 0; // tbd
//cairo_font_face_t* ExCanvas::crf[8];

// class ExCanvas
//
ExCanvas::~ExCanvas() {
    deleteMemGC();
    //refcnt--;
    //if (refcnt == 0) {
    //    for (int i = 0; i < 8; i++) {
    //        if (ftFace[i])
    //            FT_Done_Face(ftFace[i]);
    //        if (crf[i])
    //            cairo_font_face_destroy(crf[i]);
    //        ftFace[i] = NULL;
    //        crf[i] = NULL;
    //    }
    //}
}

ExCanvas::ExCanvas()
    : ExObject()
    , wnd(NULL)
    , gc(NULL)
    , dc(NULL)
    , cr(NULL) {
    //if (refcnt == 0) {
    //    for (int i = 0; i < 8; i++) {
    //        ftFace[i] = NULL;
    //        crf[i] = NULL;
    //    }
    //}
    //refcnt++;
}

int ExCanvas::init(ExWindow* window) {
    ExSize sz = window ? window->area.u.sz : ExApp::smSize;
    return init(window, sz);
}

int ExCanvas::init(ExWindow* window, ExSize sz) {
    wnd = window;
    wnd->canvas = this;
    //if (ftLib == NULL &&
    //    FT_Init_FreeType(&ftLib))
    //    dprint1("FT_Init_FreeType fail.");
    return createMemGC(sz.w, sz.h);
}

int ExCanvas::resize(int w, int h) {
    deleteMemGC();
    return createMemGC(w, h);
}

#if 0
// create cairo font
int ExCanvas::newFace(uint fontId, const char* faceName) {
    if (!(fontId < 8 && crf[fontId] == NULL)) {
        dprint1("%s(%d) invalid fontId", __func__, fontId);
        return -1;
    }
    if (ftLib != NULL &&
        FT_New_Face(ftLib, faceName, 0, &ftFace[fontId]) != FT_Err_Ok) {
        dprint1("%s(%d) FT_New_Face fail", __func__, fontId);
        return -1;
    }
    crf[fontId] = cairo_ft_font_face_create_for_ft_face(ftFace[fontId], FT_LOAD_DEFAULT | FT_LOAD_NO_BITMAP);
    if (crf[fontId] == NULL) {
        dprint1("%s(%d) FT_New_Face fail", __func__, fontId);
        return -1;
    }
    return 0;
}
#endif

int ExCanvas::deleteMemGC() {
    if (cr) {
        cairo_destroy(cr);
        cr = NULL;
    }
    if (gc) {
        delete gc;
        gc = NULL;
    }
    return 0;
}

int ExCanvas::createMemGC(int width, int height) {
    deleteMemGC();
    gc = ExImage::create(width, height, Ex_IMAGE_DIRECT_8888);
    if (!gc) {
        dprint1("%s(%d,%d) %s\n", __func__, width, height, "ExImage::create fail");
        return -1;
    }
    cairo_status_t status;
    cairo_format_t format = CAIRO_FORMAT_ARGB32;
    int stride = cairo_format_stride_for_width(format, gc->width);
    gc->crs = cairo_image_surface_create_for_data(
        gc->bits, format, gc->width, gc->height, stride);
    assert(stride == gc->bpl);
    //static const cairo_user_data_key_t key;
    //cairo_surface_set_user_data(gc->crs, &key, gc->bits, (cairo_destroy_func_t)free);
    //cairo_content_t crc_image = cairo_surface_get_content(gc->crs);
    //assert(crc_image == CAIRO_CONTENT_COLOR_ALPHA);
    status = cairo_surface_status(gc->crs);
    if (status == CAIRO_STATUS_SUCCESS) {
        cr = cairo_create(gc->crs);
        status = cairo_status(cr);
    }
    cairo_surface_destroy(gc->crs); // unref
    if (status == CAIRO_STATUS_SUCCESS) {
        wnd->damage(); // tbd
        return 0;
    }
    dprint1("%s(%d,%d) %s\n", __func__, width, height, cairo_status_to_string(status));
    deleteMemGC();
    return -1;
}

void ExCanvas::text_extent(cairo_font_face_t* crf, floatt size, const wchar* ucs2, cairo_text_extents_t* ext) {
    cairo_set_font_face(cr, crf);
    cairo_set_font_size(cr, size);
    cairo_text_extents(cr, ucs2, ext);
}

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
    for (int i = 1; i < srcrgn->n_boxes; i++) {
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

