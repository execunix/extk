/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "exmessage.h"
#include "exwindow.h"
#include "exwproc.h"

#ifdef __linux__
ExMsgFifo exMsgList;

#if 0
static ExMsg* new_event()
{
    std::allocator<ExMsg> em_allocator;
    ExMsg* const em = em_allocator.allocate(1U);
    em_allocator.construct(em, ExMsg(None));
    return em;
}

static void delete_event(ExMsg* const em)
{
    std::allocator<ExMsg> em_allocator;
    // em_allocator.destroy(em); // hasnt destructor
    em_allocator.deallocate(em, 1UL);
}
#endif

ExMsg* ExMsgFifo::get_event(ExMsg* const em)
{
    ExMsg* emref = nullptr;
    (void)enter();
    if (!empty()) {
        emref = &pull_head();
        *em = *emref;
    }
    (void)leave();
    return emref;
}

ExMsg* ExMsgFifo::peek_event(ExMsg* const em)
{
    ExMsg* emref = nullptr;
    (void)enter();
    if (!empty()) {
        emref = &head();
        *em = *emref;
    }
    (void)leave();
    return emref;
}

ExMsg* ExMsgFifo::emit_event(const ExMsg* const em)
{
    ExMsg* emref = nullptr;
    (void)enter();
    if (!is_full()) {
        emref = &push_tail();
        *emref = *em;
    } else {
        dprint1("ExMsgFifo::emit_event() full\n");
    }
    (void)leave();
    return emref;
}

ExMsg* ExMsgFifo::emit_event(HWND hwnd, int32 message, uint32 wParam, int64 lParam)
{
    #if 1
    ExMsg em(hwnd, message, wParam, lParam);
    return exMsgList.emit_event(&em);
    #else
    ExMsg* emref = exMsgList.emit_event(nullptr);
    if (emref != nullptr) {
        emref->clear();
        emref->hwnd = hwnd;
        emref->message = message;
        emref->wParam = wParam;
        emref->lParam = lParam;
    }
    return emref;
    #endif
}

ExMsg* ExGetMessage(ExMsg* em)
{
    return exMsgList.get_event(em);
}

ExMsg* ExPostPtrMsg(int32 message, int32 pt_x, int32 pt_y)
{
    ExMsg* emref = exMsgList.emit_event(None, message);
    if (emref != nullptr) {
        emref->pt.x = static_cast<int16>(pt_x);
        emref->pt.y = static_cast<int16>(pt_y);
        emref->time = exWatchDisp->getTick();
    }
    (void)exWatchDisp->wakeup();
    return emref;
}

bool PostMessage(HWND hwnd, int32 message, uint32 wparam, int64 lparam)
{
    ExMsg* emref = exMsgList.emit_event(hwnd, message, wparam, lparam);
    (void)exWatchDisp->wakeup();
    return (emref != nullptr);
}
#endif // __linux__

#ifdef WIN32
bool ExEventPeek(MSG& msg)
{
    BOOL bRet;
    exWatchDisp->leave();
    if ((bRet = GetMessage(&msg, NULL, 0, 0)) != TRUE) {
        exassert(msg.message == WM_QUIT);
        // WM_DESTROY => PostQuitMessage
        bRet = TRUE;
    }
    exWatchDisp->enter();
    return bRet;
}
#else
bool ExEventPeek(ExMsg* em)
{
    return false; // tbd
}
#endif

ExEventFunc exEventFunc = &ExEventPeek;
ExEventFunc exCalibFunc = nullptr;

// ExEmit APIs - deprecated
//

#ifdef __linux__
static bool PostPtrMsg(int32 message, int32 pt_x, int32 pt_y)
{
    ExMsg em(None);
    em.message = message;
    em.pt.x = pt_x;
    em.pt.y = pt_y;
    em.time = exWatchDisp->getTick();
    if (exCalibFunc != nullptr) {
        (void)exCalibFunc(&em);
    }
    ExMsg* back = exMsgList.emit_event(&em);
    return (back != nullptr);
}

bool ExEmitMessage(HWND hwnd, int32 message, uint32 wParam, int64 lParam)
{
    return PostMessage(hwnd, message, wParam, lParam);
}

bool ExEmitPtrEvent(HWND hwnd, int32 message, int32 pt_x, int32 pt_y)
{
    bool r = true;
    //int32_t origin_x = pt_x, origin_y = pt_y;
    //ExWindow* window = exWndProcMap.search(hwnd);
    if ((exMsgList.size() > 2UL) && (message == WM_MOUSEMOVE)) {
        dprint0("skip frequent move em\n");
    } else {
        r = PostPtrMsg(message, pt_x, pt_y);
    }
    return r;
}
#endif // __linux__

#ifdef WIN32
bool ExEmitMessage(HWND hwnd, int32 message, uint32 wParam, int64 lParam) {
    BOOL r = PostMessage(hwnd, message, wParam, lParam);
    return r ? true : false;
}

bool ExEmitPtrEvent(HWND hwnd, int32 message, int32 x, int32 y) {
    LPARAM lParam = MAKELPARAM(x, y);
    return ExEmitMessage(hwnd, message, 0U, lParam);
}

bool ExEmitButPress(ExWidget* w, int32 x, int32 y) {
    bool r;
    ExWindow* window = w->getWindow();
    HWND hwnd = (window != nullptr) ? window->getHwnd() : None;
    if (hwnd != None) {
        ExPoint pt(w->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        r = (ExEmitPtrEvent(hwnd, WM_MOUSEMOVE, x, y) &&
             ExEmitPtrEvent(hwnd, WM_LBUTTONDOWN, x, y));
    } else {
        r = false;
    }
    return r;
}

bool ExEmitButRelease(ExWidget* w, int32 x, int32 y) {
    bool r;
    ExWindow* window = w->getWindow();
    HWND hwnd = (window != nullptr) ? window->getHwnd() : None;
    if (hwnd != None) {
        ExPoint pt(w->getRect().center());
        x += pt.x;
        y += pt.y;
        SetCursorPos(x, y);
        r = ExEmitPtrEvent(hwnd, WM_LBUTTONUP, x, y);
    } else {
        r = false;
    }
    return r;
}
#endif
