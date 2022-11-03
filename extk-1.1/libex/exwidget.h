/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exwidget_h__
#define __exwidget_h__

#include "excallback.h"
#include "exobject.h"
#include "exgeomet.h"
#include "exgdiobj.h"
#include "exregion.h"
//#include "exstyle.h"
#include <list>

extern ExWatch* exWatchDisp;

typedef std::list<ExWidget*> ExWidgetList;

// Widget constants definition
//

/*
 * Widget class flags

    Ex_RECTANGULAR
        If failed, is opaque
    Ex_CONTAINER
        Children should be drawn within
    Ex_DISJOINT
        Menus/Windows (co-ords irrelevant)
*/
enum ExWidgetClassFlags {
    Ex_RECTANGULAR  = 1 << 0,
    Ex_CONTAINER    = 1 << 1,
    Ex_DISJOINT     = 1 << 2,
};

/*
 * Widget flags
    Common flags used by all widgets. Except for those indicated as read-only, these flags are all read/write.
    When setting a flag, the first argument(nMasks) is a "bit mask" indicating which elements of the bit field should be used.
    The second argument(nFlags) to setFlags() is a bit field specifying the "value" of the bits to be set.

    Ex_AutoHighlight
        Highlight and give focus to the widget when the cursor enters its extent, and unhighlight and remove focus when the cursor leaves.
    Ex_Blocked
        Prevent the widget and all its children from interacting with any events.
    Ex_Damaged (read-only)
        The widget requires repair.
    Ex_Destroyed (read-only)
        The widget has been marked for destruction.
    Ex_FocusRender
        Render a focus indicator when the widget when it gets focus.
    Ex_Focused
        Allow the widget to be granted focus.
    Ex_Ghost
        Dim the widget. Setting this flag doesn't affect the widget's behavior, just its appearance.
    Ex_Highlighted
        Allow the widget to be highlighted.
    Ex_Opaque
        This widget obscures everything directly behind it (i.e. it isn't transparent)
    Ex_Realized (read-only)
        The widget is realized.
    Ex_Exposed (read-only)
        The widget and all its children need to be rebuild.
    Ex_Selectable
        You can select (press, release, repeat, activate) the widget. Widgets usually provide visual feedback when selected.
    Ex_Set
        The widget is in a "set" state. Generally, this indicates that the widget has been selected.
    Ex_SkipLayout
        Skip this widget when performing a layout.
    Ex_Toggle
        Pressing the pointer button on this widget causes it to toggle between being set and unset.
    Ex_Visible
        The widget is visible.
    Ex_FreeMemory
        When calling the widget destroy function, the memory is also freed automatically.
*/
enum ExWidgetFlags {
    Ex_Destroyed        = 1 << 0,   // RO
    Ex_Realized         = 1 << 1,   // RO
    Ex_HasOwnGC         = 1 << 2,   // RW
    Ex_AutoHighlight    = 1 << 3,   // RW
    Ex_Highlighted      = 1 << 4,   // RW
    Ex_FocusRender      = 1 << 5,   // RW
    Ex_Focused          = 1 << 6,   // RO
    Ex_Selectable       = 1 << 7,   // RW
    Ex_PtrEntered       = 1 << 8,   // RO
    Ex_ButPressed       = 1 << 9,   // RO
    Ex_Visible          = 1 << 10,  // RO
    Ex_Blocked          = 1 << 11,  // RW
    Ex_Ghost            = 1 << 12,  // RW
    Ex_Set              = 1 << 13,  // RW
    Ex_Toggle           = 1 << 14,  // RW
    Ex_Opaque           = 1 << 15,  // RW
    Ex_Damaged          = 1 << 27,  // RO
    Ex_Exposed          = 1 << 28,  // RO
    Ex_Rebuild          = 1 << 29,  // RO tbd - used only by OwnGC.
    Ex_SkipLayout       = 1 << 30,  // RO tbd
    Ex_FreeMemory       = 1 << 31,  // RW
};

// class ExWidget
//
class ExWidget : public ExObject {
protected:
    ExWidget* parent;
    ExWidget* broNext;
    ExWidget* broPrev;
    ExWidget* childHead;
    ExWidget* childTail() {
        return childHead ? childHead->broPrev : NULL;
    }
    char*       name;
    // ExLayoutInfo
    ExBox       extent;     // the origin is the nearest canvas. intersect with parent
    ExBox       select;     // read-only
    ExPoint     deploy;     // tbd - translate to window
    ExPoint     origin;     // translate to the nearest canvas.
    ExRegion    damageRgn;  // the origin is the nearest canvas.
    ExRegion    exposeRgn;  // the origin is the nearest canvas. visible or repair
    ExRegion    opaqueRgn;  // the origin is the widget's left-top.
    int         flags;      // Common flags used by all widgets.
    int         _ra_1;      // reserved for align
    void*       data;       // This resource is used internally by FrameWorks as well as by compound widgets.
public:
    ExDrawFunc  drawFunc;   // Function for draw
    ExRect      area;       // relative to the parent
    int         id;         // identity, index, etc.
    int         value;      // estimate, evaluate, etc.
    int         shape;      // flags for the widget shape
    int         state;      // flags for the widget state
    void*       style;      // Storing style struct
    union {                 // Storing arbitrary user data : 256 bytes
        mutable uint64 u64[32];
        mutable uint32 u32[64];
        mutable void*  ptr[32];
    } userdata;
    // usage: Type& t = widget->of<Type>();
    template <typename T> T& of() { return (T&)userdata.u64; }
public:
    virtual ~ExWidget();
    explicit ExWidget();
public:
    ExWindow* getWindow() const {
        for (const ExWidget* w = this; w; w = w->parent)
            if (w->getClassFlags(Ex_DISJOINT) || ExIsBase<ExWindow>(w))
                return (ExWindow*)w;
        return NULL;
    }
    ExWidget* getParent() const { return parent; }
    void detachAll();
    void detachParent();
    void attachHead(ExWidget* child);
    void attachTail(ExWidget* child);
    static ExWidget* seekNext(ExWidget* seek);
    static ExWidget* seekPrev(ExWidget* seek);
    static ExWidget* seekLast(ExWidget* seek); // top-most
    ExWidget* next() { return seekNext(this); }
    ExWidget* prev() { return seekPrev(this); }
    ExWidget* last() { return seekLast(this); }
    void dumpBackToFront(ExWidget* end = NULL);
    void dumpFrontToBack(ExWidget* end = NULL);

    int init(ExWidget* parent, const char* name = NULL, const ExRect* area = NULL);
    static ExWidget* create(ExWidget* parent, const char* name = NULL, const ExRect* area = NULL);
    virtual int destroy(); // the widget family hierarchy marks Ex_Destroyed, broadcast Ex_CbDestroyed
#if 1 // deprecated - traditional legacy compatibility.
    virtual int realize(); // visible widgets only, marks Ex_Realized and broadcast Ex_CbRealized.
    virtual int unrealize(); // visible widgets only, unmarks Ex_Realized and broadcast Ex_CbUnrealized
#endif
protected:
    virtual int getClassFlags(int masks = Ex_BitTrue) const {
        return (masks & (Ex_RECTANGULAR | Ex_CONTAINER));
    }
    virtual void reconstruct() {
        this->~ExWidget(); // nonvirtual explicit destructor calls
        new (this) ExWidget(); // nonvirtual explicit constructor calls
    }
    void addRenderFlags(int value); // Ex_RenderRebuild
    void addUpdateRegion(const ExRegion& rgn);
    void subUpdateRegion(const ExRegion& rgn);
    void resetArea();
public:
    virtual int setVisible(bool show);
    bool isVisible();
    int vanish(ExWindow* window);
    int layout(ExRect& ar);
    int damage();
    int damage(const ExBox& clip);
    bool isOpaque() const { return getFlags(Ex_Opaque) || !opaqueRgn.empty(); }
    bool isExtentContainPoint(const ExPoint& pt);
    bool isSelectContainPoint(const ExPoint& pt);
    virtual bool isSelectable(const ExPoint& pt) { return isSelectContainPoint(pt); } // tbd
    ExWidget* getPointOwner(const ExPoint& pt);
    ExWidget* getSelectable(const ExPoint& pt);
    ExWidget* getChildHead() { return childHead; }
    ExWidget* getChildTail() { return childHead ? childHead->broPrev : NULL; }
    ExWidget* getBroPrev() { return (this != parent->getChildHead()) ? broPrev : NULL; }
    ExWidget* getBroNext() { return (this != parent->getChildTail()) ? broNext : NULL; }
    const char* getName() const { return name ? name : "(null)"; }
    void        setName(const char* text);
    void* getData() const { return data; }
    void  setData(void* p) { data = p; }
    ExBox& getBox(ExBox& bx) const; // for event processing
    ExRect& getRect(ExRect& rc) const; // for event processing
    ExBox& calcBox(ExBox& bx) const; // for drawing on canvas
    ExRect& calcRect(ExRect& rc) const; // for drawing on canvas
    ExBox getBox() const { ExBox bx; return getBox(bx); }
    ExRect getRect() const { ExRect rc; return getRect(rc); }
    ExBox calcBox() const { ExBox bx; return calcBox(bx); }
    ExRect calcRect() const { ExRect rc; return calcRect(rc); }
    //const ExBox& getExtent() const { return extent; } // tbd
    void setOpaqueRegion(const ExRegion& op);
    void setOpaque(bool set);
    void setSelect(const ExBox& box) { select = box; }
    void setArea(const ExRect& area) { this->area = area; resetArea(); }
    void setSize(const ExSize& size) { area.u.sz = size; resetArea(); }
    void setPos(const ExPoint& pos) { area.u.pt = pos; resetArea(); }
    void toBack() { if (parent) parent->attachHead(this); }
    void toFront() { if (parent) parent->attachTail(this); }
public: // widget flags operation
    int getFlags(int masks) const {
        return (masks & flags);
    }
    int setFlags(int masks, int value = Ex_BitTrue) {
        return (flags = ((~masks & flags) | (masks & value)));
    }
protected: // widget callback internal
    struct Listener : public ExCallback {
        int type;
        uint8 prio;
        uint8 flag;
        uint16 mask; // tbd - ???
        Listener(const ExCallback& cb, int t, uint8 p)
            : ExCallback(cb), type(t), prio(p), flag(0), mask(0) {
        }
    };
    class ListenerList : public std::list<Listener> {
        ushort influx, change; // for recurs
    public:
        ListenerList() : std::list<Listener>(), influx(0), change(0) {}
    public:
        // inherit size_type size();
        bool remove(int type, uint8 prio);
        // inherit void remove(const Listener& cb);
        // inherit void push_back(const Listener& cb);
        // inherit void push_front(const Listener& cb);
        void push(const Listener& cb);
        int invoke(ExWatch* watch, int type, ExObject* object, ExCbInfo* cbinfo);
    };
    ListenerList listenerList;
public: // widget callback operation
    void addListener(int(STDCALL *f)(void*, ExWidget*, ExCbInfo*), void* d, int type, uint8 prio = 5) {
        listenerList.push(Listener(ExCallback(f, d), type, prio));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addListener(int(STDCALL *f)(A*, W*, ExCbInfo*), A* d, int type, uint8 prio = 5) {
        listenerList.push(Listener(ExCallback(f, d), type, prio));
    }
    template <typename A, class W/*inherit ExWidget*/>
    void addListener(A* d, int(STDCALL A::*f)(W*, ExCbInfo*), int type, uint8 prio = 5) {
        listenerList.push(Listener(ExCallback(d, f), type, prio));
    }
    void removeListener(int type, uint8 prio = 5) { // tbd
        listenerList.remove(type, prio);
    }
    int invokeListener(int type) {
        ExCbInfo cbinfo(type);
        return listenerList.invoke(exWatchDisp, type, this, &cbinfo);
        //return listenerList.invoke(type, this, &ExCbInfo(type)); // -fpermissive
    }
    int invokeListener(int type, ExCbInfo* cbinfo) {
        return listenerList.invoke(exWatchDisp, type, this, cbinfo);
    }
protected:
    bool calcExtent();
    void calcOpaque(ExRegion& opaqueAcc);
    void buildExtent();
    void buildRegion();
    #if 0 // tbd
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
    #endif
public:
    void dumpImage(ExCanvas* canvas); // for dumping images to a temporary canvas
    //int dumpImage(ExCanvas* canvas, const ExRegion& updateRgn);
public:
    static ExWidget* enumBackToFront(ExWidget* begin, ExWidget* end, const ExCallback& cb, ExCbInfo* cbinfo);
    static ExWidget* enumFrontToBack(ExWidget* begin, ExWidget* end, const ExCallback& cb, ExCbInfo* cbinfo);
public:
    friend struct ExRender;
    friend class ExWindow;
    friend class ExApp;
public:
    Ex_DECLARE_TYPEINFO(ExWidget, ExObject);
};

inline bool ExWidget::isExtentContainPoint(const ExPoint& pt) {
    return extent.contain(pt); // tbd - deprecated ?
}

inline bool ExWidget::isSelectContainPoint(const ExPoint& pt) {
    // tbd
    return (!extent.empty() &&
            ExBox(extent.l - select.l, extent.t - select.t,
                  extent.r + select.r, extent.b + select.b).contain(pt));
}

/**
ExWidget
    A superclass of widget resources for all widgets
Description:
    ExWidget is the fundamental superclass.
    All widgets belong to a subclass of ExWidget.
    The ExWidget supperclass provides basic resources for all widgets.
    It provides the fundamental callbacks for:
        * getting/losing focus
        * activating
        * button press, release, and repeat
    Also, ExWidget supports:
        * toggle buttons
        * autohighlighting
    and provides resources for:
        * margins
        * bevel colors
        * outline and inline colors
        * draw color
        * fill color
        * fill pattern
Geometry:
    Geometry refers to the size and location of the widget.
Resources:
    Widget shapes
*/

/**
ExWidget::ListenerList::invoke()
    invoke a callback list
Arguments:
    type    The type of callback list to invoke, for example Ex_CbActivate.
    object  The widget pointer to pass to the callbacks as the first argument.
    cbinfo  A pointer to a ExCbInfo structure that's passed to each callback
            in the list as the third argument.
Description:
    This function invokes the provided callback list listenerList.
Returns:
    A return status from the callback list:
        Ex_Continue/Ex_Remove/Ex_Break/Ex_End/Ex_Halt
    If the returned status is Ex_End, have your function consume the event and remove it.
*/

/**
ExWidget::invokeListener()
    invoke a callback list of a specific type
Arguments:
    widget  The widget pointer to pass to the callbacks as the first argument.
    cbinfo  A pointer to a ExCbInfo structure that's passed to each callback
            in the list as the third argument.
    type    The type of callback list to invoke, for example Ex_CbActivate.
Description:
    This function invokes a callback list of type for a widget.
Returns:
    A return status from the callback list:
        Ex_Continue/Ex_Remove/Ex_Break/Ex_End/Ex_Halt
    If the returned status is Ex_Break, have your function consume the event.
    If the returned status is Ex_Remove, have your widget remove the callback.
*/

/**
ExWidget::destroy()
    Remove a widget from the widget family hierarchy
Description:
    This function performs the following on the specified widget:
        - detachs it, if necessary
        - destroys its children
        - removes it from the widget family hierarchy
        - flags it for destruction by adding it to the destroyed list.
    The widget's resources aren't freed until the return of ExEventHandler().
    --------------------------------------------------------------------------------
    You might get callbacks from the widget after ExWidget::destroy() has returned.
    To determine if this is happening, check the widget's Ex_Destroyed flag.
    For example:
    if (widget->getFlags(Ex_Destroyed)) {
        return Ex_Break;
    }
    --------------------------------------------------------------------------------
Returns:
    0   Success.
    -1  An error occurred.
*/

/**
ExWidget::create()
    Create a widget
Description:
    This function creates a widget in the current widget hierarchy.
    The parent argument specifies the parent widget.
    The argc argument contains the number of arguments being passed to the widget library
    and the args argument points to an array containing argc ExArg entries.
    Since this function modifies and allocates only local data structures, it doesn't result in any
    interaction with the Photon Manager. The user doesn't see the widget until it's realized.
    --------------------------------------------------------------------------------
    Widgets that belong to the PtContainer class become the current parent widget when created.
    If you're creating multiple PtContainer-class widgets, make sure each one is placed in the correct container.
    To do this, either specify the desired parent in parent or call PtSetParentWidget().
    --------------------------------------------------------------------------------
Returns:
    A pointer to the newly created widget, or NULL if an error occurs.
*/

/**
ExWidget::damage()
    Mark a widget as damaged so it will be redrawn
Description:
    This function adds the specified widget's extent to the damage list of the widget's first
    window parent. This effectively marks the widget as being damaged so that it will be redrawn.
    The widget library takes care of updating widgets whenever resources are modified; you don't
    normally need to use this function unless you're using a PtRaw widget and want it to redraw
    and repair itself.
    If you want the widget to be redrawn immediately, call ExWindow::flush() after calling ExWidget::damage().
Returns:
    0   Successful completion.
    -1  An error occurred.
*/

/**
ExWidget::getChildHead()
    Get the child that's farthest back in a container
ExWidget::getChildTail()
    Get the child at the very front of a container
ExWidget::getBroPrev()
    Get the brother behind a widget
ExWidget::getBroNext()
    Get the brother in front of a widget
* Usage:
    - BackToFront
        for (ExWidget* wgt = btn->getChildHead(); wgt; wgt = wgt->getBroNext())
    - FrontToBack
        for (ExWidget* wgt = btn->getChildTail(); wgt; wgt = wgt->getBroPrev())
*/

/**
ExWidget::toBack()
    Move a widget behind all its brothers
Description:
    This function moves the specified widget behind of all its brothers (i.e. away from the
    user). All of widget's children are moved too. Any widgets damaged as a result of this
    operation are automatically repaired.
Returns:
    0   Successful completion.
    -1  An error occurred.
*/

/**
ExWidget::toFront()
    Move a widget in front of all its brothers
Description:
    This function moves the specified widget in front of all its brothers (i.e. toward the
    user). All of widget's children are moved too. Any widgets damaged as a result of this
    operation are automatically repaired.
Returns:
    0   Successful completion.
    -1  An error occurred.
*/

#endif//__exwidget_h__
