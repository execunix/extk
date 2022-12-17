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
        floatt a, r, g, b;

        Color() {}
        Color(floatt f) : a(f), r(f), g(f), b(f) {}
        Color(floatt r, floatt g, floatt b) : a(0.), r(r), g(g), b(b) {}
        Color(floatt r, floatt g, floatt b, floatt a) : a(a), r(r), g(g), b(b) {}

        void set(floatt r, floatt g, floatt b) {
            this->r = r; this->g = g; this->b = b; this->a = 1.;
        }
        void set(floatt r, floatt g, floatt b, floatt a) {
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
        floatt x, y;

        Point() {}
        Point(floatt f) : x(f), y(f) {}
        Point(floatt x, floatt y) : x(x), y(y) {}
        Point(int x, int y) : x((floatt)x), y((floatt)y) {}

        void set(floatt x, floatt y) { this->x = x; this->y = y; }
        void set(int x, int y) { this->x = (floatt)x; this->y = (floatt)y; }
    };

    struct Size {
        floatt w, h;

        Size() {}
        Size(floatt f) : w(f), h(f) {}
        Size(floatt w, floatt h) : w(w), h(h) {}
        Size(int w, int h) : w((floatt)w), h((floatt)h) {}

        void set(floatt w, floatt h) { this->w = w; this->h = h; }
        void set(int w, int h) { this->w = (floatt)w; this->h = (floatt)h; }
    };

    struct Rect {
        union {
            struct { floatt x, y, w, h; };
            struct { Point pt; Size sz; } u;
        };

        Rect() {}
        Rect(ExRect rc) : x((floatt)rc.x), y((floatt)rc.y), w((floatt)rc.w), h((floatt)rc.h) {}
        Rect(int x, int y, int w, int h) : x((floatt)x), y((floatt)y), w((floatt)w), h((floatt)h) {}
        Rect(floatt x, floatt y, floatt w, floatt h) : x(x), y(y), w(w), h(h) {}

        void set(ExRect rc) {
            this->x = (floatt)rc.x; this->y = (floatt)rc.y; this->w = (floatt)rc.w; this->h = (floatt)rc.h;
        }
        void set(int x, int y, int w, int h) {
            this->x = (floatt)x; this->y = (floatt)y; this->w = (floatt)w; this->h = (floatt)h;
        }
        void set(floatt x, floatt y, floatt w, floatt h) {
            this->x = x; this->y = y; this->w = w; this->h = h;
        }
        Point p2() const { return Point(x + w, y + h); }
    };

    struct Box {
        union {
            struct { floatt l, t, r, b; };
            struct { Point p1, p2; } u;
        };

        Box() {}
        Box(ExBox bx) : l((floatt)bx.l), t((floatt)bx.t), r((floatt)bx.r), b((floatt)bx.b) {}
        Box(int l, int t, int r, int b) : l((floatt)l), t((floatt)t), r((floatt)r), b((floatt)b) {}
        Box(floatt l, floatt t, floatt r, floatt b) : l(l), t(t), r(r), b(b) {}

        floatt width() const { return r - l; }
        floatt height() const { return b - t; }

        void set(ExBox bx) {
            this->l = (floatt)bx.l; this->t = (floatt)bx.t; this->r = (floatt)bx.r; this->b = (floatt)bx.b;
        }
        void set(int l, int t, int r, int b) {
            this->l = (floatt)l; this->t = (floatt)t; this->r = (floatt)r; this->b = (floatt)b;
        }
        void set(floatt l, floatt t, floatt r, floatt b) {
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
    void fill_rect_rgba(floatt x, floatt y, floatt w, floatt h, const Color& c);

#ifdef WIN32
    static void text_extent(cairo_t* cr, cairo_font_face_t* crf, floatt size,
                            const wchar* wcs, cairo_text_extents_t* te);
#endif
#ifdef __linux__
    static void text_extent(cairo_t* cr, cairo_font_face_t* crf, floatt size,
                            const char* utf8, cairo_text_extents_t* te);
#endif

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
    Point text_align(const wchar* wcs, const Rect& r, int align = 0);
#endif
#ifdef __linux__
    Point text_align(const char* utf8, const Rect& r, int align = 0);
#endif

#ifdef WIN32
    void show_text(const wchar* wcs, const Color& c, const Rect& r, int align = 0);
#endif
#ifdef __linux__
    void show_text(const char* utf8, const Color& c, const Rect& r, int align = 0);
#endif

#ifdef WIN32
    void show_text(const wchar* wcs, const Color& c, const Point& p);
#endif
#ifdef __linux__
    void show_text(const char* utf8, const Color& c, const Point& p);
#endif

#ifdef WIN32
    void show_text(const wchar* wcs, floatt r, floatt g, floatt b, floatt x, floatt y);
#endif
#ifdef __linux__
    void show_text(const char* utf8, floatt r, floatt g, floatt b, floatt x, floatt y);
#endif

    void set_font(cairo_font_face_t* font, floatt size);
};

#pragma pack(pop)

#endif//__excairo_h__
