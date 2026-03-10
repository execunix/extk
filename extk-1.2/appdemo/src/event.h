//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _event_h_
#define _event_h_

#include <exevent.h>
#include <list>

#ifdef __linux__

/*
 * PostMessage(None, WM_COMMAND, CMD_XXXX, ...);
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
 * PostMessage(None, WM_APP_SHOW, MSGBOX_XXXX, ...);
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
 * PostMessage(None, WM_DEBRIEF_COMMAND, DEBRIEF_XXXX, ...);
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

int32 DefWndProc(ExEvent& ev);

bool PostPtrMsg(const int32 message, const int32 pt_x, const int32 pt_y);
void EmitTouchEvent(const uint32 tickCount, const int32 message, int32 pt_x, int32 pt_y);

#endif // __linux__

#endif // _event_h_
