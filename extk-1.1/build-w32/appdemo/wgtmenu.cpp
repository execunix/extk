//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtmenu.h"

const UINT IDM_EXIT = 100;

void WgtMenu::Popup::clear() {
    destroy();
    if (wgtMenu)
        delete[] wgtMenu;
    wgtMenu = NULL;
    mlist = NULL;
}

void WgtMenu::onDrawMenu(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    ExCairo::Color fc; // fill color
    if (widget->getFlags(Ex_PtrEntered)) {
        fc.set(.5f, .5f, .5f, 1.f);
    } else {
        fc.set(0.f, 0.f, 0.f, .5f);
    }
    cairo_set_source_rgba(cr, fc.r, fc.g, fc.b, fc.a);
    cairo_rectangle(cr, rc.l, rc.t, rc.r, rc.b);
    cairo_fill(cr);

    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, fontSize);
    Menu* menu = (Menu*)widget->getData();
    cairo_text_extents_t& extents = menu->extents;
    ExCairo::Point pt;
    pt.x = 18.f; // left
    //pt.x = (rc.width() - extents.width) / 2.f - extents.x_bearing; // center
    pt.y = (rc.height() - extents.height) / 2.f - extents.y_bearing; // center
    cairo_move_to(cr, rc.l + pt.x, rc.t + pt.y);
    cairo_set_source_rgb(cr, 1.f, 1.f, 1.f);
    cairo_show_text(cr, menu->text);

    cairo_restore(cr);
}

int WgtMenu::onLayoutHorz(ExWidget* widget, ExCbInfo* cbinfo) {
    ExArea& horz = *(ExArea*)cbinfo->data;
    ExCanvas* canvas = getWindow()->canvas;
    cairo_t* cr = canvas->cr; // tbd - assert
    // calc cairo_text_extents
    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, fontSize);
    Menu* menu = (Menu*)widget->getData();
    cairo_text_extents(cr, menu->text, &menu->extents);
    int menu_width = (int)menu->extents.width + 36;
    widget->area.set(horz.x, horz.y, menu_width, horz.h);
    horz.x += menu_width + 1;
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

int WgtMenu::onLayoutVert(ExWidget* widget, ExCbInfo* cbinfo) {
    ExArea& vert = *(ExArea*)cbinfo->data;
    ExCanvas* canvas = getWindow()->canvas;
    cairo_t* cr = canvas->cr; // tbd - assert
    // calc cairo_text_extents
    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, fontSize);
    Menu* menu = (Menu*)widget->getData();
    cairo_text_extents(cr, menu->text, &menu->extents);
    int menu_width = (int)menu->extents.width + 36;
    if (vert.w < menu_width) vert.w = menu_width; // save max width
    widget->area.set(vert.x, vert.y, vert.w, 28);
    vert.y += 29;
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

int WgtMenu::onActivate(ExWidget* widget, ExCbInfo* cbinfo) {
    return Ex_Continue;
}

int WgtMenu::onFocused(ExWidget* widget, ExCbInfo* cbinfo) {
    return Ex_Continue;
}

int WgtMenu::onHandler(ExWidget* widget, ExCbInfo* cbinfo) {
    return Ex_Continue;
}

int WgtMenu::onFilter(ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->event->message == WM_COMMAND) {
        dprintf(L"WM_COMMAND: %d\n", cbinfo->event->wParam);
        if (cbinfo->event->wParam == IDM_EXIT)
            return Ex_Halt;
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_MOUSEMOVE) {
        if (popList.empty())
            return Ex_Continue;
        ExWindow* window = getWindow();
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        ExPoint pt(xPos, yPos);
        Popup* pop = NULL;
        // find entered
        ExWidget* w = getPointOwner(pt);
        Menu* menu = w ? (Menu*)w->getData() : NULL;
        if (!menu) {
            PopList::iterator i = popList.begin();
            while (i != popList.end() && !menu) {
                pop = *i++;
                w = pop->getPointOwner(pt);
                menu = w ? (Menu*)w->getData() : NULL;
            }
        }
        if (menu && window->wgtEntered != w) {
            // w is new entered
            assert(menu->view == w);
            while (!popList.empty()) {
                pop = popList.front();
                if (pop->mlist == &menu->subList)
                    return Ex_Continue; // already poped
                if (pop == w->getParent())
                    break;
                popList.pop_front();
                delete pop;
            }
            if (!menu->subList.empty()) {
                ExRect rc = menu->view->getRect();
                if (popList.empty())
                    popList.push_front(popup(rc.l, rc.b, menu->subList));
                else
                    popList.push_front(popup(rc.r, rc.t, menu->subList));
            }
        }
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_LBUTTONDOWN) {
        ExWindow* window = getWindow();
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        ExPoint pt(xPos, yPos);
        Popup* pop = NULL;
        // find pressed
        ExWidget* w = getPointOwner(pt);
        Menu* menu = w ? (Menu*)w->getData() : NULL;
        if (!menu) {
            PopList::iterator i = popList.begin();
            while (i != popList.end() && !menu) {
                pop = *i++;
                w = pop->getPointOwner(pt);
                menu = w ? (Menu*)w->getData() : NULL;
            }
        }
        int popcnt = popList.size();
        while (!popList.empty()) {
            pop = popList.front();
            if (menu && this != w->getParent()) {
                assert(menu->view == w);
                if (pop->mlist == &menu->subList)
                    return Ex_Break; // already poped
                if (pop == w->getParent() && !menu->subList.empty())
                    break;
            }
            popList.pop_front();
            delete pop;
        }
        if (menu) {
            if (popcnt > 0 && this == w->getParent())
                return Ex_Break; // toggle
            if (!menu->subList.empty()) {
                ExRect rc = menu->view->getRect();
                if (popList.empty())
                    popList.push_front(popup(rc.l, rc.b, menu->subList));
                else
                    popList.push_front(popup(rc.r, rc.t, menu->subList));
            } else {
                HWND hwnd = window->getHwnd();
                PostMessage(hwnd, WM_COMMAND, menu->id, (LPARAM)menu);
            }
            return Ex_Break;
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WgtMenu::onLayout(ExWidget* widget, ExCbInfo* cbinfo) {
    ExArea& expand = *(ExArea*)cbinfo->data;
    MenuList& ml = menuList;
    ExArea horz(1, 1, area.w - 2, area.h - 2);
    for (uint n = 0; n < ml.size(); n++) {
        menuBar[n].layout(horz);
    }
    expand = horz;
    //layout(horz);
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

WgtMenu::Popup* WgtMenu::popup(int x, int y, MenuList& ml) {
    ExWindow* window = getWindow();
    Popup* pop = new Popup;
    pop->init(window);
    pop->mlist = &ml;
    pop->layout(ExArea(x, y, 100, 30));
    pop->wgtMenu = new ExWidget[ml.size()];
    MenuList::iterator it = ml.begin();
    ExArea vert(1, 1, 1, 1);
    for (uint n = 0; n < ml.size(); n++) {
        Menu* menu = *it++;
        menu->view = &pop->wgtMenu[n];
        pop->wgtMenu[n].setData(menu);
        pop->wgtMenu[n].init(pop, menu->text);
        pop->wgtMenu[n].setFlags(Ex_Selectable | Ex_AutoHighlight | Ex_FocusRender);
        pop->wgtMenu[n].addCallback(this, &WgtMenu::onLayoutVert, Ex_CbLayout);
        pop->wgtMenu[n].addCallback(this, &WgtMenu::onActivate, Ex_CbActivate);
        pop->wgtMenu[n].addCallback(this, &WgtMenu::onFocused, Ex_CbGotFocus);
        pop->wgtMenu[n].drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenu);
        pop->wgtMenu[n].layout(vert);
    }
    pop->area.w = vert.w + 2;
    pop->area.h = vert.y + 2;
    for (uint n = 0; n < ml.size(); n++) {
        pop->wgtMenu[n].area.w = vert.w; // expand max width
    }
    return pop;
}

void WgtMenu::setup() {
    MenuList& ml = menuList;
    menuBar = new ExWidget[ml.size()];
    MenuList::iterator it = ml.begin();
    for (uint n = 0; n < ml.size(); n++) {
        Menu* menu = *it++;
        menu->view = &menuBar[n];
        menuBar[n].setData(menu);
        menuBar[n].init(this, menu->text);
        menuBar[n].setFlags(Ex_Selectable | Ex_AutoHighlight | Ex_FocusRender);
        menuBar[n].addCallback(this, &WgtMenu::onLayoutHorz, Ex_CbLayout);
        menuBar[n].addCallback(this, &WgtMenu::onActivate, Ex_CbActivate);
        menuBar[n].addCallback(this, &WgtMenu::onFocused, Ex_CbGotFocus);
        menuBar[n].drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenu);
    }
}

void WgtMenu::fini() {
    while (!popList.empty()) {
        Popup* pop = popList.front();
        popList.pop_front();
        delete pop;
    }
    destroy();
    if (menuBar)
        delete[] menuBar;
    menuBar = NULL;
}

void WgtMenu::init(ExWindow* window) {
    ExWidget::init(window, L"wgtMenu");
    setFlags(Ex_Selectable);
    addCallback(this, &WgtMenu::onLayout, Ex_CbLayout);
    window->addHandler(this, &WgtMenu::onHandler);
    window->addFilter(this, &WgtMenu::onFilter);

    load();

    setup();
}

void WgtMenu::load() {
    // sample
    Menu* menu1 = NULL; // depth 1
    Menu* menu2 = NULL; // depth 2
    Menu* menu3 = NULL; // depth 3

    menu1 = menuList.add(L"File", 1000);
    menu2 = menu1->subList.add(L"New Project...", 1001);
    menu2 = menu1->subList.add(L"New File...", 1002);
    menu2 = menu1->subList.add(L"Open Project...", 1003);
    menu2 = menu1->subList.add(L"Open File...", 1004);
    menu2 = menu1->subList.add(L"Start Page", 1005);
    menu2 = menu1->subList.add(L"Open from Source Control", 1006);
    menu2 = menu1->subList.add(L"Exit", IDM_EXIT);

    menu1 = menuList.add(L"Edit", 2000);
    menu2 = menu1->subList.add(L"Go To", 2001);
    menu3 = menu2->subList.add(L"Go To Line...", 2002);
    menu3 = menu2->subList.add(L"Go To All...", 2003);
    menu3 = menu2->subList.add(L"Go To File...", 2004);
    menu2 = menu1->subList.add(L"Find and Replace", 2005);
    menu3 = menu2->subList.add(L"Quick Find", 2006);
    menu3 = menu2->subList.add(L"Quick Replace", 2007);
    menu3 = menu2->subList.add(L"Find In Files", 2008);
    menu3 = menu2->subList.add(L"Replace In Files", 2009);
    menu2 = menu1->subList.add(L"Undo", 2010);
    menu2 = menu1->subList.add(L"Redo", 2011);
    menu2 = menu1->subList.add(L"Cut", 2012);
    menu2 = menu1->subList.add(L"Copy", 2013);
    menu2 = menu1->subList.add(L"Paste", 2014);

    menu1 = menuList.add(L"View", 3000);
    menu2 = menu1->subList.add(L"Code", 3001);
    menu2 = menu1->subList.add(L"Start Page", 3002);
    menu2 = menu1->subList.add(L"Solution Explorer", 3003);
    menu2 = menu1->subList.add(L"Team Explorer", 3004);
    menu2 = menu1->subList.add(L"Server Explorer", 3005);
    menu2 = menu1->subList.add(L"SQL Server Object Explorer", 3006);
    menu2 = menu1->subList.add(L"Call Hierarchy", 3007);

    menu1 = menuList.add(L"Window", 4000);
    menu2 = menu1->subList.add(L"New Window", 4001);
    menu2 = menu1->subList.add(L"Split", 4002);
    menu2 = menu1->subList.add(L"Float", 4003);
    menu2 = menu1->subList.add(L"Float All", 4004);
    menu2 = menu1->subList.add(L"Dock", 4005);
    menu2 = menu1->subList.add(L"Auto Hide", 4006);
    menu2 = menu1->subList.add(L"Hide", 4007);

    menu1 = menuList.add(L"Help", 5000);
    menu2 = menu1->subList.add(L"View Help", 5001);
    menu2 = menu1->subList.add(L"Add and Remove Help Content", 5002);
    menu2 = menu1->subList.add(L"Set Help Preference", 5003);
    menu2 = menu1->subList.add(L"Send Feedback", 5004);
    menu2 = menu1->subList.add(L"Register Product", 5005);
    menu2 = menu1->subList.add(L"Technical Support", 5006);
    menu2 = menu1->subList.add(L"Online Privacy Statement...", 5007);
    menu2 = menu1->subList.add(L"Manage Visual Studio Performance", 5008);
    menu2 = menu1->subList.add(L"Check for Updates", 5009);
}

