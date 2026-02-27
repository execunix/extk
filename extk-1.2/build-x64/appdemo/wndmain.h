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
    uint32 onLayout(WgtTitle* widget, ExCbInfo* cbinfo);
    void onDrawTitle(ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage);
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
    void onExFlush(WndMain* w, const ExRegion* updateRgn) { ExWindow::onExFlush(w, updateRgn); } // apitest
    void onWmPaint(WndMain* w, const ExRegion* updateRgn) { ExWindow::onWmPaint(w, updateRgn); } // apitest
    uint32 onDestroyed(WndMain* w, ExCbInfo* cbinfo);
    uint32 onLayout(WndMain* widget, ExCbInfo* cbinfo);
    uint32 onFocused(WndMain* widget, ExCbInfo* cbinfo);
    uint32 onActMain(WndMain* widget, ExCbInfo* cbinfo);
    uint32 onActBkgd(WndMain* widget, ExCbInfo* cbinfo);
    uint32 onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void onDrawBkgd(ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage);
    void onDrawTrap(ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage);
    void onDrawBtns(ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage);
    void onDrawPane(ExCanvas* canvas, const ExWgtRes* wgtres, const ExRegion* damage);
    uint32 onRbtnDown(WndMain* w, ExCbInfo* cbinfo);
    uint32 onHandler(WndMain* w, ExCbInfo* cbinfo);
    uint32 onFilter(WndMain* w, ExCbInfo* cbinfo);
    uint32 onTimer(ExTimer* timer, ExCbInfo* cbinfo);
    ExWidget* moveFocus(int dir);
    ExWidget toy;
    ExTimer timerToy;
    float toy_alpha, toy_delta, toy_scale;
    void onDrawToy(ExCanvas* canvas, ExWgtRes* wgtres, ExRegion* damage);
    uint32 onTimerToy(WndMain* w, ExCbInfo* cbinfo);
    void onFlushBackBuf(WndMain* w, const ExRegion* updateRgn);
    void onDrawBackBuf(ExCanvas* canvas, const ExWgtRes* w, const ExRegion* damage);
    uint32 onBackViewMove(WndMain* widget, ExCbInfo* cbinfo);
    uint32 onBackBufUpdater(ExTimer* timer, ExCbInfo* cbinfo);
};
