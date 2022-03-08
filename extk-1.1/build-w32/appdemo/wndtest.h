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
    int initBtn(ExWidget* parent, ExWidget* btn, const wchar* name);
    int STDCALL onDestroyed(WndTest* w, ExCbInfo* cbinfo);
    int STDCALL onLayout(WndTest* widget, ExCbInfo* cbinfo);
    int STDCALL onActMain(WndTest* widget, ExCbInfo* cbinfo);
    int STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onFilter(WndTest* w, ExCbInfo* cbinfo);
    int STDCALL onTimer(ExTimer* timer, ExCbInfo* cbinfo);
};
