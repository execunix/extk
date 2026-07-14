/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exrender.h"

#define logdraw dprint0
#define logdra0 dprint0

// ExRender::Culling4MT
//
void ExRender::Culling4MT::startCull(ExWidget* w) {
    #if 0 // allow dump for debug
    exassert(w->isFlagVisible());
    #endif
    probeRegion(w); // recurs - back to front
}

bool ExRender::Culling4MT::buildRegion(ExWidget* w) {
    bool isVisible = false;
    if (w->isFlagVisible()) {
        if (w->calcExtent()) { // is valid ?
            w->visualRgn.setRect(w->extent);
            isVisible = true;
        }
    }
    return isVisible;
}

void ExRender::Culling4MT::probeRegion(ExWidget* w) {
    if (buildRegion(w)) {
        for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                exassert(c->canvas != nullptr);
                if ((c->flags & Ex_Rebuild) != 0U) {
                    Culling4MT cull;
                    cull.startCull(c);
                } else { // stop recurs for OwnGC
                    (void)buildRegion(c);
                }
            } else {
                probeRegion(c); // recurs - back to front
            }
        }
    }
    w->flags &= ~Ex_Rebuild;
}

// ExRender::Drawing4MT
//
void ExRender::Drawing4MT::startDraw(ExWidget* w) {
    if (w->isFlagVisible()) {
        drawRecurs(w);
    }
    canvas->update.setEmpty();
}

void ExRender::Drawing4MT::drawWidget(ExWidget* w) {
    if (w->drawFunc && !w->visualRgn.empty()) {
        w->drawFunc(canvas, w, &w->visualRgn);
#ifdef DEBUG
        if (exDrawFuncTrap) {
            exDrawFuncTrap(canvas, w, &w->visualRgn);
        }
#endif
    }
    w->flags &= ~(Ex_Exposed | Ex_Damaged);
}

void ExRender::Drawing4MT::drawRecurs(ExWidget* w) {
    exassert(w->isFlagVisible());
    drawWidget(w);
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        if (c->isFlagVisible()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                //exassert(c->canvas != nullptr);
                enter_render();
                if (!c->canvas->update.empty()) {
                    // if the canvas owner is self, then repair the widget's contents.
                    // else, just need to copy the widget's contents to the canvas.
                    c->canvas->origin = c->origin;
                    Drawing4MT draw(c->canvas);
                    draw.startDraw(c); // repair the widget's contents.
                }
                leave_render();
                drawWidget(c); // copy the widget's contents to the canvas.
            } else {
                drawRecurs(c);
            }
        }
    }
}

// ExRender::render4MT
//
void ExRender::render4MT(ExCanvas* canvas, ExWidget* w) {
    enter_render();
    if ((w->flags & Ex_Rebuild) != 0U) {
        Culling4MT cull;
        cull.startCull(w);
    }
    canvas->update.copy(w->visualRgn);
    leave_render();
    // each canvas can draw in parallel, so no need to lock.
    if (!canvas->update.empty()) {
        Drawing4MT draw(canvas);
        draw.startDraw(w);
    }
}

// ExRender::Culling4ST
//
void ExRender::Culling4ST::startCull(ExWidget* w, ExCanvas* canvas) {
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

void ExRender::Culling4ST::stackExpose(ExWidget* w, int32 flag) {
    bool isVisible = w->isFlagVisible();
    #if 0
    bool isOwnGC = flag > 0x0FFFFFFF;
    #else
    bool isOwnGC = false;
    #endif
    flag &= 0x0FFFFFFF; // clear OwnGC flag
    if (flag == 0) { // check exposed
        if (w->getFlags(Ex_Exposed) != 0U) {
            // marks that the old area should be updated
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
                w->flags |= Ex_Exposed;
                // marks that the new area should be updated
                exposeAcc.combine(w->extent); // add new extent
            } // else, exposeAcc is merged, so need to call calcExtent only
            flag++;
        } else { // extent is not visible
            isVisible = false;
        }
    }
    if (isVisible && !isOwnGC) {
        for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                exassert(c->canvas != nullptr);
                if ((c->flags & Ex_Rebuild) != 0U) {
                    Culling4ST cull;
                    cull.startCull(c, c->canvas);
                    if (flag == 0) { // is not merged ?
                        exposeAcc.combine(cull.exposeAcc);
                    }
                } else {
                    stackExpose(c, flag | 0x10000000); // stop recurs for OwnGC
                }
            } else {
                stackExpose(c, flag); // recurs - back to front
            }
        }
    }
}

void ExRender::Culling4ST::stackOpaque(ExWidget* w) { // remove hidden areas
    // exassert(w->isFlagVisible() && w->extent.valid());
    for (ExWidget* c = w->getChildTail(); c != nullptr; c = c->getBroPrev()) {
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

// ExRender::Drawing4ST
//
void ExRender::Drawing4ST::startDraw(ExWidget* w) {
    if (w->isFlagVisible()) {
        drawRecurs(w);
    }
    canvas->update.setEmpty();
}

void ExRender::Drawing4ST::drawWidget(ExWidget* w) {
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
    w->flags &= ~(Ex_Rebuild | Ex_Exposed | Ex_Damaged);
}

void ExRender::Drawing4ST::drawRecurs(ExWidget* w) {
    exassert(w->isFlagVisible());
    drawWidget(w);
    for (ExWidget* c = w->getChildHead(); c != nullptr; c = c->getBroNext()) {
        if (c->isFlagVisible()) {
            if (c->getFlags(Ex_HasOwnGC) != 0U) {
                //exassert(c->canvas != nullptr);
                if (!c->canvas->update.empty()) {
                    // if the canvas owner is self, then repair the widget's contents.
                    // else, just need to copy the widget's contents to the canvas.
                    c->canvas->origin = c->origin;
                    Drawing4ST draw(c->canvas);
                    draw.startDraw(c); // repair the widget's contents.
                }
                drawWidget(c); // copy the widget's contents to the canvas.
            } else {
                drawRecurs(c);
            }
        }
    }
}

// ExRender::render4MT
//
void ExRender::render(ExCanvas* canvas, ExWidget* w) {
    if ((w->flags & Ex_Rebuild) != 0U) {
        Culling4ST cull;
        cull.startCull(w, canvas);
    }
    if (!canvas->update.empty()) {
        Drawing4ST draw(canvas);
        draw.startDraw(w);
    }
}

#if defined(EXAPITEST) // sample pseudo code
void onDrawOwnGC(void* data, ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(wgtres->calcRect());
    if ((wgtres->canvas == nullptr) || (wgtres->canvas == canvas)) {
        // draw self & child to my canvas
        // cairo_...
    } else { // copy the widget's contents to the canvas.
        cairo_set_source_surface(cr, wgtres->canvas->gc.crs, rc.x, rc.y);
        cairo_paint(cr);
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
