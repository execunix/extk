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
    struct Culling4MT { // multi-thread version
        Culling4MT(ExWidget* w) noexcept;
        static void stackExpose(ExWidget* w); // recurs - back to front
        static void buildRegion(ExWidget* w); // recurs - front to back
    };
    struct Culling {
        ExRegion exposeAcc; // repair on show/hide/move
        ExRegion opaqueAcc; // repair on show/hide/move
        Culling() noexcept : exposeAcc(), opaqueAcc() {}
        void startCull(ExWidget* w, ExCanvas* canvas);
        void stackExpose(ExWidget* w, int32 flag); // recurs - back to front
        void stackOpaque(ExWidget* w); // recurs - front to back
    };
    struct Drawing {
        ExCanvas* canvas;
        ExRegion damageRgn;
        Drawing(ExCanvas* canvas) noexcept : canvas(canvas), damageRgn() {}
        void startDraw(ExWidget* w);
        void drawWidget(ExWidget* w);
        void drawRecurs(ExWidget* w); // back to front
    };
    static void render(ExCanvas* canvas, ExWidget* widget, uint32 flags);
    static void render4MT(ExCanvas* canvas, ExWidget* widget, uint32 flags);
    static void renderOwnGC(ExCanvas* canvas, ExWidget* widget);
};

#endif//__exrender_h__
