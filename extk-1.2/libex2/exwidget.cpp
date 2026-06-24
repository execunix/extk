/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "excairo.h"
#include "eximage.h"
#include "exapp.h"
#include <cairo.h>

#define logdraw dprint0
#define logdra0 dprint0

// test sample
static void s_fill(void* data, const ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage) {
#if 1
    if (!(canvas && canvas->cr))
        return;
    ExCairo cr(canvas, damage);
    ExCairo::Box bx(wgtres->calcBox());

    //bx.l += 1.F;
    //bx.t += 1.F;
    //bx.r -= 1.F;
    //bx.b -= 1.F;

    cairo_new_path(cr);
    cairo_move_to(cr, bx.l, bx.t);
    cairo_line_to(cr, bx.r, bx.t);
    cairo_line_to(cr, bx.r, bx.b);
    cairo_line_to(cr, bx.l, bx.b);
    cairo_close_path(cr);

    ExCairo::Color lc; // line color
    uint32 c = ((uint64)wgtres) & 0xffffff;
    lc.setv(ExRValue(c), ExGValue(c), ExBValue(c), 96);

    cairo_set_line_width(cr, 1.f);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
    cairo_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
    cairo_stroke(cr);
#else // deprecated
    HWND hwnd = wgtres->getWindow()->getHwnd();
    HDC hdc = GetDC(hwnd ? hwnd : GetDesktopWindow());
    COLORREF c = ((uint64)wgtres) & 0xffffff;//RGB(0, 0, 128);
    HBRUSH hbr = CreateSolidBrush(c);
    for (int32 i = 0; i < damage->n_boxes; i++)
        FillRect(hdc, damage->boxes[i], hbr);
    DeleteObject(hbr);
#endif
}

// class ExWgtRes
//
ExWgtRes::~ExWgtRes() noexcept {
    if (name != nullptr) {
        free(name);
    }
    if (canvas != nullptr) {
        delete canvas;
    }
}

ExWgtRes::ExWgtRes() noexcept
    : ExObject()
    , name(nullptr)
    , extent(0)
    , select(0)
    , origin(0)
    , visualRgn()
    , opaqueRgn()
    , flags(Ex_Destroyed)
    , _ra_1(0)
    , data(nullptr)
    , canvas(nullptr)
    , drawFunc()
    , area(0)
    , id(0)
    , value(0)
    , shape(0)
    , state(0)
    , style(nullptr)
    , userdata {
#if defined(_MSC_VER)
        0ull,
#else
        .u64 = { 0ull, }
#endif
    } {
#ifdef DEBUG // test
    drawFunc = ExDrawFunc(&s_fill, (void*)nullptr); // tbd
#endif
    //flags |= Ex_Opaque; // test
    flags |= Ex_Visible; // default visible
}

void ExWgtRes::setName(const char* text) {
    char buf[20];
    if (name != nullptr) {
        free(name);
    }
    if (text == nullptr) {
        snprintf(buf, 20, "%p", this);
        text = buf;
    }
    name = strdup(text);
}

ExBox& ExWgtRes::calcBox(ExBox& bx) const {
    bx.l = origin.x;
    bx.t = origin.y;
    bx.r = bx.l + area.w;
    bx.b = bx.t + area.h;
    return bx;
}

ExRect& ExWgtRes::calcRect(ExRect& rc) const {
    rc.x = origin.x;
    rc.y = origin.y;
    rc.w = area.w;
    rc.h = area.h;
    return rc;
}

// class ExWidget
//
ExWidget::~ExWidget() noexcept {
    // clean
}

ExWidget::ExWidget() noexcept
    : ExWgtRes()
    , parent(nullptr)
    , broNext(nullptr)
    , broPrev(nullptr)
    , childHead(nullptr)
    , listenerList() {
}

void ExWidget::detachAll() {
    vanish(getWindow());
    for (ExWidget* w = last(); w != nullptr; w = last()) {
        dprint1("detach: %s\n", w->name);
        w->detachParent();
        if (w == this) {
            break;
        }
    }
}

void ExWidget::detachParent() {
    if (parent == nullptr) {
        return;
    }
    if (getFlags(Ex_Destroyed) == 0U) {
        vanish(getWindow());
    }
    ExWidget* next = nullptr;
    if (broNext != this) {
        broNext->broPrev = broPrev;
        broPrev->broNext = broNext;
        next = broNext;
    }
    if (parent->childHead == this) {
        parent->childHead = next;
    }
    parent = broNext = broPrev = nullptr;
}

void ExWidget::attachHead(ExWidget* child) {
    exassert(child != this);
    if (child == nullptr) {
        return;
    }
    if (childHead == child) { // already attached to the head
        return;
    }

    child->detachParent();

    if (childHead == nullptr) {
        child->broNext = child;
        child->broPrev = child;
    } else {
        child->broNext = childHead;
        child->broPrev = childHead->broPrev;
        childHead->broPrev->broNext = child;
        childHead->broPrev = child;
    }
    childHead = child;
    child->parent = this;
    child->flags |= Ex_Damaged;
}

void ExWidget::attachTail(ExWidget* child) {
    exassert(child != this);
    if (child == nullptr) {
        return;
    }
    if (childTail() == child) { // already attached to the tail
        return;
    }

    child->detachParent();

    if (childHead == nullptr) {
        childHead = child;
        child->broNext = child;
        child->broPrev = child;
    } else {
        child->broNext = childHead;
        child->broPrev = childHead->broPrev;
        childHead->broPrev->broNext = child;
        childHead->broPrev = child;
    }
    child->parent = this;
    child->flags |= Ex_Damaged;
}

ExWidget* ExWidget::seekNext(ExWidget* seek) {
    if (seek->childHead != nullptr) {
        return seek->childHead;
    }
    while (seek->parent != nullptr) {
        if (seek->broNext != seek->parent->childHead) {
            return seek->broNext;
        }
        seek = seek->parent;
    }
    return nullptr;
}

ExWidget* ExWidget::seekPrev(ExWidget* seek) {
    if (seek->parent == nullptr) { // is root ?
        return nullptr;
    }
    if (seek->parent->childHead == seek) {
        return seek->parent;
    }
    seek = seek->broPrev;
    while (seek->childHead != nullptr) {
        seek = seek->childHead->broPrev;
    }
    return seek;
}

ExWidget* ExWidget::seekLast(ExWidget* seek) { // top-most
    while (seek->childHead != nullptr) {
        seek = seek->childHead->broPrev;
    }
    return seek;
}

void ExWidget::dumpBackToFront(ExWidget* end) {
    ExWidget* w = this;
    for (; (w != nullptr) && (w != end); w = w->next()) {
        dprint1("seek name: %s\n", w->name);
    }
}

void ExWidget::dumpFrontToBack(ExWidget* end) {
    ExWidget* w = this;
    for (; (w != nullptr) && (w != end); w = w->prev()) {
        dprint1("seek name: %s\n", w->name);
    }
}

ExBox& ExWidget::getBox(ExBox& bx) const {
    ExPoint pt = area.u.pt;
    const ExWidget* w = this;
    for (; (w != nullptr) && !w->isClassDisjoint(); w = w->parent) {
        pt += w->area.u.pt;
    }
    bx.l = pt.x;
    bx.t = pt.y;
    bx.r = bx.l + area.w;
    bx.b = bx.t + area.h;
    return bx;
}

ExRect& ExWidget::getRect(ExRect& rc) const {
    ExPoint pt = area.u.pt;
    const ExWidget* w = this;
    for (; (w != nullptr) && !w->isClassDisjoint(); w = w->parent) {
        pt += w->area.u.pt;
    }
    rc.x = pt.x;
    rc.y = pt.y;
    rc.w = area.w;
    rc.h = area.h;
    return rc;
}

uint32 ExWidget::init(ExWidget* parent, const char* name, const ExRect* area) {
    this->setName(name);
    if (parent) {
        parent->attachTail(this);
    }
    if (area) {
        this->area = *area;
    }
    flags |= (Ex_Exposed | Ex_Damaged);
    addRenderFlags(Ex_RenderRebuild); // for setup visualRgn
    flags &= ~Ex_Destroyed;
    return 0;
}

ExWidget* // static
ExWidget::create(ExWidget* parent, const char* name, const ExRect* area) {
    ExWidget* widget = new ExWidget();
    exassert(widget != nullptr);
    widget->flags |= Ex_FreeMemory;
    widget->init(parent, name, area);
    return widget;
}

uint32 ExWidget::destroy() {
    if (getFlags(Ex_Destroyed) != 0U) {
        return 1;
    }
    ExWindow* window = getWindow();
    ExWidgetList destroyed;
    vanish(window);
    for (ExWidget* w = last(); w != nullptr; w = last()) {
        dprint0("destroy: %s\n", w->name);
        w->flags |= Ex_Destroyed;
        w->detachParent();
        if (window->wgtCapture == w) {
            window->wgtCapture = nullptr;
        }
        if (window->wgtEntered == w) {
            window->wgtEntered = nullptr;
        }
        if (window->wgtPressed == w) {
            window->wgtPressed = nullptr;
        }
        destroyed.push_back(w);
        if (w == this) {
            break;
        }
    }
    ExWidgetList::iterator i = destroyed.begin();
    while (i != destroyed.end()) {
        ExWidget* w = *i;
        // tbd - detach listenerList
        w->invokeListener(Ex_CbDestroyed);
        if (w->getFlags(Ex_FreeMemory) != 0U) {
            ExApp::addCollectWidget(w);
        }
        ++i;
    }
    return 0;
}

uint32 ExWidget::realize() {
    if (getFlags(Ex_Realized) != 0U) {
        return 1;
    }
    ExWidget* end = last();
    for (ExWidget* w = this; w != nullptr; w = next()) {
        if ((w->getFlags(Ex_Realized) == 0U) && w->isVisible()) {
            dprint1("realize: %s\n", w->name);
            w->flags |= Ex_Realized;
            w->invokeListener(Ex_CbRealized);
        }
        if (w == end) {
            break;
        }
    }
    return 0;
}

uint32 ExWidget::unrealize() {
    if (getFlags(Ex_Realized) == 0U) {
        return 1;
    }
    ExWidget* end = this;
    for (ExWidget* w = last(); w != nullptr; w = prev()) {
        if (w->getFlags(Ex_Realized) != 0U) {
            dprint1("unrealize: %s\n", w->name);
            w->flags &= ~Ex_Realized;
            w->invokeListener(Ex_CbUnrealized);
        }
        if (w == end) {
            break;
        }
    }
    return 0;
}

void ExWidget::addRenderFlags(uint32 value) {
    for (ExWidget* w = this; w != nullptr; w = w->parent) {
        if (w->isClassDisjoint() && isFlagVisible()) {
            ((ExWindow*)w)->renderFlags |= value;
            return;
        }
    }
}

void ExWidget::addUpdateRegion(const ExRegion& rgn) {
    if (isVisible()) {
        for (ExWidget* w = this; w != nullptr; w = w->parent) {
            if (w->canvas != nullptr) {
                w->canvas->update.combine(rgn); // translated to the disjoint
            }
        }
    }
}

void ExWidget::subUpdateRegion(const ExRegion& rgn) {
    if (isVisible()) {
        for (ExWidget* w = this; w != nullptr; w = w->parent) {
            if (w->canvas != nullptr) {
                w->canvas->update.subtract(rgn); // translated to the disjoint
            }
        }
    }
}

void ExWidget::resetArea() {
    if (isVisible() && ((getFlags(Ex_Exposed) == 0U))) {
        // marks that the old area should be updated
        if (extent.valid()) {
            addUpdateRegion(ExRegion(extent));
        }
        addRenderFlags(Ex_RenderRebuild);
    }
    // tbd - distinguish between move and resize
    flags |= Ex_Exposed;
}

void ExWidget::setVisible(bool show) {
    if (!isFlagVisible() == !show) {
        return;
    }
    if (!show) {
        vanish(getWindow());
        flags &= ~Ex_Visible;
        visualRgn.setEmpty();
    } else {
        flags |= Ex_Visible;
        addRenderFlags(Ex_RenderRebuild);
    }
    flags |= Ex_Exposed; // mark as show or hide
    return;
}

bool ExWidget::isVisible() const {
    const ExWidget* w = this;
    for (; (w != nullptr) && w->isFlagVisible(); w = w->parent) {
        if (w->isClassDisjoint()) {
            return true;
        }
    }
    return false;
}

uint32 ExWidget::vanish(ExWindow* window) {
    if (getFlags(Ex_Destroyed) != 0U) {
        return 1;
    }
    if (window != nullptr) {
        if (getFlags(Ex_Focused) != 0U) {
            window->giveFocus(parent);
        }
        if ((window != this) && isVisible()) {
            window->renderFlags |= Ex_RenderRebuild;
            window->canvas->update.combine(ExRegion(extent)); // inval
        }
    }
    return 0;
}

uint32 ExWidget::layout(ExRect& ar) {
    // Layout is to determine its own area relative to the parent,
    // regardless of whether it is visible or not.
    area = ar;

    //if (parent != nullptr) {
    //    origin.x = area.x + parent->origin.x;
    //    origin.y = area.y + parent->origin.y;
    //}
    ExCbInfo cbinfo(Ex_CbLayout, Ex_LayoutInit, nullptr, &ar);
    invokeListener(Ex_CbLayout, &cbinfo);

    flags |= Ex_Exposed; // mark as reset visualRgn
    addRenderFlags(Ex_RenderRebuild);

    return 0;
}

uint32 ExWidget::damage() {
    if (!isFlagVisible()) {
        return -1;
    }
    if ((getFlags(Ex_Damaged | Ex_Exposed) != 0U) ||
        visualRgn.empty()) {
        return 1;
    }
    flags |= Ex_Damaged;
    addUpdateRegion(visualRgn);
    return 0;
}

uint32 ExWidget::damage(const ExBox& clip) {
    addUpdateRegion(ExRegion(clip));
    return 0;
}

/**
Extent Method
-------------
Invokes the Extent method of ExWidget via ExSuperClassCalcExtent().
The resulting extent is then adjusted to account for borders and margins.
The Extent method calculates the widget's opaque rectangle and determines whether
the widget's Ex_Opaque flag is set. The opaque rectangle, widget->opaqueRgn,
indicates:
    - the rectangle under which damage needn't occur if this widget is damaged
    - what should be damaged if this widget changes position or dimension
This rectangle is the area capable of obscuring any widgets beneath. Widgets
completely obscured by another widget aren't drawn.
*/
bool ExWidget::calcExtent() {
    const bool isRoot = (parent == nullptr) || isClassDisjoint();
    if (isRoot) {
        origin.x = 0;
        origin.y = 0;
    } else {
        origin.x = area.x + parent->origin.x;
        origin.y = area.y + parent->origin.y;
    }
    extent.l = origin.x;
    extent.t = origin.y;
    extent.r = origin.x + area.w;
    extent.b = origin.y + area.h;
    if (!extent.valid()) {
        return false;
    }
    if (!isRoot &&
        !extent.intersect(parent->extent)) { // is empty ?
        flags &= ~(Ex_Exposed | Ex_Damaged);
        visualRgn.setEmpty();
        return false;
    }
    flags |= Ex_Exposed;
    logdraw("extent: %s [%d,%d-%dx%d]\n", getName(),
            extent.l, extent.t, extent.width(), extent.height());
    return true;
}

/**
Calc Opaque Rect Method
-----------------------
Sets or clears the widget's Ex_Opaque flag based on the widget's attribute.
When the Ex_Opaque flag is set for a widget, it means the widget draws over the
entire widget extent area. This allows the widget library to be smart about redrawing
the widget, because it knows that nothing beneath the widget needs to be redrawn.
This flag is essential for creating flicker-free effects. If any part of the widget is
transparent(i.e. any widget beneath can be seen), the Ex_Opaque flag must be cleared.
*/
void
ExWidget::calcOpaque(ExRegion& opaqueAcc) {
    exassert(!extent.empty());
    visualRgn.setRect(extent);
    visualRgn.subtract(opaqueAcc);
    if (!drawFunc) {
        // if no drawFunc then it's transparent
    } else if (getFlags(Ex_Opaque) != 0U) {
        opaqueAcc.combine(extent);
    } else if (!opaqueRgn.empty()) {
        ExRegion clipRgn(extent);
        clipRgn.move(-origin);
        clipRgn.intersect(opaqueRgn);
        clipRgn.move(origin);
        opaqueAcc.combine(clipRgn);
    } else {
        // nop
    }
    logdraw("opaque: %s [%d,%d-%dx%d] visible:%d blind:%d\n", getName(),
            visualRgn.extent.l, visualRgn.extent.t,
            visualRgn.extent.width(), visualRgn.extent.height(),
            visualRgn.n_boxes, opaqueAcc.n_boxes);
}

// void ExWidget::buildExtent() {
//     exassert(isFlagVisible());
//     if (!calcExtent()) {
//         flags &= ~(Ex_Exposed | Ex_Damaged);
//         visualRgn.setEmpty();
//         return;
//     }
//     flags |= Ex_Exposed;
//     for (ExWidget* c = getChildHead(); c != nullptr; c = c->getBroNext()) {
//         if (c->isFlagVisible()) {
//             c->buildExtent();
//         }
//     }
// }

// void ExWidget::buildRegion() { // simple ver for gpu
//     exassert(isFlagVisible() && !extent.empty());
//     for (ExWidget* c = getChildTail(); c != nullptr; c = c->getBroPrev()) {
//         if ((c->getFlags(Ex_Exposed) != 0U) &&
//             c->isFlagVisible()) {
//             c->buildRegion();
//         }
//     }
//     visualRgn.setRect(extent);
// }

void ExWidget::dumpImage(const ExCanvas* canvas) {
    exassert(isFlagVisible() && !extent.empty());
    if (drawFunc && !visualRgn.empty()) {
        drawFunc(canvas, this, &visualRgn);
#ifdef DEBUG
        if (exDrawFuncTrap)
            exDrawFuncTrap(canvas, this, &visualRgn);
#endif
    }
    for (ExWidget* c = getChildHead(); c != nullptr; c = c->getBroNext()) {
        if (c->isFlagVisible() && !c->extent.empty()) {
            c->dumpImage(canvas);
        }
    }
}

#if 0 // deprecated...
uint32 ExWidget::dumpImage(const ExCanvas* canvas, const ExRegion& updateRgn) { // tbd
    uint32 call_cnt = 0;
    logdraw("%s(%s) enter update:%d\n", _func_, getName(), updateRgn.n_boxes);
    ExWidget* w = this;
    ExWidget* c;
    do { // back to front iterator
proc_enter:
        if (!w->isFlagVisible() || w->extent.empty()) {
            goto proc_leave; // leave to parent and goto next_child
        }
        if (w->drawFunc && !w->visualRgn.empty()) {
            if (w->getFlags(Ex_Damaged) != 0U) {
                w->damageRgn.copy(w->visualRgn);
            } else {
                w->damageRgn.copy(w->visualRgn);
                w->damageRgn.intersect(updateRgn);
            }
            if (!w->damageRgn.empty()) {
                logdraw("render: %s visible:%d damage:%d\n", w->getName(),
                        w->visualRgn.n_boxes, w->damageRgn.n_boxes);
                w->drawFunc(canvas, w, &w->damageRgn);
#ifdef DEBUG
                if (exDrawFuncTrap) {
                    exDrawFuncTrap(canvas, w, &w->damageRgn);
                }
#endif
                call_cnt++;
                if (w->getFlags(Ex_HasOwnGC) != 0U) { // tbd - tbd
                    goto proc_clear;
                }
            }
        }
        // proc done

        // back to front
        c = w->childHead;
        while (c != nullptr) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead->broPrev ? c->broNext : nullptr;
        }
proc_clear:
        logdra0("render: %s clear damage\n", w->getName());
        w->flags &= ~Ex_Damaged;
        w->damageRgn.setEmpty();
proc_leave:
        if ((w == this) ||
            (w->parent == nullptr)) { // is root ?
            break;
        }
        c = w;
        w = w->parent;
        goto next_child;
    } while (false);
    return call_cnt;
}
#endif

ExWidget* ExWidget::getPointOwner(const ExPoint& pt) {
    ExWidget* w = this;
    ExWidget* c;
    do { // front to back iterator
proc_enter:
        if (!w->isFlagVisible()) {
            goto proc_leave; // leave to parent and goto next_child
        }
        // front to back
        c = w->childHead ? w->childHead->broPrev : nullptr;
        while (c != nullptr) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead ? c->broPrev : nullptr;
        }
        // w is visible and ...
        if (w->isSelectable(pt)) {
            return w;
        }
        // proc done
proc_leave:
        if ((w == this) ||
            (w->parent == nullptr)) { // is root ?
            break;
        }
        c = w;
        w = w->parent;
        goto next_child;
    } while (false);
    return nullptr;
}

ExWidget* ExWidget::getSelectable(const ExPoint& pt) {
    ExWidget* w = this;
    ExWidget* c;
    do { // front to back iterator
proc_enter:
        if (!w->isFlagVisible()) {
            goto proc_leave; // leave to parent and goto next_child
        }
        // front to back
        c = w->childHead ? w->childHead->broPrev : nullptr;
        while (c != nullptr) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead ? c->broPrev : nullptr;
        }
        // w is visible and ...
        if ((w->getFlags(Ex_Selectable | Ex_AutoHighlight) != 0U) &&
            w->isSelectable(pt)) {
            for (ExWidget* p = w; ; p = p->parent) {
                if (p->getFlags(Ex_Blocked) != 0U) {
                    return nullptr;
                }
                if ((p == this) ||
                    (p->parent == nullptr)) {
                    break;
                }
            }
            return w;
        }
        // proc done
proc_leave:
        if ((w == this) ||
            (w->parent == nullptr)) { // is root ?
            break;
        }
        c = w;
        w = w->parent;
        goto next_child;
    } while (false);
    return nullptr;
}

void ExWidget::setOpaqueRegion(const ExRegion& op) {
    if (opaqueRgn.equal(op)) {
        return;
    }
    opaqueRgn.copy(op);
    flags |= Ex_Exposed;
    addRenderFlags(Ex_RenderRebuild);
}

void ExWidget::setOpaque(bool set) {
    if (!getFlags(Ex_Opaque) == !set) {
        return;
    }
    if (set) {
        flags |= Ex_Opaque;
    } else {
        flags &= ~Ex_Opaque;
    }
    flags |= Ex_Exposed;
    addRenderFlags(Ex_RenderRebuild);
}

ExWidget* // static
ExWidget::enumBackToFront(ExWidget* begin, ExWidget* end, const ExCallback& cb, ExCbInfo* cbinfo) {
    uint32 r;
    ExCbInfo ci(0);
    if (cbinfo == nullptr) {
        cbinfo = &ci;
    }
    ExWidget* w = begin;
    ExWidget* c;
    do { // back to front iterator
proc_enter:
        cbinfo->type = Ex_CbEnumEnter;
        r = cb(w, cbinfo);
        if ((r & Ex_Break) != 0U) {
            return w;
        }
        if ((r & Ex_Discard) != 0U) { // discard proc and skip leave callback
            goto proc_leave; // leave to parent and goto next_child
        }
        // back to front
        c = w->childHead;
        while (c != nullptr) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead->broPrev ? c->broNext : nullptr;
        }
        cbinfo->type = Ex_CbEnumLeave;
        r = cb(w, cbinfo);
        if ((r & Ex_Break) != 0U) {
            return w;
        }
proc_leave:
        if ((w == end) ||
            (w->parent == nullptr)) { // is root ?
            break;
        }
        c = w;
        w = w->parent;
        goto next_child;
    } while (false);
    return w;
}

ExWidget* // static
ExWidget::enumFrontToBack(ExWidget* begin, ExWidget* end, const ExCallback& cb, ExCbInfo* cbinfo) {
    uint32 r;
    ExCbInfo ci(0);
    if (cbinfo == nullptr) {
        cbinfo = &ci;
    }
    ExWidget* w = begin;
    ExWidget* c;
    do { // front to back iterator
proc_enter:
        cbinfo->type = Ex_CbEnumEnter;
        r = cb(w, cbinfo);
        if ((r & Ex_Break) != 0U) {
            return w;
        }
        if ((r & Ex_Discard) != 0U) { // discard proc and skip leave callback
            goto proc_leave; // leave to parent and goto next_child
        }
        // front to back
        c = w->childHead ? w->childHead->broPrev : nullptr;
        while (c != nullptr) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead ? c->broPrev : nullptr;
        }
        cbinfo->type = Ex_CbEnumLeave;
        r = cb(w, cbinfo);
        if ((r & Ex_Break) != 0U) {
            return w;
        }
proc_leave:
        if ((w == end) ||
            (w->parent == nullptr)) { // is root ?
            break;
        }
        c = w;
        w = w->parent;
        goto next_child;
    } while (false);
    return w;
}
