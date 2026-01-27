/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "eximage.h"

// impl. no clip, no mask, support 32bpp only but fast

void ExImage::fillBoxAlphaEx(const ExBox* box, uint8 alpha, uint8 a_out)
{
    dprint("%s\n", __func__);
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.init0();
    }
    uint8* p = this->bits;
    int32 y = 0;
    for (; y < bx.t; y++) {
        uint8* p_end = p + this->bpl;
        for (; p < p_end; p += 4)
            p[3] = a_out;
    }
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.b; y++) {
        uint8* p_endl = p + rc_lx4;
        uint8* p_endr = p + rc_rx4;
        uint8* p_endw = p + this->bpl;
        for (; p < p_endl; p += 4)
            p[3] = a_out;
        for (; p < p_endr; p += 4)
            p[3] = alpha;
        for (; p < p_endw; p += 4)
            p[3] = a_out;
    }
    for (; y < this->height; y++) {
        uint8* p_end = p + this->bpl;
        for (; p < p_end; p += 4)
            p[3] = a_out;
    }
}

void ExImage::fillBoxAlpha(const ExBox* box, uint8 alpha)
{
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.l = 0;
        bx.t = 0;
        bx.r = this->width;
        bx.b = this->height;
    }
    int32 y = bx.t;
    uint8* p_y = this->bits + this->bpl * y;
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.b; y++) {
        uint8* p = p_y + rc_lx4;
        uint8* q = p_y + rc_rx4;
        for (; p < q; p += 4)
            p[3] = alpha;
        p_y += this->bpl;
    }
}

void ExImage::fillBoxRgbEx(const ExBox* box, uint32 rgb, uint32 rgb_out)
{
    dprint("%s\n", __func__);
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.init0();
    }
    uint8* p = this->bits;
    int32 y = 0;
    for (; y < bx.t; y++) {
        uint8* p_end = p + this->bpl;
        for (; p < p_end; p += 4)
            *(uint32*)p = (0xff000000 & *(uint32*)p) | rgb_out;
    }
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.b; y++) {
        uint8* p_endl = p + rc_lx4;
        uint8* p_endr = p + rc_rx4;
        uint8* p_endw = p + this->bpl;
        for (; p < p_endl; p += 4)
            *(uint32*)p = (0xff000000 & *(uint32*)p) | rgb_out;
        for (; p < p_endr; p += 4)
            *(uint32*)p = (0xff000000 & *(uint32*)p) | rgb;
        for (; p < p_endw; p += 4)
            *(uint32*)p = (0xff000000 & *(uint32*)p) | rgb_out;
    }
    for (; y < this->height; y++) {
        uint8* p_end = p + this->bpl;
        for (; p < p_end; p += 4)
            *(uint32*)p = (0xff000000 & *(uint32*)p) | rgb_out;
    }
}

void ExImage::fillBoxRgb(const ExBox* box, uint32 rgb)
{
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.l = 0;
        bx.t = 0;
        bx.r = this->width;
        bx.b = this->height;
    }
    int32 y = bx.t;
    uint8* p_y = this->bits + this->bpl * y;
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.b; y++) {
        uint8* p = p_y + rc_lx4;
        uint8* q = p_y + rc_rx4;
        for (; p < q; p += 4)
            *(uint32*)p = (0xff000000 & *(uint32*)p) | rgb;
        p_y += this->bpl;
    }
}

void ExImage::fillBoxEx(const ExBox* box, uint32 color, uint32 c_out)
{
    dprint("%s\n", __func__);
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.init0();
    }
    uint8* p = this->bits;
    int32 y = 0;
    for (; y < bx.t; y++) {
        uint8* p_end = p + this->bpl;
        for (; p < p_end; p += 4)
            *(uint32*)p = c_out;
    }
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.b; y++) {
        uint8* p_endl = p + rc_lx4;
        uint8* p_endr = p + rc_rx4;
        uint8* p_endw = p + this->bpl;
        for (; p < p_endl; p += 4)
            *(uint32*)p = c_out;
        for (; p < p_endr; p += 4)
            *(uint32*)p = color;
        for (; p < p_endw; p += 4)
            *(uint32*)p = c_out;
    }
    for (; y < this->height; y++) {
        uint8* p_end = p + this->bpl;
        for (; p < p_end; p += 4)
            *(uint32*)p = c_out;
    }
}

void ExImage::fillBox(const ExBox* box, uint32 color)
{
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.l = 0;
        bx.t = 0;
        bx.r = this->width;
        bx.b = this->height;
    }
    int32 y = bx.t;
    uint8* p_y = this->bits + this->bpl * y;
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.b; y++) {
        uint8* p = p_y + rc_lx4;
        uint8* q = p_y + rc_rx4;
        for (; p < q; p += 4)
            *(uint32*)p = color;
        p_y += this->bpl;
    }
}

void ExImage::drawBox(const ExBox* box, uint32 color)
{
    if (!(this->bits && this->bpp == 32))
        return;
    ExBox bx;
    if (box && box->valid()) {
        bx = *box;
        if (bx.l < 0)
            bx.l = 0;
        if (bx.t < 0)
            bx.t = 0;
        if (bx.r > this->width)
            bx.r = this->width;
        if (bx.b > this->height)
            bx.b = this->height;
    } else {
        bx.l = 0;
        bx.t = 0;
        bx.r = this->width;
        bx.b = this->height;
    }
    int32 y = bx.t;
    uint8* p_y = this->bits + this->bpl * y;
    int32 rc_lx4 = (int32)bx.l * 4;
    int32 rc_rx4 = (int32)bx.r * 4;
    for (; y < bx.t + 1; y++) {
        uint8* p = p_y + rc_lx4;
        uint8* q = p_y + rc_rx4;
        for (; p < q; p += 4)
            *(uint32*)p = color;
        p_y += this->bpl;
    }
    for (; y < bx.b - 1; y++) {
        uint8* p = p_y + rc_lx4;
        uint8* q = p_y + rc_rx4;
        *(uint32*)p = color;
        q -= 4;
        *(uint32*)q = color;
        p_y += this->bpl;
    }
    for (; y < bx.b; y++) {
        uint8* p = p_y + rc_lx4;
        uint8* q = p_y + rc_rx4;
        for (; p < q; p += 4)
            *(uint32*)p = color;
        p_y += this->bpl;
    }
}

void ExImage::Blit(ExImage* dstimg, int32 dx, int32 dy, int32 w, int32 h,
    const ExImage* srcimg, int32 sx, int32 sy)
{
    // tbd - clipping, masking, raster-op, bpp-mode-func-table...
    exassert(dstimg != srcimg && dstimg->bpp == 32 && srcimg->bpp == 32); // 32bpp only
    ExBox bx(dx - sx, dy - sy, srcimg->width + dx - sx, srcimg->height + dy - sy);
    if (!bx.intersect(0, 0, dstimg->width, dstimg->height))
        return;
    if (!bx.intersect(dx, dy, dx + w, dy + h))
        return;
    sx += bx.l - dx;
    sy += bx.t - dy;
    dx = bx.l;
    dy = bx.t;
    w = bx.width();
    h = bx.height();

    size_t spnext = srcimg->bpl - w * 4;
    size_t dpnext = dstimg->bpl - w * 4;
    uint8* sp = srcimg->bits + srcimg->bpl * sy + sx * 4;
    uint8* dp = dstimg->bits + dstimg->bpl * dy + dx * 4;
    while (h--) {
        int32 width = w;
        while (width--) {
            *(uint32*)dp = *(uint32*)sp;
            sp += 4;
            dp += 4;
        }
        sp += spnext;
        dp += dpnext;
    }
}

void ExImage::BlitRgb(ExImage* dstimg, int32 dx, int32 dy, int32 w, int32 h,
    const ExImage* srcimg, int32 sx, int32 sy)
{
    exassert(dstimg != srcimg && dstimg->bpp == 32 && srcimg->bpp == 32); // 32bpp only
    ExBox bx(dx - sx, dy - sy, srcimg->width + dx - sx, srcimg->height + dy - sy);
    if (!bx.intersect(0, 0, dstimg->width, dstimg->height))
        return;
    if (!bx.intersect(dx, dy, dx + w, dy + h))
        return;
    sx += bx.l - dx;
    sy += bx.t - dy;
    dx = bx.l;
    dy = bx.t;
    w = bx.width();
    h = bx.height();

    size_t spnext = srcimg->bpl - w * 4;
    size_t dpnext = dstimg->bpl - w * 4;
    uint8* sp = srcimg->bits + srcimg->bpl * sy + sx * 4;
    uint8* dp = dstimg->bits + dstimg->bpl * dy + dx * 4;
    while (h--) {
        int32 width = w;
        while (width--) {
            uint32 src = 0x00ffffff & *(uint32*)sp;
            uint32 dst = 0xff000000 & *(uint32*)dp;
            *(uint32*)dp = src | dst;
            sp += 4;
            dp += 4;
        }
        sp += spnext;
        dp += dpnext;
    }
}

void ExImage::BlitAlpha(ExImage* dstimg, int32 dx, int32 dy, int32 w, int32 h,
    const ExImage* srcimg, int32 sx, int32 sy)
{
    exassert(dstimg != srcimg && dstimg->bpp == 32 && srcimg->bpp == 32); // 32bpp only
    ExBox bx(dx - sx, dy - sy, srcimg->width + dx - sx, srcimg->height + dy - sy);
    if (!bx.intersect(0, 0, dstimg->width, dstimg->height))
        return;
    if (!bx.intersect(dx, dy, dx + w, dy + h))
        return;
    sx += bx.l - dx;
    sy += bx.t - dy;
    dx = bx.l;
    dy = bx.t;
    w = bx.width();
    h = bx.height();

    size_t spnext = srcimg->bpl - w * 4;
    size_t dpnext = dstimg->bpl - w * 4;
    uint8* sp = srcimg->bits + srcimg->bpl * sy + sx * 4;
    uint8* dp = dstimg->bits + dstimg->bpl * dy + dx * 4;
    while (h--) {
        int32 width = w;
        while (width--) {
            dp[3] = sp[3];
            sp += 4;
            dp += 4;
        }
        sp += spnext;
        dp += dpnext;
    }
}

/*
In general, the argument passed to a drawing function is often reused as a local variable.
When passing a structure pointer, you need to make a local variable on the stack.
Therefore, when calling a function, it is better in performance to unpack and pass arguments.
It's inconvenient to write ...
*/

/* WARNING: This file is generated by combine.pl from combine.inc.
   Please edit one of those files rather than this one. */

#define COMPONENT_SIZE      8
#define MASK                0xff
#define ONE_HALF            0x80

#define A_SHIFT             8 * 3
#define R_SHIFT             8 * 2
#define G_SHIFT             8
#define A_MASK              0xff000000
#define R_MASK              0xff0000
#define G_MASK              0xff00

#define RB_MASK             0xff00ff
#define AG_MASK             0xff00ff00
#define RB_ONE_HALF         0x800080
#define RB_MASK_PLUS_ONE    0x10000100

#define ALPHA_8(x)          ((x) >> A_SHIFT)
#define RED_8(x)            (((x) >> R_SHIFT) & MASK)
#define GREEN_8(x)          (((x) >> G_SHIFT) & MASK)
#define BLUE_8(x)           ((x) & MASK)

/*
 * Helper macros.
 */

#define MUL_UN8(a, b, t) \
    ((t) = (a) * (b) + ONE_HALF, ((((t) >> G_SHIFT) + (t)) >> G_SHIFT))

#define DIV_UN8(a, b) \
    (((uint16)(a) * MASK) / (b))

#define ADD_UN8(x, y, t) \
    ((t) = x + y,        \
        (uint32)(uint8)((t) | (0 - ((t) >> G_SHIFT))))

#define DIV_ONE_UN8(x) \
    (((x) + ONE_HALF + (((x) + ONE_HALF) >> G_SHIFT)) >> G_SHIFT)

/*
 * The methods below use some tricks to be able to do two color
 * components at the same time.
 */

/*
 * x_rb = (x_rb * a) / 255
 */
#define UN8_rb_MUL_UN8(x, a, t)                          \
    do {                                                 \
        t = ((x)&RB_MASK) * (a);                         \
        t += RB_ONE_HALF;                                \
        x = (t + ((t >> G_SHIFT) & RB_MASK)) >> G_SHIFT; \
        x &= RB_MASK;                                    \
    } while (0)

/*
 * x_rb = min (x_rb + y_rb, 255)
 */
#define UN8_rb_ADD_UN8_rb(x, y, t)                          \
    do {                                                    \
        t = ((x) + (y));                                    \
        t |= RB_MASK_PLUS_ONE - ((t >> G_SHIFT) & RB_MASK); \
        x = (t & RB_MASK);                                  \
    } while (0)

/*
 * x_rb = (x_rb * a_rb) / 255
 */
#define UN8_rb_MUL_UN8_rb(x, a, t)                       \
    do {                                                 \
        t = (x & MASK) * (a & MASK);                     \
        t |= (x & R_MASK) * ((a >> R_SHIFT) & MASK);     \
        t += RB_ONE_HALF;                                \
        t = (t + ((t >> G_SHIFT) & RB_MASK)) >> G_SHIFT; \
        x = t & RB_MASK;                                 \
    } while (0)

/*
 * x_c = (x_c * a) / 255
 */
#define UN8x4_MUL_UN8(x, a)       \
    do {                          \
        uint32 r1, r2, t;         \
        r1 = (x);                 \
        UN8_rb_MUL_UN8(r1, a, t); \
        r2 = (x) >> G_SHIFT;      \
        UN8_rb_MUL_UN8(r2, a, t); \
        x = r1 | (r2 << G_SHIFT); \
    } while (0)

/*
 * x_c = (x_c * a) / 255 + y_c
 */
#define UN8x4_MUL_UN8_ADD_UN8x4(x, a, y) \
    do {                                 \
        uint32 r1, r2, r3, t;            \
        r1 = (x);                        \
        r2 = (y)&RB_MASK;                \
        UN8_rb_MUL_UN8(r1, a, t);        \
        UN8_rb_ADD_UN8_rb(r1, r2, t);    \
        r2 = (x) >> G_SHIFT;             \
        r3 = ((y) >> G_SHIFT) & RB_MASK; \
        UN8_rb_MUL_UN8(r2, a, t);        \
        UN8_rb_ADD_UN8_rb(r2, r3, t);    \
        x = r1 | (r2 << G_SHIFT);        \
    } while (0)

/*
 * x_c = (x_c * a + y_c * b) / 255
 */
#define UN8x4_MUL_UN8_ADD_UN8x4_MUL_UN8(x, a, y, b) \
    do {                                            \
        uint32 r1, r2, r3, t;                       \
        r1 = x;                                     \
        r2 = y;                                     \
        UN8_rb_MUL_UN8(r1, a, t);                   \
        UN8_rb_MUL_UN8(r2, b, t);                   \
        UN8_rb_ADD_UN8_rb(r1, r2, t);               \
        r2 = (x >> G_SHIFT);                        \
        r3 = (y >> G_SHIFT);                        \
        UN8_rb_MUL_UN8(r2, a, t);                   \
        UN8_rb_MUL_UN8(r3, b, t);                   \
        UN8_rb_ADD_UN8_rb(r2, r3, t);               \
        x = r1 | (r2 << G_SHIFT);                   \
    } while (0)

/*
 * x_c = (x_c * a_c) / 255
 */
#define UN8x4_MUL_UN8x4(x, a)         \
    do {                              \
        uint32 r1, r2, r3, t;         \
        r1 = x;                       \
        r2 = a;                       \
        UN8_rb_MUL_UN8_rb(r1, r2, t); \
        r2 = x >> G_SHIFT;            \
        r3 = a >> G_SHIFT;            \
        UN8_rb_MUL_UN8_rb(r2, r3, t); \
        x = r1 | (r2 << G_SHIFT);     \
    } while (0)

/*
 * x_c = (x_c * a_c) / 255 + y_c
 */
#define UN8x4_MUL_UN8x4_ADD_UN8x4(x, a, y) \
    do {                                   \
        uint32 r1, r2, r3, t;              \
        r1 = x;                            \
        r2 = a;                            \
        UN8_rb_MUL_UN8_rb(r1, r2, t);      \
        r2 = y & RB_MASK;                  \
        UN8_rb_ADD_UN8_rb(r1, r2, t);      \
        r2 = (x >> G_SHIFT);               \
        r3 = (a >> G_SHIFT);               \
        UN8_rb_MUL_UN8_rb(r2, r3, t);      \
        r3 = (y >> G_SHIFT) & RB_MASK;     \
        UN8_rb_ADD_UN8_rb(r2, r3, t);      \
        x = r1 | (r2 << G_SHIFT);          \
    } while (0)

/*
 * x_c = (x_c * a_c + y_c * b) / 255
 */
#define UN8x4_MUL_UN8x4_ADD_UN8x4_MUL_UN8(x, a, y, b) \
    do {                                              \
        uint32 r1, r2, r3, t;                         \
        r1 = x;                                       \
        r2 = a;                                       \
        UN8_rb_MUL_UN8_rb(r1, r2, t);                 \
        r2 = y;                                       \
        UN8_rb_MUL_UN8(r2, b, t);                     \
        UN8_rb_ADD_UN8_rb(r1, r2, t);                 \
        r2 = x >> G_SHIFT;                            \
        r3 = a >> G_SHIFT;                            \
        UN8_rb_MUL_UN8_rb(r2, r3, t);                 \
        r3 = y >> G_SHIFT;                            \
        UN8_rb_MUL_UN8(r3, b, t);                     \
        UN8_rb_ADD_UN8_rb(r2, r3, t);                 \
        x = r1 | (r2 << G_SHIFT);                     \
    } while (0)

/*
   x_c = min(x_c + y_c, 255)
 */
#define UN8x4_ADD_UN8x4(x, y)          \
    do {                               \
        uint32 r1, r2, r3, t;          \
        r1 = x & RB_MASK;              \
        r2 = y & RB_MASK;              \
        UN8_rb_ADD_UN8_rb(r1, r2, t);  \
        r2 = (x >> G_SHIFT) & RB_MASK; \
        r3 = (y >> G_SHIFT) & RB_MASK; \
        UN8_rb_ADD_UN8_rb(r2, r3, t);  \
        x = r1 | (r2 << G_SHIFT);      \
    } while (0)

static inline uint32 over(uint32 src, uint32 dest)
{
    uint32 a = ~src >> 24;

    UN8x4_MUL_UN8_ADD_UN8x4(dest, a, src);

    return dest;
}

void ExImage::BlitAlphaOver(ExImage* dstimg, int32 dx, int32 dy, int32 w, int32 h,
    const ExImage* srcimg, int32 sx, int32 sy)
{
    exassert(dstimg != srcimg && dstimg->bpp == 32 && srcimg->bpp == 32); // 32bpp only
    ExBox bx(dx - sx, dy - sy, srcimg->width + dx - sx, srcimg->height + dy - sy);
    if (!bx.intersect(0, 0, dstimg->width, dstimg->height))
        return;
    if (!bx.intersect(dx, dy, dx + w, dy + h))
        return;
    sx += bx.l - dx;
    sy += bx.t - dy;
    dx = bx.l;
    dy = bx.t;
    w = bx.width();
    h = bx.height();

    size_t spnext = srcimg->bpl - w * 4;
    size_t dpnext = dstimg->bpl - w * 4;
    uint8* sp = srcimg->bits + srcimg->bpl * sy + sx * 4;
    uint8* dp = dstimg->bits + dstimg->bpl * dy + dx * 4;
    while (h--) {
        int32 width = w;
        while (width--) {
            if (sp[3] == 0xff) {
                *(uint32*)dp = *(uint32*)sp;
            } else if (*(uint32*)sp) {
                // dst = (dst * alpha) / 255 + src
                *(uint32*)dp = over(*(uint32*)sp, *(uint32*)dp);
            }
            sp += 4;
            dp += 4;
        }
        sp += spnext;
        dp += dpnext;
    }
}
