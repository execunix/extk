/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excairo_h__
#define __excairo_h__

#include "excanvas.h"
#include "exgeomet.h"

#ifdef WIN32
// float-32 divide 8bit value
#define FD8V(v) ((v) / 255.f)
#else // compat linux
// float-64 divide 8bit value
#define FD8V(v) ((v) / 255.)
#endif

#pragma pack(push, 1)

class ExCairo {
public:
    struct Color {
        double a, r, g, b;

        Color() {}
        Color(double f) : a(f), r(f), g(f), b(f) {}
        Color(double r, double g, double b) : a(1.), r(r), g(g), b(b) {}
        Color(double r, double g, double b, double a) : a(a), r(r), g(g), b(b) {}

        void set(double r, double g, double b) {
            this->r = r; this->g = g; this->b = b; this->a = 1.;
        }
        void set(double r, double g, double b, double a) {
            this->r = r; this->g = g; this->b = b; this->a = a;
        }
        void setv(uint8 r, uint8 g, uint8 b) {
            this->r = FD8V(r); this->g = FD8V(g); this->b = FD8V(b); this->a = 1.;
        }
        void setv(uint8 r, uint8 g, uint8 b, uint8 a) {
            this->r = FD8V(r); this->g = FD8V(g); this->b = FD8V(b); this->a = FD8V(a);
        }
        void setv(uint32 rgb) {
            setv(rgb >> 16, rgb >> 8, rgb);
        }
    };

    struct Point {
        double x, y;

        Point() {}
        Point(double f) : x(f), y(f) {}
        Point(double x, double y) : x(x), y(y) {}
        Point(int x, int y) : x((double)x), y((double)y) {}

        void set(double x, double y) { this->x = x; this->y = y; }
        void set(int x, int y) { this->x = (double)x; this->y = (double)y; }
    };

    struct Size {
        double w, h;

        Size() {}
        Size(double f) : w(f), h(f) {}
        Size(double w, double h) : w(w), h(h) {}
        Size(int w, int h) : w((double)w), h((double)h) {}

        void set(double w, double h) { this->w = w; this->h = h; }
        void set(int w, int h) { this->w = (double)w; this->h = (double)h; }
    };

    struct Rect {
        union {
            struct { double x, y, w, h; };
            struct { Point pt; Size sz; } u;
        };

        Rect() {}
        Rect(ExRect rc) : x((double)rc.x), y((double)rc.y), w((double)rc.w), h((double)rc.h) {}
        Rect(int x, int y, int w, int h) : x((double)x), y((double)y), w((double)w), h((double)h) {}
        Rect(double x, double y, double w, double h) : x(x), y(y), w(w), h(h) {}

        void set(ExRect rc) {
            this->x = (double)rc.x; this->y = (double)rc.y; this->w = (double)rc.w; this->h = (double)rc.h;
        }
        void set(int x, int y, int w, int h) {
            this->x = (double)x; this->y = (double)y; this->w = (double)w; this->h = (double)h;
        }
        void set(double x, double y, double w, double h) {
            this->x = x; this->y = y; this->w = w; this->h = h;
        }
        Point p2() const { return Point(x + w, y + h); }
    };

    struct Box {
        union {
            struct { double l, t, r, b; };
            struct { Point p1, p2; } u;
        };

        Box() {}
        Box(ExBox bx) : l((double)bx.l), t((double)bx.t), r((double)bx.r), b((double)bx.b) {}
        Box(int l, int t, int r, int b) : l((double)l), t((double)t), r((double)r), b((double)b) {}
        Box(double l, double t, double r, double b) : l(l), t(t), r(r), b(b) {}

        double width() const { return r - l; }
        double height() const { return b - t; }

        void set(ExBox bx) {
            this->l = (double)bx.l; this->t = (double)bx.t; this->r = (double)bx.r; this->b = (double)bx.b;
        }
        void set(int l, int t, int r, int b) {
            this->l = (double)l; this->t = (double)t; this->r = (double)r; this->b = (double)b;
        }
        void set(double l, double t, double r, double b) {
            this->l = l; this->t = t; this->r = r; this->b = b;
        }
    };

protected:
    const ExCanvas* const canvas;
    void set_region(const ExRegion* srcrgn);
public:
    ~ExCairo();
    ExCairo(const ExCanvas* canvas, const ExRegion* damage);
public:
    operator cairo_t* const () const { return canvas->cr; }
    void fill_rect_rgba(const Rect& r, const Color& c);
    void fill_rect_rgba(double x, double y, double w, double h, const Color& c);

#ifdef WIN32
    static void ucs2_extent(cairo_t* cr, cairo_font_face_t* crf, double size,
                            const UCS2* ucs2, cairo_text_extents_t* te);
#endif
    static void text_extent(cairo_t* cr, cairo_font_face_t* crf, double size,
                            const char* utf8, cairo_text_extents_t* te);

    enum {
        Left    = 1 << 0,
        Right   = 2 << 0,
        Center  = 0 << 0,
        Top     = 1 << 2,
        Bottom  = 2 << 2,
        VCenter = 0 << 2,
    };
    static Point text_align(const cairo_font_extents_t& fe, const cairo_text_extents_t& te,
                            const Rect& r, int align = 0);

#ifdef WIN32
    Point ucs2_align(const UCS2* ucs2, const Rect& r, int align = 0);
#endif
    Point text_align(const char* utf8, const Rect& r, int align = 0);

#ifdef WIN32
    void show_ucs2(const UCS2* ucs2, const Color& c, const Rect& r, int align = 0);
#endif
    void show_text(const char* utf8, const Color& c, const Rect& r, int align = 0);

#ifdef WIN32
    void show_ucs2(const UCS2* ucs2, const Color& c, const Point& p);
#endif
    void show_text(const char* utf8, const Color& c, const Point& p);

#ifdef WIN32
    void show_ucs2(const UCS2* ucs2, double r, double g, double b, double x, double y);
#endif
    void show_text(const char* utf8, double r, double g, double b, double x, double y);

    void set_font(cairo_font_face_t* font, double size);
};

#pragma pack(pop)

#endif//__excairo_h__
