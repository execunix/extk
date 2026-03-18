/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exrender.h"

#define logdraw dprint0
#define logdra0 dprint0

// ExRender::Build4MT
//
void ExRender::Build4MT::checkExtent(ExWidget* w) {
    if (!w->isFlagVisible()) {
        return;
    }
    if (w->getFlags(Ex_Exposed) != 0U) {
        w->buildExtent(); // recurs
        return;
    }
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        checkExtent(c);
    }
}

void ExRender::Build4MT::buildRegion(ExWidget* w) {
    exassert(w->isFlagVisible() && !w->extent.empty());
    for (ExWidget* c = w->getChildTail(); c != nullptr; c = c->getBroPrev()) {
        if ((c->getFlags(Ex_Exposed) != 0U) &&
            c->isFlagVisible()) {
            buildRegion(c);
        }
    }
    w->exposeRgn.setRect(w->extent);
    w->flags &= ~Ex_Exposed;
}

ExRender::Build4MT::Build4MT(ExWidget* w) {
    exassert(w->isFlagVisible() && (w->getFlags(Ex_HasOwnGC) != 0U));
    checkExtent(w);
    buildRegion(w);
}

// ExRender::Build
//
void ExRender::Build::checkExtent(ExWidget* w) {
    if (!w->isFlagVisible()) {
        return;
    }
    if (w->getFlags(Ex_Exposed) != 0U) {
#if 0
        //exposeAcc.combine(w->extent); // add old extent
        buildExtent(w); // recurs
        if (w->getFlags(Ex_HasOwnGC) == 0U) {
            if (w->getFlags(Ex_Opaque) != 0U) {
                exposeAcc.combine(w->extent); // add new extent
            } else if (!w->opaqueRgn.empty()) {
                exposeAcc.combine(w->opaqueRgn);
            } else {
                // nop
            }
        }
#else
        exposeAcc.combine(w->extent); // add old extent
        buildExtent(w); // recurs
        exposeAcc.combine(w->extent); // add new extent
#endif
        return;
    }
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        checkExtent(c);
    }
}

void ExRender::Build::buildExtent(ExWidget* w) {
    exassert(w->isFlagVisible());
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
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        if (c->isFlagVisible()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                Build build(c);
                exposeAcc.combine(build.exposeAcc);
            } else {
                buildExtent(c);
            }
        }
    }
}

void ExRender::Build::buildOpaque(ExWidget* w) { // remove hidden areas
    exassert(w->isFlagVisible() && !w->extent.empty());
    for (ExWidget* c = w->getChildTail(); c != nullptr; c = c->getBroPrev()) {
        if (c->isFlagVisible() && !c->extent.empty()) {
            buildOpaque(c);
        }
    }
    if ((w->getFlags(Ex_Exposed) != 0U) ||
        (exposeAcc.contain(w->extent) != Ex_OverlapOut)) {
        w->calcOpaque(opaqueAcc);
    }
}

ExRender::Build::Build(ExWidget* w)
    : exposeAcc()
    , opaqueAcc() {
#if 0
    exassert((w->getFlags(Ex_Rebuild) != 0U) &&
             w->isFlagVisible() && (w->getFlags(Ex_HasOwnGC) != 0U));
    exposeAcc.copy(w->exposeRgn);
#else
    exassert(w->isFlagVisible() && (w->getFlags(Ex_HasOwnGC) != 0U));
#endif
    checkExtent(w);
    if (!w->extent.empty() &&
        !exposeAcc.empty()) {
        buildOpaque(w);
    }
    w->opaqueRgn.copy(opaqueAcc);
    w->exposeRgn.setRect(w->extent);
}

// ExRender::Draw
//
void ExRender::Draw::draw(ExWidget* w) {
    exassert(w->isFlagVisible());
    if (w->drawFunc && !w->exposeRgn.empty()) {
        if (w->getFlags(Ex_HasOwnGC) != 0U) {
            exassert(&w->damageRgn == &updateRgn);
        } else if (w->getFlags(Ex_Exposed | Ex_Damaged) != 0U) {
            w->damageRgn.copy(w->exposeRgn);
        } else {
            w->damageRgn.copy(w->exposeRgn);
            w->damageRgn.intersect(updateRgn);
        }
        if (!w->damageRgn.empty()) {
            w->drawFunc(canvas, w, &w->damageRgn);
#ifdef DEBUG
            if (exDrawFuncTrap) {
                exDrawFuncTrap(canvas, w, &w->damageRgn);
            }
#endif
        }
    }
    w->flags &= ~(Ex_Exposed | Ex_Damaged);
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        if (c->isFlagVisible()) {
#if 1 // tbd
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                c->drawFunc((ExCanvas*)NULL, c, &c->damageRgn);
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
    exassert(w->getFlags(Ex_HasOwnGC) != 0U);
    if (w->isFlagVisible()) {
        draw(w);
    }
    updateRgn.setEmpty();
}

// ExRender
//
void ExRender::render(ExCanvas* canvas, ExWidget* w, uint32 flags) {
    if ((flags & Ex_RenderRebuild) != 0U) {
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

#if defined(EXAPITEST) // sample pseudo code
void onDrawOwnGC(void* data, ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage) {
    if (canvas == NULL/*my_canvas*/) {
        // draw self & child to my canvas
        ExCanvas my_canvas;
        my_canvas.gc = NULL/*my_gc*/;
        my_canvas.cr = NULL/*my_cr*/;
        ExPoint pt = wgtres->calcRect().u.pt;
        // tbd - translate
        cairo_translate(my_canvas.cr, -pt.x, -pt.y);
        ExWidget* w = (ExWidget*)wgtres;
        ExRender::renderOwnGC(&my_canvas, w);
    } else {
        //flush_my_canvas_to_canvas();
    }
}
#endif

#if defined(EXAPITEST)
uint32 exrender_test1(void*, ExWidget* w, ExCbInfo* cbinfo) {
    if (cbinfo->type != Ex_CbEnumEnter) {
        return Ex_Continue;
    }
    if (!w->isFlagVisible()) {
        dprint("%s [%d,%d-%dx%d] invisible\n", w->getName(),
               w->area.x, w->area.y, w->area.w, w->area.h);
        return Ex_Discard;
    }
    dprint("%s [%d,%d-%dx%d] visible\n", w->getName(),
           w->area.x, w->area.y, w->area.w, w->area.h);
    return Ex_Continue;
}
#endif
