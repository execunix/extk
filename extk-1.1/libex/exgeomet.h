/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exgeomet_h__
#define __exgeomet_h__

#include <extypes.h>

// ExPoint
//
struct ExPoint {
    int16 x, y;

    ExPoint() {}
    ExPoint(int16 i) : x(i), y(i) {}
    ExPoint(int16 x, int16 y) : x(x), y(y) {}
    ExPoint(const ExPoint& pt) : x(pt.x), y(pt.y) {}
    ExPoint& operator = (const ExPoint& pt) { x = pt.x; y = pt.y; return *this; }
#ifdef WIN32
    ExPoint(const POINT& pt) : x((int16)pt.x), y((int16)pt.y) {}
    ExPoint& operator = (const POINT& pt) { x = (int16)pt.x; y = (int16)pt.y; return *this; }
#endif

    void rotccw(ExPoint* dst) const { int16 t = x; dst->x = y; dst->y = -t; }
    void rotcw(ExPoint* dst) const { int16 t = x; dst->x = -y; dst->y = t; }
    void rotccw() { this->rotccw(this); }
    void rotcw() { this->rotcw(this); }
    void neg() { x = -x; y = -y; }
    void set(int16 x, int16 y) { this->x = x; this->y = y; }
    bool equal(int16 x, int16 y) const { return (this->x == x && this->y == y); }
    bool operator == (const ExPoint& pt) const { return (x == pt.x && y == pt.y); }
    bool operator != (const ExPoint& pt) const { return (x != pt.x || y != pt.y); }
    ExPoint& operator += (const ExPoint& pt) { x += pt.x; y += pt.y; return *this; }
    ExPoint& operator -= (const ExPoint& pt) { x -= pt.x; y -= pt.y; return *this; }
    ExPoint operator + (const ExPoint& pt) const { return ExPoint(x + pt.x, y + pt.y); }
    ExPoint operator - (const ExPoint& pt) const { return ExPoint(x - pt.x, y - pt.y); }
    ExPoint operator - () const { return ExPoint(-x, -y); }
    ExPoint& operator += (const ExSize& sz); // reasonable
    ExPoint& operator -= (const ExSize& sz); // reasonable

    static int dotProduct(const ExPoint& p1, const ExPoint& p2) {
        return p1.x * p2.x + p1.y * p2.y;
    }
    static int crossPruduct(const ExPoint& p1, const ExPoint& p2) {
        return p1.x * p2.y - p1.y * p2.x;
    }
};

inline ExPoint
operator * (const ExPoint& pt, int16 i) {
    return ExPoint(pt.x * i, pt.y * i);
}

inline ExPoint
operator / (const ExPoint& pt, int16 i) {
    return ExPoint(pt.x / i, pt.y / i); // permit devide by 0 exception
}

// ExSize
//
struct ExSize {
    int16 w, h;

    ExSize() {}
    ExSize(int16 i) : w(i), h(i) {}
    ExSize(int16 w, int16 h) : w(w), h(h) {}
    ExSize(const ExSize& sz) : w(sz.w), h(sz.h) {}
    ExSize& operator = (const ExSize& sz) { w = sz.w; h = sz.h; return *this; }
#ifdef WIN32
    ExSize(const SIZE& sz) : w((int16)sz.cx), h((int16)sz.cy) {}
    ExSize& operator = (const SIZE& sz) { w = (int16)sz.cx; h = (int16)sz.cy; return *this; }
#endif

    void clamp() { if (w < 0) w = 0; if (h < 0) h = 0; }
    void set(int16 w, int16 h) { this->w = w; this->h = h; }
    bool zero() const { return (this->w == 0 && this->h == 0); }
    bool empty() const { return (this->w <= 0 || this->h <= 0); }
    bool equal(int16 w, int16 h) const { return (this->w == w && this->h == h); }
    bool operator == (const ExSize& sz) const { return (w == sz.w && h == sz.h); }
    bool operator != (const ExSize& sz) const { return (w != sz.w || h != sz.h); }
    ExSize& operator += (const ExSize& sz) { w += sz.w; h += sz.h; return *this; }
    ExSize& operator -= (const ExSize& sz) { w -= sz.w; h -= sz.h; return *this; }
    ExSize operator + (const ExSize& sz) { return ExSize(w + sz.w, h + sz.h); }
    ExSize operator - (const ExSize& sz) { return ExSize(w - sz.w, h - sz.h); }
    ExSize& operator += (const ExPoint& pt); // unreasonable
    ExSize& operator -= (const ExPoint& pt); // unreasonable
};

inline ExSize
operator * (const ExSize& sz, int16 i) {
    return ExSize(sz.w * i, sz.h * i); // permit negative size
}

inline ExSize
operator / (const ExSize& sz, int16 i) {
    return ExSize(sz.w / i, sz.h / i); // permit devide by 0 exception
}

inline ExPoint
operator + (const ExPoint& pt, const ExSize& sz) {
    return ExPoint(pt.x + sz.w, pt.y + sz.h); // reasonable
}

inline ExPoint
operator - (const ExPoint& pt, const ExSize& sz) {
    return ExPoint(pt.x - sz.w, pt.y - sz.h); // reasonable
}

inline ExSize
operator + (const ExSize& sz, const ExPoint& pt) {
    return ExSize(sz.w + pt.x, sz.h + pt.y); // unreasonable - permit negative size
}

inline ExSize
operator - (const ExSize& sz, const ExPoint& pt) {
    return ExSize(sz.w - pt.x, sz.h - pt.y); // unreasonable - permit negative size
}

inline ExPoint&
ExPoint::operator += (const ExSize& sz) {
    this->x += sz.w;
    this->y += sz.h;
    return *this; // reasonable
}

inline ExPoint&
ExPoint::operator -= (const ExSize& sz) {
    this->x -= sz.w;
    this->y -= sz.h;
    return *this; // reasonable
}

inline ExSize&
ExSize::operator += (const ExPoint& pt) {
    this->w += pt.x;
    this->h += pt.y;
    return *this; // unreasonable - permit negative size
}

inline ExSize&
ExSize::operator -= (const ExPoint& pt) {
    this->w -= pt.x;
    this->h -= pt.y;
    return *this; // unreasonable - permit negative size
}

// ExRect
//
struct ExRect {
    union {
        struct { int16 x, y, w, h; }; // x, y, width, height
        struct { ExPoint pt; ExSize sz; };
    };

    ExRect() {}
    ExRect(int16 i) : x(i), y(i), w(i), h(i) {}
    ExRect(int16 x, int16 y, int16 w, int16 h) : x(x), y(y), w(w), h(h) {}
    ExRect(const ExPoint& pt, const ExSize& sz) : x(pt.x), y(pt.y), w(sz.w), h(sz.h) {}
    ExRect(const ExRect& rc) : x(rc.x), y(rc.y), w(rc.w), h(rc.h) {}
    ExRect(const ExBox& bx);
    ExRect& operator = (const ExRect& rc) { x = rc.x; y = rc.y; w = rc.w; h = rc.h; return *this; }
    ExRect& operator = (const ExBox& bx);
#ifdef WIN32
    ExRect(const RECT& rc);
    ExRect& operator = (const RECT& rc);
#endif

    int16 left() const { return x; }
    int16 top() const { return y; }
    int16 right() const { return x + w; }
    int16 bottom() const { return y + h; }
    int16 width() const { return w; }
    int16 height() const { return h; }
    ExPoint center() const { return ExPoint(x + w / 2, y + h / 2); }
    void center(int16* px, int16* py) const { *px = (x + w / 2); *py = (y + h / 2); }
    void center(ExPoint& pt) const { center(&pt.x, &pt.y); }
    void offset(int16 l, int16 t, int16 r, int16 b) { x += l; y += t; w += (r - l); h += (b - t); }
    void inset(int16 dx, int16 dy) { x += dx; y += dy; w -= dx * 2; h -= dy * 2; } // should check valid
    void inset(const ExPoint& pt) { inset(pt.x, pt.y); }
    void move(int16 dx, int16 dy) { x += dx; y += dy; }
    void move(const ExPoint& pt) { move(pt.x, pt.y); }
    void init0() { x = y = w = h = 0; }
    void set(int16 x, int16 y, int16 w, int16 h) { this->x = x; this->y = y; this->w = w; this->h = h; }
    void set(const ExPoint& pt, const ExSize& sz) { x = pt.x; y = pt.y; w = sz.w; h = sz.h; }
    bool valid() const { return (0 < w && 0 < h); }
    bool empty() const { return !valid(); }
    bool equal(int16 x, int16 y, int16 w, int16 h) const { return operator == (ExRect(x, y, w, h)); }
    bool operator == (const ExRect& rc) const { return (x == rc.x && y == rc.y && w == rc.w && h == rc.h); }
    bool operator != (const ExRect& rc) const { return (x != rc.x || y != rc.y || w != rc.w || h != rc.h); }

    bool contain(const ExPoint& pt) const;
    bool contain(const ExRect& rc) const;
    bool contain(int16 x, int16 y) const { return contain(ExPoint(x, y)); }
    bool contain(int16 x, int16 y, int16 w, int16 h) const;
};

// ExBox
//
struct ExBox {
    union {
        struct { int16 x1, y1, x2, y2; }; // box segment for clip region
        struct { int16 l, t, r, b; }; // left, top, right, bottom
        struct { ExPoint ul, lr; }; // upper-left corner, lower-right corner
    };

    ExBox() {}
    ExBox(int16 i) : l(i), t(i), r(i), b(i) {}
    ExBox(int16 l, int16 t, int16 r, int16 b) : l(l), t(t), r(r), b(b) {}
    ExBox(const ExPoint& ul, const ExPoint& lr) : l(ul.x), t(ul.y), r(lr.x), b(lr.y) {}
    ExBox(const ExRect& rc) : l(rc.x), t(rc.y), r(rc.right()), b(rc.bottom()) {}
    ExBox(const ExBox& bx) : l(bx.l), t(bx.t), r(bx.r), b(bx.b) {}
    ExBox& operator = (const ExBox& bx) { l = bx.l; t = bx.t; r = bx.r; b = bx.b; return *this; }
    ExBox& operator = (const ExRect& rc);
#ifdef WIN32
    ExBox(const RECT& rc);
    ExBox& operator = (const RECT& rc);
#endif

    int16 left() const { return l; }
    int16 top() const { return t; }
    int16 right() const { return r; }
    int16 bottom() const { return b; }
    int16 width() const { return r - l; }
    int16 height() const { return b - t; }
    ExSize size() const { return ExSize(r - l, b - t); }
    ExPoint center() const { return ExPoint((l + r) / 2, (t + b) / 2); }
    void center(int16* px, int16* py) const { *px = (l + r) / 2; *py = (t + b) / 2; }
    void center(ExPoint& pt) const { center(&pt.x, &pt.y); }
    void offset(int16 l, int16 t, int16 r, int16 b) { x1 += l; y1 += t; x2 += r; y2 += b; }
    void inset(int16 dx, int16 dy) { l += dx; t += dy; r -= dx; b -= dy; } // should check valid or sort
    void inset(const ExPoint& pt) { inset(pt.x, pt.y); }
    void move(int16 dx, int16 dy) { l += dx; t += dy; r += dx; b += dy; }
    void move(const ExPoint& pt) { move(pt.x, pt.y); }
    void init0() { l = t = r = b = 0; }
    void sort() { if (l > r) exswap<int16>(l, r); if (t > b) exswap<int16>(t, b); }
    void set(int16 l, int16 t, int16 r, int16 b) { this->l = l; this->t = t; this->r = r; this->b = b; }
    void set(const ExPoint& ul, const ExPoint& lr) { l = ul.x; t = ul.y; r = lr.x; b = lr.y; }
    bool valid() const { return (l < r && t < b); }
    bool empty() const { return !valid(); }
    bool equal(int16 l, int16 t, int16 r, int16 b) const { return operator == (ExBox(l, t, r, b)); }
    bool operator == (const ExBox& bx) const { return (l == bx.l && t == bx.t && r == bx.r && b == bx.b); }
    bool operator != (const ExBox& bx) const { return (l != bx.l || t != bx.t || r != bx.r || b != bx.b); }

    bool contain(const ExPoint& pt) const;
    bool contain(const ExBox& bx) const;
    bool contain(int16 x, int16 y) const { return contain(ExPoint(x, y)); }
    bool contain(int16 l, int16 t, int16 r, int16 b) const { return contain(ExBox(l, t, r, b)); }
    static bool isIntersect(const ExBox& b1, const ExBox& b2);
    bool intersect(const ExBox& bx);
    bool intersect(const ExBox& b1, const ExBox& b2);
    bool intersect(int16 l, int16 t, int16 r, int16 b) {
        return intersect(ExBox(l, t, r, b));
    }
    void join(const ExBox& bx);
    void join(int16 l, int16 t, int16 r, int16 b) {
        join(ExBox(l, t, r, b));
    }
};

// rect & box cross assign operators (also copy constructors)
//
inline
ExRect::ExRect(const ExBox& bx)
    : x(bx.l)
    , y(bx.t)
    , w(bx.r - bx.l)
    , h(bx.b - bx.t) {}

inline ExRect&
ExRect::operator = (const ExBox& bx) {
    x = bx.l;
    y = bx.t;
    w = bx.r - bx.l;
    h = bx.b - bx.t;
    return *this;
}

inline ExBox&
ExBox::operator = (const ExRect& rc) {
    l = rc.x;
    t = rc.y;
    r = rc.x + rc.w;
    b = rc.y + rc.h;
    return *this;
}

#ifdef WIN32
inline
ExRect::ExRect(const RECT& rc)
    : x((int16)rc.left)
    , y((int16)rc.top)
    , w((int16)(rc.right - rc.left))
    , h((int16)(rc.bottom - rc.top)) {}

inline
ExBox::ExBox(const RECT& rc)
    : l((int16)rc.left)
    , t((int16)rc.top)
    , r((int16)rc.right)
    , b((int16)rc.bottom) {}

inline ExRect&
ExRect::operator = (const RECT& rc) {
    x = (uint16)rc.left;
    y = (uint16)rc.top;
    w = (uint16)(rc.right - rc.left);
    h = (uint16)(rc.bottom - rc.top);
    return *this;
}

inline ExBox&
ExBox::operator = (const RECT& rc) {
    l = (uint16)rc.left;
    t = (uint16)rc.top;
    r = (uint16)rc.right;
    b = (uint16)rc.bottom;
    return *this;
}
#endif

// rect & box op funcs
//
inline bool
ExBox::contain(const ExPoint& pt) const {
    return ((uint)(pt.x - l) < (uint)(r - l) &&
            (uint)(pt.y - t) < (uint)(b - t));
}

inline bool
ExRect::contain(const ExPoint& pt) const {
    return ((uint)(pt.x - x) < (uint)w &&
            (uint)(pt.y - y) < (uint)h);
}

inline bool
ExBox::contain(const ExBox& bx) const {
    return (!bx.empty() && !empty() &&
            l <= bx.l && t <= bx.t &&
            r >= bx.r && b >= bx.b);
}

inline bool
ExRect::contain(const ExRect& rc) const {
    return ExBox(*this).contain(ExBox(rc));
}

inline bool
ExRect::contain(int16 x, int16 y, int16 w, int16 h) const {
    return ExBox(*this).contain(x, y, x + w, y + h);
}

// contain point funcs
//
#if 0 // deprecated
inline bool
ExContainPoint(int16 left, int16 top, int16 right, int16 bottom, int16 x, int16 y) {
    return ExBox(left, top, right, bottom).contain(x, y);
}

#ifdef WIN32
inline bool
ExContainPoint(const RECT& rc, const POINT& pt) {
    return ExBox(rc).contain(ExPoint(pt));
}
#endif
#endif

// ExArc
//
struct ExArc {
    int16 x, y;
    uint16 w, h;
    int16 angle1, angle2;

    ExArc() {}
    ExArc(short x, short y) : x(x), y(y), w(0), h(0), angle1(0), angle2(0) {}
    // tbd
};

// ExSpan
//
struct ExSpan {
    int16 x, y, w;

    ExSpan() {}
    ExSpan(int16 x, int16 y, int16 w) : x(x), y(y), w(w) {}
    // tbd
};

// ExTile
//
struct ExTile {
    ExBox box;
    ExTile* next;

    ExTile() {}
    ExTile(const ExRect& rc) : box(rc), next(NULL) {}
    ExTile(const ExBox& bx) : box(bx), next(NULL) {}
    // tbd
};

#endif//__exgeomet_h__
