/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "excairo.h"
#include <assert.h>

ExCairo::~ExCairo() {
    cairo_restore(canvas->cr);
}

ExCairo::ExCairo(const ExCanvas* canvas, const ExRegion* damage) : canvas(canvas) {
    cairo_save(canvas->cr);
    set_region(damage);
    cairo_clip(canvas->cr);
}

void ExCairo::set_region(const ExRegion* srcrgn) {
    cairo_t* cr = canvas->cr;
    //cairo_reset_clip(cr); // tbd
    assert(!srcrgn->empty());
    if (srcrgn->empty()) {
        dprint("srcrgn empty\n");
        cairo_rectangle(cr,
                        -1, -1, 1, 1);
        return;
    }
    for (int i = 0; i < srcrgn->n_boxes; i++) {
        cairo_rectangle(cr,
                        (double)srcrgn->boxes[i].u.ul.x,
                        (double)srcrgn->boxes[i].u.ul.y,
                        (double)srcrgn->boxes[i].width(),
                        (double)srcrgn->boxes[i].height());
    }
    // usage-1: paint
    //      cairo_save(cr);
    //      set_region(rgn);
    //      cairo_clip(cr); // all clipped out
    //      cairo_set_source...(cr, ...);
    //      cairo_paint(cr);
    //      cairo_restore(cr);
    // usage-2: fill
    //      cairo_save(cr);
    //      set_region(cr, rgn);
    //      cairo_set_source...(cr, ...);
    //      cairo_fill(cr);
    //      cairo_clip(cr); // all clipped out
    //      cairo_restore(cr);
    // should call "cairo_restore(cr);" at application side
}

void ExCairo::fill_rect_rgba(const Rect& r, const Color& c) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgba(cr, c.r, c.g, c.b, c.a);
    cairo_rectangle(cr, r.x, r.y, r.w, r.h);
    cairo_fill(cr);
}

void ExCairo::fill_rect_rgba(double x, double y, double w, double h, const Color& c) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgba(cr, c.r, c.g, c.b, c.a);
    cairo_rectangle(cr, x, y, w, h);
    cairo_fill(cr);
}

#ifdef WIN32
void // static
ExCairo::ucs2_extent(cairo_t* cr, cairo_font_face_t* crf, double size,
                     const UCS2* ucs2, cairo_text_extents_t* te) {
    cairo_set_font_face(cr, crf);
    cairo_set_font_size(cr, size);
    cairo_ucs2_extents(cr, ucs2, te);
}
#endif
void // static
ExCairo::text_extent(cairo_t* cr, cairo_font_face_t* crf, double size,
                     const char* utf8, cairo_text_extents_t* te) {
    cairo_set_font_face(cr, crf);
    cairo_set_font_size(cr, size);
    cairo_text_extents(cr, utf8, te);
}

ExCairo::Point // static
ExCairo::text_align(const cairo_font_extents_t& fe, const cairo_text_extents_t& te, const Rect& r, int align) {
    Point p;
    switch (align & 0x3) {
        case Center: p.x = r.x + (r.w - te.width) / 2.f; break;
        case Right: p.x = r.x + r.w - te.width; break;
        default: p.x = r.x;
    }
    switch (align & (0x3 << 2)) {
        case VCenter: p.y = r.y + (r.h + fe.height) / 2.f; break;
        case Bottom: p.y = r.y + r.h; break;
        default: p.y = r.y + fe.height;
    }
    p.x -= te.x_bearing;
    p.y -= fe.descent;
    return p;
}

#ifdef WIN32
ExCairo::Point
ExCairo::ucs2_align(const UCS2* ucs2, const Rect& r, int align) {
    cairo_t* cr = canvas->cr;
    cairo_text_extents_t te;
    cairo_ucs2_extents(cr, ucs2, &te);
    return text_align(canvas->fe, te, r, align);
}
#endif
ExCairo::Point
ExCairo::text_align(const char* utf8, const Rect& r, int align) {
    cairo_t* cr = canvas->cr;
    cairo_text_extents_t te;
    cairo_text_extents(cr, utf8, &te);
    return text_align(canvas->fe, te, r, align);
}

#ifdef WIN32
void ExCairo::show_ucs2(const UCS2* ucs2, const Color& c, const Rect& r, int align) {
    cairo_t* cr = canvas->cr;
    ExCairo::Point p(ucs2_align(ucs2, r, align));
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_ucs2(cr, ucs2);
}
#endif
void ExCairo::show_text(const char* utf8, const Color& c, const Rect& r, int align) {
    cairo_t* cr = canvas->cr;
    ExCairo::Point p(text_align(utf8, r, align));
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_text(cr, utf8);
}

#ifdef WIN32
void ExCairo::show_ucs2(const UCS2* ucs2, const Color& c, const Point& p) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_ucs2(cr, ucs2);
}
#endif
void ExCairo::show_text(const char* utf8, const Color& c, const Point& p) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_text(cr, utf8);
}

#ifdef WIN32
void ExCairo::show_ucs2(const UCS2* ucs2, double r, double g, double b, double x, double y) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, r, g, b);
    cairo_move_to(cr, x, y);
    cairo_show_ucs2(cr, ucs2);
}
#endif
void ExCairo::show_text(const char* utf8, double r, double g, double b, double x, double y) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, r, g, b);
    cairo_move_to(cr, x, y);
    cairo_show_text(cr, utf8);
}

void ExCairo::set_font(cairo_font_face_t* font, double size) {
    cairo_t* cr = canvas->cr;
    cairo_set_font_face(cr, font);
    cairo_set_font_size(cr, size);
    cairo_font_extents(cr, &canvas->fe);
}

#if defined(EXAPITEST)
void
excairo_apitest()
{
}
#endif
