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
#include "exwatch.h"
#include <list>

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
    Ex_RECTANGULAR  = 1U << 0,
    Ex_CONTAINER    = 1U << 1,
    Ex_DISJOINT     = 1U << 2,
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
enum class ExWidgetFlags : uint32 {
    Destroyed        = 1U << 0,  // RO
    Realized         = 1U << 1,  // RO
    HasOwnGC         = 1U << 2,  // RW
    AutoHighlight    = 1U << 3,  // RW
    Highlighted      = 1U << 4,  // RW
    FocusRender      = 1U << 5,  // RW
    Focused          = 1U << 6,  // RO
    Selectable       = 1U << 7,  // RW
    PtrEntered       = 1U << 8,  // RO
    ButPressed       = 1U << 9,  // RO
    Visible          = 1U << 10, // RO
    Blocked          = 1U << 11, // RW
    Ghost            = 1U << 12, // RW
    Set              = 1U << 13, // RW
    Toggle           = 1U << 14, // RW
    Opaque           = 1U << 15, // RW
    Damaged          = 1U << 27, // RO
    Exposed          = 1U << 28, // RO
    Rebuild          = 1U << 29, // RO tbd - used only by OwnGC.
    SkipLayout       = 1U << 30, // RO tbd
    FreeMemory       = 1U << 31, // RW
};

const uint32 Ex_Destroyed     = static_cast<uint32>(ExWidgetFlags::Destroyed);
const uint32 Ex_Realized      = static_cast<uint32>(ExWidgetFlags::Realized);
const uint32 Ex_HasOwnGC      = static_cast<uint32>(ExWidgetFlags::HasOwnGC);
const uint32 Ex_AutoHighlight = static_cast<uint32>(ExWidgetFlags::AutoHighlight);
const uint32 Ex_Highlighted   = static_cast<uint32>(ExWidgetFlags::Highlighted);
const uint32 Ex_FocusRender   = static_cast<uint32>(ExWidgetFlags::FocusRender);
const uint32 Ex_Focused       = static_cast<uint32>(ExWidgetFlags::Focused);
const uint32 Ex_Selectable    = static_cast<uint32>(ExWidgetFlags::Selectable);
const uint32 Ex_PtrEntered    = static_cast<uint32>(ExWidgetFlags::PtrEntered);
const uint32 Ex_ButPressed    = static_cast<uint32>(ExWidgetFlags::ButPressed);
const uint32 Ex_Visible       = static_cast<uint32>(ExWidgetFlags::Visible);
const uint32 Ex_Blocked       = static_cast<uint32>(ExWidgetFlags::Blocked);
const uint32 Ex_Ghost         = static_cast<uint32>(ExWidgetFlags::Ghost);
const uint32 Ex_Set           = static_cast<uint32>(ExWidgetFlags::Set);
const uint32 Ex_Toggle        = static_cast<uint32>(ExWidgetFlags::Toggle);
const uint32 Ex_Opaque        = static_cast<uint32>(ExWidgetFlags::Opaque);
const uint32 Ex_Damaged       = static_cast<uint32>(ExWidgetFlags::Damaged);
const uint32 Ex_Exposed       = static_cast<uint32>(ExWidgetFlags::Exposed);
const uint32 Ex_Rebuild       = static_cast<uint32>(ExWidgetFlags::Rebuild);
const uint32 Ex_SkipLayout    = static_cast<uint32>(ExWidgetFlags::SkipLayout);
const uint32 Ex_FreeMemory    = static_cast<uint32>(ExWidgetFlags::FreeMemory);

// class ExWgtRes
//
class ExWgtRes : public ExObject {
protected:
    char*       name;
    // ExLayoutInfo
    ExBox       extent;     // the origin is the disjoint. intersect with parent.
    ExBox       select;     // read-only
    ExPoint     origin;     // translate point to the disjoint for window events.
    ExRegion    visualRgn;  // the origin is the disjoint. (visible or repair)
    ExRegion    opaqueRgn;  // the origin is the widget's left-top.
    uint32      flags;      // Common flags used by all widgets.
    uint32      _ra_1;      // reserved for align
    void*       data;       // This resource is used internally by FrameWorks as well as by compound widgets.
public:
    ExCanvas*   canvas;
    ExDrawFunc  drawFunc;   // Function for draw
    ExRect      area;       // relative to the parent
    int32       id;         // identity, index, etc.
    int32       value;      // estimate, evaluate, etc.
    int32       shape;      // flags for the widget shape
    int32       state;      // flags for the widget state
    void*       style;      // Storing style struct
    union {                 // Storing arbitrary user data : 256 bytes
        mutable uint64 u64[32];
        mutable uint32 u32[64];
        mutable void*  ptr[32];
    } userdata;
    // usage: Type* t = widget->userdata_of<Type>();
    template <typename T> T& userdata_of() const { T* t = (T*)userdata.u64; return *t; }
public:
    virtual ~ExWgtRes() noexcept;
    explicit ExWgtRes() noexcept;
public:
    const char* getName() const { return name ? name : "(null)"; }
    void        setName(const char* text);
    void* getData() const { return data; }
    void  setData(void* p) { data = p; }
    bool isOpaque() const { return (getFlags(Ex_Opaque) != 0U) || (!opaqueRgn.empty()); }
    ExBox& calcBox(ExBox& bx) const; // for drawing on canvas
    ExRect& calcRect(ExRect& rc) const; // for drawing on canvas
    ExBox calcBox() const { ExBox bx; return calcBox(bx); }
    ExRect calcRect() const { ExRect rc; return calcRect(rc); }
public: // widget flags operation
    uint32 getFlags(uint32 masks) const {
        return (masks & flags);
    }
public:
    Ex_DECLARE_TYPEINFO(ExWgtRes, ExObject);
};

// class ExWidget
//
class ExWidget : public ExWgtRes {
protected:
    ExWidget* parent;
    ExWidget* broNext;
    ExWidget* broPrev;
    ExWidget* childHead;
    ExWidget* childTail() {
        return childHead ? childHead->broPrev : nullptr;
    }
public:
    virtual ~ExWidget() noexcept;
    explicit ExWidget() noexcept;
public:
    ExWindow* getWindow() const {
        for (const ExWidget* w = this; w != nullptr; w = w->parent) {
            if (w->isClassDisjoint() || ExIsBase<ExWindow>(w)) {
                return (ExWindow*)w;
            }
        }
        return nullptr;
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
    void dumpBackToFront(ExWidget* end = nullptr);
    void dumpFrontToBack(ExWidget* end = nullptr);

    uint32 init(ExWidget* parent, const char* name = nullptr, const ExRect* area = nullptr);
    static ExWidget* create(ExWidget* parent, const char* name = nullptr, const ExRect* area = nullptr);
    virtual uint32 destroy(); // the widget family hierarchy marks Ex_Destroyed, broadcast Ex_CbDestroyed
#if 1 // deprecated - traditional legacy compatibility.
    virtual uint32 realize(); // visible widgets only, marks Ex_Realized and broadcast Ex_CbRealized.
    virtual uint32 unrealize(); // visible widgets only, unmarks Ex_Realized and broadcast Ex_CbUnrealized
#endif
protected:
    virtual uint32 getClassFlags(uint32 masks = Ex_BitTrue) const {
        return (masks & (Ex_RECTANGULAR | Ex_CONTAINER));
    }
    virtual void reconstruct() {
        this->~ExWidget(); // nonvirtual explicit destructor calls
        new (this) ExWidget(); // nonvirtual explicit constructor calls
    }
    void addUpdateRegion(const ExRegion& rgn);
    void subUpdateRegion(const ExRegion& rgn);
    void setRebuildFlag(); // for setup visualRgn
    void resetArea();
public:
    virtual void setVisible(bool show);
    bool isVisible() const;
    bool isFlagVisible() const { return ((flags & Ex_Visible) != 0U); }
    bool isClassDisjoint() const { return ((getClassFlags() & Ex_DISJOINT) != 0U); }
    uint32 vanish(ExWindow* window);
    uint32 layout(ExRect& ar);
    uint32 damage();
    uint32 damage(const ExBox& clip);
    bool isExtentContainPoint(const ExPoint& pt);
    bool isSelectContainPoint(const ExPoint& pt);
    virtual bool isSelectable(const ExPoint& pt) { return isSelectContainPoint(pt); } // tbd
    ExWidget* getPointOwner(const ExPoint& pt);
    ExWidget* getSelectable(const ExPoint& pt);
    ExWidget* getChildHead() { return childHead; }
    ExWidget* getChildTail() { return childHead ? childHead->broPrev : nullptr; }
    ExWidget* getBroPrev() { return (this != parent->getChildHead()) ? broPrev : nullptr; }
    ExWidget* getBroNext() { return (this != parent->getChildTail()) ? broNext : nullptr; }
    ExBox& getBox(ExBox& bx) const; // for event processing
    ExRect& getRect(ExRect& rc) const; // for event processing
    ExBox getBox() const { ExBox bx; return getBox(bx); }
    ExRect getRect() const { ExRect rc; return getRect(rc); }
    //const ExBox& getExtent() const { return extent; } // tbd
    void setOpaqueRegion(const ExRegion& op);
    void setOpaque(bool set);
    void setSelect(const ExBox& box) { select = box; }
    void setArea(const ExRect& area) { this->area = area; resetArea(); }
    void setSize(const ExSize& size) { area.u.sz = size; resetArea(); }
    void setPos(const ExPoint& pos);
    void toBack() { if (parent) parent->attachHead(this); }
    void toFront() { if (parent) parent->attachTail(this); }
public: // widget flags operation
    uint32 setFlags(uint32 masks, uint32 value = Ex_BitTrue) {
        return (flags = ((~masks & flags) | (masks & value)));
    }
protected: // widget callback internal
    struct Listener : public ExCallback {
        uint32 type;
        uint8 prio;
        uint8 flag;
        uint16 mask; // tbd - ???
        Listener(const ExCallback& cb, const uint32 t, const uint8 p) noexcept
            : ExCallback(cb), type(t), prio(p), flag(0), mask(0) {
        }
    };
    class ListenerList : public std::list<Listener> {
        uint16 influx, change; // for recurs
    public:
        ListenerList() noexcept : std::list<Listener>(), influx(0), change(0) {}
    public:
        // inherit size_type size();
        bool remove(const uint32 type, const uint8 prio);
        // inherit void remove(const Listener& cb);
        // inherit void push_back(const Listener& cb);
        // inherit void push_front(const Listener& cb);
        void push(const Listener& cb);
        uint32 invoke(ExWatch* watch, const uint32 type, const ExObject* object, const ExCbInfo* cbinfo);
    };
    ListenerList listenerList;
public: // widget callback operation
    void addListener(uint32(*f)(void*, ExWidget*, ExCbInfo*), void* d, const uint32 type, const uint8 prio = 5U) { // lambda
        listenerList.push(Listener(ExCallback(f, d), type, prio));
    }
    template <typename A, class W/*inherit ExWidget*/, typename C/*inherit ExCbInfo*/>
    void addListener(uint32(*f)(A*, W*, C*), A* d, const uint32 type, const uint8 prio = 5U) {
        static_assert(std::is_base_of<ExWidget, W>::value, "W must be derived from ExWidget");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        listenerList.push(Listener(ExCallback(f, d), type, prio));
    }
    template <typename A, class W/*inherit ExWidget*/, typename C/*inherit ExCbInfo*/>
    void addListener(A* d, uint32(A::*f)(W*, C*), const uint32 type, const uint8 prio = 5U) {
        static_assert(std::is_base_of<ExWidget, W>::value, "W must be derived from ExWidget");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        listenerList.push(Listener(ExCallback(d, f), type, prio));
    }
    void removeListener(const uint32 type, const uint8 prio = 5U) { // tbd
        listenerList.remove(type, prio);
    }
    uint32 invokeListener(const uint32 type) {
        ExCbInfo cbinfo(type);
        return listenerList.invoke(exWatchDisp, type, this, &cbinfo);
        //return listenerList.invoke(type, this, &ExCbInfo(type)); // -fpermissive
    }
    uint32 invokeListener(const uint32 type, const ExCbInfo* cbinfo) {
        return listenerList.invoke(exWatchDisp, type, this, cbinfo);
    }
protected:
    bool calcExtent();
    void calcOpaque(ExRegion& opaqueAcc);
public:
    void dumpImage(const ExCanvas* canvas); // for dumping images to a temporary canvas
    //uint32 dumpImage(const ExCanvas* canvas, const ExRegion& updateRgn);
public:
    static ExWidget* enumBackToFront(ExWidget* begin, ExWidget* end, const ExCallback& cb, ExCbInfo* cbinfo);
    static ExWidget* enumFrontToBack(ExWidget* begin, ExWidget* end, const ExCallback& cb, ExCbInfo* cbinfo);
public:
    friend struct ExRender;
    friend class ExWindow;
    friend class ExApp;
public:
    Ex_DECLARE_TYPEINFO(ExWidget, ExWgtRes);
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
