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
#define WM_NULL                         0x0000
#define WM_CREATE                       0x0001
#define WM_DESTROY                      0x0002
#define WM_MOVE                         0x0003
#define WM_SIZE                         0x0005
#define WM_ACTIVATE                     0x0006
#define WM_SETFOCUS                     0x0007
#define WM_KILLFOCUS                    0x0008
#define WM_PAINT                        0x000F
#define WM_CLOSE                        0x0010
#define WM_QUIT                         0x0012
#define WM_SHOWWINDOW                   0x0018

#define WM_KEYDOWN                      0x0100
#define WM_KEYUP                        0x0101
#define WM_CHAR                         0x0102
#define WM_COMMAND                      0x0111

#define WM_MOUSEMOVE                    0x0200
#define WM_LBUTTONDOWN                  0x0201
#define WM_LBUTTONUP                    0x0202
#define WM_LBUTTONDBLCLK                0x0203
#define WM_RBUTTONDOWN                  0x0204
#define WM_RBUTTONUP                    0x0205
#define WM_RBUTTONDBLCLK                0x0206
#define WM_MBUTTONDOWN                  0x0207
#define WM_MBUTTONUP                    0x0208
#define WM_MBUTTONDBLCLK                0x0209

/*
 * Virtual Keys, Standard Set
 */
#define VK_LBUTTON        0x01
#define VK_RBUTTON        0x02
#define VK_CANCEL         0x03
#define VK_MBUTTON        0x04    /* NOT contiguous with L & RBUTTON */

#if(_WIN32_WINNT >= 0x0500)
#define VK_XBUTTON1       0x05    /* NOT contiguous with L & RBUTTON */
#define VK_XBUTTON2       0x06    /* NOT contiguous with L & RBUTTON */
#endif /* _WIN32_WINNT >= 0x0500 */
/*
 * 0x07 : reserved
 */
#define VK_BACK           0x08
#define VK_TAB            0x09
/*
 * 0x0A - 0x0B : reserved
 */
#define VK_CLEAR          0x0C
#define VK_RETURN         0x0D
/*
 * 0x0E - 0x0F : unassigned
 */
#define VK_SHIFT          0x10
#define VK_CONTROL        0x11
#define VK_MENU           0x12
#define VK_PAUSE          0x13
#define VK_CAPITAL        0x14

#define VK_KANA           0x15
#define VK_HANGEUL        0x15  /* old name - should be here for compatibility */
#define VK_HANGUL         0x15
#define VK_IME_ON         0x16
#define VK_JUNJA          0x17
#define VK_FINAL          0x18
#define VK_HANJA          0x19
#define VK_KANJI          0x19
#define VK_IME_OFF        0x1A

#define VK_ESCAPE         0x1B

#define VK_CONVERT        0x1C
#define VK_NONCONVERT     0x1D
#define VK_ACCEPT         0x1E
#define VK_MODECHANGE     0x1F

#define VK_SPACE          0x20
#define VK_PRIOR          0x21
#define VK_NEXT           0x22
#define VK_END            0x23
#define VK_HOME           0x24
#define VK_LEFT           0x25
#define VK_UP             0x26
#define VK_RIGHT          0x27
#define VK_DOWN           0x28
#define VK_SELECT         0x29
#define VK_PRINT          0x2A
#define VK_EXECUTE        0x2B
#define VK_SNAPSHOT       0x2C
#define VK_INSERT         0x2D
#define VK_DELETE         0x2E
#define VK_HELP           0x2F
/*
 * VK_0 - VK_9 are the same as ASCII '0' - '9' (0x30 - 0x39)
 * 0x3A - 0x40 : unassigned
 * VK_A - VK_Z are the same as ASCII 'A' - 'Z' (0x41 - 0x5A)
 */
#define VK_LWIN           0x5B
#define VK_RWIN           0x5C
#define VK_APPS           0x5D
/*
 * 0x5E : reserved
 */
#define VK_SLEEP          0x5F

#define VK_NUMPAD0        0x60
#define VK_NUMPAD1        0x61
#define VK_NUMPAD2        0x62
#define VK_NUMPAD3        0x63
#define VK_NUMPAD4        0x64
#define VK_NUMPAD5        0x65
#define VK_NUMPAD6        0x66
#define VK_NUMPAD7        0x67
#define VK_NUMPAD8        0x68
#define VK_NUMPAD9        0x69
#define VK_MULTIPLY       0x6A
#define VK_ADD            0x6B
#define VK_SEPARATOR      0x6C
#define VK_SUBTRACT       0x6D
#define VK_DECIMAL        0x6E
#define VK_DIVIDE         0x6F
#define VK_F1             0x70
#define VK_F2             0x71
#define VK_F3             0x72
#define VK_F4             0x73
#define VK_F5             0x74
#define VK_F6             0x75
#define VK_F7             0x76
#define VK_F8             0x77
#define VK_F9             0x78
#define VK_F10            0x79
#define VK_F11            0x7A
#define VK_F12            0x7B
#define VK_F13            0x7C
#define VK_F14            0x7D
#define VK_F15            0x7E
#define VK_F16            0x7F
#define VK_F17            0x80
#define VK_F18            0x81
#define VK_F19            0x82
#define VK_F20            0x83
#define VK_F21            0x84
#define VK_F22            0x85
#define VK_F23            0x86
#define VK_F24            0x87

// WM_GWES 0x0000~0x03FF : Messages reserved for use by the system
// WM_USER 0x0400~0x7FFF : Integer messages for use by private window classes
// WM_APP  0x8000~0xBFFF : Messages available for use by applications

#define WM_APP                          0x8000

/*
 * PostMessage(WM_COMMAND, CMD_XXXX, ...);
 */
enum {
    CMD_UNDEF,
    CMD_LOGIN,
    CMD_LOGOUT,
    CMD_USBCONN,
    CMD_BRIGHTNESS,
    CMD_DISCONNECT,
    CMD_DELETE_MISSION,
    CMD_KIT_BIT_RESULT,
    CMD_KIT_TO_LOAD_MIF,
    CMD_CLURDY_TRANSMIT,
    CMD_DAYNIGHT,
    CMD_TOUCH_CALIBRAT,
    CMD_SCREEN_CAPTURE,
    CMD_EVENT_MARK,
    CMD_KWPAN_BOOT,
    CMD_KWPAN_CHANNEL,
    CMD_KWPAN_RXPKT,
    CMD_MSG_VIEW_UPD,
};

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
#define WM_APP_SHOW                     0x8001
enum {
    GPSVIEW_HIDE,
    GPSVIEW_SHOW,
    KITVIEW_HIDE,
    KITVIEW_SHOW,
    MSGVIEW_HIDE,
    MSGVIEW_SHOW,
    LISTMIF_SHOW,
    MSGBOX_LOGIN_FAIL,
    MSGBOX_LOGOUT,
    MSGBOX_DAYNIGHT,
    MSGBOX_PBIT_ERR,
    MSGBOX_DISCONNECT,
    MSGBOX_DELETE_MISSION,
    MSGBOX_KIT_BIT_TIMEOUT,
    MSGBOX_KIT_BIT_RESULT,
};

#define WM_MAP_DRAW                     0x8003
enum {
    MAP_REDRAW,
    MAP_HEADING,
    MAP_ZOOMIN,
    MAP_ZOOMOUT,
    MAP_MOVE,
};

#define Ex_CbEditChange (Ex_CbUser + 1)
#define Ex_CbPopupClose (Ex_CbUser + 1)

struct Event : public ExEvent {
    union {
        struct {
            ExWidget* wgt; // link to update
            char* buf; // in/out
            int len;
        } edit;
        // tbd - add custom msg
    } u;
    Event() : ExEvent() {
        memset(&u, 0, sizeof(u));
    }
    Event(const Event& ev) : ExEvent(ev) {
        memcpy(&u, &ev.u, sizeof(u));
    }
    Event& operator = (const Event& ev) {
        ExEvent::operator = (ev);
        memcpy(&u, &ev, sizeof(u));
        return *this;
    }
};

class EventList : public std::list<Event*> {
public:
    mutable pthread_mutex_t mutex;
    int enter() const {
        return pthread_mutex_lock(&mutex);
    }
    int leave() const {
        return pthread_mutex_unlock(&mutex);
    }
public:
    ~EventList() {
        pthread_mutex_destroy(&mutex);
    }
    EventList() : std::list<Event*>() {
        pthread_mutex_init(&mutex, NULL);
    }
    int add(Event* ev);
};

extern EventList gEventList;

int DefWndProc(Event& ev);

int GetMessage(Event& ev);
int PostMessage(int message, ExPoint pt);
int PostMessage(int message, int wparam = 0, int64 lparam = 0);
int PostEditMsg(int message, int wparam, ExWidget* wgt, char* buf, int len);
int EmitTouchEvent(uint32 tickCount, int message, ExPoint pt);
#endif // __linux__

#endif // _event_h_
