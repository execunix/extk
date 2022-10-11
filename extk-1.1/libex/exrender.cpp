/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exrender.h"
#include <assert.h>

#define logdraw dprint0
#define logdra0 dprint0

// ExRender::Build4MT
//
void ExRender::Build4MT::checkExtent(ExWidget* w) {
    if (!w->getFlags(Ex_Visible))
        return;
    if (w->getFlags(Ex_Exposed)) {
        w->buildExtent(); // recurs
        return;
    }
    for (ExWidget* c = w->getChildHead(); c; c = c->getBroNext())
        checkExtent(c);
}

void ExRender::Build4MT::buildRegion(ExWidget* w) {
    assert(w->getFlags(Ex_Visible) && !w->extent.empty());
    for (ExWidget* c = w->getChildTail(); c; c = c->getBroPrev()) {
        if (c->getFlags(Ex_Exposed) &&
            c->getFlags(Ex_Visible)) {
            buildRegion(c);
        }
    }
    w->exposeRgn.setRect(w->extent);
    w->flags &= ~Ex_Exposed;
}

ExRender::Build4MT::Build4MT(ExWidget* w) {
    assert(w->getFlags(Ex_Visible) && w->getFlags(Ex_HasOwnGC));
    checkExtent(w);
    buildRegion(w);
}

// ExRender::Build
//
void ExRender::Build::checkExtent(ExWidget* w) {
    if (!w->getFlags(Ex_Visible))
        return;
    if (w->getFlags(Ex_Exposed)) {
#if 0
        //exposeAcc.combine(w->extent); // add old extent
        buildExtent(w); // recurs
        if (!w->getFlags(Ex_HasOwnGC)) {
            if (w->getFlags(Ex_Opaque))
                exposeAcc.combine(w->extent); // add new extent
            else if (!w->opaqueRgn.empty())
                exposeAcc.combine(w->opaqueRgn);
        }
#else
        exposeAcc.combine(w->extent); // add old extent
        buildExtent(w); // recurs
        exposeAcc.combine(w->extent); // add new extent
#endif
        return;
    }
    for (ExWidget* c = w->getChildHead(); c; c = c->getBroNext())
        checkExtent(c);
}

void ExRender::Build::buildExtent(ExWidget* w) {
    assert(w->getFlags(Ex_Visible));
    if (!w->calcExtent()) {
        w->flags &= ~(Ex_Exposed | Ex_Damaged);
        w->exposeRgn.setEmpty();
        w->damageRgn.setEmpty();
        return;
    }
#if 0
    w->exposeRgn.setRect(w->extent);
    w->flags |= (Ex_Exposed | Ex_Damaged);
#else
    w->flags |= Ex_Exposed;
#endif
    for (ExWidget* c = w->getChildHead(); c; c = c->getBroNext()) {
        if (c->getFlags(Ex_Visible)) {
            if (c->getFlags(Ex_HasOwnGC)) {
                Build build(c);
                exposeAcc.combine(build.exposeAcc);
            } else {
                buildExtent(c);
            }
        }
    }
}

void ExRender::Build::buildOpaque(ExWidget* w) { // remove hidden areas
    assert(w->getFlags(Ex_Visible) && !w->extent.empty());
    for (ExWidget* c = w->getChildTail(); c; c = c->getBroPrev()) {
        if (c->getFlags(Ex_Visible) && !c->extent.empty()) {
            buildOpaque(c);
        }
    }
    if (w->getFlags(Ex_Exposed) ||
        exposeAcc.contain(w->extent) != Ex_OverlapOut) {
        w->calcOpaque(opaqueAcc);
    }
}

ExRender::Build::Build(ExWidget* w)
    : exposeAcc()
    , opaqueAcc() {
#if 0
    assert(w->getFlags(Ex_Rebuild) &&
           w->getFlags(Ex_Visible) &&
           w->getFlags(Ex_HasOwnGC));
    exposeAcc.copy(w->exposeRgn);
#else
    assert(w->getFlags(Ex_Visible) && w->getFlags(Ex_HasOwnGC));
#endif
    checkExtent(w);
    if (!w->extent.empty() &&
        !exposeAcc.empty())
        buildOpaque(w);
    w->opaqueRgn.copy(opaqueAcc);
    w->exposeRgn.setRect(w->extent);
}

// ExRender::Draw
//
void ExRender::Draw::draw(ExWidget* w) {
    assert(w->getFlags(Ex_Visible));
    if (w->drawFunc && !w->exposeRgn.empty()) {
        if (w->getFlags(Ex_HasOwnGC)) {
            assert(&w->damageRgn == &updateRgn);
        } else if (w->getFlags(Ex_Exposed | Ex_Damaged)) {
            w->damageRgn.copy(w->exposeRgn);
        } else {
            w->damageRgn.copy(w->exposeRgn);
            w->damageRgn.intersect(updateRgn);
        }
        if (!w->damageRgn.empty()) {
            w->drawFunc(canvas, w, &w->damageRgn);
#ifdef DEBUG
            if (exDrawFuncTrap)
                exDrawFuncTrap(canvas, w, &w->damageRgn);
#endif
        }
    }
    w->flags &= ~(Ex_Exposed | Ex_Damaged);
    for (ExWidget* c = w->getChildHead(); c; c = c->getBroNext()) {
        if (c->getFlags(Ex_Visible)) {
#if 1 // tbd
            if (c->getFlags(Ex_HasOwnGC)) {
                c->drawFunc(NULL, c, &c->damageRgn);
                // I don't know, but you know what canvas to draw on ...
                // I will give you the opportunity to fill in the content of the canvas ...
            }
#endif
            draw(c);
        }
    }
}

ExRender::Draw::Draw(ExCanvas* canvas, ExWidget* w)
    : canvas(canvas), updateRgn(w->damageRgn) {
    assert(w->getFlags(Ex_HasOwnGC));
    if (w->getFlags(Ex_Visible))
        draw(w);
    updateRgn.setEmpty();
}

// ExRender
//
void ExRender::render(ExCanvas* canvas, ExWidget* w, int flags) {
    if (flags & Ex_RenderRebuild) {
        Build build(w);
        w->damageRgn.combine(build.exposeAcc);
        //Build4MT build(w);
        //w->damageRgn.copy(w->exposeRgn);
    }
    if (!w->damageRgn.empty()) {
        Draw(canvas, w);
    }
}

void ExRender::renderOwnGC(ExCanvas* canvas, ExWidget* w) { // tbd
    if (!w->damageRgn.empty()) {
        Draw(canvas, w);
    }
}

#if 1 // sample pseudo code
static void STDCALL onDrawOwnGC(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    if (canvas == NULL/*my_canvas*/) {
        // draw self & child to my canvas
        ExCanvas my_canvas;
        my_canvas.gc = NULL/*my_gc*/;
        my_canvas.cr = NULL/*my_cr*/;
        ExPoint pt = widget->calcRect().u.pt;
        // tbd - translate
        cairo_translate(my_canvas.cr, -pt.x, -pt.y);
        ExWidget* w = (ExWidget*)widget;
        ExRender::renderOwnGC(&my_canvas, w);
    } else {
        //flush_my_canvas_to_canvas();
    }
}
#endif

static int test1(void*, ExWidget* w, ExCbInfo* cbinfo) {
    if (cbinfo->type != Ex_CbEnumEnter)
        return Ex_Continue;
    if (!w->getFlags(Ex_Visible)) {
        dprint(L"%s [%d,%d-%dx%d] invisible\n", w->getName(),
               w->area.x, w->area.y, w->area.w, w->area.h);
        return Ex_Discard;
    }
    dprint(L"%s [%d,%d-%dx%d] visible\n", w->getName(),
           w->area.x, w->area.y, w->area.w, w->area.h);
    return Ex_Continue;
}
