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

// ExArea
//
struct ExArea {
    union {
        struct { int x, y, w, h; }; // x, y, width, height
        struct { ExPoint pos; ExSize size; };
    };

    ExArea() {}
    ExArea(int i) : x(i), y(i), w(i), h(i) {}
    ExArea(int x, int y, int w, int h) : x(x), y(y), w(w), h(h) {}
    ExArea(const ExPoint& pt, const ExSize& sz) : x(pt.x), y(pt.y), w(sz.w), h(sz.h) {}
    ExArea(const ExArea& ar) : x(ar.x), y(ar.y), w(ar.w), h(ar.h) {}
    ExArea(const ExRect& rc);// : x(rc.l), y(rc.t), w(rc.r - rc.l), h(rc.b - rc.t) {}
    ExArea(const RECT& rc) : x(rc.left), y(rc.top), w(rc.right - rc.left), h(rc.bottom - rc.top) {}
    ExArea& operator = (const ExArea& ar) { x = ar.x; y = ar.y; w = ar.w; h = ar.h; return *this; }
    ExArea& operator = (const ExRect& rc);
    ExArea& operator = (const RECT& rc);

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
    bool equal(int x, int y, int w, int h) const { return operator == (ExArea(x, y, w, h)); }
    bool operator == (const ExArea& ar) const { return (x == ar.x && y == ar.y && w == ar.w && h == ar.h); }
    bool operator != (const ExArea& ar) const { return (x != ar.x || y != ar.y || w != ar.w || h != ar.h); }
    operator RECT* () const { return (RECT*)this; }
    RECT& ToArea(RECT& rc) const { rc.left = x; rc.top = y; rc.right = w; rc.bottom = h; return rc; }
    RECT ToArea() const { RECT rc; rc.left = x; rc.top = y; rc.right = w; rc.bottom = h; return rc; }
    RECT& ToRect(RECT& rc) const { rc.left = x; rc.top = y; rc.right = x + w; rc.bottom = y + h; return rc; }
    RECT ToRect() const { RECT rc; rc.left = x; rc.top = y; rc.right = x + w; rc.bottom = y + h; return rc; }

    bool contain(const ExPoint& pt) const;
    bool contain(const ExArea& ar) const;
    bool contain(int x, int y) const { return contain(ExPoint(x, y)); }
    bool contain(int x, int y, int w, int h) const;
};

// ExRect
//
struct ExRect {
    union {
        struct { int l, t, r, b; }; // left, top, right, bottom
        struct { ExPoint ul, lr; }; // upper-left corner, lower-right corner
        struct { int x1, y1, x2, y2; }; // box segment for clip region
    };

    ExRect() {}
    ExRect(int i) : l(i), t(i), r(i), b(i) {}
    ExRect(int l, int t, int r, int b) : l(l), t(t), r(r), b(b) {}
    ExRect(const ExPoint& ul, const ExPoint& lr) : l(ul.x), t(ul.y), r(lr.x), b(lr.y) {}
    ExRect(const ExArea& ar) : l(ar.x), t(ar.y), r(ar.right()), b(ar.bottom()) {}
    ExRect(const ExRect& rc) : l(rc.l), t(rc.t), r(rc.r), b(rc.b) {}
    ExRect(const RECT& rc) : l(rc.left), t(rc.top), r(rc.right), b(rc.bottom) {}
    ExRect& operator = (const ExRect& rc) { l = rc.l; t = rc.t; r = rc.r; b = rc.b; return *this; }
    ExRect& operator = (const ExArea& ar);
    ExRect& operator = (const RECT& rc);

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
    bool equal(int l, int t, int r, int b) const { return operator == (ExRect(l, t, r, b)); }
    bool operator == (const ExRect& rc) const { return (l == rc.l && t == rc.t && r == rc.r && b == rc.b); }
    bool operator != (const ExRect& rc) const { return (l != rc.l || t != rc.t || r != rc.r || b != rc.b); }
    pixman_box32_t* box32() const { return (pixman_box32_t*)this; }
    operator RECT* () const { return (RECT*)this; }
    RECT& ToArea(RECT& rc) const { rc.left = l; rc.top = t; rc.right = r - l; rc.bottom = b - t; return rc; }
    RECT ToArea() const { RECT rc; rc.left = l; rc.top = t; rc.right = r - l; rc.bottom = b - t; return rc; }
    RECT& ToRect(RECT& rc) const { rc.left = l; rc.top = t; rc.right = r; rc.bottom = b; return rc; }
    RECT ToRect() const { RECT rc; rc.left = l; rc.top = t; rc.right = r; rc.bottom = b; return rc; }

    bool contain(const ExPoint& pt) const;
    bool contain(const ExRect& rc) const;
    bool contain(int x, int y) const { return contain(ExPoint(x, y)); }
    bool contain(int l, int t, int r, int b) const { return contain(ExRect(l, t, r, b)); }
    static bool isIntersect(const ExRect& r1, const ExRect& r2);
    bool intersect(const ExRect& rc);
    bool intersect(const ExRect& r1, const ExRect& r2);
    bool intersect(int l, int t, int r, int b) {
        return intersect(ExRect(l, t, r, b));
    }
    void join(const ExRect& rc);
    void join(int l, int t, int r, int b) {
        join(ExRect(l, t, r, b));
    }
};

// area & rect cross assign operators (also copy constructors)
//
inline
ExArea::ExArea(const ExRect& rc)
    : x(rc.l)
    , y(rc.t)
    , w(rc.r - rc.l)
    , h(rc.b - rc.t) {}

inline ExArea&
ExArea::operator = (const ExRect& rc) {
    x = rc.l;
    y = rc.t;
    w = rc.r - rc.l;
    h = rc.b - rc.t;
    return *this;
}

inline ExRect&
ExRect::operator = (const ExArea& ar) {
    l = ar.x;
    t = ar.y;
    r = ar.x + ar.w;
    b = ar.y + ar.h;
    return *this;
}

inline ExArea&
ExArea::operator = (const RECT& rc) {
    x = rc.left;
    y = rc.top;
    w = rc.right - rc.left;
    h = rc.bottom - rc.top;
    return *this;
}

inline ExRect&
ExRect::operator = (const RECT& rc) {
    l = rc.left;
    t = rc.top;
    r = rc.right;
    b = rc.bottom;
    return *this;
}

// rect & area op funcs
//
inline bool
ExRect::contain(const ExPoint& pt) const {
    return ((uint)(pt.x - l) < (uint)(r - l) &&
            (uint)(pt.y - t) < (uint)(b - t));
}

inline bool
ExArea::contain(const ExPoint& pt) const {
    return ((uint)(pt.x - x) < (uint)w &&
            (uint)(pt.y - y) < (uint)h);
}

inline bool
ExRect::contain(const ExRect& rc) const {
    return (!rc.empty() && !empty() &&
            l <= rc.l && t <= rc.t &&
            r >= rc.r && b >= rc.b);
}

inline bool
ExArea::contain(const ExArea& ar) const {
    return ExRect(*this).contain(ExRect(ar));
}

inline bool
ExArea::contain(int x, int y, int w, int h) const {
    return ExRect(*this).contain(x, y, x + w, y + h);
}

// contain point funcs
//
#if 1 // deprecated
inline bool
ExContainPoint(int left, int top, int right, int bottom, int x, int y) {
    return ExRect(left, top, right, bottom).contain(x, y);
}

inline bool
ExContainPoint(const RECT& rc, const POINT& pt) {
    return ExRect(rc).contain(ExPoint(pt));
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
    ExRect rect;
    ExTile* next;

    ExTile() {}
    ExTile(const ExArea& ar) : rect(ar), next(NULL) {}
    ExTile(const ExRect& rc) : rect(rc), next(NULL) {}
    // tbd
};

#endif//__exgeomet_h__
