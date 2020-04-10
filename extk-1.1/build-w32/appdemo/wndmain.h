//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>

class WndMain : public ExWindow {
public:
    wchar respath[256];
    ExWidget panes[3];
    ExWidget btns0[5];
    ExWidget btns1[6];
    ExWidget btns2[6];
    ExWidget wgtBkgd;
    ExImage imgBkgd0;
    ExImage imgBkgd1;
    ExPoint img_pt0;
    ExPoint img_pt1;
    ExTimer timer;
    ExWindow wndBackBuf;
    ExWidget wgtBackBtn;
    ExWidget wgtBackViewer;
    ExTimer backBufUpdater;
    int backBufCnt;
public:
    ~WndMain() {}
    WndMain() : ExWindow() {}
public:
    int start();
    int initInput();
    int initCanvas();
    int initBtn(ExWidget* parent, ExWidget* btn, const wchar* name);
    void STDCALL onExFlush(WndMain* w, const ExRegion* updateRgn) { ExWindow::onExFlush(w, updateRgn); } // apitest
    void STDCALL onWmPaint(WndMain* w, const ExRegion* updateRgn) { ExWindow::onWmPaint(w, updateRgn); } // apitest
    int STDCALL onDestroyed(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onLayout(WndMain* widget, ExCbInfo* cbinfo);
    int STDCALL onActMain(WndMain* widget, ExCbInfo* cbinfo);
    int STDCALL onActBkgd(WndMain* widget, ExCbInfo* cbinfo);
    int STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawTrap(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawPane(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onHandler(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onFilter(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onTimer(ExTimer* timer, ExCbInfo* cbinfo);
    ExWidget toy;
    ExTimer timerToy;
    float toy_alpha, toy_delta, toy_scale;
    void STDCALL onDrawToy(ExCanvas* canvas, const WndMain* w, const ExRegion* damage);
    int STDCALL onTimerToy(WndMain* w, ExCbInfo* cbinfo);
    void STDCALL onFlushBackBuf(WndMain* w, const ExRegion* updateRgn);
    void STDCALL onDrawBackBuf(ExCanvas* canvas, const ExWidget* w, const ExRegion* damage);
    int STDCALL onBackBufUpdater(ExTimer* timer, ExCbInfo* cbinfo);
};
