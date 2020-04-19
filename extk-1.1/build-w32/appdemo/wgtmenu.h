//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>
#include <list>

class Menu {
public:
    ExImage* icon;
    wchar text[256];
    wchar hkey[32];
    int flag;
    int id;
    enum {
        Separator = 1 << 0,
        Disabled  = 1 << 1,
    };
public:
    Menu* parent;
    Menu* child;
    Menu* next;
    Menu* prev;
    int size;
    void detach();
    void attach(Menu* menu);
public:
    ExWidget* view; // ref
    cairo_text_extents_t extents;
public:
    ~Menu();
    Menu();
    Menu* add(const wchar* text, int id, int flag = 0);
};

class WgtMenu : public ExWidget {
    class Popup : public ExWidget {
    public:
        ExWidget* menuPop; // new
        Menu* link; // ref
        floatt ani;
        ExTimer timerAni;
    public:
        ~Popup() { clear(); }
        Popup() : ExWidget(), menuPop(NULL), link(NULL) {}
    public:
        void clear();
    };
    typedef std::list<Popup*> PopList;

    struct MoveTable {
        Menu* home;
        Menu* prev;
        Menu* next;
        Menu* end;

        void fill(Menu* menu);
    };

    const UINT WM_APP_MENUPOPUP = ExRegAppMessage();
    const floatt fontSize = 12.f;
    const int menuHeight = 28;
protected:
    ExWindow* window;
public:
    Menu rootMenu;
    PopList popList;
    ExWidget* menuBar; // new
    ExWidget* oldFocus;
    Menu* focused; // ref
public:
    ~WgtMenu() { fini();  }
    WgtMenu() : ExWidget(), menuBar(NULL), oldFocus(NULL), focused(NULL) {}
public:
    int STDCALL onTimerAni(Popup* popup, ExCbInfo* cbinfo);
    void STDCALL onDrawMenuPopBkgd(ExCanvas* canvas, const Popup* popup, const ExRegion* damage);
    void STDCALL onDrawMenuPop(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawMenuBarBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawMenuBar(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    //void STDCALL onDrawMenu(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onLayoutHorz(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayoutVert(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onActivate(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFocused(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onHandler(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFilter(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    void moveMenuFocus(int dir);
    Menu* findMenu(const ExPoint& pt);
    void menuFocus(Menu* menu);
    void showPopup(Menu* link);
    Popup* popup(int x, int y, Menu* link); // popup menu
    void setup(); // root menu
    void fini();
    void init(ExWindow* window);
    void load(); // sample
};
