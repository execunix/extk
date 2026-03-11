/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exevent_h__
#define __exevent_h__

#include "excallback.h"
#include "exgeomet.h"
#ifdef __linux__
#include <pthread.h>
#endif // __linux__
#include <array>

#ifdef __linux__

constexpr int32 WM_NULL             = 0x0000;
constexpr int32 WM_CREATE           = (WM_NULL + 0x0001);
constexpr int32 WM_DESTROY          = (WM_NULL + 0x0002);
constexpr int32 WM_MOVE             = (WM_NULL + 0x0003);
constexpr int32 WM_SIZE             = (WM_NULL + 0x0005);
constexpr int32 WM_ACTIVATE         = (WM_NULL + 0x0006);
constexpr int32 WM_SETFOCUS         = (WM_NULL + 0x0007);
constexpr int32 WM_KILLFOCUS        = (WM_NULL + 0x0008);
constexpr int32 WM_PAINT            = (WM_NULL + 0x000F);
constexpr int32 WM_CLOSE            = (WM_NULL + 0x0010);
constexpr int32 WM_QUIT             = (WM_NULL + 0x0012);
constexpr int32 WM_SHOWWINDOW       = (WM_NULL + 0x0018);

constexpr int32 WM_KEYDOWN          = (WM_NULL + 0x0100);
constexpr int32 WM_KEYUP            = (WM_NULL + 0x0101);
constexpr int32 WM_CHAR             = (WM_NULL + 0x0102);
constexpr int32 WM_COMMAND          = (WM_NULL + 0x0111);

constexpr int32 WM_MOUSEMOVE        = (WM_NULL + 0x0200);
constexpr int32 WM_LBUTTONDOWN      = (WM_NULL + 0x0201);
constexpr int32 WM_LBUTTONUP        = (WM_NULL + 0x0202);
constexpr int32 WM_LBUTTONDBLCLK    = (WM_NULL + 0x0203);
constexpr int32 WM_RBUTTONDOWN      = (WM_NULL + 0x0204);
constexpr int32 WM_RBUTTONUP        = (WM_NULL + 0x0205);
constexpr int32 WM_RBUTTONDBLCLK    = (WM_NULL + 0x0206);
constexpr int32 WM_MBUTTONDOWN      = (WM_NULL + 0x0207);
constexpr int32 WM_MBUTTONUP        = (WM_NULL + 0x0208);
constexpr int32 WM_MBUTTONDBLCLK    = (WM_NULL + 0x0209);

/*
 * Virtual Keys, Standard Set
 */
constexpr int32 VK_NULL             = 0x0000;
constexpr int32 VK_LBUTTON          = (VK_NULL + 0x01);
constexpr int32 VK_RBUTTON          = (VK_NULL + 0x02);
constexpr int32 VK_CANCEL           = (VK_NULL + 0x03);
constexpr int32 VK_MBUTTON          = (VK_NULL + 0x04); /* NOT contiguous with L & RBUTTON */

#if(_WIN32_WINNT >= 0x0500)
constexpr int32 VK_XBUTTON1         = (VK_NULL + 0x05); /* NOT contiguous with L & RBUTTON */
constexpr int32 VK_XBUTTON2         = (VK_NULL + 0x06); /* NOT contiguous with L & RBUTTON */
#endif /* _WIN32_WINNT >= 0x0500 */
/*
 * 0x07 : reserved
 */
constexpr int32 VK_BACK             = (VK_NULL + 0x08);
constexpr int32 VK_TAB              = (VK_NULL + 0x09);
/*
 * 0x0A - 0x0B : reserved
 */
constexpr int32 VK_CLEAR            = (VK_NULL + 0x0C);
constexpr int32 VK_RETURN           = (VK_NULL + 0x0D);
/*
 * 0x0E - 0x0F : unassigned
 */
constexpr int32 VK_SHIFT            = (VK_NULL + 0x10);
constexpr int32 VK_CONTROL          = (VK_NULL + 0x11);
constexpr int32 VK_MENU             = (VK_NULL + 0x12);
constexpr int32 VK_PAUSE            = (VK_NULL + 0x13);
constexpr int32 VK_CAPITAL          = (VK_NULL + 0x14);

constexpr int32 VK_KANA             = (VK_NULL + 0x15);
constexpr int32 VK_HANGEUL          = (VK_NULL + 0x15); /* old name - should be here for compatibility */
constexpr int32 VK_HANGUL           = (VK_NULL + 0x15);
constexpr int32 VK_IME_ON           = (VK_NULL + 0x16);
constexpr int32 VK_JUNJA            = (VK_NULL + 0x17);
constexpr int32 VK_FINAL            = (VK_NULL + 0x18);
constexpr int32 VK_HANJA            = (VK_NULL + 0x19);
constexpr int32 VK_KANJI            = (VK_NULL + 0x19);
constexpr int32 VK_IME_OFF          = (VK_NULL + 0x1A);

constexpr int32 VK_ESCAPE           = (VK_NULL + 0x1B);

constexpr int32 VK_CONVERT          = (VK_NULL + 0x1C);
constexpr int32 VK_NONCONVERT       = (VK_NULL + 0x1D);
constexpr int32 VK_ACCEPT           = (VK_NULL + 0x1E);
constexpr int32 VK_MODECHANGE       = (VK_NULL + 0x1F);

constexpr int32 VK_SPACE            = (VK_NULL + 0x20);
constexpr int32 VK_PRIOR            = (VK_NULL + 0x21);
constexpr int32 VK_NEXT             = (VK_NULL + 0x22);
constexpr int32 VK_END              = (VK_NULL + 0x23);
constexpr int32 VK_HOME             = (VK_NULL + 0x24);
constexpr int32 VK_LEFT             = (VK_NULL + 0x25);
constexpr int32 VK_UP               = (VK_NULL + 0x26);
constexpr int32 VK_RIGHT            = (VK_NULL + 0x27);
constexpr int32 VK_DOWN             = (VK_NULL + 0x28);
constexpr int32 VK_SELECT           = (VK_NULL + 0x29);
constexpr int32 VK_PRINT            = (VK_NULL + 0x2A);
constexpr int32 VK_EXECUTE          = (VK_NULL + 0x2B);
constexpr int32 VK_SNAPSHOT         = (VK_NULL + 0x2C);
constexpr int32 VK_INSERT           = (VK_NULL + 0x2D);
constexpr int32 VK_DELETE           = (VK_NULL + 0x2E);
constexpr int32 VK_HELP             = (VK_NULL + 0x2F);
/*
 * VK_0 - VK_9 are the same as ASCII '0' - '9' (0x30 - 0x39)
 * 0x3A - 0x40 : unassigned
 * VK_A - VK_Z are the same as ASCII 'A' - 'Z' (0x41 - 0x5A)
 */
constexpr int32 VK_LWIN             = (VK_NULL + 0x5B);
constexpr int32 VK_RWIN             = (VK_NULL + 0x5C);
constexpr int32 VK_APPS             = (VK_NULL + 0x5D);
/*
 * 0x5E : reserved
 */
constexpr int32 VK_SLEEP            = (VK_NULL + 0x5F);

constexpr int32 VK_NUMPAD0          = (VK_NULL + 0x60);
constexpr int32 VK_NUMPAD1          = (VK_NULL + 0x61);
constexpr int32 VK_NUMPAD2          = (VK_NULL + 0x62);
constexpr int32 VK_NUMPAD3          = (VK_NULL + 0x63);
constexpr int32 VK_NUMPAD4          = (VK_NULL + 0x64);
constexpr int32 VK_NUMPAD5          = (VK_NULL + 0x65);
constexpr int32 VK_NUMPAD6          = (VK_NULL + 0x66);
constexpr int32 VK_NUMPAD7          = (VK_NULL + 0x67);
constexpr int32 VK_NUMPAD8          = (VK_NULL + 0x68);
constexpr int32 VK_NUMPAD9          = (VK_NULL + 0x69);
constexpr int32 VK_MULTIPLY         = (VK_NULL + 0x6A);
constexpr int32 VK_ADD              = (VK_NULL + 0x6B);
constexpr int32 VK_SEPARATOR        = (VK_NULL + 0x6C);
constexpr int32 VK_SUBTRACT         = (VK_NULL + 0x6D);
constexpr int32 VK_DECIMAL          = (VK_NULL + 0x6E);
constexpr int32 VK_DIVIDE           = (VK_NULL + 0x6F);
constexpr int32 VK_F1               = (VK_NULL + 0x70);
constexpr int32 VK_F2               = (VK_NULL + 0x71);
constexpr int32 VK_F3               = (VK_NULL + 0x72);
constexpr int32 VK_F4               = (VK_NULL + 0x73);
constexpr int32 VK_F5               = (VK_NULL + 0x74);
constexpr int32 VK_F6               = (VK_NULL + 0x75);
constexpr int32 VK_F7               = (VK_NULL + 0x76);
constexpr int32 VK_F8               = (VK_NULL + 0x77);
constexpr int32 VK_F9               = (VK_NULL + 0x78);
constexpr int32 VK_F10              = (VK_NULL + 0x79);
constexpr int32 VK_F11              = (VK_NULL + 0x7A);
constexpr int32 VK_F12              = (VK_NULL + 0x7B);
constexpr int32 VK_F13              = (VK_NULL + 0x7C);
constexpr int32 VK_F14              = (VK_NULL + 0x7D);
constexpr int32 VK_F15              = (VK_NULL + 0x7E);
constexpr int32 VK_F16              = (VK_NULL + 0x7F);
constexpr int32 VK_F17              = (VK_NULL + 0x80);
constexpr int32 VK_F18              = (VK_NULL + 0x81);
constexpr int32 VK_F19              = (VK_NULL + 0x82);
constexpr int32 VK_F20              = (VK_NULL + 0x83);
constexpr int32 VK_F21              = (VK_NULL + 0x84);
constexpr int32 VK_F22              = (VK_NULL + 0x85);
constexpr int32 VK_F23              = (VK_NULL + 0x86);
constexpr int32 VK_F24              = (VK_NULL + 0x87);

// WM_GWES 0x0000~0x03FF : Messages reserved for use by the system
// WM_USER 0x0400~0x7FFF : Integer messages for use by private window classes
// WM_APP  0x8000~0xBFFF : Messages available for use by applications

constexpr int32 WM_APP              = (WM_NULL + 0x8000);

#endif // __linux__

constexpr int32 WM_CbRemove         = (WM_APP + 0x3FFD);
constexpr int32 WM_ExEvEmit         = (WM_APP + 0x3FFE);
constexpr int32 WM_ExEvWake         = (WM_APP + 0x3FFF);

// ExEvent
//
struct ExEvent {
    HWND        hwnd;
    int32       message;
    uint32      wParam;
    int64       lParam;
    int64       lResult;
    uint32      time;
    uint32      flag;
    ExPoint     pt;
    ExSize      sz;
    uint64      u64[8]; // 64 bytes
    ExObject*   emitter;
    ExObject*   collector;
    void*       data;
    ExEvent() noexcept {}
    ExEvent(HWND hwnd) noexcept
        : hwnd(hwnd), message(0), wParam(0U), lParam(0LL)
        , lResult(0LL), time(0U), flag(0U), pt(0), sz(0), u64{0ULL,}
        , emitter(nullptr), collector(nullptr), data(nullptr) {
    }
    ExEvent(const ExEvent&) noexcept = default;
    ExEvent& operator = (const ExEvent&) noexcept = default;
    ExEvent& set(HWND wnd, int32 msg, int32 wpa, int64 lpa) noexcept {
        hwnd = wnd;
        message = msg;
        wParam = wpa;
        lParam = lpa;
        return *this;
    }
    void clear() noexcept {
        hwnd = None;
        message = 0;
        wParam = 0U;
        lParam = 0LL;
        lResult = 0LL;
        time = 0U;
        flag = 0U;
        pt.set(0, 0);
        sz.set(0, 0);
        (void)memset(u64, 0, sizeof(u64));
        emitter = nullptr;
        collector = nullptr;
        data = nullptr;
    }
};

#ifdef __linux__
class ExEventFifo {
    static constexpr size_t Capacity = static_cast<size_t>(64);
    static constexpr size_t Zero = static_cast<size_t>(0);
    static_assert(Capacity > Zero, "Capacity is zero");
    std::array<ExEvent, Capacity> pool;
    size_t dataCnt;
    size_t headIdx;
    mutable pthread_mutex_t mutex;
    ExEvent& at(int32 i) { return pool.at(static_cast<size_t>(i)); }
public:
    int32 enter() const {
        return pthread_mutex_lock(&mutex);
    }
    int32 leave() const {
        return pthread_mutex_unlock(&mutex);
    }
public:
    ~ExEventFifo() noexcept {
        (void)pthread_mutex_destroy(&mutex);
    }
    ExEventFifo() noexcept : pool(), dataCnt(Zero), headIdx(Zero) {
        (void)pthread_mutex_init(&mutex, nullptr);
    }
public:
    void clear() {
        dataCnt = Zero;
        headIdx = Zero;
    }
    bool empty() const {
        return (dataCnt == Zero);
    }
    size_t capacity() const {
        return Capacity;
    }
    size_t size() const {
        return dataCnt;
    }
    ExEvent* back() { // peek tail
        size_t tailIdx = headIdx + dataCnt;
        if (tailIdx >= Capacity) {
            tailIdx -= Capacity;
        }
        return &pool.at(tailIdx);
    }
    ExEvent* front() { // peek head
        return (dataCnt != Zero) ? &pool.at(headIdx) : nullptr;
    }
    ExEvent* pushBack() { // push tail
        ExEvent* event;
        if (dataCnt < Capacity) {
            size_t tailIdx = headIdx + dataCnt;
            if (tailIdx >= Capacity) {
                tailIdx -= Capacity;
            }
            dataCnt++;
            event = &pool.at(tailIdx);
        } else {
            dprint1("ExEventFifo::pushBack overflow - discard head\n");
            event = nullptr;
        }
        return event;
    }
    ExEvent* popFront() { // pop head
        ExEvent* event;
        if (dataCnt > Zero) {
            event = &pool.at(headIdx);
            headIdx++;
            if (headIdx >= Capacity) {
                headIdx = Zero;
            }
            dataCnt--;
        } else {
            event = nullptr;
        }
        return event;
    }
    ExEvent* add(ExEvent* const ev);
    ExEvent* add(HWND hwnd, int32 message, uint32 wParam = 0U, int64 lParam = 0LL);
};

extern ExEventFifo exEventList;

ExEvent* ExGetMessage(ExEvent* ev = nullptr);
ExEvent* ExPostPtrMsg(int32 message, int32 pt_x, int32 pt_y);
bool PostMessage(HWND hwnd, int32 message, uint32 wparam = 0U, int64 lparam = 0LL);
#endif // __linux__

/**
ExEventPeek()
    Provide asynchronous event notification
Description:
    This function provides an asynchronous event-notification mechanism.
Returns:
    0	no messages are available
    1	a message is available
*/
#ifdef WIN32
typedef bool (*ExEventFunc)(MSG& msg);
bool ExEventPeek(MSG& msg);
#endif // WIN32
#ifdef __linux__
typedef bool (*ExEventFunc)(ExEvent* event);
bool ExEventPeek(ExEvent* event);
#endif // __linux__
extern ExEventFunc exEventFunc;
extern ExEventFunc exCalibFunc;

// ExEmit APIs - deprecated => Call the callback function directly.
//
bool ExEmitMessage(HWND hwnd, int32 message, uint32 wParam, int64 lParam);
bool ExEmitPtrEvent(HWND hwnd, int32 message, int32 pt_x, int32 pt_y);
#ifdef WIN32
bool ExEmitButPress(ExWidget* w, int32 x, int32 y);
bool ExEmitButRelease(ExWidget* w, int32 x, int32 y);
#endif // WIN32

#endif//__exevent_h__
