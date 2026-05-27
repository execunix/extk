/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "exwatch.h"
#include "exmessage.h"
#include "exwindow.h"
#include "exwproc.h"

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

ExMsg* ExMsgFifo::getMessage(ExMsg* const em)
{
    ExMsg* emref = nullptr;
    (void)enter();
    if (!empty()) {
        emref = &pull_head();
        if (em != nullptr) {
            *em = *emref;
        }
    }
    (void)leave();
    return emref;
}

ExMsg* ExMsgFifo::seekMessage(const size_t idx)
{
    ExMsg* emref = nullptr;
    (void)enter();
    if (idx < size()) {
        emref = &at(idx);
    }
    (void)leave();
    return emref;
}

ExMsg* ExMsgFifo::emitMessage(const ExMsg* const em)
{
    ExMsg* emref = nullptr;
    (void)enter();
    if (!is_full()) {
        emref = &push_tail();
        if (em != nullptr) {
            *emref = *em;
        }
    } else {
        dprint1("ExMsgFifo::emitMessage() full\n");
    }
    (void)leave();
    return emref;
}

ExMsg* ExMsgFifo::emitMessage(HWND hwnd, int32 message, uint32 wParam, int64 lParam)
{
    #if 1
    ExMsg em(hwnd, message, wParam, lParam);
    return emitMessage(&em);
    #else
    ExMsg* emref = emitMessage(nullptr);
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
    return exMsgList.getMessage(em);
}

ExMsg* ExEmitMessage(const ExMsg* const em)
{
    ExMsg* emref = exMsgList.emitMessage(em);
    (void)exWatchDisp->wakeup();
    return emref;
}

ExMsg* ExEmitMessage(int32 message, uint32 wParam, int64 lParam)
{
    ExMsg* emref = exMsgList.emitMessage(None, message, wParam, lParam);
    (void)exWatchDisp->wakeup();
    return emref;
}

ExMsg* ExEmitPtrMsg(int32 message, int32 pt_x, int32 pt_y)
{
    ExMsg* emref = exMsgList.emitMessage(None, message);
    if (emref != nullptr) {
        emref->pt.x = pt_x;
        emref->pt.y = pt_y;
        emref->lParam = MAKELPARAM(pt_x, pt_y);
        emref->time = exWatchDisp->getTick();
    }
    (void)exWatchDisp->wakeup();
    return emref;
}

#ifdef __linux__
bool PostMessage(HWND hwnd, int32 message, uint32 wparam, int64 lparam)
{
    ExMsg* emref = exMsgList.emitMessage(hwnd, message, wparam, lparam);
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

ExMessageFunc exEventFunc = &ExEventPeek;
