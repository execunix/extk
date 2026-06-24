/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exrender.h"

#define logdraw dprint0
#define logdra0 dprint0

// ExRender::Culling4MT
//
ExRender::Culling4MT::Culling4MT(ExWidget* w) noexcept {
    exassert(w->isFlagVisible() && (w->getFlags(Ex_HasOwnGC) != 0U));
    stackExpose(w);
    buildRegion(w);
}

void ExRender::Culling4MT::stackExpose(ExWidget* w) {
    if (!w->isFlagVisible()) {
        return;
    }
    if (w->getFlags(Ex_Exposed) != 0U) {
        // w->buildExtent(); // recurs
        return;
    }
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        stackExpose(c);
    }
}

void ExRender::Culling4MT::buildRegion(ExWidget* w) {
    exassert(w->isFlagVisible() && w->extent.valid());
    for (ExWidget* c = w->getChildTail(); c != nullptr; c = c->getBroPrev()) {
        if ((c->getFlags(Ex_Exposed) != 0U) &&
            c->isFlagVisible()) {
            buildRegion(c);
        }
    }
    w->visualRgn.setRect(w->extent);
    w->flags &= ~Ex_Exposed;
}

// ExRender::Culling
//
void ExRender::Culling::startCull(ExWidget* w, ExCanvas* canvas) {
    #if 0 // allow dump for debug
    exassert(w->isFlagVisible());
    #endif
    // start to stack up exposeAcc region
    stackExpose(w, 0); // recurs - back to front
    // now, widget's extent area is valid
    if (!w->extent.empty() &&
        !exposeAcc.empty()) { // is need repair ?
        // start to stack up opaqueAcc region
        stackOpaque(w); // recurs - front to back
        // now, windget's visual and opaque region is valid
    }
    canvas->opaque.copy(opaqueAcc);
    canvas->update.combine(exposeAcc);
}

void ExRender::Culling::stackExpose(ExWidget* w, int32 flag) {
    bool isVisible = w->isFlagVisible();
    if (flag == 0) { // check exposed
        if (w->getFlags(Ex_Exposed) != 0U) {
            exposeAcc.combine(w->extent); // add old extent
            if (isVisible == false) { // is hide ?
                w->flags &= ~Ex_Exposed;
            } else { // is visible ?
                flag = 1; // need to reset the widget's all hierarchy
            }
        }
    }
    if (isVisible && (flag > 0)) {
        if (w->calcExtent()) { // is valid ?
            if (flag == 1) {
                exposeAcc.combine(w->extent); // add new extent
            } // else, exposeAcc is merged, so need to call calcExtent only
            flag++;
        } else {
            isVisible = false;
        }
    }
    if (isVisible) {
        for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                Culling cull;
                exassert(c->canvas != nullptr);
                cull.startCull(c, c->canvas);
            } else {
                stackExpose(c, flag); // recurs - back to front
            }
        }
    }
}

void ExRender::Culling::stackOpaque(ExWidget* w) { // remove hidden areas
    // exassert(w->isFlagVisible() && w->extent.valid());
    for (ExWidget* c = w->getChildTail(); c != nullptr; c = c->getBroPrev()) {
        // tbd : check canvas opaque for Ex_HasOwnGC
        if (c->isFlagVisible() &&
            c->extent.valid()) {
            stackOpaque(c); // recurs - front to back
        }
    }
    // now, the widget flag is visible and no more child widget
    if ((w->getFlags(Ex_Exposed) != 0U) ||
        (exposeAcc.contain(w->extent) != Ex_OverlapOut)) { // is need repair ?
        // reset the windget's visual and opaque region
        w->calcOpaque(opaqueAcc);
    }
}

// ExRender::Drawing
//
void ExRender::Drawing::startDraw(ExWidget* w) {
    if (w->isFlagVisible()) {
        drawRecurs(w);
    }
}

void ExRender::Drawing::drawWidget(ExWidget* w) {
    if (w->drawFunc && !w->visualRgn.empty()) {
        damageRgn.copy(w->visualRgn);
        if (w->getFlags(Ex_Exposed | Ex_Damaged) == 0U) {
            damageRgn.intersect(canvas->update);
        }
        if (!damageRgn.empty()) {
            w->drawFunc(canvas, w, &damageRgn);
#ifdef DEBUG
            if (exDrawFuncTrap) {
                exDrawFuncTrap(canvas, w, &damageRgn);
            }
#endif
        }
    }
    w->flags &= ~(Ex_Exposed | Ex_Damaged);
}

void ExRender::Drawing::drawRecurs(ExWidget* w) {
    exassert(w->isFlagVisible());
    drawWidget(w);
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        if (c->isFlagVisible()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                // if the canvas owner is self, then repair the widget's contents.
                // else, just need to copy the widget's contents to the canvas.
                Drawing draw(c->canvas);
                draw.startDraw(c); // repair the widget's contents.
                drawWidget(c); // copy the widget's contents to the canvas.
            } else {
                drawRecurs(c);
            }
        }
    }
}

// ExRender
//
void ExRender::render(ExCanvas* canvas, ExWidget* w, uint32 flags) {
    if ((flags & Ex_RenderRebuild) != 0U) {
        Culling cull;
        cull.startCull(w, canvas);
    }
    if (!canvas->update.empty()) {
        Drawing draw(canvas);
        draw.startDraw(w);
    }
}

void ExRender::render4MT(ExCanvas* canvas, ExWidget* w, uint32 flags) {
    if ((flags & Ex_RenderRebuild) != 0U) {
        Culling4MT cull(w);
        canvas->update.copy(w->visualRgn); // tbd
    }
    if (!canvas->update.empty()) {
        Drawing draw(canvas);
        draw.startDraw(w);
    }
}

void ExRender::renderOwnGC(ExCanvas* canvas, ExWidget* w) { // tbd
    if (!canvas->update.empty()) {
        Drawing draw(canvas);
        draw.startDraw(w);
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
