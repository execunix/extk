/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exrender_h__
#define __exrender_h__

#include "exwindow.h"

// ExRender
//
struct ExRender {

    static void enter_render() {} // tbd - mutex lock for multi-thread render
    static void leave_render() {} // tbd - mutex lock for multi-thread render

    // multi-thread version
    //
    struct Culling4MT {
        Culling4MT() noexcept {};
        static void startCull(ExWidget* w);
        static bool buildRegion(ExWidget* w);
        static void probeRegion(ExWidget* w); // back to front
    };
    struct Drawing4MT {
        ExCanvas* canvas;
        Drawing4MT(ExCanvas* canvas) noexcept : canvas(canvas) {}
        void startDraw(ExWidget* w);
        void drawWidget(ExWidget* w);
        void drawRecurs(ExWidget* w); // back to front
    };
    static void render4MT(ExCanvas* canvas, ExWidget* widget);

    // single-thread version
    //
    struct Culling4ST {
        ExRegion exposeAcc; // repair on show/hide/move
        ExRegion opaqueAcc; // repair on show/hide/move
        Culling4ST() noexcept : exposeAcc(), opaqueAcc() {}
        void startCull(ExWidget* w, ExCanvas* canvas);
        void stackExpose(ExWidget* w, int32 flag); // recurs - back to front
        void stackOpaque(ExWidget* w); // recurs - front to back
    };
    struct Drawing4ST {
        ExCanvas* canvas;
        ExRegion damageRgn;
        Drawing4ST(ExCanvas* canvas) noexcept : canvas(canvas), damageRgn() {}
        void startDraw(ExWidget* w);
        void drawWidget(ExWidget* w);
        void drawRecurs(ExWidget* w); // back to front
    };
    static void render(ExCanvas* canvas, ExWidget* widget);

};

#endif//__exrender_h__
