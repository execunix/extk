/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exgeomet_h__
#define __exgeomet_h__

#include <extype.h>

// ExPoint
//
struct ExPoint {
    int x, y;

    ExPoint() {}
    ExPoint(int i) : x(i), y(i) {}
    ExPoint(int x, int y) : x(x), y(y) {}
    ExPoint(const POINT& pt) : x(pt.x), y(pt.y) {}
    ExPoint(const ExPoint& pt) : x(pt.x), y(pt.y) {}
    ExPoint& operator = (const POINT& pt) { x = pt.x; y = pt.y; return *this; }
    ExPoint& operator = (const ExPoint& pt) { x = pt.x; y = pt.y; return *this; }

    void rotccw(ExPoint* dst) const { int t = x; dst->x = y; dst->y = -t; }
    void rotcw(ExPoint* dst) const { int t = x; dst->x = -y; dst->y = t; }
    void rotccw() { this->rotccw(this); }
    void rotcw() { this->rotcw(this); }
    void neg() { x = -x; y = -y; }
    void set(int x, int y) { this->x = x; this->y = y; }
    bool equal(int x, int y) const { return (this->x == x && this->y == y); }
    bool operator == (const ExPoint& pt) const { return (x == pt.x && y == pt.y); }
    bool operator != (const ExPoint& pt) const { return (x != pt.x || y != pt.y); }
    ExPoint& operator += (const ExPoint& pt) { x += pt.x; y += pt.y; return *this; }
    ExPoint& operator -= (const ExPoint& pt) { x -= pt.x; y -= pt.y; return *this; }
    ExPoint& operator += (const POINT& pt) { x += pt.x; y += pt.y; return *this; }
    ExPoint& operator -= (const POINT& pt) { x -= pt.x; y -= pt.y; return *this; }
    ExPoint operator + (const ExPoint& pt) const { return ExPoint(x + pt.x, y + pt.y); }
    ExPoint operator - (const ExPoint& pt) const { return ExPoint(x - pt.x, y - pt.y); }
    ExPoint operator + (const POINT& pt) const { return ExPoint(x + pt.x, y + pt.y); }
    ExPoint operator - (const POINT& pt) const { return ExPoint(x - pt.x, y - pt.y); }
    ExPoint operator - () const { return ExPoint(-x, -y); }
    operator POINT () const { return *(POINT*)this; }
    ExPoint& operator += (const ExSize& sz); // reasonable
    ExPoint& operator -= (const ExSize& sz); // reasonable

    static int dotProduct(const ExPoint& p1, const ExPoint& p2) {
        return p1.x * p2.x + p1.y * p2.y;
    }
    static int crossPruduct(const ExPoint& p1, const ExPoint& p2) {
        return p1.x * p2.y - p1.y * p2.x;
    }
};

inline POINT
operator + (const POINT& p1, const ExPoint& p2) {
    POINT pt;
    pt.x = p1.x + p2.x;
    pt.y = p1.y + p2.y;
    return pt;
}

inline POINT
operator - (const POINT& p1, const ExPoint& p2) {
    POINT pt;
    pt.x = p1.x - p2.x;
    pt.y = p1.y - p2.y;
    return pt;
}

inline ExPoint
operator * (const ExPoint& pt, int i) {
    return ExPoint(pt.x * i, pt.y * i);
}

inline ExPoint
operator / (const ExPoint& pt, int i) {
    return ExPoint(pt.x / i, pt.y / i); // permit devide by 0 exception
}

// ExSize
//
struct ExSize {
    int w, h;

    ExSize() {}
    ExSize(int i) : w(i), h(i) {}
    ExSize(int w, int h) : w(w), h(h) {}
    ExSize(const SIZE& sz) : w(sz.cx), h(sz.cy) {}
    ExSize(const ExSize& sz) : w(sz.w), h(sz.h) {}
    ExSize& operator = (const SIZE& sz) { w = sz.cx; h = sz.cy; return *this; }
    ExSize& operator = (const ExSize& sz) { w = sz.w; h = sz.h; return *this; }

    void clamp() { if (w < 0) w = 0; if (h < 0) h = 0; }
    void set(int w, int h) { this->w = w; this->h = h; }
    bool zero() const { return (this->w == 0 && this->h == 0); }
    bool empty() const { return (this->w <= 0 || this->h <= 0); }
    bool equal(int w, int h) const { return (this->w == w && this->h == h); }
    bool operator == (const ExSize& sz) const { return (w == sz.w && h == sz.h); }
    bool operator != (const ExSize& sz) const { return (w != sz.w || h != sz.h); }
    ExSize& operator += (const ExSize& sz) { w += sz.w; h += sz.h; return *this; }
    ExSize& operator -= (const ExSize& sz) { w -= sz.w; h -= sz.h; return *this; }
    ExSize& operator += (const SIZE& sz) { w += sz.cx; h += sz.cy; return *this; }
    ExSize& operator -= (const SIZE& sz) { w -= sz.cx; h -= sz.cy; return *this; }
    ExSize operator + (const ExSize& sz) { return ExSize(w + sz.w, h + sz.h); }
    ExSize operator - (const ExSize& sz) { return ExSize(w - sz.w, h - sz.h); }
    ExSize operator + (const SIZE& sz) { return ExSize(w + sz.cx, h + sz.cy); }
    ExSize operator - (const SIZE& sz) { return ExSize(w - sz.cx, h - sz.cy); }
    operator SIZE () const { return *(SIZE*)this; }
    ExSize& operator += (const ExPoint& pt); // unreasonable
    ExSize& operator -= (const ExPoint& pt); // unreasonable
};

inline SIZE
operator + (const SIZE& s1, const ExSize& s2) {
    SIZE sz;
    sz.cx = s1.cx + s2.w;
    sz.cy = s1.cy + s2.h;
    return sz;
}

inline SIZE
operator - (const SIZE& s1, const ExSize& s2) {
    SIZE sz;
    sz.cx = s1.cx - s2.w;
    sz.cy = s1.cy - s2.h;
    return sz;
}

inline ExSize
operator * (const ExSize& sz, int i) {
    return ExSize(sz.w * i, sz.h * i); // permit negative size
}

inline ExSize
operator / (const ExSize& sz, int i) {
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
        struct { int x, y, w, h; }; // x, y, width, height
        struct { ExPoint pt; ExSize sz; };
    };

    ExRect() {}
    ExRect(int i) : x(i), y(i), w(i), h(i) {}
    ExRect(int x, int y, int w, int h) : x(x), y(y), w(w), h(h) {}
    ExRect(const ExPoint& pt, const ExSize& sz) : x(pt.x), y(pt.y), w(sz.w), h(sz.h) {}
    ExRect(const ExRect& rc) : x(rc.x), y(rc.y), w(rc.w), h(rc.h) {}
    ExRect(const ExBox& bx);// : x(bx.l), y(bx.t), w(bx.r - bx.l), h(bx.b - bx.t) {}
    ExRect(const RECT& rc) : x(rc.left), y(rc.top), w(rc.right - rc.left), h(rc.bottom - rc.top) {}
    ExRect& operator = (const ExRect& rc) { x = rc.x; y = rc.y; w = rc.w; h = rc.h; return *this; }
    ExRect& operator = (const ExBox& bx);
    ExRect& operator = (const RECT& rc);

    int left() const { return x; }
    int top() const { return y; }
    int right() const { return x + w; }
    int bottom() const { return y + h; }
    int width() const { return w; }
    int height() const { return h; }
    ExPoint center() const { return ExPoint(x + w / 2, y + h / 2); }
    void center(int* px, int* py) const { *px = (x + w / 2); *py = (y + h / 2); }
    void center(ExPoint& pt) const { center(&pt.x, &pt.y); }
    void offset(int l, int t, int r, int b) { x += l; y += t; w += (r - l); h += (b - t); }
    void inset(int dx, int dy) { x += dx; y += dy; w -= dx * 2; h -= dy * 2; } // should check valid
    void inset(const ExPoint& pt) { inset(pt.x, pt.y); }
    void move(int dx, int dy) { x += dx; y += dy; }
    void move(const ExPoint& pt) { move(pt.x, pt.y); }
    void init0() { x = y = w = h = 0; }
    void set(int x, int y, int w, int h) { this->x = x; this->y = y; this->w = w; this->h = h; }
    void set(const ExPoint& pt, const ExSize& sz) { x = pt.x; y = pt.y; w = sz.w; h = sz.h; }
    bool valid() const { return (0 < w && 0 < h); }
    bool empty() const { return !valid(); }
    bool equal(int x, int y, int w, int h) const { return operator == (ExRect(x, y, w, h)); }
    bool operator == (const ExRect& rc) const { return (x == rc.x && y == rc.y && w == rc.w && h == rc.h); }
    bool operator != (const ExRect& rc) const { return (x != rc.x || y != rc.y || w != rc.w || h != rc.h); }

    bool contain(const ExPoint& pt) const;
    bool contain(const ExRect& rc) const;
    bool contain(int x, int y) const { return contain(ExPoint(x, y)); }
    bool contain(int x, int y, int w, int h) const;
};

// ExBox
//
struct ExBox {
    union {
        struct { int l, t, r, b; }; // left, top, right, bottom
        struct { ExPoint ul, lr; }; // upper-left corner, lower-right corner
        struct { int x1, y1, x2, y2; }; // box segment for clip region
    };

    ExBox() {}
    ExBox(int i) : l(i), t(i), r(i), b(i) {}
    ExBox(int l, int t, int r, int b) : l(l), t(t), r(r), b(b) {}
    ExBox(const ExPoint& ul, const ExPoint& lr) : l(ul.x), t(ul.y), r(lr.x), b(lr.y) {}
    ExBox(const ExRect& rc) : l(rc.x), t(rc.y), r(rc.right()), b(rc.bottom()) {}
    ExBox(const ExBox& bx) : l(bx.l), t(bx.t), r(bx.r), b(bx.b) {}
    ExBox(const RECT& rc) : l(rc.left), t(rc.top), r(rc.right), b(rc.bottom) {}
    ExBox& operator = (const ExBox& bx) { l = bx.l; t = bx.t; r = bx.r; b = bx.b; return *this; }
    ExBox& operator = (const ExRect& rc);
    ExBox& operator = (const RECT& rc);

    int left() const { return l; }
    int top() const { return t; }
    int right() const { return r; }
    int bottom() const { return b; }
    int width() const { return r - l; }
    int height() const { return b - t; }
    ExSize size() const { return ExSize(r - l, b - t); }
    ExPoint center() const { return ExPoint((l + r) / 2, (t + b) / 2); }
    void center(int* px, int* py) const { *px = (l + r) / 2; *py = (t + b) / 2; }
    void center(ExPoint& pt) const { center(&pt.x, &pt.y); }
    void offset(int l, int t, int r, int b) { x1 += l; y1 += t; x2 += r; y2 += b; }
    void inset(int dx, int dy) { l += dx; t += dy; r -= dx; b -= dy; } // should check valid or sort
    void inset(const ExPoint& pt) { inset(pt.x, pt.y); }
    void move(int dx, int dy) { l += dx; t += dy; r += dx; b += dy; }
    void move(const ExPoint& pt) { move(pt.x, pt.y); }
    void init0() { l = t = r = b = 0; }
    void sort() { if (l > r) exswap<int>(l, r); if (t > b) exswap<int>(t, b); }
    void set(int l, int t, int r, int b) { this->l = l; this->t = t; this->r = r; this->b = b; }
    void set(const ExPoint& ul, const ExPoint& lr) { l = ul.x; t = ul.y; r = lr.x; b = lr.y; }
    bool valid() const { return (l < r && t < b); }
    bool empty() const { return !valid(); }
    bool equal(int l, int t, int r, int b) const { return operator == (ExBox(l, t, r, b)); }
    bool operator == (const ExBox& bx) const { return (l == bx.l && t == bx.t && r == bx.r && b == bx.b); }
    bool operator != (const ExBox& bx) const { return (l != bx.l || t != bx.t || r != bx.r || b != bx.b); }
    pixman_box32_t* box32() const { return (pixman_box32_t*)this; }

    bool contain(const ExPoint& pt) const;
    bool contain(const ExBox& bx) const;
    bool contain(int x, int y) const { return contain(ExPoint(x, y)); }
    bool contain(int l, int t, int r, int b) const { return contain(ExBox(l, t, r, b)); }
    static bool isIntersect(const ExBox& b1, const ExBox& b2);
    bool intersect(const ExBox& bx);
    bool intersect(const ExBox& b1, const ExBox& b2);
    bool intersect(int l, int t, int r, int b) {
        return intersect(ExBox(l, t, r, b));
    }
    void join(const ExBox& bx);
    void join(int l, int t, int r, int b) {
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

inline ExRect&
ExRect::operator = (const RECT& rc) {
    x = rc.left;
    y = rc.top;
    w = rc.right - rc.left;
    h = rc.bottom - rc.top;
    return *this;
}

inline ExBox&
ExBox::operator = (const RECT& rc) {
    l = rc.left;
    t = rc.top;
    r = rc.right;
    b = rc.bottom;
    return *this;
}

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
ExRect::contain(int x, int y, int w, int h) const {
    return ExBox(*this).contain(x, y, x + w, y + h);
}

// contain point funcs
//
#if 1 // deprecated
inline bool
ExContainPoint(int left, int top, int right, int bottom, int x, int y) {
    return ExBox(left, top, right, bottom).contain(x, y);
}

inline bool
ExContainPoint(const RECT& rc, const POINT& pt) {
    return ExBox(rc).contain(ExPoint(pt));
}
#endif

// ExArc
//
struct ExArc {
    short x, y;
    unsigned short w, h;
    short angle1, angle2;

    ExArc() {}
    ExArc(short x, short y) : x(x), y(y), w(0), h(0), angle1(0), angle2(0) {}
    // tbd
};

// ExSpan
//
struct ExSpan {
    int x, y, w;

    ExSpan() {}
    ExSpan(int x, int y, int w) : x(x), y(y), w(w) {}
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
