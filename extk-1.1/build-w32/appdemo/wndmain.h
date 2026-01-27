//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>
#include "wgtmenu.h"

class WgtTitle : public ExWidget {
public:
    char title[256];
public:
    ~WgtTitle() {}
    WgtTitle() : ExWidget() {}
public:
    void init(ExWindow* window);
    void setTitle(const char* str) {
        strncpy(title, str, 255);
        title[255] = 0;
    }
    uint32 STDCALL onLayout(WgtTitle* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawTitle(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
};

class WndMain : public ExWindow {
public:
    ExWidget panes[3];
    ExWidget btns0[5];
    ExWidget btns1[6];
    ExWidget btns2[6];
    ExWidget wgtBkgd;
    ExPoint img_pt0;
    ExTimer timer;
    ExWindow wndBackBuf;
    ExWidget wgtBackBtn;
    ExWidget wgtBackViewer;
    ExTimer backBufUpdater;
    int backBufCnt;
    WgtMenu wgtMenu;
    WgtTitle wgtTitle;
    const UINT WM_APP_TEST = ExRegAppMessage();
public:
    ~WndMain() {}
    WndMain() : ExWindow() {}
public:
    int start();
    int initIomux();
    bool initBtn(ExWidget* parent, ExWidget* btn, const char* name);
    void STDCALL onExFlush(WndMain* w, const ExRegion* updateRgn) { ExWindow::onExFlush(w, updateRgn); } // apitest
    void STDCALL onWmPaint(WndMain* w, const ExRegion* updateRgn) { ExWindow::onWmPaint(w, updateRgn); } // apitest
    uint32 STDCALL onDestroyed(WndMain* w, ExCbInfo* cbinfo);
    uint32 STDCALL onLayout(WndMain* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onFocused(WndMain* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onActMain(WndMain* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onActBkgd(WndMain* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawTrap(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawPane(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    uint32 STDCALL onRbtnDown(WndMain* w, ExCbInfo* cbinfo);
    uint32 STDCALL onHandler(WndMain* w, ExCbInfo* cbinfo);
    uint32 STDCALL onFilter(WndMain* w, ExCbInfo* cbinfo);
    uint32 STDCALL onTimer(ExTimer* timer, ExCbInfo* cbinfo);
    ExWidget* moveFocus(int dir);
    ExWidget toy;
    ExTimer timerToy;
    float toy_alpha, toy_delta, toy_scale;
    void STDCALL onDrawToy(ExCanvas* canvas, const WndMain* w, const ExRegion* damage);
    uint32 STDCALL onTimerToy(WndMain* w, ExCbInfo* cbinfo);
    void STDCALL onFlushBackBuf(WndMain* w, const ExRegion* updateRgn);
    void STDCALL onDrawBackBuf(ExCanvas* canvas, const ExWidget* w, const ExRegion* damage);
    uint32 STDCALL onBackViewMove(WndMain* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onBackBufUpdater(ExTimer* timer, ExCbInfo* cbinfo);
};
