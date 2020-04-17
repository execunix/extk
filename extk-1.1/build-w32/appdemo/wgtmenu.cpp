//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtmenu.h"

const UINT IDM_EXIT = 100;

void Menu::detach() {
    if (parent == NULL)
        return;
    Menu* head = NULL;
    if (next != this) {
        next->prev = prev;
        prev->next = next;
        head = next;
    }
    if (parent->child == this) {
        parent->child = head;
    }
    parent->size--;
    parent = next = prev = NULL;
}

void Menu::attach(Menu* menu) {
    if (menu == NULL)
        return;
    if (child && child->prev == menu) // already attached to the tail
        return;

    menu->detach();

    if (child == NULL) {
        child = menu;
        menu->next = menu;
        menu->prev = menu;
    } else {
        menu->next = child;
        menu->prev = child->prev;
        child->prev->next = menu;
        child->prev = menu;
    }
    menu->parent = this;
    size++;
}

Menu::~Menu() {
    Menu* menu;
    while (child) {
        menu = child->prev;
        menu->detach();
        delete menu;
    }
}

Menu::Menu()
    : flag(0), id(0)
    , parent(NULL), child(NULL), next(NULL), prev(NULL)
    , size(0), view(NULL) {
    text[0] = 0;
    extents.width = 0;
}

Menu* Menu::add(const wchar* text, int id, int flag) {
    Menu* menu = new Menu;
    wcsncpy(menu->text, text, 255);
    menu->text[255] = 0;
    menu->flag = flag;
    menu->id = id;
    attach(menu);
    return menu;
}

void WgtMenu::Popup::clear() {
    destroy();
    if (menuPop)
        delete[] menuPop;
    menuPop = NULL;
    link = NULL;
}

void WgtMenu::onDrawMenuPopBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    ExCairo::Color fc; // fill color
    fc.set(0.f, 0.f, 0.f, .75f);
    cairo_set_source_rgba(cr, fc.r, fc.g, fc.b, fc.a);
    cairo_rectangle(cr, rc.l, rc.t, rc.width(), rc.height());
    cairo_fill(cr);

    // tbd - border

    cairo_restore(cr);
}

void WgtMenu::onDrawMenuPop(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    Menu* menu = (Menu*)widget->getData();
    ExCairo::Point pt;
    pt.x = rc.l + 36.f;
    if (menu->flag & Menu::Separator) {
        pt.y = rc.t + menuHeight + 1.5f;
        cairo_set_source_rgb(cr, 1.f, 1.f, 1.f);
        cairo_move_to(cr, pt.x, pt.y);
        cairo_line_to(cr, rc.r, pt.y);
        cairo_set_line_width(cr, .2f);
        cairo_stroke(cr);
    }
    if (menu->child) {
        floatt h2, x1, x2, yc;
        h2 = menuHeight / 3.f;
        x1 = rc.r - menuHeight;
        x2 = x1 + h2;
        yc = rc.t + menuHeight / 2.f;
        cairo_set_source_rgb(cr, 1.f, 1.f, 1.f);
        cairo_move_to(cr, x1, yc - h2 * .6f);
        cairo_line_to(cr, x1, yc + h2 * .6f);
        cairo_line_to(cr, x2, yc);
        cairo_close_path(cr);
        cairo_set_line_width(cr, 1.f);
        cairo_stroke(cr);
    }
    if (!(menu->flag & Menu::Disabled) &&
        widget->getFlags(Ex_Focused)) {
        ExCairo::Color fc; // fill color
        fc.set(.5f, .5f, .5f, .5f);
        cairo_set_source_rgba(cr, fc.r, fc.g, fc.b, fc.a);
        cairo_rectangle(cr, rc.l, rc.t, rc.width(), menuHeight);
        cairo_fill(cr);
    }
    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, fontSize);
    cairo_text_extents_t& extents = menu->extents;
    pt.y = rc.t + (menuHeight - extents.height) / 2.f - extents.y_bearing; // center
    cairo_move_to(cr, pt.x, pt.y);
    if (menu->flag & Menu::Disabled)
        cairo_set_source_rgb(cr, .5f, .5f, .5f);
    else
        cairo_set_source_rgb(cr, 1.f, 1.f, 1.f);
    cairo_show_text(cr, menu->text);

    cairo_restore(cr);
}

void WgtMenu::onDrawMenuBarBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    ExCairo::Color fc; // fill color
    fc.set(0.f, 0.f, 0.f, .5f);
    cairo_set_source_rgba(cr, fc.r, fc.g, fc.b, fc.a);
    cairo_rectangle(cr, rc.l, rc.t, rc.width(), rc.height());
    cairo_fill(cr);

    cairo_restore(cr);
}

void WgtMenu::onDrawMenuBar(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    Menu* menu = (Menu*)widget->getData();
    Popup* pop = popList.empty() ? NULL : popList.back();
    bool isPopFocused = pop && pop->link == menu;
    bool isPtrEntered = !pop && widget->getFlags(Ex_PtrEntered);
    if (isPopFocused || isPtrEntered) {
        ExCairo::Color fc; // fill color
        if (isPopFocused)
            fc.set(0.f, 0.f, 0.f, .75f);
        else
            fc.set(.5f, .5f, .5f, 1.f);
        cairo_set_source_rgba(cr, fc.r, fc.g, fc.b, fc.a);
        cairo_rectangle(cr, rc.l, rc.t, rc.width(), rc.height());
        cairo_fill(cr);
    }
    ExCairo::Point pt;
    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, fontSize);
    cairo_text_extents_t& extents = menu->extents;
    pt.x = rc.l + (rc.width() - extents.width) / 2.f - extents.x_bearing; // center
    pt.y = rc.t + (menuHeight - extents.height) / 2.f - extents.y_bearing; // center
    cairo_move_to(cr, pt.x, pt.y);
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
    int menu_width = (int)menu->extents.width + 120;
    int separator = menu->flag & Menu::Separator ? 3 : 0;
    if (vert.w < menu_width) vert.w = menu_width; // save max width
    widget->area.set(vert.x, vert.y, vert.w, menuHeight + separator);
    vert.y += menuHeight + separator;
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
#if 1 // like modal loop
        if (menu) {
            if (window->wgtEntered != menu->view) {
                if (window->wgtEntered) {
                    window->wgtEntered->setFlags(Ex_PtrEntered, Ex_BitFalse);
                    window->wgtEntered->damage();
                }
                window->wgtEntered = menu->view;
                menu->view->setFlags(Ex_PtrEntered, Ex_BitTrue);
                menu->view->damage();
            }
        }
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
            //menu->view->setFlags(Ex_PtrEntered, Ex_BitFalse);
            //menu->view->damage();
            if (menu->view->getParent() == this) {
                menu->view->damage();
                if (popcnt > 0) {
                    showPopup(NULL); // hide
                    return Ex_Break; // toggle
                }
            }
            if (menu->size == 0) {
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
            case VK_HOME:
                moveMenuFocus(Ex_DirHome);
                break;
            case VK_END:
                moveMenuFocus(Ex_DirEnd);
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
    for (int n = 0; n < rootMenu.size; n++) {
        menuBar[n].layout(horz);
    }
    expand = horz;
    //layout(horz);
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

void WgtMenu::MoveTable::fill(Menu* menu) {
    home = prev = next = end = NULL;
    Menu* im = menu->parent->child; // iter
    Menu* tail = im->prev;
    bool found = false;
    while (im) {
        if (!(im->flag & Menu::Disabled)) {
            if (found && !next) next = im;
            if (im == menu) found = true;
            if (!found) prev = im;
            if (!home) home = im;
            end = im;
        }
        im = im != tail ? im->next : NULL;
    }
    if (!prev) prev = end;
    if (!next) next = home;
}

void WgtMenu::moveMenuFocus(int dir) {
    Menu* up = NULL;
    Menu* down = NULL;
    Menu* left = NULL;
    Menu* right = NULL;
    Menu* home = NULL;
    Menu* end = NULL;
    MoveTable mtBar, mtPop;
    if (focused->parent == &rootMenu) {
        mtBar.fill(focused);
        left = mtBar.prev;
        right = mtBar.next;
        mtPop.fill(focused->child);
        up = mtPop.home;
        down = mtPop.home;
        home = mtPop.home;
        end = mtPop.end;
    } else { // focus has popup
        mtPop.fill(focused);
        up = mtPop.prev;
        down = mtPop.next;
        home = mtPop.home;
        end = mtPop.end;
        Menu* bar = focused;
        while (bar->parent != &rootMenu)
            bar = bar->parent;
        mtBar.fill(bar);
        if (focused->parent->parent == &rootMenu) {
            left = mtBar.prev;
        } else {
            left = focused->parent;
        }
        if (!focused->child) {
            right = mtBar.next;
        } else {
            mtPop.fill(focused->child);
            right = mtPop.home;
        }
    }

    switch (dir) {
        case Ex_DirHome: showPopup(home); break;
        case Ex_DirEnd: showPopup(end); break;
        case Ex_DirUp: showPopup(up); break;
        case Ex_DirDown: showPopup(down); break;
        case Ex_DirLeft: showPopup(left); break;
        case Ex_DirRight: showPopup(right); break;
        case Ex_DirTabPrev: showPopup(left); break;
        case Ex_DirTabNext: showPopup(right); break;
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
        if (pop->link == link) {
            menuFocus(link);
            return; // already poped
        }
        if (pop->link->view->getParent() == this)
            pop->link->view->damage();
        if (link && link->view->getParent() == pop)
            break;
        popList.pop_front();
        delete pop;
    }
    if (link && link->size != 0) {
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
    pop->menuPop = new ExWidget[link->size];
    Menu* menu = link->child;
    ExArea vert(1, 1, 1, 1);
    for (int n = 0; n < link->size; n++) {
        menu->view = &pop->menuPop[n];
        pop->menuPop[n].setData(menu);
        pop->menuPop[n].init(pop, menu->text);
        pop->menuPop[n].setFlags(Ex_Selectable | Ex_FocusRender);
        pop->menuPop[n].addCallback(this, &WgtMenu::onLayoutVert, Ex_CbLayout);
        pop->menuPop[n].addCallback(this, &WgtMenu::onActivate, Ex_CbActivate);
        pop->menuPop[n].addCallback(this, &WgtMenu::onFocused, Ex_CbGotFocus);
        pop->menuPop[n].drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenuPop);
        pop->menuPop[n].layout(vert);
        menu = menu->next;
    }
    pop->drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenuPopBkgd);
    pop->area.w = vert.w + 2;
    pop->area.h = vert.y + 2;
    for (int n = 0; n < link->size; n++) {
        pop->menuPop[n].area.w = vert.w; // expand max width
    }
    return pop;
}

void WgtMenu::setup() {
    menuBar = new ExWidget[rootMenu.size];
    Menu* menu = rootMenu.child;
    for (int n = 0; n < rootMenu.size; n++) {
        menu->view = &menuBar[n];
        menuBar[n].setData(menu);
        menuBar[n].init(this, menu->text);
        menuBar[n].setFlags(Ex_Selectable | Ex_AutoHighlight | Ex_FocusRender);
        menuBar[n].addCallback(this, &WgtMenu::onLayoutHorz, Ex_CbLayout);
        menuBar[n].addCallback(this, &WgtMenu::onActivate, Ex_CbActivate);
        menuBar[n].addCallback(this, &WgtMenu::onFocused, Ex_CbGotFocus);
        menuBar[n].drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenuBar);
        menu = menu->next;
    }
    drawFunc = ExDrawFunc(this, &WgtMenu::onDrawMenuBarBkgd);
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

    menu1 = rootMenu.add(L"File", 1000);
    menu2 = menu1->add(L"New Project...", 1001);
    menu2 = menu1->add(L"New File...", 1002, Menu::Separator);
    menu2 = menu1->add(L"Open Project...", 1003);
    menu2 = menu1->add(L"Open File...", 1004);
    menu2 = menu1->add(L"Start Page", 1005, Menu::Separator);
    menu2 = menu1->add(L"Open from Source Control", 1006);
    menu2 = menu1->add(L"Exit", IDM_EXIT);

    menu1 = rootMenu.add(L"Edit", 2000);
    menu2 = menu1->add(L"Go To", 2001);
    menu3 = menu2->add(L"Go To Line...", 2002);
    menu3 = menu2->add(L"Go To All...", 2003);
    menu3 = menu2->add(L"Go To File...", 2004);
    menu2 = menu1->add(L"Find and Replace", 2005, Menu::Separator);
    menu3 = menu2->add(L"Quick Find", 2006);
    menu3 = menu2->add(L"Quick Replace", 2007);
    menu3 = menu2->add(L"Find In Files", 2008);
    menu3 = menu2->add(L"Replace In Files", 2009);
    menu2 = menu1->add(L"Undo", 2010);
    menu2 = menu1->add(L"Redo", 2011, Menu::Separator);
    menu2 = menu1->add(L"Cut", 2012);
    menu2 = menu1->add(L"Copy", 2013);
    menu2 = menu1->add(L"Paste", 2014);

    menu1 = rootMenu.add(L"View", 3000);
    menu2 = menu1->add(L"Code", 3001, Menu::Separator);
    menu2 = menu1->add(L"Start Page", 3002, Menu::Separator);
    menu2 = menu1->add(L"Solution Explorer", 3003);
    menu2 = menu1->add(L"Team Explorer", 3004);
    menu2 = menu1->add(L"Server Explorer", 3005);
    menu2 = menu1->add(L"SQL Server Object Explorer", 3006, Menu::Separator);
    menu2 = menu1->add(L"Call Hierarchy", 3007);

    menu1 = rootMenu.add(L"Window", 4000);
    menu2 = menu1->add(L"New Window", 4001);
    menu2 = menu1->add(L"Split", 4002, Menu::Separator);
    menu2 = menu1->add(L"Float", 4003);
    menu2 = menu1->add(L"Float All", 4004);
    menu2 = menu1->add(L"Dock", 4005, Menu::Disabled);
    menu2 = menu1->add(L"Auto Hide", 4006, Menu::Disabled);
    menu2 = menu1->add(L"Hide", 4007, Menu::Separator | Menu::Disabled);
    menu2 = menu1->add(L"Pin Tab", 4008, Menu::Separator);

    menu1 = rootMenu.add(L"Help", 5000);
    menu2 = menu1->add(L"View Help", 5001);
    menu2 = menu1->add(L"Add and Remove Help Content", 5002);
    menu2 = menu1->add(L"Set Help Preference", 5003, Menu::Separator);
    menu2 = menu1->add(L"Send Feedback", 5004, Menu::Separator);
    menu2 = menu1->add(L"Register Product", 5005);
    menu2 = menu1->add(L"Technical Support", 5006);
    menu2 = menu1->add(L"Online Privacy Statement...", 5007);
    menu2 = menu1->add(L"Manage Visual Studio Performance", 5008);
    menu2 = menu1->add(L"Check for Updates", 5009);
}

