//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>
#include <list>

class WgtPage1 : public ExWidget {
    ExWidget label1;
    ExWidget button1;
public:
    ~WgtPage1() { fini(); }
    WgtPage1() : ExWidget() {}
public:
    void fini();
    void init(ExWidget* parent, ExRect& rc);
};

class WgtPage2 : public ExWidget {
    ExWidget label1;
    ExWidget button1;
public:
    ~WgtPage2() { fini(); }
    WgtPage2() : ExWidget() {}
public:
    void fini();
    void init(ExWidget* parent, ExRect& rc);
};

class WgtPage3 : public ExWidget {
    ExWidget label1;
    ExWidget button1;
public:
    ~WgtPage3() { fini(); }
    WgtPage3() : ExWidget() {}
public:
    void fini();
    void init(ExWidget* parent, ExRect& rc);
};

class WgtSetup : public ExWidget {
    const UINT WM_APP_SETUP = ExRegAppMessage();
public:
    ExWidget title;
    ExWidget close;
    ExWidget tab1;
    WgtPage1 page1;
    ExWidget tab2;
    WgtPage2 page2;
    ExWidget tab3;
    WgtPage3 page3;
public:
    ~WgtSetup() { fini();  }
    WgtSetup() : ExWidget() {}
public:
    void STDCALL onDrawSetup(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onActivate(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFocused(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onHandler(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFilter(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    void fini();
    void init(ExWidget* parent, int x, int y);
};
