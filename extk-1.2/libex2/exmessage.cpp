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

uint32 ExMsgFifo::filter(const int32 msg_min, const int32 msg_max)
{
    uint32 count = 0;
    (void)enter();
    for (size_t i = 0; i < size(); ++i) {
        ExMsg& em = at(i);
        if ((msg_min <= em.message) && (em.message <= msg_max)) {
            dprint("filter em[%u]: 0x%04x\n", count, em.message);
            em.message = WM_NULL;
            ++count;
        }
    }
    (void)leave();
    #ifdef WIN32
    MSG msg;
    (void)exWatchDisp->leave();
    while (PeekMessage(&msg, NULL, (UINT)msg_min, (UINT)msg_max, PM_REMOVE)) {
        dprint("filter msg[%u]: 0x%04x\n", count, msg.message);
        ++count;
    }
    (void)exWatchDisp->enter();
    #endif
    return count;
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
MSG* ExPeekMessage(MSG* msg)
{
    ExMsg* em;
    if ((em = exMsgList.getMessage()) != nullptr) {
        msg->hwnd = em->hwnd;
        msg->message = em->message;
        msg->wParam = em->wParam;
        msg->lParam = em->lParam;
        msg->time = em->time;
        msg->pt.x = em->pt.x;
        msg->pt.y = em->pt.y;
    } else {
        (void)exWatchDisp->leave();
        if (PeekMessage(msg, NULL, 0U, 0U, PM_REMOVE) == FALSE) {
            msg = nullptr;
        }
        (void)exWatchDisp->enter();
    }
    return msg;
}
#else
ExMsg* ExPeekMessage(ExMsg* em)
{
    return exMsgList.getMessage(em);
}
#endif
