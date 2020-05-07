/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <excairo.h>
#include <eximage.h>

#define logdraw dprint0
#define logdra0 dprint0

typedef std::list<ExWidget*> ExWidgetList;

static ExWidgetList deleteWidgetList;

void collectWidget() {
    while (!deleteWidgetList.empty()) {
        ExWidget* w = deleteWidgetList.front();
        deleteWidgetList.pop_front();

        dprint1(L"collectWidget %s\n", w->getName());
        delete w;
        //
        // After destroy, can't access callback list...
        // Be careful not to access member variables any more.
        //
    }
}

// test sample
static void STDCALL s_fill(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
#if 1
    if (!(canvas && canvas->cr))
        return;
    ExCairo cr(canvas, damage);
    //ExCairo::Rect rc(widget->calcRect());
    ExCairo::Box bx(widget->calcBox());

    //bx.l += 1.f;
    //bx.t += 1.f;
    //bx.r -= 1.f;
    //bx.b -= 1.f;

    cairo_new_path(cr);
    cairo_move_to(cr, bx.l, bx.t);
    cairo_line_to(cr, bx.r, bx.t);
    cairo_line_to(cr, bx.r, bx.b);
    cairo_line_to(cr, bx.l, bx.b);
    cairo_close_path(cr);

    ExCairo::Color lc; // line color
    uint32 c = ((uint)widget) & 0xffffff;
    lc.setv(ExRValue(c), ExGValue(c), ExBValue(c), 96);

    cairo_set_line_width(cr, 1.f);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
    cairo_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
    cairo_stroke(cr);
#else // deprecated
    HWND hwnd = widget->getWindow()->getHwnd();
    HDC hdc = GetDC(hwnd ? hwnd : GetDesktopWindow());
    COLORREF c = ((uint)widget) & 0xffffff;//RGB(0, 0, 128);
    HBRUSH hbr = CreateSolidBrush(c);
    for (int i = 0; i < damage->n_boxes; i++)
        FillRect(hdc, damage->boxes[i], hbr);
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
    , extent(0)
    , select(0)
    //, deploy(0)
    , origin(0)
    , damageRgn()
    , exposeRgn()
    , opaqueRgn()
    , flags(Ex_Destroyed)
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
#ifdef DEBUG // test
    drawFunc = ExDrawFunc(&s_fill, NULL); // tbd
#endif
    //flags |= Ex_Opaque; // test
    flags |= Ex_Visible; // default visible
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
    child->flags |= Ex_Damaged;
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
    child->flags |= Ex_Damaged;
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

ExBox& ExWidget::getBox(ExBox& bx) const {
    ExPoint pt = area.pt;
    const ExWidget* w = this;
    for (; w && !w->getClassFlags(Ex_DISJOINT); w = w->parent)
        pt += w->area.pt;

    bx.l = pt.x;
    bx.t = pt.y;
    bx.r = bx.l + area.w;
    bx.b = bx.t + area.h;
    return bx;
}

ExRect& ExWidget::getRect(ExRect& rc) const {
    ExPoint pt = area.pt;
    const ExWidget* w = this;
    for (; w && !w->getClassFlags(Ex_DISJOINT); w = w->parent)
        pt += w->area.pt;

    rc.x = pt.x;
    rc.y = pt.y;
    rc.w = area.w;
    rc.h = area.h;
    return rc;
}

ExBox& ExWidget::calcBox(ExBox& bx) const {
    bx.l = origin.x;
    bx.t = origin.y;
    bx.r = bx.l + area.w;
    bx.b = bx.t + area.h;
    return bx;
}

ExRect& ExWidget::calcRect(ExRect& rc) const {
    rc.x = origin.x;
    rc.y = origin.y;
    rc.w = area.w;
    rc.h = area.h;
    return rc;
}

int ExWidget::init(ExWidget* parent, const wchar* name, const ExRect* area) {
    this->setName(name);
    if (parent) parent->attachTail(this);
    if (area) this->area = *area;
    flags |= Ex_Exposed | Ex_Damaged;
    addRenderFlags(Ex_RenderRebuild); // for setup exposeRgn
    flags &= ~Ex_Destroyed;
    return 0;
}

ExWidget* // static
ExWidget::create(ExWidget* parent, const wchar* name, const ExRect* area) {
    ExWidget* widget = new ExWidget();
    assert(widget != NULL);
    widget->flags |= Ex_FreeMemory;
    widget->init(parent, name, area);
    return widget;
}

int ExWidget::destroy() {
    if (getFlags(Ex_Destroyed))
        return 1;
    ExWindow* window = getWindow();
    ExWidgetList destroyed;
    vanish(window);
    for (ExWidget* w = last(); w; w = last()) {
        dprint1(L"destroy: %s\n", w->name);
        w->flags |= Ex_Destroyed;
        w->detachParent();
        if (window->wgtCapture == w)
            window->wgtCapture = NULL;
        if (window->wgtEntered == w)
            window->wgtEntered = NULL;
        if (window->wgtPressed == w)
            window->wgtPressed = NULL;
        destroyed.push_back(w);
        if (w == this)
            break;
    }
    ExWidgetList::iterator i = destroyed.begin();
    while (i != destroyed.end()) {
        ExWidget* w = *i;
        // tbd - detach cbList
        w->invokeCallback(Ex_CbDestroyed);
        if (w->getFlags(Ex_FreeMemory))
            deleteWidgetList.push_back(w);
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
            ((ExWindow*)w)->damageRgn.combine(rgn);
            return;
        }
    }
}

void ExWidget::subUpdateRegion(const ExRegion& rgn) {
    for (ExWidget* w = this; w; w = w->parent) {
        if (w->getClassFlags(Ex_DISJOINT) && w->getFlags(Ex_Visible)) {
            ((ExWindow*)w)->damageRgn.subtract(rgn);
            return;
        }
    }
}

void ExWidget::resetArea() {
    if (isVisible() && !(getFlags(Ex_Exposed))) {
        // marks that the old area should be updated
        if (extent.valid())
            addUpdateRegion(ExRegion(extent));
        addRenderFlags(Ex_RenderRebuild);
    }
    // tbd - distinguish between move and resize
    flags |= Ex_Exposed;
}

int ExWidget::setVisible(bool show) {
    if (!getFlags(Ex_Visible) == !show)
        return 1;

    if (!show) {
        vanish(getWindow());
        flags &= ~Ex_Visible;
        exposeRgn.setEmpty();
        damageRgn.setEmpty();
    } else /*if (calcExtent()) */{ // tbd
        flags |= Ex_Visible | Ex_Exposed;
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
    if (window) {
        if (getFlags(Ex_Focused))
            window->giveFocus(parent);
        if (window != this && isVisible()) {
            window->damageRgn.combine(ExRegion(extent)); // inval
            window->renderFlags |= Ex_RenderRebuild;
            flags |= Ex_Rebuild; // tbd - merge to exposeAcc
        }
    }
    return 0;
}

int ExWidget::layout(ExRect& ar) {
    // Layout is to determine its own area relative to the parent,
    // regardless of whether it is visible or not.
    area = ar;

    //if (parent != NULL) {
    //    origin.x = area.x + parent->origin.x;
    //    origin.y = area.y + parent->origin.y;
    //}
    invokeCallback(Ex_CbLayout, &ExCbInfo(Ex_CbLayout, Ex_LayoutInit, NULL, &ar));

    flags |= Ex_Exposed; // mark as reset exposeRgn
    addRenderFlags(Ex_RenderRebuild);

    return 0;
}

int ExWidget::damage() {
    if (!getFlags(Ex_Visible))
        return -1;
    if (getFlags(Ex_Damaged | Ex_Exposed) ||
        exposeRgn.empty())
        return 1;
    flags |= Ex_Damaged;
    addUpdateRegion(exposeRgn);
    return 0;
}

int ExWidget::damage(const ExBox& clip) {
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
    if (parent && !getFlags(Ex_HasOwnGC)) {
        origin.x = area.x + parent->origin.x;
        origin.y = area.y + parent->origin.y;
    //} else if (getFlags(Ex_HasOwnGC)) {
    //    origin.x = area.x;
    //    origin.y = area.y;
    } else {
        origin.x = 0;
        origin.y = 0;
    }
    extent.l = origin.x;
    extent.t = origin.y;
    extent.r = origin.x + area.w;
    extent.b = origin.y + area.h;
    if (!extent.valid())
        return false;
    if (parent && !getFlags(Ex_HasOwnGC) &&
        !extent.intersect(parent->extent))
        return false;
    logdraw(L"extent: %s [%d,%d-%dx%d]\n", getName(),
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
    assert(!extent.empty());
    exposeRgn.setRect(extent);
    exposeRgn.subtract(opaqueAcc);
    if (!drawFunc) {
        ; // if no drawFunc then it's transparent
    } else if (getFlags(Ex_Opaque)) {
        opaqueAcc.combine(extent);
    } else if (!opaqueRgn.empty()) {
        ExRegion clipRgn(extent);
        clipRgn.move(-origin);
        clipRgn.intersect(opaqueRgn);
        clipRgn.move(origin);
        opaqueAcc.combine(clipRgn);
    }
    logdraw(L"opaque: %s [%d,%d-%dx%d] visible:%d blind:%d\n", getName(),
            exposeRgn.extent.l, exposeRgn.extent.t,
            exposeRgn.extent.width(), exposeRgn.extent.height(),
            exposeRgn.n_boxes, opaqueAcc.n_boxes);
}

void ExWidget::buildExtent() {
    assert(getFlags(Ex_Visible));
    if (!calcExtent()) {
        flags &= ~(Ex_Exposed | Ex_Damaged);
        exposeRgn.setEmpty();
        damageRgn.setEmpty();
        return;
    }
    flags |= Ex_Exposed;
    for (ExWidget* c = getChildHead(); c; c = c->getBroNext()) {
        if (c->getFlags(Ex_Visible)) {
            c->buildExtent();
        }
    }
}

void ExWidget::buildRegion() { // simple ver for gpu
    assert(getFlags(Ex_Visible) && !extent.empty());
    for (ExWidget* c = getChildTail(); c; c = c->getBroPrev()) {
        if (c->getFlags(Ex_Exposed) &&
            c->getFlags(Ex_Visible)) {
            c->buildRegion();
        }
    }
    exposeRgn.setRect(extent);
}

void ExWidget::dumpImage(ExCanvas* canvas) {
    assert(getFlags(Ex_Visible) && !extent.empty());
    if (drawFunc && !exposeRgn.empty()) {
        drawFunc(canvas, this, &exposeRgn);
#ifdef DEBUG
        if (exDrawFuncTrap)
            exDrawFuncTrap(canvas, this, &exposeRgn);
#endif
    }
    for (ExWidget* c = getChildHead(); c; c = c->getBroNext()) {
        if (c->getFlags(Ex_Visible) && !c->extent.empty()) {
            c->dumpImage(canvas);
        }
    }
}

#if 0 // deprecated...
int ExWidget::dumpImage(ExCanvas* canvas, const ExRegion& updateRgn) { // tbd
    int call_cnt = 0;
    logdraw(L"%s(%s) enter update:%d\n", __funcw__, getName(), updateRgn.n_boxes);
    ExWidget* w = this;
    ExWidget* c;
    do { // back to front iterator
proc_enter:
        if (!w->getFlags(Ex_Visible) || w->extent.empty())
            goto proc_leave; // leave to parent and goto next_child
        if (w->drawFunc && !w->exposeRgn.empty()) {
            if (w->getFlags(Ex_Damaged)) {
                w->damageRgn.copy(w->exposeRgn);
            } else {
                w->damageRgn.copy(w->exposeRgn);
                w->damageRgn.intersect(updateRgn);
            }
            if (!w->damageRgn.empty()) {
                logdraw(L"render: %s visible:%d damage:%d\n", w->getName(),
                        w->exposeRgn.n_boxes, w->damageRgn.n_boxes);
                w->drawFunc(canvas, w, &w->damageRgn);
#ifdef DEBUG
                if (exDrawFuncTrap)
                    exDrawFuncTrap(canvas, w, &w->damageRgn);
#endif
                call_cnt++;
                if (w->getFlags(Ex_HasOwnGC)) // tbd - tbd
                    goto proc_clear;
            }
        }
        // proc done

        // back to front
        c = w->childHead;
        while (c) {
            w = c;
            goto proc_enter;
next_child:
            c = c != w->childHead->broPrev ? c->broNext : NULL;
        }
proc_clear:
        logdra0(L"render: %s clear damage\n", w->getName());
        w->flags &= ~Ex_Damaged;
        w->damageRgn.setEmpty();
proc_leave:
        if (w == this ||
            w->parent == NULL) // is root ?
            break;
        c = w;
        w = w->parent;
        goto next_child;
    } while (0);
    return call_cnt;
}
#endif

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
    flags |= Ex_Exposed;
    addRenderFlags(Ex_RenderRebuild);
}

void ExWidget::setOpaque(bool set) {
    if (!getFlags(Ex_Opaque) == !set)
        return;
    if (set)
        flags |= Ex_Opaque;
    else
        flags &= ~Ex_Opaque;
    flags |= Ex_Exposed;
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

