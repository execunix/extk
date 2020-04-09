/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <eximage.h>

#define logdraw dprint0
#define logdra0 dprint0

 // test sample
static void STDCALL s_fill(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
#if 1
    if (!(canvas && canvas->cr))
        return;
    cairo_t* cr = canvas->cr;
    ExRect rc = widget->getRect();
    cairo_save(cr);

    cairo_new_path(cr);
    cairo_move_to(cr, rc.l + 1, rc.t + 1);
    cairo_line_to(cr, rc.r - 1, rc.t + 1);
    cairo_line_to(cr, rc.r - 1, rc.b - 1);
    cairo_line_to(cr, rc.l + 1, rc.b - 1);
    cairo_close_path(cr);
    cairo_set_line_width(cr, 1.);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
    uint c = ((uint)widget) & 0xffffff;
    cairo_set_source_rgb(cr, ExRValue(c) / 255., ExGValue(c) / 255., ExBValue(c) / 255.);
    cairo_stroke(cr);

    cairo_restore(cr);
#else // deprecated
    HWND hwnd = widget->getWindow()->getHwnd();
    HDC hdc = GetDC(hwnd ? hwnd : GetDesktopWindow());
    COLORREF c = ((uint)widget) & 0xffffff;//RGB(0, 0, 128);
    HBRUSH hbr = CreateSolidBrush(c);
    for (int i = 0; i < damage->n_rects; i++)
        FillRect(hdc, damage->rects[i], hbr);
    DeleteObject(hbr);
#endif
}

// class ExWidget
//
ExWidget::~ExWidget() {
    if (name)
        free(name);
}

ExWidget::ExWidget()
    : ExObject()
    , parent(NULL)
    , broNext(NULL)
    , broPrev(NULL)
    , childHead(NULL)
    , name(NULL)
    , rect(0)
    , extent(0)
    , select(0)
    , visibleRgn()
    , opaqueRgn()
    , damageRgn()
    , flags(0)
    , data(NULL)
    , area(0)
    , id(0)
    , value(0)
    , shape(0)
    , state(0)
    , style(NULL)
    , userdata(NULL)
    , drawFunc()
    , cbList() {
#if 1 // test
    drawFunc = ExDrawFunc(&s_fill, NULL); // tbd
#endif
}

void ExWidget::detachAll() {
    vanish(getWindow());
    for (ExWidget* w = last(); w; w = last()) {
        dprint1(L"detach: %s\n", w->name);
        w->detachParent();
        if (w == this)
            break;
    }
}

void ExWidget::detachParent() {
    if (parent == NULL)
        return;
    if (!getFlags(Ex_Destroyed))
        vanish(getWindow());
    ExWidget* next = NULL;
    if (broNext != this) {
        broNext->broPrev = broPrev;
        broPrev->broNext = broNext;
        next = broNext;
    }
    if (parent->childHead == this) {
        parent->childHead = next;
    }
    parent = broNext = broPrev = NULL;
}

void ExWidget::attachHead(ExWidget* child) {
    assert(child != this);
    if (child == NULL)
        return;
    if (childHead == child) // already attached to the head
        return;

    child->detachParent();

    if (childHead == NULL) {
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
    child->flags |= Ex_DamageFamily;
}

void ExWidget::attachTail(ExWidget* child) {
    assert(child != this);
    if (child == NULL)
        return;
    if (childTail() == child) // already attached to the tail
        return;

    child->detachParent();

    if (childHead == NULL) {
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
    child->flags |= Ex_DamageFamily;
}

ExWidget* ExWidget::seekNext(ExWidget* seek) {
    if (seek->childHead != NULL)
        return seek->childHead;
    while (seek->parent != NULL) {
        if (seek->broNext != seek->parent->childHead)
            return seek->broNext;
        seek = seek->parent;
    }
    return NULL;
}

ExWidget* ExWidget::seekPrev(ExWidget* seek) {
    if (seek->parent == NULL) // is root ?
        return NULL;
    if (seek->parent->childHead == seek)
        return seek->parent;
    seek = seek->broPrev;
    while (seek->childHead != NULL)
        seek = seek->childHead->broPrev;
    return seek;
}

ExWidget* ExWidget::seekLast(ExWidget* seek) { // top-most
    while (seek->childHead != NULL)
        seek = seek->childHead->broPrev;
    return seek;
}

void ExWidget::dumpBackToFront(ExWidget* end) {
    for (ExWidget* w = this; w && w != end; w = w->next()) {
        dprint1(L"seek name: %s\n", w->name);
    }
}

void ExWidget::dumpFrontToBack(ExWidget* end) {
    for (ExWidget* w = this; w && w != end; w = w->prev()) {
        dprint1(L"seek name: %s\n", w->name);
    }
}

void ExWidget::setName(const wchar* text) {
    wchar buf[20];
    if (name != NULL)
        free(name);
    if (text == NULL) {
        swprintf(buf, L"%p", this);
        text = buf;
    }
    name = exwcsdup(text);
}

int ExWidget::init(ExWidget* parent, const wchar* name, const ExArea* area) {
    this->setName(name);
    if (parent) parent->attachTail(this);
    if (area) this->area = *area;
    if (calcExtent()) { // is valid ?
        flags |= Ex_DamageFamily;
        addRenderFlags(Ex_RenderRebuild); // for setup visibleRgn
    }
    flags |= Ex_Visible; // default visible
    return 0;
}

ExWidget* // static
ExWidget::create(ExWidget* parent, const wchar* name, const ExArea* area) {
    ExWidget* widget = new ExWidget();
    assert(widget != NULL);
    widget->flags |= Ex_FreeMemory;
    widget->init(parent, name, area);
    return widget;
}

int ExWidget::destroy() {
    if (getFlags(Ex_Destroyed))
        return 1;
    vanish(getWindow());
    ExWidgetList destroyed;
    for (ExWidget* w = last(); w; w = last()) {
        dprint1(L"destroy: %s\n", w->name);
        w->flags |= Ex_Destroyed;
        w->detachParent();
        destroyed.push_back(w);
        if (w == this)
            break;
    }
    ExWidgetList::iterator i = destroyed.begin();
    while (i != destroyed.end()) {
        ExWidget* w = *i;
        // tbd - detach cbList
        w->invokeCallback(Ex_CbDestroyed);
        if (w->getFlags(Ex_FreeMemory)) {
            dprint1(L"delete %s\n", w->name);
            delete w;
            //
            // Be careful not to access member variables any more.
            //
        }
        ++i;
    }
    return 0;
}

int ExWidget::realize() {
    if (getFlags(Ex_Realized))
        return 1;
    ExWidget* end = last();
    for (ExWidget* w = this; w; w = next()) {
        if (!w->getFlags(Ex_Realized) && w->isVisible()) {
            dprint1(L"realize: %s\n", w->name);
            w->flags |= Ex_Realized;
            w->invokeCallback(Ex_CbRealized);
        }
        if (w == end)
            break;
    }
    return 0;
}

int ExWidget::unrealize() {
    if (!getFlags(Ex_Realized))
        return 1;
    ExWidget* end = this;
    for (ExWidget* w = last(); w; w = prev()) {
        if (w->getFlags(Ex_Realized)) {
            dprint1(L"unrealize: %s\n", w->name);
            w->flags &= ~Ex_Realized;
            w->invokeCallback(Ex_CbUnrealized);
        }
        if (w == end)
            break;
    }
    return 0;
}

void ExWidget::addRenderFlags(int value) {
    for (ExWidget* w = this; w; w = w->parent) {
        if (w->getClassFlags(Ex_DISJOINT) && w->getFlags(Ex_Visible)) {
            ((ExWindow*)w)->renderFlags |= value;
            return;
        }
    }
}

void ExWidget::addUpdateRegion(const ExRegion& rgn) {
    for (ExWidget* w = this; w; w = w->parent) {
        if (w->getClassFlags(Ex_DISJOINT) && w->getFlags(Ex_Visible)) {
            ((ExWindow*)w)->updateRgn.combine(rgn);
            return;
        }
    }
}

void ExWidget::subUpdateRegion(const ExRegion& rgn) {
    for (ExWidget* w = this; w; w = w->parent) {
        if (w->getClassFlags(Ex_DISJOINT) && w->getFlags(Ex_Visible)) {
            ((ExWindow*)w)->updateRgn.subtract(rgn);
            return;
        }
    }
}

void ExWidget::resetArea() {
    if (isVisible() && !(getFlags(Ex_ResetExtent))) {
        // marks that the old area should be updated
        if (extent.valid())
            addUpdateRegion(ExRegion(extent));
        addRenderFlags(Ex_RenderRebuild);
    }
    flags |= Ex_ResetExtent;
}

int ExWidget::setVisible(bool show) {
    if (!getFlags(Ex_Visible) == !show)
        return 1;

    if (!show) {
        vanish(getWindow());
        flags &= ~Ex_Visible;
    } else if (calcExtent()) { // tbd
        flags |= (Ex_Visible | Ex_DamageFamily);
        addRenderFlags(Ex_RenderRebuild);
    }
    return 0;
}

bool ExWidget::isVisible() {
    for (ExWidget* w = this; w && w->getFlags(Ex_Visible); w = w->parent) {
        if (w->getClassFlags(Ex_DISJOINT))
            return true;
    }
    return false;
}

int ExWidget::vanish(ExWindow* window) {
    if (getFlags(Ex_Destroyed))
        return 1;
    if (window && getFlags(Ex_Focused))
        window->giveFocus(parent);
    if (window && window != this && isVisible()) {
        window->updateRgn.combine(ExRegion(extent)); // inval
        window->renderFlags |= Ex_RenderDamaged;
    }
    return 0;
}

int ExWidget::layout(const ExArea& ar) {
    // Layout is to determine its own area relative to the parent,
    // regardless of whether it is visible or not.
    area = ar;
    if (parent == NULL) {
        rect.l = 0;
        rect.t = 0;
        rect.r = area.w;
        rect.b = area.h;
    } else {
        rect.l = area.x + parent->rect.l;
        rect.t = area.y + parent->rect.t;
        rect.r = area.w + rect.l;
        rect.b = area.h + rect.t;
    }

    flags |= Ex_ResetExtent; // mark as reset visibleRgn
    addRenderFlags(Ex_RenderRebuild);

    invokeCallback(Ex_CbLayout, &ExCbInfo(Ex_CbLayout, Ex_LayoutInit, NULL, &area));
    // tbd - do recurs ?
    invokeCallback(Ex_CbLayout, &ExCbInfo(Ex_CbLayout, Ex_LayoutDone, NULL, &area));

    return 0;
}

/*
Ex_ResetExtent  - Ex_RenderRebuild bit call calcExtent back to front, setup extent
Ex_ResetRegion  - Ex_RenderRebuild bit call calcOpaque front to back, setup visibleRgn
Ex_DamageFamily - Ex_RenderDamaged bit combine the widget visibleRgn, skip child
Ex_Damaged      - Ex_RenderDamaged bit combine each widget damageRgn recursively
*/

int ExWidget::damage() {
    if (!getFlags(Ex_Visible))
        return -1;
    flags |= Ex_DamageFamily;
    addRenderFlags(Ex_RenderDamaged);
    return 0;
}

int ExWidget::damage(const ExRect& clip) {
    if (!getFlags(Ex_Visible))
        return -1;
    if (getFlags(Ex_DamageFamily | Ex_ResetExtent | Ex_ResetRegion))
        return 1;
    ExRegion clip_rgn(clip);
    clip_rgn.intersect(visibleRgn);
    if (clip_rgn.empty())
        return 1;
    damageRgn.combine(clip_rgn);
    flags |= Ex_Damaged;
    addRenderFlags(Ex_RenderDamaged);
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
    visibleRgn.setEmpty();
    damageRgn.setEmpty();
    if (parent == NULL) {
        rect.l = 0;
        rect.t = 0;
        rect.r = area.w;
        rect.b = area.h;
    } else {
        rect.l = area.x + parent->rect.l;
        rect.t = area.y + parent->rect.t;
        rect.r = area.w + rect.l;
        rect.b = area.h + rect.t;
    }
    extent = rect;
    if (!extent.valid())
        return false;
    if (parent && !extent.intersect(parent->extent))
        return false;
    flags |= Ex_ResetRegion; // mark as reset visibleRgn
    logdraw(L"extent: %s [%d,%d-%dx%d] [%d,%d-%dx%d]\n", getName(),
            rect.l, rect.t, rect.width(), rect.height(),
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
    // should Ex_ResetRegion remove
    flags &= ~Ex_ResetRegion;
    if (extent.empty()) {
        logdraw(L"opaque: %s extent empty visible:%d blind:%d\n", getName(),
                visibleRgn.n_rects, opaqueAcc.n_rects);
        return;
    }
    visibleRgn.setRect(extent);
    visibleRgn.subtract(opaqueAcc);
    if (!drawFunc) {
        ; // if no drawFunc then it's transparent
    } else if (getFlags(Ex_Opaque)) {
        opaqueAcc.combine(extent);
    } else if (!opaqueRgn.empty()) {
        ExRegion clipRgn(extent);
        clipRgn.offset(-rect.ul);
        clipRgn.intersect(opaqueRgn);
        clipRgn.offset(rect.ul);
        opaqueAcc.combine(clipRgn);
    }
    logdraw(L"opaque: %s [%d,%d-%dx%d] visible:%d blind:%d\n", getName(),
            visibleRgn.extent.l, visibleRgn.extent.t,
            visibleRgn.extent.width(), visibleRgn.extent.height(),
            visibleRgn.n_rects, opaqueAcc.n_rects);
}

ExWidget* ExWidget::getPointOwner(const ExPoint& pt) {
    ExWidget* w = this;
    ExWidget* c;
    do { // front to back iterator
proc_enter:
        if (!w->getFlags(Ex_Visible))
            goto proc_leave; // leave to parent and goto next_child
        // front to back
        c = w->childHead ? w->childHead->broPrev : NULL;
        while (c) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead ? c->broPrev : NULL;
        }
        // w is visible and ...
        if (w->isSelectable(pt))
            return w;
        // proc done
proc_leave:
        if (w == this ||
            w->parent == NULL) // is root ?
            break;
        c = w;
        w = w->parent;
        goto next_child;
    } while (0);
    return NULL;
}

ExWidget* ExWidget::getSelectable(const ExPoint& pt) {
    ExWidget* w = this;
    ExWidget* c;
    do { // front to back iterator
proc_enter:
        if (!w->getFlags(Ex_Visible))
            goto proc_leave; // leave to parent and goto next_child
        // front to back
        c = w->childHead ? w->childHead->broPrev : NULL;
        while (c) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead ? c->broPrev : NULL;
        }
        // w is visible and ...
        if (w->getFlags(Ex_Selectable | Ex_AutoHighlight) &&
            w->isSelectable(pt)) {
            for (ExWidget* p = w; ; p = p->parent) {
                if (p->getFlags(Ex_Blocked))
                    return NULL;
                if (p == this ||
                    p->parent == NULL)
                    break;
            }
            return w;
        }
        // proc done
proc_leave:
        if (w == this ||
            w->parent == NULL) // is root ?
            break;
        c = w;
        w = w->parent;
        goto next_child;
    } while (0);
    return NULL;
}

void ExWidget::setOpaqueRegion(const ExRegion& op) {
    if (opaqueRgn.equal(op))
        return;
    opaqueRgn.copy(op);
    addRenderFlags(Ex_RenderRebuild);
}

void ExWidget::setOpaque(bool set) {
    if (!getFlags(Ex_Opaque) == !set)
        return;
    if (set)
        flags |= Ex_Opaque;
    else
        flags &= ~Ex_Opaque;
    addRenderFlags(Ex_RenderRebuild);
}

ExWidget* // static
ExWidget::enumBackToFront(ExWidget* begin, ExWidget* end, ExCallback& cb, ExCbInfo* cbinfo) {
    int r;
    ExCbInfo ci(0);
    if (cbinfo == NULL)
        cbinfo = &ci;
    ExWidget* w = begin;
    ExWidget* c;
    do { // back to front iterator
proc_enter:
        cbinfo->type = Ex_CbEnumEnter;
        r = cb(w, cbinfo);
        if (r & Ex_Break)
            return w;
        if (r & Ex_Discard) // discard proc and skip leave callback
            goto proc_leave; // leave to parent and goto next_child
        // back to front
        c = w->childHead;
        while (c) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead->broPrev ? c->broNext : NULL;
        }
        cbinfo->type = Ex_CbEnumLeave;
        r = cb(w, cbinfo);
        if (r & Ex_Break)
            return w;
proc_leave:
        if (w == end ||
            w->parent == NULL) // is root ?
            break;
        c = w;
        w = w->parent;
        goto next_child;
    } while (0);
    return w;
}

ExWidget* // static
ExWidget::enumFrontToBack(ExWidget* begin, ExWidget* end, ExCallback& cb, ExCbInfo* cbinfo) {
    int r;
    ExCbInfo ci(0);
    if (cbinfo == NULL)
        cbinfo = &ci;
    ExWidget* w = begin;
    ExWidget* c;
    do { // front to back iterator
proc_enter:
        cbinfo->type = Ex_CbEnumEnter;
        r = cb(w, cbinfo);
        if (r & Ex_Break)
            return w;
        if (r & Ex_Discard) // discard proc and skip leave callback
            goto proc_leave; // leave to parent and goto next_child
        // front to back
        c = w->childHead ? w->childHead->broPrev : NULL;
        while (c) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead ? c->broPrev : NULL;
        }
        cbinfo->type = Ex_CbEnumLeave;
        r = cb(w, cbinfo);
        if (r & Ex_Break)
            return w;
proc_leave:
        if (w == end ||
            w->parent == NULL) // is root ?
            break;
        c = w;
        w = w->parent;
        goto next_child;
    } while (0);
    return w;
}

