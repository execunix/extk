/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __eximage_h__
#define __eximage_h__

#include <exobject.h>
#include <exregion.h>

// Graphics macro functions
//
#define _ExSWAPRGB(c)           (((c) & 0xFF00FF00) | ((c >> 16) & 0x000000FF) | ((c << 16) & 0x00FF0000))
#define _ExSWAPPRGB(c)          _ExSWAPRGB(c)
#define _ExSWAPARGB(c)          (((c >> 24) & 0x000000FF) | ((c >> 16) & 0x000000FF) | ((c) & 0x0000FF00) | ((c << 16) & 0x00FF0000))

/* Macros for manipulating color values */
#define ExRGB(r,g,b)            (((uint32)((r) & 0xFF) << 16) | ((uint32)((g) & 0xFF) << 8) | (uint32)((b) & 0xFF))
#define ExRGBA(r,g,b,a)         (((uint32)((r) & 0xFF) << 16) | ((uint32)((g) & 0xFF) << 8) | (uint32)((b) & 0xFF) | ((uint32)((a) & 0xFF) << 24))
#define ExARGB(a,r,g,b)         (((uint32)((a) & 0xFF) << 24) | ((uint32)((r) & 0xFF) << 16) | ((uint32)((g) & 0xFF) << 8) | (uint32)((b) & 0xFF))
#define ExCMY(c,m,y)            (ExRGB(c, m, y) ^ 0xFFFFFF)
#define ExCMYK(c,m,y,k)         ExRGB(0xff ^ min(c + k,255), \
                                      0xff ^ min(m + k,255), \
                                      0xff ^ min(y + k,255))
#define ExCMYK2RGB(a)           ExCMYK((a).c,(a).m,(a).y,(a).k)
#define ExGray(v)               ExRGB(v, v, v)
#define ExGrey(v)               ExGray(v)
#define ExBValue(c)             ((uint8)((c) & 0xFF))
#define ExGValue(c)             ((uint8)(((c) >> 8) & 0xFF))
#define ExRValue(c)             ((uint8)(((c) >> 16) & 0xFF))
#define ExAValue(c)             ((uint8)(((c) >> 24) & 0xFF))
#define ExGreyValue(c)          (((ExRValue(c) * 77) + (ExGValue(c) * 151) + (ExBValue(c) * 28)) >> 8)
#define ExGrayValue(c)          (((ExRValue(c) * 77) + (ExGValue(c) * 151) + (ExBValue(c) * 28)) >> 8)

/* Macros for manipulating 16-bit color values (565) */
#define Ex565to8888(c)          ((((c) & 0x1F) << 3) | (((c) & 0x7E0) << 5) | (((c) & 0xF800) << 8))
#define Ex8888to565(c)          ((((c) & 0xF8) >> 3) | (((c) & 0xFC00) >> 5) | (((c) & 0xF80000) >> 8))
#define ExRGB565(r,g,b)         ((((r) & 0xF8) << 8) | (((g) & 0xFC) << 3) | (((b) & 0xF8) >> 3))
#define ExBlueValue565(c)       (((c) & 0x1F) << 3)
#define ExGreenValue565(c)      (((c) & 0x7E0) >> 3)
#define ExRedValue565(c)        (((c) & 0xF800) >> 8)

/* Macros for manipulating 16-bit color values (555) */
#define Ex555to8888(c)          ((((c) & 0x1F) << 3) | (((c) & 0x3E0) << 6) | (((c) & 0x7C00) << 9))
#define Ex8888to555(c)          ((((c) & 0xF8) >> 3) | (((c) & 0xF800) >> 6) | (((c) & 0xF80000) >> 9))
#define ExRGB555(r,g,b)         ((((r) & 0xF8) << 7) | (((g) & 0xF8) << 2) | (((b) & 0xF8) >> 3))
#define ExBlueValue555(c)       ExBlueValue565(c)
#define ExGreenValue555(c)      (((c) & 0x3E0) >> 2)
#define ExRedValue555(c)        (((c) & 0x7C00) >> 7)

/* Macros for manipulating 16-bit color values (555) */
#define Ex1555to8888(c)         ((((c) & 0x80) << 16) |  (((c) & 0x1F) << 3) | (((c) & 0x3E0) << 6) | (((c) & 0x7C00) << 9))
#define Ex8888to1555(c)         ((((c) & 0x80000000) >> 16) | (((c) & 0xF8) >> 3) | (((c) & 0xF800) >> 6) | (((c) & 0xF80000) >> 9))
#define ExRGB1555(a,r,g,b)      ((((a) & 0x80) << 8) | (((r) & 0xF8) << 7) | (((g) & 0xF8) << 2) | (((b) & 0xF8) >> 3))
#define ExAlphaValue1555(c)     (((c) & 0x8000) >> 8)
#define ExBlueValue1555(c)      ExBlueValue565(c)
#define ExGreenValue1555(c)     (((c) & 0x3E0) >> 2)
#define ExRedValue1555(c)       (((c) & 0x7C00) >> 7)

/* Macros for manipulating 16-bit color values (444) */
#define Ex444to8888(c)          ((((c) & 0xF) << 4) | (((c) & 0xF0) << 8) | (((c) & 0xF00) << 12))
#define Ex8888to444(c)          ((((c) & 0xF0) >> 4) | (((c) & 0xF000) >> 8) | (((c) & 0xF00000) >> 12))
#define ExRGB444(r,g,b)         ((((r) & 0xF0) << 4) | ((g) & 0xF0) |  (((b) & 0xF0) >> 4))
#define ExBlueValue444(c)       (((c) & 0xF) << 4)
#define ExGreenValue444(c)      ((c) & 0xF0)
#define ExRedValue444(c)        (((c) & 0xF00) >> 4)

#define Ex4444to8888(c)         ((((c) & 0xF) << 4) | (((c) & 0xF0) << 8) | (((c) & 0xF00) << 12) | (((c) & 0xF000) << 16))
#define Ex8888to4444(c)         ((((c) & 0xF0) >> 4) | (((c) & 0xF000) >> 8) | (((c) & 0xF00000) >> 12) | (((c) & 0xF0000000) >> 16))
#define ExRGB4444(a,r,g,b)      ((((a) & 0xF0) << 8) | (((r) & 0xF0) << 4) | ((g) & 0xF0) |  (((b) & 0xF0) >> 4))
#define ExBlueValue4444(c)      (((c) & 0xF) << 4)
#define ExGreenValue4444(c)     ((c) & 0xF0)
#define ExRedValue4444(c)       (((c) & 0xF00) >> 4)
#define ExAlphaValue4444(c)     (((c) & 0xF000) >> 8)

#define ExLighterColor(c)       (ExRGB( (0xff-((0xff-ExRValue(c)) >> 1)), \
                                        (0xff-((0xff-ExGValue(c)) >> 1)), \
                                        (0xff-((0xff-ExBValue(c)) >> 1)) ))

#define ExALighterColor(c)      (ExARGB(ExAValue(c), \
                                        (0xff - ((0xff - ExRValue(c)) >> 1)), \
                                        (0xff - ((0xff - ExGValue(c)) >> 1)), \
                                        (0xff - ((0xff - ExBValue(c)) >> 1)) ))

#define ExDarkerColor(c)        (ExRGB( (ExRValue(c) >> 1), \
                                        (ExGValue(c) >> 1), \
                                        (ExBValue(c) >> 1) ))

#define ExADarkerColor(c)       (ExARGB(ExAValue(c), \
                                        (ExRValue(c) >> 1), \
                                        (ExGValue(c) >> 1),\
                                        (ExBValue(c) >> 1) ))

#define ExAverageColor(a,b)     (ExRGB( ((ExRValue(a) >> 1) + (ExRValue(b) >> 1)), \
                                        ((ExGValue(a) >> 1) + (ExGValue(b) >> 1)), \
                                        ((ExBValue(a) >> 1) + (ExBValue(b) >> 1)) ))

#define ExAAverageColor(a,b)    (ExARGB(ExAValue(c), \
                                        ((ExRValue(a) >> 1) + (ExRValue(b) >> 1)), \
                                        ((ExGValue(a) >> 1) + (ExGValue(b) >> 1)), \
                                        ((ExBValue(a) >> 1) + (ExBValue(b) >> 1)) ))

#define Ex_IMAGE_DIRECT_8888    0x20    /* AAAAAAAARRRRRRRRGGGGGGGGBBBBBBBB */
#define Ex_IMAGE_DIRECT_888     0x21    /* RRRRRRRRGGGGGGGGBBBBBBBB */
#define Ex_IMAGE_DIRECT_565     0x22    /* RRRRRGGGGGGBBBBB */
#define Ex_IMAGE_DIRECT_555     0x23    /* xRRRRRGGGGGBBBBB	*/
#define Ex_IMAGE_DIRECT_444     0x24    /* xxxxRRRRGGGGBBBB	*/
#define Ex_IMAGE_DIRECT_4444    0x25    /* AAAARRRRGGGGBBBB	*/
#define Ex_IMAGE_DIRECT_1555    0x26    /* ARRRRRGGGGGBBBBB */


/* Macro to calculate 16.16 percentage a of b */
#define ExCalcPercentage(a, b)  (((((a) * 100) / (b)) << 16) | (((((a) * 100) % (b)) << 16) / (b)))

/* ExImageFunc format definitions */
#define Ex_IMM_BMP              0x00
#define Ex_IMM_GIF              0x01
#define Ex_IMM_JPG              0x02
#define Ex_IMM_PCX              0x03
#define Ex_IMM_TGA              0x04
#define Ex_IMM_PNG              0x05
#define Ex_IMM_TIFF             0x06
#define Ex_IMM_XBM              0x07
#define Ex_IMM_PHIMAGE          0x08

/* ExMethods flags definitions */
#define Ex_IMM_LOAD             0x00
#define Ex_IMM_QUERY            0x01
#define Ex_IMM_SUPPRESS_CRC     0x02
#define Ex_IMM_SUPPRESS_TAG     0x02
#define Ex_IMM_DIRECT_COLOR     0x04
#define Ex_IMM_TRANSPARENT      0x08
#define Ex_IMM_SCALE            0x10
#define Ex_IMM_USECOLORS        0x20
#define Ex_IMM_DODITHER         0x40

/* free/alloc type definitions */
#define Ex_IMM_NORMAL           0x00
#define Ex_IMM_IMAGE            0x01
#define Ex_IMM_PALETTE          0x02
#define Ex_IMM_METHODS          0x80000000

/* ExImage flags bits */
#define Ex_ImageAlloc           0x00000001
#define Ex_ImageQuery           0x00000080

#define Ex_ShmemBits            0x00000100	// RO
#define Ex_ShmemPalette         0x00000200	// RO
#define Ex_ShmemMaskBits        0x00000400	// RO
#define Ex_ShmemGhostBits       0x00000800	// RO
#define Ex_ShmemAlphaMap        0x00001000	// RO
#define Ex_ShmemAllocAll        0x00001f00	// RO

#define Ex_ReleaseBits          0x00010000
#define Ex_ReleasePalette       0x00020000
#define Ex_ReleaseMaskBits      0x00040000
#define Ex_ReleaseGhostBits     0x00080000
#define Ex_ReleaseAlphaMap      0x00100000
#define Ex_ReleaseImageAll      0x001f0000

#define Ex_UseTransparency      0x01000000
#define Ex_ImageFreeMemory      0x80000000	// RO

// class ExImage
//
class ExImage : public ExObject {
public:
    int         type;           /* image type ( milti, pseudo, direct ) */
                                /* bitmap type (backfilled, transparent fill)*/
    int         bpp;            /* image bits per pixel (channels=bpp/8) */
    int         bpl;            /* image bytes per line (len=bpl*height) */
    int         width;          /* image size.width */
    int         height;         /* image size.height */
    int         format;         /* graphic format */
    int         flags;          /* image flags */
    uint8*      bits;           /* image bitmap data */
    uint32      chroma;         /* color to mask out when drawing */
    cairo_surface_t* crs;
public:
    virtual ~ExImage();
    explicit ExImage() : ExObject(), type(0), bpp(0), bpl(0)
        , width(0), height(0), format(0), flags(0), bits(NULL)
        , chroma(0), crs(NULL) {}
public:
    static ExImage* create(int width, int height, int type);
    int init(int width, int height, int type);
    int load(const wchar* fname, bool query = false);
    int getBitsSize() { return bpl * height; }
    int makeTrans(uint32 transColor) { return 0; } // tbd
    int makeGhost() { return 0; } // tbd
    void clear() {
        if (bits) free(bits);
        if (crs) cairo_surface_destroy(crs);
        type = bpp = bpl = width = height = format = 0;
        bits = NULL; crs = NULL;
        chroma = 0;
    }
    void fillRectAlphaEx(const ExRect* rect, uint8 alpha, uint8 a_out);
    void fillRectAlpha(const ExRect* rect, uint8 alpha);
    void fillRectRgbEx(const ExRect* rect, uint32 rgb, uint32 rgb_out);
    void fillRectRgb(const ExRect* rect, uint32 rgb);
    void fillRectEx(const ExRect* rect, uint32 color, uint32 c_out);
    void fillRect(const ExRect* rect, uint32 color);
    void drawRect(const ExRect* rect, uint32 color);
    void blit(int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy) {
        Blit(this, dx, dy, w, h, srcimg, sx, sy);
    }
    void blitRgb(int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy) {
        BlitRgb(this, dx, dy, w, h, srcimg, sx, sy);
    }
    void blitAlpha(int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy) {
        BlitAlpha(this, dx, dy, w, h, srcimg, sx, sy);
    }
    void blitAlphaOver(int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy) {
        BlitAlphaOver(this, dx, dy, w, h, srcimg, sx, sy);
    }
    static void Blit(ExImage* dstimg, int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy);
    static void BlitRgb(ExImage* dstimg, int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy);
    static void BlitAlpha(ExImage* dstimg, int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy);
    static void BlitAlphaOver(ExImage* dstimg, int dx, int dy, int w, int h, const ExImage* srcimg, int sx, int sy);
protected:
    int setInfo(int width, int height, int type);
    int loadBmp(HANDLE hFile, const wchar* fname, bool query);
    int loadGif(HANDLE hFile, const wchar* fname, bool query);
    int loadJpg(HANDLE hFile, const wchar* fname, bool query);
    int loadPng(HANDLE hFile, const wchar* fname, bool query);
    int savePng(HANDLE hFile);
    void preMultiply();
public:
    static int getBitsPerPixel(int type) {
        switch (type) {
            case Ex_IMAGE_DIRECT_8888: return 32;
            case Ex_IMAGE_DIRECT_888: return 24;
            case Ex_IMAGE_DIRECT_565: return 16;
            case Ex_IMAGE_DIRECT_555: return 15;
            case Ex_IMAGE_DIRECT_444: return 12;
            case Ex_IMAGE_DIRECT_4444: return 16;
            case Ex_IMAGE_DIRECT_1555: return 16;
        }
        return 0;
    }
    static int getBytesPerLine(int w, int bpp) {
        return ((w * bpp + 31) & ~31) / 8;
    }
public:
    Ex_DECLARE_TYPEINFO(ExImage, ExObject);
};

/*
ExImage::create()
    Create a new ExImage structure
Description:
    The function allocates a structure for you.
*/

#endif//__eximage_h__
