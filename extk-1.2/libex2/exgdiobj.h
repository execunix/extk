/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exgdiobj_h__
#define __exgdiobj_h__

#ifdef WIN32

#include "exobject.h"
#include "exgeomet.h"

/////////////////////////////////////////////////////////////////////////////
// class ExGdiObj

class ExGdiObj : public ExObject {
protected:
    HGDIOBJ hobj;
public:
    virtual ~ExGdiObj() { Destroy(); }
    explicit ExGdiObj() : ExObject(), hobj(NULL) {}
    explicit ExGdiObj(HGDIOBJ h) : ExObject(), hobj(NULL) { Attach(h); }
public:
    operator HGDIOBJ () const { return (this ? hobj : NULL); }
    HGDIOBJ Detach() { HGDIOBJ h = hobj; hobj = NULL; return h; }
    int32 Attach(HGDIOBJ h) { if (!h) return -1; hobj = h; return 0; }
    int32 Destroy() { if (!hobj) return -1; return DeleteObject(Detach()) ? 0 : 1; }
    //	int32 Create() { return Attach(CreateGdiObject()); }
public:
    Ex_DECLARE_TYPEINFO(ExGdiObj, ExObject);
};

/////////////////////////////////////////////////////////////////////////////
// class ExGdiBmp

class ExGdiBmp : public ExObject {
public:
    HBITMAP     hbmp;
    COLORREF    chroma;	// [Default:0],[Chroma:RGB(9,9,9)]
    HBITMAP     hbmOld;
    HDC         hdc;
    BITMAP      bm;
    //BITMAPINFO  bmi;
public:
    virtual ~ExGdiBmp() { Destroy(); }
    explicit ExGdiBmp() : ExObject(), hbmp(NULL), chroma(0) {}
    explicit ExGdiBmp(HBITMAP h) : ExObject(), hbmp(NULL), chroma(0) { Attach(h); }
    explicit ExGdiBmp(ExImage& img, int32 bpp) : ExObject(), hbmp(NULL), chroma(0) { Create(img, bpp); }
    explicit ExGdiBmp(int32 w, int32 h, int32 bpp, const void* lpvBits)
        : ExObject(), hbmp(NULL), chroma(0) {
        Create(w, h, bpp, lpvBits);
    }
public:
    operator HBITMAP () const { return (this ? hbmp : NULL); }
    HBITMAP Detach() { HBITMAP h = hbmp; hbmp = NULL; return h; }
    int32 Attach(HBITMAP h) { if (!h) return -1; hbmp = h; GetObject(hbmp, sizeof(bm), &bm); return 0; }
    int32 Destroy() { if (!hbmp) return -1; return DeleteObject(Detach()) ? 0 : 1; }
    int32 Create(int32 w, int32 h, int32 bpp, const void* lpvBits); // DIB
    int32 Create(ExImage& img, int32 bpp = 0/*[0:DDB],[15,16,24,32:DIB],[Others:Invalid]*/);
    int32 Size() { return this && hbmp ? bm.bmHeight*bm.bmWidthBytes : 0; }
    int32 Width() { return this && hbmp ? bm.bmWidth : 0; }
    int32 Height() { return this && hbmp ? bm.bmHeight : 0; }
    BYTE* Bits() { return this && hbmp ? (BYTE*)bm.bmBits : NULL; }
    bool IsDIB() { return this && hbmp && bm.bmBits ? true : false; }
    bool IsDDB() { return this && hbmp && !bm.bmBits ? true : false; }
    virtual HDC BltBegin();
    virtual void BltEnd();
public:
    friend int32 ExBmpBlt(HDC dhdc, int32 dx, int32 dy, int32 dw, int32 dh, ExGdiBmp* sbmp, int32 sx, int32 sy, int32 sw, int32 sh);
    friend int32 ExBmpBlt(HDC dhdc, const ExRect& da, ExGdiBmp* sbmp, const ExRect& sa);
    friend int32 ExBmpBlt(HDC dhdc, int32 dx, int32 dy, int32 w, int32 h, ExGdiBmp* sbmp, int32 sx, int32 sy);
    friend int32 ExBmpBlt(HDC dhdc, int32 dx, int32 dy, ExGdiBmp* sbmp);
    friend int32 ExBmpBlt(HDC dhdc, const ExRect& da, ExGdiBmp* sbmp, int32 sx, int32 sy);
    friend int32 ExBmpBlt(HDC dhdc, const ExPoint& dp, ExGdiBmp* sbmp);
public:
    Ex_DECLARE_TYPEINFO(ExGdiBmp, ExObject);
};

inline int32
ExBmpBlt(HDC dhdc, const ExRect& da, ExGdiBmp* sbmp, const ExRect& sa) {
    return ExBmpBlt(dhdc, da.x, da.y, da.w, da.h, sbmp, sa.x, sa.y, sa.w, sa.h);
}

inline int32
ExBmpBlt(HDC dhdc, const ExRect& da, ExGdiBmp* sbmp, int32 sx, int32 sy) {
    return ExBmpBlt(dhdc, da.x, da.y, da.w, da.h, sbmp, sx, sy);
}

inline int32
ExBmpBlt(HDC dhdc, const ExPoint& dp, ExGdiBmp* sbmp) {
    return ExBmpBlt(dhdc, dp.x, dp.y, sbmp);
}

/////////////////////////////////////////////////////////////////////////////
// class ExGdiBrush

class ExGdiBrush : public ExObject {
protected:
    HBRUSH hbrush;
public:
    virtual ~ExGdiBrush() { Destroy(); }
    explicit ExGdiBrush() : ExObject(), hbrush(NULL) {}
    explicit ExGdiBrush(HBRUSH h) : ExObject(), hbrush(NULL) { Attach(h); }
    explicit ExGdiBrush(COLORREF color) : ExObject(), hbrush(NULL) { Create(color); }
    explicit ExGdiBrush(BYTE r, BYTE g, BYTE b) : ExObject(), hbrush(NULL) { Create(RGB(r, g, b)); }
public:
    operator HBRUSH () const { return (this ? hbrush : NULL); }
    HBRUSH Detach() { HBRUSH h = hbrush; hbrush = NULL; return h; }
    int32 Attach(HBRUSH h) { if (!h) return -1; hbrush = h; return 0; }
    int32 Destroy() { if (!hbrush) return -1; return DeleteObject(Detach()) ? 0 : 1; }
    int32 Create(COLORREF color) { return Attach(CreateSolidBrush(color)); }
public:
    Ex_DECLARE_TYPEINFO(ExGdiBrush, ExObject);
};

/////////////////////////////////////////////////////////////////////////////
// class ExGdiFont

class ExGdiFont : public ExObject {
protected:
    HFONT hfont;
public:
    virtual ~ExGdiFont() { Destroy(); }
    explicit ExGdiFont() : ExObject(), hfont(NULL) {}
    explicit ExGdiFont(HFONT h) : ExObject(), hfont(NULL) { Attach(h); }
    explicit ExGdiFont(const LOGFONT* logfont) : ExObject(), hfont(NULL) { Create(logfont); }
    explicit ExGdiFont(int32 height, int32 weight, const char* facename);
public:
    operator HFONT () const { return (this ? hfont : NULL); }
    HFONT Detach() { HFONT h = hfont; hfont = NULL; return h; }
    int32 Attach(HFONT h) { if (!h) return -1; hfont = h; return 0; }
    int32 Destroy() { if (!hfont) return -1; return DeleteObject(Detach()) ? 0 : 1; }
    int32 Create(const LOGFONT* logfont) { return Attach(CreateFontIndirect(logfont)); }
    int32 CreateFont(int32 height, int32 weight, const char* facename);
    int32 GetLogFont(LOGFONT* logfont);
public:
    Ex_DECLARE_TYPEINFO(ExGdiFont, ExObject);
};

inline
ExGdiFont::ExGdiFont(int32 height, int32 weight, const char* facename)
    : ExObject(), hfont(NULL) {
    CreateFont(height, weight, facename);
}

inline int32
ExGdiFont::GetLogFont(LOGFONT* logfont) {
    return (hfont ? GetObject(hfont, sizeof(LOGFONT), logfont) : -1);
}

/////////////////////////////////////////////////////////////////////////////
// class ExGdiPen

class ExGdiPen : public ExObject {
protected:
    HPEN hpen;
public:
    virtual ~ExGdiPen() { Destroy(); }
    explicit ExGdiPen() : ExObject(), hpen(NULL) {}
    explicit ExGdiPen(HPEN h) : ExObject(), hpen(NULL) { Attach(h); }
    explicit ExGdiPen(int32 style, int32 width, COLORREF color);
public:
    operator HPEN () const { return (this ? hpen : NULL); }
    HPEN Detach() { HPEN h = hpen; hpen = NULL; return h; }
    int32 Attach(HPEN h) { if (!h) return -1; hpen = h; return 0; }
    int32 Destroy() { if (!hpen) return -1; return DeleteObject(Detach()) ? 0 : 1; }
    int32 Create(int32 style, int32 width, COLORREF color);
public:
    Ex_DECLARE_TYPEINFO(ExGdiPen, ExObject);
};

inline
ExGdiPen::ExGdiPen(int32 style, int32 width, COLORREF color)
    : ExObject(), hpen(NULL) {
    Create(style, width, color);
}

inline int32
ExGdiPen::Create(int32 style, int32 width, COLORREF color) {
    return Attach(CreatePen(style, width, color));
}

/////////////////////////////////////////////////////////////////////////////
// class ExGdiDC

class ExGdiDC : public ExObject {
protected:
    HDC hdc;
    ExGdiDC() : ExObject(), hdc(NULL) {}
public:
    /*virtual*/ ~ExGdiDC() { /*Detach();*/ }
    explicit ExGdiDC(HDC h) : ExObject(), hdc(NULL) { Attach(h); }
public:
    operator HDC () const { return (this ? hdc : NULL); }
    HDC Detach() { HDC h = hdc; hdc = NULL; return h; }
    int32 Attach(HDC h) { if (!h) return -1; hdc = h; return 0; }
public:
    Ex_DECLARE_TYPEINFO(ExGdiDC, ExObject);
};

/////////////////////////////////////////////////////////////////////////////
// class ExWndDC

class ExWndDC : public ExGdiDC {
protected:
    HWND hwnd;
public:
    virtual ~ExWndDC() { Destroy(); }
    explicit ExWndDC() : ExGdiDC(), hwnd(NULL) {}
    explicit ExWndDC(HWND h) : ExGdiDC(), hwnd(h) { Attach(GetDC(hwnd)); }
public:
    int32 Destroy() { if (!hdc) return -1; return ReleaseDC(hwnd, Detach()) ? 0 : 1; }
    int32 Create(HWND h) { hwnd = h; return Attach(GetDC(hwnd)); }
public:
    Ex_DECLARE_TYPEINFO(ExWndDC, ExGdiDC);
};

/////////////////////////////////////////////////////////////////////////////
// class ExMemDC

class ExMemDC : public ExGdiDC {
protected:
    HBITMAP hbmOld;
    HBITMAP hbmMem;
    BITMAP  bm;
public:
    virtual ~ExMemDC();
    explicit ExMemDC();
    explicit ExMemDC(ExWindow* window); // DDB
    explicit ExMemDC(HDC hdcWnd, int32 w, int32 h); // DDB
    explicit ExMemDC(int32 w, int32 h, int32 planes, int32 bpp, DWORD biCompression = BI_RGB); // DIB
    // planes/*1*/, bpp/*16,24,32*/, biCompression/*BI_RGB,BI_ALPHABITFIELDS*/
public:
    int32 Destroy();
    int32 Create(ExWindow* window); // DDB
    int32 Create(HDC hdcWnd, int32 w, int32 h); // DDB
    int32 Create(int32 w, int32 h, int32 planes, int32 bpp, DWORD biCompression = BI_RGB); // DIB
    friend class ExGdiBmp;
public:
    Ex_DECLARE_TYPEINFO(ExMemDC, ExGdiDC);
};

#endif // WIN32

#endif//__exgdiobj_h__
