/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __linux__

#include "exgdiobj.h"
#include "exwindow.h"
#include "eximage.h"
#include <assert.h>

/////////////////////////////////////////////////////////////////////////////
// class ExGdiBmp

int
ExGdiBmp::Create(int w, int h, int bpp, const void* lpvBits)
{
    //Destroy();
#if 1
    BITMAPINFO bmi;
    RGBQUAD rgbq[4];
    BYTE* bits = NULL;
    chroma = RGB(0, 0, 0);
    memset(&bm, 0, sizeof(bm));
    memset(&bmi, 0, sizeof(bmi));
    memset(&rgbq, 0, sizeof(rgbq));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = w;
    bmi.bmiHeader.biHeight = -h;
    bmi.bmiHeader.biPlanes = 1;/*planes=1*/
    bmi.bmiHeader.biBitCount = bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
#if 0
    if (bmi.bmiHeader.biBitCount == 32) {
        *(unsigned int*)&bmi.bmiColors[0] = 0x000000FF;
        *(unsigned int*)&bmi.bmiColors[1] = 0x0000FF00;
        *(unsigned int*)&bmi.bmiColors[2] = 0x00FF0000;
        *(unsigned int*)&bmi.bmiColors[3] = 0xFF000000;
    }
#endif
    hbmp = CreateDIBSection(NULL, &bmi, DIB_RGB_COLORS, (void**)&bits, NULL, NULL);
    if (hbmp == NULL) {
        exerror(L"%s - CreateDIBSection fail.\n", __funcw__);
        return -1;
    }
    GetObject(hbmp, sizeof(bm), &bm);
    assert(bits == bm.bmBits);
    if (lpvBits != NULL) {
        // TBD
        memcpy(bm.bmBits, lpvBits, Size());
    }
    return 0;
#else
    return Attach(CreateBitmap(w, h, 1, bpp, lpvBits));
#endif
}

int
ExGdiBmp::Create(ExImage& img, int bpp/*[0:DDB],[15,16,24,32:DIB],[Others:Invalid]*/)
{
    //Destroy();
    LONG w, h;
    chroma = img.chroma;
    // DIBs: device-independent bitmaps
    // DDBs: device-dependent bitmaps
    // load to video memory
    if (bpp == 0) {
#if 1
        ExWndDC wnddc(GetDesktopWindow());
        ExMemDC memdc(wnddc, img.width, img.height);
        if (memdc.hbmMem == NULL) {
            exerror(L"%s - CreateCompatibleBitmap fail.\n", __funcw__);
            return -1;
        }
        BITMAPINFO bmi;
        memset(&bmi, 0, sizeof(bmi));
        bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
        bmi.bmiHeader.biWidth = img.width;
        bmi.bmiHeader.biHeight = -img.height;
        bmi.bmiHeader.biPlanes = 1;/*planes=1*/
        bmi.bmiHeader.biBitCount = img.bpp;/*16,24,32*/
        bmi.bmiHeader.biCompression = BI_RGB;/*BI_RGB,BI_ALPHABITFIELDS*/
        bmi.bmiHeader.biSizeImage = 0; // This may be set to zero for BI_RGB bitmaps
        SetDIBitsToDevice(memdc, 0, 0, img.width, img.height,
                          0, 0, 0, img.height, img.bits, &bmi, DIB_RGB_COLORS);
        Attach(memdc.hbmMem);
        memdc.hbmMem = NULL;
#else
        ExWndDC wnddc(GetDesktopWindow());
        HBITMAP hbmDDB = CreateCompatibleBitmap(wnddc, img.width, img.height);
        if (hbmDDB == NULL) goto ddb_fail;
        //LONG SetBitmapBits(HBITMAP hbmp, DWORD cBytes, CONST VOID *lpBits);
        SetBitmapBits(hbmDDB, size, img.bits);
        Attach(hbmDDB);
        //hbmp = hbmDDB;
        //GetObject(hbmp, sizeof(bm), &bm);
#endif
        return 0;
    }
    if ((bpp == 24 || bpp == 32) ||
        (img.bpp == 24 || img.bpp == 32)) {
        bpp = img.bpp;
    }
    if (Create(img.width, img.height, bpp, NULL))
        return -1;
    if (Bits() == NULL)
        return -1;
    if (bpp == 24 || bpp == 32) {
        memcpy(Bits(), img.bits, Size());
        return 0;
    }
    if (bpp == 16) {
        int channels = img.bpp / 8;
        for (h = 0; h < bm.bmHeight; h++) {
            BYTE* sp = (BYTE*)img.bits + img.bpl * h;
            WORD* dp = (WORD*)((BYTE*)bm.bmBits + bm.bmWidthBytes * h);
            for (w = 0; w < bm.bmWidth; w++, sp += channels) {
                *dp++ = ((sp[0] & 0xF8) >> 3) |
                    ((sp[1] & 0xFC) << 3) |
                    ((sp[2] & 0xF8) << 8);
            }
        }
        return 0;
    }
    if (bpp == 15) {
        int channels = img.bpp / 8;
        if (channels == 4) {
            for (h = 0; h < bm.bmHeight; h++) {
                BYTE* sp = (BYTE*)img.bits + img.bpl * h;
                WORD* dp = (WORD*)((BYTE*)bm.bmBits + bm.bmWidthBytes * h);
                for (w = 0; w < bm.bmWidth; w++, sp += channels) {
                    *dp++ = ((sp[0] & 0xF8) >> 3) |
                        ((sp[1] & 0xF8) << 2) |
                        ((sp[2] & 0xF8) << 7) |
                        ((sp[3] & 0x80) << 8);
                }
            }
        } else
            if (channels == 3) {
                for (h = 0; h < bm.bmHeight; h++) {
                    BYTE* sp = (BYTE*)img.bits + img.bpl * h;
                    WORD* dp = (WORD*)((BYTE*)bm.bmBits + bm.bmWidthBytes * h);
                    for (w = 0; w < bm.bmWidth; w++, sp += channels) {
                        *dp++ = ((sp[0] & 0xF8) >> 3) |
                            ((sp[1] & 0xF8) << 2) |
                            ((sp[2] & 0xF8) << 7);
                    }
                }
            }
        return 0;
    }
    exerror(L"%s - invalid param. bpp=%d\n", __funcw__, bpp);
    return -1;
}

HDC
ExGdiBmp::BltBegin()
{
    if (hbmp == NULL)
        return NULL;
    hdc = CreateCompatibleDC(NULL);
    if (hdc == NULL)
        return NULL;
    hbmOld = (HBITMAP)SelectObject(hdc, hbmp);
    return hdc;
}

void
ExGdiBmp::BltEnd()
{
    SelectObject(hdc, hbmOld);
    hbmOld = NULL;
    DeleteDC(hdc);
    hdc = NULL;
}

int
ExBmpBlt(HDC dhdc, int dx, int dy, int dw, int dh, ExGdiBmp* sbmp, int sx, int sy, int sw, int sh)
{
    if (!(dhdc && sbmp))
        return -1;
    HDC shdc = sbmp->BltBegin();
    if (shdc == NULL)
        return -1;
    if (sbmp->chroma)
        TransparentBlt(dhdc, dx, dy, dw, dh, shdc, sx, sy, sw, sh, sbmp->chroma);
    else
        StretchBlt(dhdc, dx, dy, dw, dh, shdc, sx, sy, sw, sh, SRCCOPY);
    sbmp->BltEnd();
    return 0;
}

int
ExBmpBlt(HDC dhdc, int dx, int dy, int w, int h, ExGdiBmp* sbmp, int sx, int sy)
{
    if (!(dhdc && sbmp))
        return -1;
    HDC shdc = sbmp->BltBegin();
    if (shdc == NULL)
        return -1;
    if (sbmp->chroma)
        TransparentBlt(dhdc, dx, dy, w, h, shdc, sx, sy, w, h, sbmp->chroma);
    else
        StretchBlt(dhdc, dx, dy, w, h, shdc, sx, sy, w, h, SRCCOPY);
    sbmp->BltEnd();
    return 0;
}

int
ExBmpBlt(HDC dhdc, int dx, int dy, ExGdiBmp* sbmp)
{
    if (!(dhdc && sbmp))
        return -1;
    HDC shdc = sbmp->BltBegin();
    if (shdc == NULL)
        return -1;
    int w = sbmp->Width();
    int h = sbmp->Height();
    if (sbmp->chroma)
        TransparentBlt(dhdc, dx, dy, w, h, shdc, 0, 0, w, h, sbmp->chroma);
    else
        StretchBlt(dhdc, dx, dy, w, h, shdc, 0, 0, w, h, SRCCOPY);
    sbmp->BltEnd();
    return 0;
}

/////////////////////////////////////////////////////////////////////////////
// class ExGdiBrush

/////////////////////////////////////////////////////////////////////////////
// class ExGdiFont

int
ExGdiFont::CreateFont(int height, int weight, const wchar* facename)
{
    LOGFONT logfont;
    memset(&logfont, 0, sizeof(logfont));
    logfont.lfHeight = height;
    logfont.lfWeight = weight;
    logfont.lfCharSet = DEFAULT_CHARSET;
#ifdef _WIN32_WCE
    logfont.lfQuality = CLEARTYPE_QUALITY;
#endif
    _snwprintf(logfont.lfFaceName, LF_FACESIZE, L"%s", facename);
    return Create(&logfont);
}

/////////////////////////////////////////////////////////////////////////////
// class ExGdiPen

/////////////////////////////////////////////////////////////////////////////
// class ExGdiDC

/////////////////////////////////////////////////////////////////////////////
// class ExWndDC

/////////////////////////////////////////////////////////////////////////////
// class ExMemDC

ExMemDC::~ExMemDC()
{
    Destroy();
}

ExMemDC::ExMemDC()
    : ExGdiDC()
    , hbmOld(NULL)
    , hbmMem(NULL)
{
    //memset(&bm, 0, sizeof(bm));
}

ExMemDC::ExMemDC(ExWindow* window)
    : ExGdiDC()
    , hbmOld(NULL)
    , hbmMem(NULL)
{
    Create(window); // DDB
}

ExMemDC::ExMemDC(HDC hdcWnd, int w, int h)
    : ExGdiDC()
    , hbmOld(NULL)
    , hbmMem(NULL)
{
    Create(hdcWnd, w, h); // DDB
}

ExMemDC::ExMemDC(int w, int h, int planes, int bpp, DWORD biCompression)
    : ExGdiDC()
    , hbmOld(NULL)
    , hbmMem(NULL)
{
    Create(w, h, planes, bpp, biCompression); // DIB
}

int
ExMemDC::Destroy()
{
    if (hbmOld) {
        SelectObject(hdc, hbmOld);
        hbmOld = NULL;
    }
    if (hbmMem) {
        DeleteObject(hbmMem);
        hbmMem = NULL;
    }
    if (hdc) {
        DeleteDC(Detach());
    }
    return 0;
}

int
ExMemDC::Create(ExWindow* window)
{
    ExWndDC wnddc;
    if (wnddc.Create(window->getHwnd()))
        return -1;
    if (Create(wnddc, window->area.w, window->area.h))
        return -1;
    return 0;
}

int
ExMemDC::Create(HDC hdcWnd, int w, int h)
{
    if (Attach(CreateCompatibleDC(NULL)))
        return -1;
    hbmMem = CreateCompatibleBitmap(hdcWnd, w, h);
    if (hbmMem == NULL) {
        Destroy();
        return 1;
    }
    GetObject(hbmMem, sizeof(bm), &bm);
    hbmOld = (HBITMAP)SelectObject(hdc, hbmMem);
    return 0;
}

int
ExMemDC::Create(int w, int h, int planes, int bpp, DWORD biCompression)
{
    BITMAPINFO bmi;
    BYTE* bits = NULL;
    memset(&bmi, 0, sizeof(bmi));
    bmi.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    bmi.bmiHeader.biWidth = w;
    bmi.bmiHeader.biHeight = -h;
    bmi.bmiHeader.biPlanes = planes;/*1*/
    bmi.bmiHeader.biBitCount = bpp;/*16,24,32*/
    bmi.bmiHeader.biCompression = biCompression;/*BI_RGB,BI_ALPHABITFIELDS*/
    bmi.bmiHeader.biSizeImage = 0;
    if (Attach(CreateCompatibleDC(NULL)))
        return -1;
    hbmMem = CreateDIBSection(NULL, &bmi, DIB_RGB_COLORS, (void**)&bits, NULL, NULL);
    if (hbmMem == NULL) {
        Destroy();
        return 1;
    }
    GetObject(hbmMem, sizeof(bm), &bm);
    hbmOld = (HBITMAP)SelectObject(hdc, hbmMem);
    assert(bits == bm.bmBits);
    return 0;
}

#endif // __linux__

