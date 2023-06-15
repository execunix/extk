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
    uint32 STDCALL onDestroyed(WndTest* w, ExCbInfo* cbinfo);
    uint32 STDCALL onLayout(WndTest* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onActMain(WndTest* widget, ExCbInfo* cbinfo);
    uint32 STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    uint32 STDCALL onFilter(WndTest* w, ExCbInfo* cbinfo);
    uint32 STDCALL onTimer(ExTimer* timer, ExCbInfo* cbinfo);
};
