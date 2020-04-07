/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excanvas_h__
#define __excanvas_h__

#include <exobject.h>
#include <exregion.h>
#include <exgdiobj.h>
#include <eximage.h>

// class ExCanvas
//
class ExCanvas : public ExObject {
public:
    ExWindow*   wnd;
    ExImage*    gc;
    ExMemDC*    dc; // tbd
    cairo_t*    cr;
    // tbd - protect with window->mutex
    static cairo_font_face_t* crf[8];
public:
    virtual ~ExCanvas();
    explicit ExCanvas();
public:
    int init(ExWindow* window);
    int size(int w, int h) { return 0; } // tbd
    int newFace(int id, const char* faceName);
    int setFont(int id, int size);
    virtual int deleteMemGC();
    virtual int createMemGC(int width, int height); // sample
    void setRegion(const ExRegion* srcrgn);
public:
    Ex_DECLARE_TYPEINFO(ExCanvas, ExObject);
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
#endif//__excanvas_h__
