//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtmenu.h"

#if 0
void WgtMenu::onDrawMenu(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    cairo_t* cr = canvas->cr;
    ExCairo::Rect rc(widget->getRect());
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    cairo_set_source_rgba(cr, 0.f, 0.f, 0.f, .5f);
    cairo_rectangle(cr, rc.l, rc.t, rc.r, rc.b);
    cairo_fill(cr);

    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, rc.height() * .4f);
    cairo_text_extents_t extents;
    cairo_text_extents(cr, widget->getName(), &extents);
    ExCairo::Point pt;
    pt.x = (rc.width() - extents.width) / 2.f - extents.x_bearing; // center
    pt.y = (rc.height() - extents.height) / 2.f - extents.y_bearing; // center
    cairo_move_to(cr, rc.l + pt.x, rc.t + pt.y);
    cairo_set_source_rgb(cr, 1.f, 1.f, 1.f);
    cairo_show_text(cr, widget->getName());

    cairo_restore(cr);
}
#endif

void WgtMenu::Popup::clear() {
    destroy();
    if (wgtMenu)
        delete[] wgtMenu;
    wgtMenu = NULL;
    //setFlags(Ex_Destroyed, Ex_BitFalse); // re-use ?
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
    if (cbinfo->type == Ex_CbActivate) {
        //PostMessage(hwnd, message, wParam, lParam);
        Menu* menu = (Menu*)widget->getData();
        PostMessage(getWindow()->getHwnd(), WM_APP + 123, 0, (LPARAM)menu);
    }
    return Ex_Continue;
}

int WgtMenu::onFocused(ExWidget* widget, ExCbInfo* cbinfo) {
    return Ex_Continue;
}

int WgtMenu::onFilter(ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->event->message == WM_APP + 123) {
        Popup* pop = !popupList.empty() ? popupList.front() : NULL;
        Menu* menu = (Menu*)cbinfo->event->lParam;
        if (pop != NULL) {
            popupList.pop_front();
            delete pop;
        }
        if (menu->parent == &menuList) {
            ExRect rc = menu->view->getRect();
            Popup* pop = popup(rc.l + 2, rc.b + 1, menu->subList);
            popupList.push_back(pop);
        }
        return Ex_Break;
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
    // tbd - destruct popup
    destroy();
    if (menuBar)
        delete[] menuBar;
    menuBar = NULL;
}

void WgtMenu::init(ExWindow* window) {
    ExWidget::init(window, L"wgtMenu");
    setFlags(Ex_Selectable);
    addCallback(this, &WgtMenu::onLayout, Ex_CbLayout);
    window->addFilter(this, &WgtMenu::onFilter);

    load();

    setup();
}

void WgtMenu::load() {
    Menu* menu[5];
    menu[0] = menuList.add(L"File", 1000);
    menu[1] = menuList.add(L"Edit", 1100);
    menu[2] = menuList.add(L"View", 1200);
    menu[3] = menuList.add(L"Window", 1300);
    menu[4] = menuList.add(L"Help", 1400);
    menu[0]->subList.add(L"Menu-0.Sub-0", 1000);
    menu[0]->subList.add(L"Menu-0.Sub-1", 1001);
    menu[0]->subList.add(L"Menu-0.Sub-2", 1002);
    menu[0]->subList.add(L"Menu-0.Sub-3", 1003);
    menu[0]->subList.add(L"Menu-0.Sub-4", 1004);
    menu[0]->subList.add(L"Menu-0.Sub-5", 1005);
    menu[1]->subList.add(L"Menu-1.Sub-0", 1100);
    menu[1]->subList.add(L"Menu-1.Sub-1", 1101);
    menu[1]->subList.add(L"Menu-1.Sub-2", 1102);
    menu[1]->subList.add(L"Menu-1.Sub-3", 1103);
    menu[1]->subList.add(L"Menu-1.Sub-4", 1104);
    menu[1]->subList.add(L"Menu-1.Sub-5", 1105);
    menu[1]->subList.add(L"Menu-1.Sub-6", 1106);
    menu[4]->subList.add(L"Menu-4.Sub-0", 1400);
    menu[4]->subList.add(L"Menu-4.Sub-1", 1401);
    menu[4]->subList.add(L"Menu-4.Sub-2", 1402);
    menu[4]->subList.add(L"Menu-4.Sub-3", 1403);
    menu[4]->subList.add(L"Menu-4.Sub-4", 1404);
    menu[4]->subList.add(L"Menu-4.Sub-5", 1405);
    menu[4]->subList.add(L"Menu-4.Sub-6", 1406);
    menu[4]->subList.add(L"Menu-4.Sub-7", 1407);
    menu[4]->subList.add(L"Menu-4.Sub-8", 1408);
}

