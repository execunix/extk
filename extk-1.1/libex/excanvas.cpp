/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <excanvas.h>
#include <exwindow.h>
#include <ft2build.h>
#include <cairo-ft.h>
#include FT_FREETYPE_H

static FT_Library ftLib;
static FT_Face ftFace[8];

static int refcnt = 0; // tbd
cairo_font_face_t* ExCanvas::crf[8];

// class ExCanvas
//
ExCanvas::~ExCanvas() {
    deleteMemGC();
    refcnt--;
    if (refcnt == 0) {
        for (int i = 0; i < 8; i++) {
            if (ftFace[i])
                FT_Done_Face(ftFace[i]);
            if (crf[i])
                cairo_font_face_destroy(crf[i]);
            ftFace[i] = NULL;
            crf[i] = NULL;
        }
    }
}

ExCanvas::ExCanvas()
    : ExObject()
    , wnd(NULL)
    , gc(NULL)
    , dc(NULL)
    , cr(NULL) {
    if (refcnt == 0) {
        for (int i = 0; i < 8; i++) {
            ftFace[i] = NULL;
            crf[i] = NULL;
        }
    }
    refcnt++;
}

int ExCanvas::init(ExWindow* window, ExSize* sz) {
    wnd = window;
    wnd->canvas = this;
    if (ftLib == NULL &&
        FT_Init_FreeType(&ftLib))
        dprint1(L"FT_Init_FreeType fail.");
    if (sz == NULL)
        sz = window ? &wnd->area.size : &ExApp::smSize;
    return createMemGC(sz->w, sz->h);
}

int ExCanvas::resize(int w, int h) {
    deleteMemGC();
    return createMemGC(w, h);
}

// create cairo font
int ExCanvas::newFace(int id, const char* faceName) {
    if (!(0 <= id && id < 8 && crf[id] == NULL)) {
        dprint1(L"%s(%d) invalid id", __funcw__, id);
        return -1;
    }
    if (ftLib != NULL &&
        FT_New_Face(ftLib, faceName, 0, &ftFace[id]) != FT_Err_Ok) {
        dprint1(L"%s(%d) FT_New_Face fail", __funcw__, id);
        return -1;
    }
    crf[id] = cairo_ft_font_face_create_for_ft_face(ftFace[id], FT_LOAD_DEFAULT | FT_LOAD_NO_BITMAP);
    if (crf[id] == NULL) {
        dprint1(L"%s(%d) FT_New_Face fail", __funcw__, id);
        return -1;
    }
    return 0;
}

int ExCanvas::setFont(int id, int size) {
    if (!(0 <= id && id < 8 && crf[id]))
        return -1;
    cairo_set_font_face(cr, crf[id]);
    cairo_set_font_size(cr, size);
    return 0;
}

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

void ExCanvas::setRegion(const ExRegion* srcrgn) {
    //cairo_reset_clip(cr); // tbd
    assert(!srcrgn->empty());
    if (srcrgn->empty()) {
        dprintf(L"srcrgn empty\n");
        cairo_rectangle(cr,
            -1, -1, 1, 1);
        return;
    }
    for (int i = 0; i < srcrgn->n_rects; i++) {
        cairo_rectangle(cr,
            srcrgn->rects[i].ul.x,
            srcrgn->rects[i].ul.y,
            srcrgn->rects[i].width(),
            srcrgn->rects[i].height());
    }
    // usage-1: paint
    //	cairo_save(cr);
    //	canvas->setRegion(rgn);
    //	cairo_clip(cr); // all clipped out
    //	cairo_set_source...(cr, ...);
    //	cairo_paint(cr);
    //	cairo_restore(cr);
    // usage-2: fill
    //	cairo_save(cr);
    //	set_region(cr, rgn);
    //	cairo_set_source...(cr, ...);
    //	cairo_fill(cr);
    //	cairo_clip(cr); // all clipped out
    //	cairo_restore(cr);
    // should call "cairo_restore(cr);" at application side
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

