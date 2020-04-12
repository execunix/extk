/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __extype_h__
#define __extype_h__

#include <exconf.h>
#include <new>

// Classes and primitive data types declared in this file
//
struct ExPoint;
struct ExSize;
struct ExArea;
struct ExRect;
struct ExSpan;
struct ExTile;
struct ExRegion;
struct ExColor;
struct ExEvent;
struct ExInput;

class ExApp;
class ExThread;
class ExObject;
class ExGC;
class ExImage;
class ExTimer;
class ExWidget;
class ExWindow;
class ExCanvas;

class ExAny {};

#define Ex_BitFalse (0)
#define Ex_BitTrue (-1)

// Event constants definition
//

/*
 * Return codes for chained functions (filter, handler, callback, etc.)

The widget's filter/handler callbacks are invoked if the event type matches the callback's type.
The callback's return code indicates what's to be done with the event:
    Ex_Continue
        The event is passed up to the other callbacks.
    Ex_Remove
        Terminate processing, removing the callback
    Ex_Break
        The event is consumed and no other callbacks are invoked.
*/
enum ExCallbackRet {
    Ex_Continue = 0x00,
    Ex_Discard = 0x01, // mask discard enum callback
    Ex_Remove = 0x01, // mask remove the callback (for just one-shot)
    Ex_Break = 0x02, // mask break
    Ex_End = 0x03, // (Ex_Remove | Ex_Break)
    Ex_Halt = 0x80, // all stop and exit
};

enum ExLayoutSubType {
    Ex_LayoutInit,
    Ex_LayoutDone,
};

/*
 * Widget callback types

    Ex_CbDestroyed
        The widget is marked for destruction and is no longer visible.
    Ex_CbUnrealized
        The widget invokes whenever it is unrealized.
    Ex_CbRealized
        The widget invokes whenever it is realized.
    Ex_CbBlocked
        The widget invokes whenever it must ignore an event due to being blocked.
    Ex_CbFilter
        A list of raw callbacks invoked when an event that matches the provided event
        mask is to be passed to the widget.
    Ex_CbHandler
        A list of callback structures that defines the raw callbacks that the widget
        invokes if the event it receives matches the event mask is to be passed.
    Ex_CbHotkey
        If the widget receives a hotkey event, the widget calls the function specified the callback.
    Ex_CbLayout
        A list of callback structures that define the callbacks invoked when the widget is about
        to start laying out children, and when the widget is finished laying out children.
        A layout is a property of container widgets that sizes and organizes its children when
        the container or its children change size. Layouts are an alternative to the direct
        geometry management of the widgets using widget->area resource.
            cbinfo->type        Ex_CbLayout
            cbinfo->subtype     Ex_LayoutInit -- starting to lay out children.
                                Ex_LayoutDone -- finished laying out children.
        You can use this callback to fine-tune the layout procedure.
    Ex_CbResize
        A list of callback structures that define the callbacks that the container invokes
        when its size changes.
    Ex_CbOutBound
        The callbacks invoked when you press the pointer button on the widget and
        then move out of the "hot spot" with the button still depressed.
        This callback is particularly useful for initiating drag or drag-and-drop
        operations.
    Ex_CbDND
        A list of callback structures that define the callbacks called when a
        drag-and-drop (ExEvDnDrop) event is received.
    Ex_CbPtrMove
        The widget calls when it receives Ex_EvPtrMove events. (with Ex_Selectable)
    Ex_CbPtrEnter
        The widget calls when it receives Ex_EvPtrEnter events. (with Ex_Selectable)
    Ex_CbPtrLeave
        The widget calls when it receives Ex_EvPtrLeave events. (with Ex_Selectable)
    Ex_CbButPress
        The widget calls when it receives Ex_EvButPress events. (with Ex_Selectable)
    Ex_CbButRepeat
        The widget calls when it receives Ex_EvButRepeat events. (with Ex_Selectable)
    Ex_CbButRelease
        The widget calls when it receives Ex_EvButRelease events. (with Ex_Selectable)
    Ex_CbKeyPress
        The widget calls when it receives Ex_EvKeyPress events. (with Ex_Selectable)
    Ex_CbKeyRepeat
        The widget calls when it receives Ex_EvKeyRepeat events. (with Ex_Selectable)
    Ex_CbKeyRelease
        The widget calls when it receives Ex_EvKeyRelease events. (with Ex_Selectable)
    Ex_CbActivate
        Receives Ex_EvPtr*,Ex_EvBut*,Ex_EvKey* events. (with Ex_Selectable)
        The widget calls when it becomes activated.
    Ex_CbGotFocus
        A widget gets focus or its focus status changes.
    Ex_CbLostFocus
        The widget calls when it loses focus.
    Ex_CbEnumEnter
        TBD...
    Ex_CbEnumLeave
        TBD...
    Ex_CbException
        TBD...
*/
enum ExCallbackType {
    Ex_CbUnknown,
    Ex_CbDestroyed,
    Ex_CbUnrealized,
    Ex_CbRealized,
    Ex_CbBlocked,
    Ex_CbFilter,
    Ex_CbHandler,
    Ex_CbHotkey,
    Ex_CbDeploy,
    Ex_CbExtent,
    Ex_CbLayout,
    Ex_CbResize,
    Ex_CbOutBound,
    Ex_CbDND,
    Ex_CbPtrMove,       // (with Ex_Selectable)
    Ex_CbPtrEnter,      // (with Ex_Selectable)
    Ex_CbPtrLeave,      // (with Ex_Selectable)
    Ex_CbButPress,      // (with Ex_Selectable)
    Ex_CbButRepeat,     // (with Ex_Selectable)
    Ex_CbButRelease,    // (with Ex_Selectable)
    Ex_CbKeyPress,      // (with Ex_Selectable)
    Ex_CbKeyRepeat,     // (with Ex_Selectable)
    Ex_CbKeyRelease,    // (with Ex_Selectable)
    Ex_CbActivate,      // (with Ex_Selectable) key/mouse/touch move,press,release
    Ex_CbGotFocus,
    Ex_CbLostFocus,
    Ex_CbEnumEnter,
    Ex_CbEnumLeave,
    Ex_CbException,
    Ex_CbInput,
    Ex_CbTimer,
    Ex_CbUser = 0x100
};

#if 0 // deprecated
/*
 * Subtype event info for the widget callback types
 */
enum ExEventType {
    Ex_EvUnknown,
    Ex_EvPtrMove,
    Ex_EvPtrLeave,
    Ex_EvPtrEnter,
    Ex_EvButPress,
    Ex_EvButRepeat,
    Ex_EvButRelease,
    Ex_EvKeyPress,
    Ex_EvKeyRepeat,
    Ex_EvKeyRelease,
};
#endif

enum ExDirType {
    Ex_DirBack,
    Ex_DirHome,
    Ex_DirUp,
    Ex_DirDown,
    Ex_DirLeft,
    Ex_DirRight,
    Ex_DirTabPrev,
    Ex_DirTabNext,
};

enum ExMenuDirType {
    Ex_MenuDirParent,
    Ex_MenuDirChild,
    Ex_MenuDirNext,
    Ex_MenuDirPrev,
};

enum ExOrientation {
    Ex_OrientationHorizontal,
    Ex_OrientationVertical,
};

enum ExScrollType {
    Ex_ScrollNone,
    Ex_ScrollJump,
    Ex_ScrollStepBackward,
    Ex_ScrollStepForward,
    Ex_ScrollPageBackward,
    Ex_ScrollPageForward,
    Ex_ScrollStepUp,
    Ex_ScrollStepDown,
    Ex_ScrollPageUp,
    Ex_ScrollPageDown,
    Ex_ScrollStepLeft,
    Ex_ScrollStepRight,
    Ex_ScrollPageLeft,
    Ex_ScrollPageRight,
    Ex_ScrollStart,
    Ex_ScrollEnd,
};

enum ExSortType {
    Ex_SortAscending,
    Ex_SortDescending,
};

// templates
//
template <typename T> inline T& exmin(T& a, T& b) { return a < b ? a : b; }
template <typename T> inline T& exmax(T& a, T& b) { return a > b ? a : b; }
template <typename T> inline void exswap(T& a, T& b) { T c(a); a = b; b = c; }

// functions
//
typedef void(*ExDestroyNotify)(void* data);

#endif//__extype_h__
