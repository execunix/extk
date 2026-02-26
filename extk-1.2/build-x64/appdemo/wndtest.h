//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>

class WndTest : public ExWindow {
public:
    ExWidget btns0[5];
    ExWidget edit;
    HWND hwndEdit;
    ExTimer timer;
public:
    ~WndTest() {}
    WndTest() : ExWindow() {}
public:
    int start();
    void initEdit(int x, int y, int w, int h);
    bool initBtn(ExWidget* parent, ExWidget* btn, const char* name);
    uint32 onDestroyed(WndTest* w, ExCbInfo* cbinfo);
    uint32 onLayout(WndTest* widget, ExCbInfo* cbinfo);
    uint32 onActMain(WndTest* widget, ExCbInfo* cbinfo);
    uint32 onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    uint32 onFilter(WndTest* w, ExCbInfo* cbinfo);
    uint32 onTimer(ExTimer* timer, ExCbInfo* cbinfo);
};
