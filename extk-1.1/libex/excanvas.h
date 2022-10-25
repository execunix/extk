/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excanvas_h__
#define __excanvas_h__

#include "exobject.h"
#include "exregion.h"
#include "exgdiobj.h"
#include "eximage.h"

// class ExCanvas
//
class ExCanvas : public ExObject {
public:
    ExWindow*   wnd;
    ExImage*    gc;
#ifdef WIN32
    ExMemDC*    dc; // tbd
#endif
    cairo_t*    cr;
    // tbd - protect with window->mutex
    //static cairo_font_face_t* crf[8];
public:
    virtual ~ExCanvas();
    explicit ExCanvas();
public:
    int init(ExWindow* window);
    int init(ExWindow* window, ExSize sz);
    int resize(int w, int h);
    virtual int deleteMemGC();
    virtual int createMemGC(int width, int height); // sample
public:
    Ex_DECLARE_TYPEINFO(ExCanvas, ExObject);
};

#ifdef WIN32
class ExCairoCanvas : public ExCanvas {
protected:
    // tbd
public:
    void* begin(const ExRegion* clip) { return NULL; };
    void* end() { return NULL; };
    // tbd
    Ex_DECLARE_TYPEINFO(ExCairoCanvas, ExCanvas);
};

class ExImageCanvas : public ExCanvas {
protected:
    // tbd
public:
    void* begin(const ExRegion* clip) { return NULL; };
    void* end() { return NULL; };
    // tbd
    Ex_DECLARE_TYPEINFO(ExImageCanvas, ExCanvas);
};

class ExGdiCanvas : public ExCanvas {
protected:
public:
    void* begin(const ExRegion* clip) { return NULL; };
    void* end() { return NULL; };
    // tbd
    Ex_DECLARE_TYPEINFO(ExGdiCanvas, ExCanvas);
};

// for thread model
//
class ExTripleCanvas : public ExCanvas {
protected:
    ExImage*    gcBuf[3];
    cairo_t*    crBuf[3];
public:
    virtual ~ExTripleCanvas();
    explicit ExTripleCanvas();
public:
    // tbd
};

HRGN ExRegionToGdi(HDC hdc, const ExRegion* srcrgn);
#endif

#endif//__excanvas_h__
