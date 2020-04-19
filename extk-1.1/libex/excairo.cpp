/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <excairo.h>

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
        dprintf(L"srcrgn empty\n");
        cairo_rectangle(cr,
                        -1, -1, 1, 1);
        return;
    }
    for (int i = 0; i < srcrgn->n_rects; i++) {
        cairo_rectangle(cr,
                        (floatt)srcrgn->rects[i].ul.x,
                        (floatt)srcrgn->rects[i].ul.y,
                        (floatt)srcrgn->rects[i].width(),
                        (floatt)srcrgn->rects[i].height());
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
    cairo_rectangle(cr, r.l, r.t, r.width(), r.height());
    cairo_fill(cr);
}

void ExCairo::fill_rect_rgba(floatt x, floatt y, floatt w, floatt h, const Color& c) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgba(cr, c.r, c.g, c.b, c.a);
    cairo_rectangle(cr, x, y, w, h);
    cairo_fill(cr);
}

void ExCairo::text_extent(const ExCanvas* canvas, uint id, floatt size, const wchar* ucs2, cairo_text_extents_t* ext) {
    cairo_t* cr = canvas->cr;
    cairo_set_font_face(cr, canvas->crf[id]);
    cairo_set_font_size(cr, size);
    cairo_text_extents(cr, ucs2, ext);
}

ExCairo::Point ExCairo::text_align(const cairo_text_extents_t& ext, const Rect& r, int align) {
    Point p;
    switch (align & 0x3) {
        case Center: p.x = r.l + (r.width() - ext.width) / 2.f; break;
        case Right: p.x = r.r - ext.width; break;
        default: p.x = r.l;
    }
    switch (align & (0x3 << 2)) {
        case VCenter: p.y = r.t + (r.height() - ext.height) / 2.f; break;
        case Bottom: p.y = r.b - ext.height; break;
        default: p.y = r.t;
    }
    p.x -= ext.x_bearing;
    p.y -= ext.y_bearing;
    return p;
}

ExCairo::Point ExCairo::text_align(const wchar* ucs2, const Rect& r, int align) {
    cairo_t* cr = canvas->cr;
    cairo_text_extents_t extents;
    cairo_text_extents(cr, ucs2, &extents);
    return text_align(extents, r, align);
}

void ExCairo::show_text(const wchar* ucs2, const Color& c, const Rect& r, int align) {
    cairo_t* cr = canvas->cr;
    ExCairo::Point p = text_align(ucs2, r, align);
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_text(cr, ucs2);
}

void ExCairo::show_text(const wchar* ucs2, const Color& c, const Point& p) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, c.r, c.g, c.b);
    cairo_move_to(cr, p.x, p.y);
    cairo_show_text(cr, ucs2);
}

void ExCairo::show_text(const wchar* ucs2, floatt r, floatt g, floatt b, floatt x, floatt y) {
    cairo_t* cr = canvas->cr;
    cairo_set_source_rgb(cr, r, g, b);
    cairo_move_to(cr, x, y);
    cairo_show_text(cr, ucs2);
}

void ExCairo::set_font(cairo_font_face_t* font, floatt size) {
    cairo_t* cr = canvas->cr;
    cairo_set_font_face(cr, font);
    cairo_set_font_size(cr, size);
}

void
excairo_apitest()
{
}
