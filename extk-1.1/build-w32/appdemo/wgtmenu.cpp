//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtmenu.h"

const UINT IDM_EXIT = 100;

void WgtMenu::Popup::clear() {
    destroy();
    if (menuPop)
        delete[] menuPop;
    menuPop = NULL;
    link = NULL;
}

void WgtMenu::onDrawMenu(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    ExCairo::Color fc; // fill color
    if (widget->getParent() == this) { // is menuBar ?
        Popup* pop = popList.empty() ? NULL : popList.back();
        if (pop && pop->link == (Menu*)widget->getData()) {
            fc.set(0.f, 0.f, 0.f, .85f);
        } else if (widget->getFlags(Ex_PtrEntered)) {
            fc.set(.5f, .5f, .5f, 1.f);
        } else {
            fc.set(0.f, 0.f, 0.f, .5f);
        }
    } else { // is menuPop ?
        fc.set(0.f, 0.f, 0.f, .85f);
        if (widget->getFlags(Ex_Focused))
            fc.set(.5f, .5f, .5f, 1.f);
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
    ExCanvas* canvas = window->canvas;
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
    ExCanvas* canvas = window->canvas;
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
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        Menu* menu = findMenu(ExPoint(xPos, yPos));
        if (menu) {
            if (window->wgtEntered != menu->view) {
                showPopup(menu);
            }
        }
#if 1 // like modal
        if (menu)
            window->wgtEntered = menu->view;
        return Ex_Break;
#else
        return Ex_Continue;
#endif
    }
    if (cbinfo->event->message == WM_LBUTTONDOWN) {
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        Menu* menu = findMenu(ExPoint(xPos, yPos));
        int popcnt = popList.size();
        showPopup(menu);
        if (menu) {
            if (menu->view->getParent() == this) {
                menu->view->damage();
                if (popcnt > 0) {
                    showPopup(NULL); // hide
                    return Ex_Break; // toggle
                }
            }
            if (menu->subList.empty()) {
                showPopup(NULL); // hide
                HWND hwnd = window->getHwnd();
                PostMessage(hwnd, WM_COMMAND, menu->id, (LPARAM)menu);
            }
            return Ex_Break;
        }
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_KEYDOWN) {
        if (focused == NULL)
            return Ex_Continue;
        Menu* menu = focused;
        switch (cbinfo->event->wParam) {
            case VK_UP:
                moveMenuFocus(Ex_DirUp);
                break;
            case VK_DOWN:
                moveMenuFocus(Ex_DirDown);
                break;
            case VK_LEFT:
                moveMenuFocus(Ex_DirLeft);
                break;
            case VK_RIGHT:
                moveMenuFocus(Ex_DirRight);
                break;
            case VK_SPACE:
            case VK_RETURN: {
                showPopup(NULL); // hide
                HWND hwnd = window->getHwnd();
                PostMessage(hwnd, WM_COMMAND, menu->id, (LPARAM)menu);
                break;
            }
            case VK_ESCAPE: {
                if (popList.empty())
                    return Ex_Continue;
                //Popup* pop = popList.back();
                //showPopup(pop->link);
                showPopup(NULL);
                break;
            }
            case VK_TAB: {
                SHORT ks = GetKeyState(VK_SHIFT);
                moveMenuFocus(ks & 0x100 ? Ex_DirTabPrev : Ex_DirTabNext);
                break;
            }
        }
        return Ex_Break;
    }
    return Ex_Continue;
}

int WgtMenu::onLayout(ExWidget* widget, ExCbInfo* cbinfo) {
    ExArea& expand = *(ExArea*)cbinfo->data;
    ExArea horz(1, 1, area.w - 2, area.h - 2);
    for (uint n = 0; n < rootList.size(); n++) {
        menuBar[n].layout(horz);
    }
    expand = horz;
    //layout(horz);
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

void WgtMenu::fillMoveTable(MoveTable& mt, MenuList* ml, Menu* menu) {
    bool found = false;
    if (ml == &rootList) { // pick left & right
        Menu* head = NULL;
        Menu* tail = NULL;
        mt.left = mt.right = NULL;
        MenuList::iterator it = ml->begin();
        while (it != ml->end() && !mt.fDone) {
            Menu* im = *it++;
            if (im->flag & Menu::Disabled) continue;
            if (found && !mt.right) mt.right = im;
            if (im == menu) found = true;
            if (!found) mt.left = im;
            if (!head) head = im;
            tail = im;
        }
        if (!mt.left) mt.left = tail;
        if (!mt.right) mt.right = head;
    } else {
        Menu* head = NULL;
        Menu* tail = NULL;
        mt.up = mt.down = NULL;
        MenuList::iterator it = ml->begin();
        while (it != ml->end() && !mt.fDone) {
            Menu* im = *it++;
            if (im->flag & Menu::Disabled) continue;
            if (found && !mt.down) mt.down = im;
            if (im == menu) found = true;
            if (!found) mt.up = im;
            if (!head) head = im;
            tail = im;
        }
        if (!mt.up) mt.up = tail;
        if (!mt.down) mt.down = head;
        mt.home = head;
        mt.end = tail;
    }
}

void WgtMenu::moveMenuFocus(int dir) {
    MoveTable moveTable;
    MenuList* path[8];
    int depth = 0;

    // fill path
    path[depth++] = &rootList;
    PopList::iterator it = popList.end();
    while (depth < 8 && it != popList.begin())
        path[depth++] = &(*--it)->link->subList;

    for (int i = 0; i < depth; i++) {
        fillMoveTable(moveTable, path[i], focused);
        if (path[i] == &focused->subList)
            break;
    }

    switch (dir) {
        case Ex_DirUp: showPopup(moveTable.up); break;
        case Ex_DirDown: showPopup(moveTable.down); break;
        case Ex_DirLeft: showPopup(moveTable.left); break;
        case Ex_DirRight: showPopup(moveTable.right); break;
        case Ex_DirTabPrev: showPopup(moveTable.left); break;
        case Ex_DirTabNext: showPopup(moveTable.right); break;
    }
}

Menu* WgtMenu::findMenu(const ExPoint& pt) {
    ExWidget* w = getPointOwner(pt);
    Menu* menu = w ? (Menu*)w->getData() : NULL;
    if (!menu) {
        PopList::iterator i = popList.begin();
        while (i != popList.end() && !menu) {
            Popup* pop = *i++;
            w = pop->getPointOwner(pt);
            menu = w ? (Menu*)w->getData() : NULL;
        }
    }
    return menu;
}

void WgtMenu::menuFocus(Menu* menu) {
    if ((focused = menu) != NULL) {
        if (oldFocus == NULL)
            oldFocus = window->wgtFocused;
        window->giveFocus(menu->view);
    } else {
        window->giveFocus(oldFocus);
        oldFocus = NULL;
    }
}

void WgtMenu::showPopup(Menu* link) {
    while (!popList.empty()) {
        Popup* pop = popList.front();
        if (pop->link == link)
            return; // already poped
        if (pop->link->view->getParent() == this)
            pop->link->view->damage();
        if (link && link->view->getParent() == pop)
            break;
        popList.pop_front();
        delete pop;
    }
    if (link && !link->subList.empty()) {
        ExRect rc = link->view->getRect();
        if (popList.empty())
            popList.push_front(popup(rc.l, rc.b, link));
        else
            popList.push_front(popup(rc.r, rc.t, link));
    }
    menuFocus(link);
}

WgtMenu::Popup* WgtMenu::popup(int x, int y, Menu* link) {
    Popup* pop = new Popup;
    pop->init(window);
    pop->link = link;
    pop->layout(ExArea(x, y, 100, 30));
    pop->menuPop = new ExWidget[link->subList.size()];
    MenuList::iterator it = link->subList.begin();
    ExArea vert(1, 1, 1, 1);
    for (uint n = 0; n < link->subList.size(); n++) {
        Menu* menu = *it++;
        menu->view = &pop->menuPop[n];
        pop->menuPop[n].setData(menu);
        pop->menuPop[n].init(pop, menu->text);
        pop->menuPop[n].setFlags(Ex_Selectable | Ex_FocusRender);
        pop->menuPop[n].addCallback(this, &WgtMenu::onLayoutVert, Ex_CbLayout);
        pop->menuPop[n].addCallback(this, &WgtMenu::onActivate, Ex_CbActivate);
        pop->menuPop[n].addCallback(this, &WgtMenu::onFocused, Ex_CbGotFocus);
        pop->menuPop[n].drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenu);
        pop->menuPop[n].layout(vert);
    }
    pop->area.w = vert.w + 2;
    pop->area.h = vert.y + 2;
    for (uint n = 0; n < link->subList.size(); n++) {
        pop->menuPop[n].area.w = vert.w; // expand max width
    }
    return pop;
}

void WgtMenu::setup() {
    menuBar = new ExWidget[rootList.size()];
    MenuList::iterator it = rootList.begin();
    for (uint n = 0; n < rootList.size(); n++) {
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
    ExWidget::init(window, L"WgtMenu");
    this->window = window;
    window->addFilter(this, &WgtMenu::onFilter, 0);
    window->addHandler(this, &WgtMenu::onHandler);
    addCallback(this, &WgtMenu::onLayout, Ex_CbLayout);
    //setFlags(Ex_Selectable);

    load();

    setup();
}

void WgtMenu::load() {
    // sample
    Menu* menu1 = NULL; // depth 1
    Menu* menu2 = NULL; // depth 2
    Menu* menu3 = NULL; // depth 3

    menu1 = rootList.add(L"File", 1000);
    menu2 = menu1->subList.add(L"New Project...", 1001);
    menu2 = menu1->subList.add(L"New File...", 1002);
    menu2 = menu1->subList.add(L"Open Project...", 1003);
    menu2 = menu1->subList.add(L"Open File...", 1004);
    menu2 = menu1->subList.add(L"Start Page", 1005);
    menu2 = menu1->subList.add(L"Open from Source Control", 1006);
    menu2 = menu1->subList.add(L"Exit", IDM_EXIT);

    menu1 = rootList.add(L"Edit", 2000);
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

    menu1 = rootList.add(L"View", 3000);
    menu2 = menu1->subList.add(L"Code", 3001);
    menu2 = menu1->subList.add(L"Start Page", 3002);
    menu2 = menu1->subList.add(L"Solution Explorer", 3003);
    menu2 = menu1->subList.add(L"Team Explorer", 3004);
    menu2 = menu1->subList.add(L"Server Explorer", 3005);
    menu2 = menu1->subList.add(L"SQL Server Object Explorer", 3006);
    menu2 = menu1->subList.add(L"Call Hierarchy", 3007);

    menu1 = rootList.add(L"Window", 4000);
    menu2 = menu1->subList.add(L"New Window", 4001);
    menu2 = menu1->subList.add(L"Split", 4002);
    menu2 = menu1->subList.add(L"Float", 4003);
    menu2 = menu1->subList.add(L"Float All", 4004);
    menu2 = menu1->subList.add(L"Dock", 4005);
    menu2 = menu1->subList.add(L"Auto Hide", 4006);
    menu2 = menu1->subList.add(L"Hide", 4007);

    menu1 = rootList.add(L"Help", 5000);
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

