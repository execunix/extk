//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>
#include <list>

class Menu;
class MenuList : public std::list<Menu*> {
public:
    ~MenuList();
    MenuList() : std::list<Menu*>() {}
    Menu* add(const wchar* text, int id);
};

class Menu {
public:
    wchar text[256];
    int flag;
    int id;
public:
    ExWidget* view;
    MenuList subList;
    cairo_text_extents_t extents;
public:
    Menu() : view(NULL) {}
};

inline MenuList::~MenuList() {
    while (!empty()) {
        Menu* menu = front();
        pop_front();
        delete menu;
    }
}

inline Menu* MenuList::add(const wchar* text, int id) {
    Menu* menu = new Menu;
    wcsncpy(menu->text, text, 255);
    menu->text[255] = 0;
    menu->flag = 0;
    menu->id = id;
    menu->view = NULL;
    menu->extents.width = 0;
    push_back(menu);
    return menu;
}

class WgtMenu : public ExWidget {
    class Popup : public ExWidget {
    public:
        ExWidget* wgtMenu;
        MenuList* mlist; // ref
    public:
        ~Popup() { clear(); }
        Popup() : ExWidget(), wgtMenu(NULL), mlist(NULL) {}
    public:
        void clear();
    };
    typedef std::list<Popup*> PopList;

    const UINT WM_APP_MENUPOPUP = ExRegAppMessage();
    const floatt fontSize = 12.5f;
public:
    PopList popList;
    MenuList menuList;
    ExWidget* menuBar;
public:
    ~WgtMenu() { fini();  }
    WgtMenu() : ExWidget() {}
public:
    void STDCALL onDrawMenu(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onLayoutHorz(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayoutVert(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onActivate(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFocused(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onHandler(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFilter(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    Popup* popup(int x, int y, MenuList& ml); // popup menu
    void setup(); // root menu
    void fini();
    void init(ExWindow* window);
    void load(); // sample
};
