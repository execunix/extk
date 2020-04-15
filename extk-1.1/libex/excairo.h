/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excairo_h__
#define __excairo_h__

#include <cairo.h>
#include <exconf.h>
#include <exgeomet.h>

// float divide 8bit value
#define FD8V(v) ((v) / 255.f)

class ExCairo {
public:
    struct Color {
        floatt a, r, g, b;

        Color() {}
        Color(floatt f) : a(f), r(f), g(f), b(f) {}
        Color(floatt r, floatt g, floatt b) : a(0.f), r(r), g(g), b(b) {}
        Color(floatt r, floatt g, floatt b, floatt a) : a(a), r(r), g(g), b(b) {}

        void set(floatt r, floatt g, floatt b) {
            this->r = r; this->g = g; this->b = b;
        }
        void set(floatt r, floatt g, floatt b, floatt a) {
            this->r = r; this->g = g; this->b = b; this->a = a;
        }
        void setv(uint8 r, uint8 g, uint8 b) {
            this->r = FD8V(r); this->g = FD8V(g); this->b = FD8V(b);
        }
        void setv(uint8 r, uint8 g, uint8 b, uint8 a) {
            this->r = FD8V(r); this->g = FD8V(g); this->b = FD8V(b); this->a = FD8V(a);
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
        floatt l, t, r, b;

        Rect() {}
        Rect(ExRect rc) : l((floatt)rc.l), t((floatt)rc.t), r((floatt)rc.r), b((floatt)rc.b) {}
        Rect(int l, int t, int r, int b) : l((floatt)l), t((floatt)t), r((floatt)r), b((floatt)b) {}
        Rect(floatt l, floatt t, floatt r, floatt b) : l(l), t(t), r(r), b(b) {}

        floatt width() const { return r - l; }
        floatt height() const { return b - t; }

        void set(ExRect rc) {
            this->l = (floatt)rc.l; this->t = (floatt)rc.t; this->r = (floatt)rc.r; this->b = (floatt)rc.b;
        }
        void set(int l, int t, int r, int b) {
            this->l = (floatt)l; this->t = (floatt)t; this->r = (floatt)r; this->b = (floatt)b;
        }
        void set(floatt l, floatt t, floatt r, floatt b) {
            this->l = l; this->t = t; this->r = r; this->b = b;
        }
    };

protected:
    cairo_t* cr;
public:
    ~ExCairo() {}
    ExCairo() {}
};

#endif//__excairo_h__
