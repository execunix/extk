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
    struct Build4MT {
        static void checkExtent(ExWidget* w);
        static void buildRegion(ExWidget* w);
        Build4MT(ExWidget* w);
    };
    struct Build {
        ExRegion exposeAcc;
        ExRegion opaqueAcc;

        void checkExtent(ExWidget* w);
        void buildExtent(ExWidget* w);
        void buildOpaque(ExWidget* w);
        Build(ExWidget* w);
    };
    struct Draw {
        ExCanvas* canvas;
        ExRegion& updateRgn;
        void draw(ExWidget* w);
        Draw(ExCanvas*, ExWidget*);
    };
    static void render(ExCanvas* canvas, ExWidget* widget, int flags);
    static void renderOwnGC(ExCanvas* canvas, ExWidget* widget);
};

#endif//__exrender_h__
