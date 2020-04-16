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
    enum {
        Separator = 1 << 0,
        Disabled  = 1 << 1,
    };
public:
    ExWidget* view; // ref
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
        ExWidget* menuPop; // new
        Menu* link; // ref
    public:
        ~Popup() { clear(); }
        Popup() : ExWidget(), menuPop(NULL), link(NULL) {}
    public:
        void clear();
    };
    typedef std::list<Popup*> PopList;

    struct MoveTable {
        Menu* up;
        Menu* down;
        Menu* left;
        Menu* right;
        Menu* home;
        Menu* end;
        union {
            int flags;
            struct {
                int fDone : 1;
                int fMatch : 1;
            };
        };

        MoveTable() {
            up = down = left = right = home = end = NULL;
            flags = 0;
        }
    };

    const UINT WM_APP_MENUPOPUP = ExRegAppMessage();
    const floatt fontSize = 12.5f;
protected:
    ExWindow* window;
    MenuList pathList;
public:
    PopList popList;
    MenuList rootList;
    ExWidget* menuBar; // new
    ExWidget* oldFocus;
    Menu* focused; // ref
public:
    ~WgtMenu() { fini();  }
    WgtMenu() : ExWidget(), menuBar(NULL), oldFocus(NULL), focused(NULL) {}
public:
    void STDCALL onDrawMenu(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onLayoutHorz(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayoutVert(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onActivate(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFocused(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onHandler(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFilter(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    void fillMoveTable(MoveTable& mt, MenuList* ml, Menu* menu);
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
