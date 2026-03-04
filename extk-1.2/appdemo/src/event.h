//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _event_h_
#define _event_h_

#ifdef __linux__
#include <pthread.h>
#endif // __linux__
#include <exevent.h>
#include <list>

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

/*
 * PostMessage(WM_COMMAND, CMD_XXXX, ...);
 */
// CMD_WPARAM : int32
constexpr int32 CMD_UNDEF = 0;
constexpr int32 CMD_LOGIN = 1;
constexpr int32 CMD_LOGOUT = 2;
constexpr int32 CMD_USBCONN = 3;
constexpr int32 CMD_CM4SEND = 4;
constexpr int32 CMD_BRIGHTNESS = 5;
constexpr int32 CMD_DISCONNECT = 6;
constexpr int32 CMD_DELETE_MISSION = 7;
constexpr int32 CMD_KIT_BIT_RESULT = 8;
constexpr int32 CMD_UPDATE_MISSION = 9;
constexpr int32 CMD_TOO_MSN_CONFIRM = 10;
constexpr int32 CMD_CLURDY_TRANSMIT = 11;
constexpr int32 CMD_RMDZ_OFF = 12;
constexpr int32 CMD_RUN_ZEROIZE = 13;
constexpr int32 CMD_DAYNIGHT = 14;
constexpr int32 CMD_SETTING_DISTUNIT = 15;
constexpr int32 CMD_TOUCH_CALIBRAT = 16;
constexpr int32 CMD_SCREEN_CAPTURE = 17;
constexpr int32 CMD_EVENT_MARK = 18;
constexpr int32 CMD_KWPAN_BOOT = 19;
constexpr int32 CMD_KWPAN_DOWN = 20;
constexpr int32 CMD_KWPAN_FAULT = 21;
constexpr int32 CMD_KWPAN_CHANNEL = 22;
constexpr int32 CMD_KWPAN_ARP_FIX = 23;
constexpr int32 CMD_KWPAN_RXPKT = 24;
constexpr int32 CMD_STA_CONNECT = 25;
constexpr int32 CMD_STA_OFFLINE = 26;
constexpr int32 CMD_MSG_VIEW_UPD = 27;
constexpr int32 CMD_DELETE_LAYER = 28;
constexpr int32 CMD_DELETE_USER = 29;
constexpr int32 CMD_CHECKLISTVIEW_MINIMIZED = 30;
constexpr int32 CMD_CHECKLISTVIEW_MAXIMIZED = 31;
constexpr int32 CMD_SELECT_GPS_BOMB_MODE = 32;
constexpr int32 CMD_CHECK_FAT32 = 71;

/* CMD_SCREEN_CAPTURE - usage:
root@imx8mm-var-dart:~# echo scrcap > /tmp/app.fifo
root@imx8mm-var-dart:~# ll /tmp/png
total 180
drwxr-xr-x  2 root root   100 Mar 24 12:22 ./
drwxrwxrwt 10 root root   260 Mar 24 12:20 ../
-rw-r--r--  1 root root 56022 Mar 24 12:20 screen-capture-00000.png
-rw-r--r--  1 root root 47069 Mar 24 12:21 screen-capture-00001.png
-rw-r--r--  1 root root 77412 Mar 24 12:22 screen-capture-00002.png
*/

/*
 * PostMessage(WM_APP_SHOW, MSGBOX_XXXX, ...);
 */
constexpr int32 WM_APP_SHOW         = (WM_NULL + 0x8001);
// APP_WPARAM : int32
constexpr int32 GPSVIEW_HIDE = 1;
constexpr int32 GPSVIEW_SHOW = 2;
constexpr int32 KITVIEW_HIDE = 3;
constexpr int32 KITVIEW_SHOW = 4;
constexpr int32 MSGVIEW_MODE = 5;
constexpr int32 MSGVIEW_SHOW = 6;
constexpr int32 CHECKLISTVIEW_SHOW = 7;
constexpr int32 LISTMIF_SHOW = 8;
constexpr int32 WPLIST_SHOW = 9;
constexpr int32 MSGBOX_LOGIN_FAIL = 11;
constexpr int32 MSGBOX_LOGOUT = 12;
constexpr int32 MSGBOX_DAYNIGHT = 13;
constexpr int32 MSGBOX_PBIT_ERR = 14;
constexpr int32 MSGBOX_DISCONNECT = 15;
constexpr int32 MSGBOX_DELETE_MISSION = 16;
constexpr int32 MSGBOX_KIT_IBIT_TIMEOUT = 17;
constexpr int32 MSGBOX_KIT_IBIT_RESULT = 18;
constexpr int32 MSGBOX_KIT_IMU_CBIT = 19;
constexpr int32 MSGBOX_KIT_ZEROIZE = 20; // show result
constexpr int32 MSGBOX_ASK_ZEROIZE = 21; // ask ok/cancel
constexpr int32 MSGBOX_ASK_RMDZ_OFF = 22; // ask ok/cancel
constexpr int32 MSGBOX_ADD_LAYER = 23;
constexpr int32 MSGBOX_DELETE_LAYER = 24;
constexpr int32 MSGBOX_MODIFY_LAYER = 25;
constexpr int32 MSGBOX_ADD_USER = 26;
constexpr int32 MSGBOX_ADD_USER_DUPLCATE_ERR = 27;
constexpr int32 MSGBOX_USER_ERR = 28;
constexpr int32 MSGBOX_DELETE_USER = 29;
constexpr int32 MSGBOX_DELETE_USER_SUCCESS = 30;
constexpr int32 MSGBOX_DELETE_USER_FAIL = 31;
constexpr int32 MSGBOX_MODIFY_USER = 32;
constexpr int32 MSGBOX_INVALID_VALUE = 33;
constexpr int32 MSGBOX_OUT_OF_RANGE = 34;
constexpr int32 CHECKLIST_REFRESH = 35;

constexpr int32 WM_LAR_PROC         = (WM_NULL + 0x8002);
constexpr int32 LAR_FLAG_CLEAR = 0;
constexpr int32 LAR_CALC_SP = 1;
constexpr int32 LAR_PROC_PP_MACH = 2;
constexpr int32 LAR_PROC_EDIT_MACH = 3;

constexpr int32 WM_MAP_DRAW         = (WM_NULL + 0x8003);
// MAP_PARAM : int32
constexpr int32 MAP_REDRAW = 1;
constexpr int32 MAP_HEADING = 2;
constexpr int32 MAP_ZOOMIN = 3;
constexpr int32 MAP_ZOOMOUT = 4;
constexpr int32 MAP_MOVE = 5;

/*
 * PostMessage(WM_DEBRIEF_COMMAND, DEBRIEF_XXXX, ...);
 */
constexpr int32 WM_DEBRIEF_COMMAND  = (WM_NULL + 0x8004);
// DEBRIEF_PARAM : int32
constexpr int32 DEBRIEF_RUN = 1;
constexpr int32 DEBRIEF_START = 2;
constexpr int32 DEBRIEF_REWIND = 3;
constexpr int32 DEBRIEF_PLAY = 4;
constexpr int32 DEBRIEF_PAUSE = 5;
constexpr int32 DEBRIEF_FORWARD = 6;
constexpr int32 DEBRIEF_SPEED = 7;
constexpr int32 DEBRIEF_STOP = 8;

const uint32 Ex_CbEditChange = (Ex_CbUser + 1U);
const uint32 Ex_CbPopupClose = (Ex_CbUser + 1U);

class Event : public ExEvent {
private:
    uint64 u64[4];
public:
    Event() : ExEvent() {}
    explicit Event(void* const hwnd) : ExEvent(hwnd) { (void)memset(&u64[0], 0, sizeof(u64)); }
    Event(const Event&) = default;
    Event& operator = (const Event&) = default;
};

class EventList : public std::list<Event*> {
    mutable pthread_mutex_t mutex;
public:
    int32 enter() const {
        return pthread_mutex_lock(&mutex);
    }
    int32 leave() const {
        return pthread_mutex_unlock(&mutex);
    }
public:
    ~EventList() {
        (void)pthread_mutex_destroy(&mutex);
    }
    EventList() : std::list<Event*>() {
        (void)pthread_mutex_init(&mutex, nullptr);
    }
    bool add(Event* const ev);
};

extern EventList gEventList;

int32 DefWndProc(Event& ev);

bool GetMessage(Event& ev);
bool PostPtrMsg(const int32 message, const int32 pt_x, const int32 pt_y);
bool PostMessage(const int32 message, const int32 wparam = 0, const int64 lparam = 0L);
void EmitTouchEvent(const uint32 tickCount, const int32 message, int32 pt_x, int32 pt_y);

#endif // __linux__

#endif // _event_h_
