//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wndtest.h"
#include <assert.h>

void WndTest::onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    if (widget == this) {
        ExRegion rgn(*damage);
        for (int i = 0; i < rgn.n_boxes; i++)
            canvas->gc->fillBox(&rgn.boxes[i], ((uint64)widget) & 0xffffff);
    }
}

void WndTest::onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());
    ExCairo::Point p2(rc.p2());

    cr_new_path(cr);
    cr_move_to(cr, rc.x + 4, rc.y + 1);
    cr_line_to(cr, p2.x - 4, rc.y + 1);
    cr_line_to(cr, p2.x - 1, rc.y + 4);
    cr_line_to(cr, p2.x - 1, p2.y - 4);
    cr_line_to(cr, p2.x - 4, p2.y - 1);
    cr_line_to(cr, rc.x + 4, p2.y - 1);
    cr_line_to(cr, rc.x + 1, p2.y - 4);
    cr_line_to(cr, rc.x + 1, rc.y + 4);
    cr_close_path(cr);

    ExCairo::Color pc0; // pattern color offset 0.f
    ExCairo::Color pc1; // pattern color offset 1.f
    if (widget->getFlags(Ex_PtrEntered)) {
        pc0.setv(112, 224, 224, 255);
        pc1.setv(64, 128, 128, 128);
    } else {
        pc0.setv(64, 128, 128, 255);
        pc1.setv(16, 64, 64, 128);
    }
    cr_pattern_t* crp = cr_pattern_create_linear(rc.x, rc.y, p2.x, p2.y);
    cr_pattern_add_color_stop_rgba(crp, 0.f, pc0.r, pc0.g, pc0.b, pc0.a);
    cr_pattern_add_color_stop_rgba(crp, 1.f, pc1.r, pc1.g, pc1.b, pc1.a);
    cr_set_source(cr, crp);
    cr_fill_preserve(cr);

    ExCairo::Color lc; // line color
    if (widget->getFlags(Ex_Focused)) {
        lc.setv(64, 255, 64, 255);
    } else if (widget->getFlags(Ex_ButPressed)) {
        lc.setv(255, 255, 255, 255);
    } else {
        uint32 c = ((uint64)widget) & 0xffffff;
        lc.setv(ExRValue(c), ExGValue(c), ExBValue(c), 255);
    }
    cr_set_line_width(cr, widget->getFlags(Ex_Focused) ? 3.6f : 1.2f);
    cr_set_line_join(cr, CR_LINE_JOIN_ROUND);
    cr_set_line_cap(cr, CR_LINE_CAP_ROUND);
    cr_set_antialias(cr, CR_ANTIALIAS_GRAY);
    cr_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
    cr_stroke(cr);

    const char* text = widget->getName();
    cr.set_font(res.f.gothic.crf, 12.f);
    cr.show_text(text, ExCairo::Color(0.f), rc);

    cr_pattern_destroy(crp);
}

uint32 WndTest::onLayout(WndTest* widget, ExCbInfo* cbinfo) {
    dprint("%s(%s) %d (%d,%d-%dx%d)\n", __func__, widget->getName(),
           cbinfo->subtype, widget->area.x, widget->area.y, widget->area.w, widget->area.h);
    ExRect ar(0, 0, widget->area.w, widget->area.h);
    if (widget == this) {
        ar.y = ar.h - 50;
        ar.h = 45;
        float margin_w = ar.w * 2 / 100.f; // 2 %
        float margin_h = ar.h * 8 / 100.f; // 8 %
        ar.inset((int)margin_w, (int)margin_h);
        float gap_x = ar.w * 3 / 100.f; // 3 %
        float grid_x = (ar.w + gap_x) / 5;
        float p_x = (float)ar.x;
        ExSize sz((int)(grid_x - gap_x), ar.h);
        for (int i = 0; i < 5; i++) {
            ExRect layout(ExPoint((int)p_x, ar.y), sz);
            btns0[i].layout(layout);
            p_x += grid_x;
        }
    }
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

uint32 WndTest::onActMain(WndTest* widget, ExCbInfo* cbinfo) {
    if (widget == this) {
        return Ex_Continue;
    }
    return Ex_Continue;
}

uint32 WndTest::onActBtns(ExWidget* widget, ExCbInfo* cbinfo) {
    dprint0("WndTest::onActBtns %s %d %d\n",
            widget->getName(), cbinfo->type, cbinfo->subtype);
    if (cbinfo->type == Ex_CbButPress) {
        giveFocus(widget);
    }
    if (widget == &btns0[0]) {
        if (cbinfo->type == Ex_CbActivate) {
            return Ex_Continue;
        }
    }
    if (widget == &btns0[1]) {
        if (cbinfo->type == Ex_CbActivate) {
            return Ex_Continue;
        }
    }
    if (widget == &btns0[2]) {
        if (cbinfo->type == Ex_CbActivate) {
            return Ex_Continue;
        }
    }
    if (widget == &btns0[3]) {
        if (cbinfo->type == Ex_CbActivate) {
            return Ex_Continue;
        }
    }
    if (widget == &btns0[4]) {
        if (cbinfo->type == Ex_CbActivate) {
            destroy();
            return Ex_Continue;
        }
    }
    return Ex_Continue;
}

uint32 WndTest::onTimer(ExTimer* timer, ExCbInfo* cbinfo)
{
    dprint0("%s: %d\n", __func__, timer->u32[0]);

    return Ex_Continue;
}

bool WndTest::initBtn(ExWidget* parent, ExWidget* btn, const char* name) {
    btn->init(parent, name, NULL);
    //btn->setFlags(Ex_Opaque); // test
    btn->setFlags(Ex_FocusRender);
    btn->setFlags(Ex_Selectable | Ex_AutoHighlight);
    btn->drawFunc = ExDrawFunc(this, &WndTest::onDrawBtns);
    btn->addListener(this, &WndTest::onActBtns, Ex_CbActivate);
    return true;
}

uint32 WndTest::onDestroyed(WndTest* w, ExCbInfo* cbinfo) {
    dprint("%s()\n", __func__);
    assert(w == this);
    timer.stop();
    return Ex_Continue;
}

uint32 WndTest::onFilter(WndTest* w, ExCbInfo* cbinfo) {
    dprint("filter WM_0x%04x\n", cbinfo->event->message);
    if (cbinfo->event->message == WM_KEYDOWN) {
        switch (cbinfo->event->wParam) {
            case VK_UP:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_UP");
                break;
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

#define ID_EDITCHILD 1001

void WndTest::initEdit(int x, int y, int w, int h)
{
    char lpszLatin[] = "Lorem ipsum dolor sit amet, consectetur "
        "adipisicing elit, sed do eiusmod tempor "
        "incididunt ut labore et dolore magna "
        "aliqua. Ut enim ad minim veniam, quis "
        "nostrud exercitation ullamco laboris nisi "
        "ut aliquip ex ea commodo consequat. Duis "
        "aute irure dolor in reprehenderit in "
        "voluptate velit esse cillum dolore eu "
        "fugiat nulla pariatur. Excepteur sint "
        "occaecat cupidatat non proident, sunt "
        "in culpa qui officia deserunt mollit "
        "anim id est laborum.";

    hwndEdit = CreateWindowEx(0, "EDIT",   // predefined class
                              NULL,         // no window title
                              WS_CHILD | WS_VISIBLE | WS_VSCROLL |
                              ES_LEFT | ES_MULTILINE | ES_AUTOVSCROLL,
                              x, y, w, h,   // set size in WM_SIZE message
                              hwnd,         // parent window
                              (HMENU)ID_EDITCHILD,   // edit control ID
                              (HINSTANCE)GetWindowLongPtr(hwnd, GWLP_HINSTANCE),
                              NULL);        // pointer not needed 

    // Add text to the window. 
    SendMessage(hwndEdit, WM_SETTEXT, 0, (LPARAM)lpszLatin);
}

int WndTest::start() {
    this->init("WndTest", 1280, 720);

    canvas = new ExCanvas;
    canvas->init(this, ExApp::smSize);

    drawFunc = ExDrawFunc(this, &WndTest::onDrawBkgd);

    flushFunc = ExFlushFunc((ExWindow*)this, &ExWindow::onExFlush);
    paintFunc = ExFlushFunc((ExWindow*)this, &ExWindow::onWmPaint);

    addListener(this, &WndTest::onDestroyed, Ex_CbDestroyed);
    addListener(this, &WndTest::onLayout, Ex_CbLayout);
    addListener(this, &WndTest::onActMain, Ex_CbActivate);

    addFilter(this, &WndTest::onFilter);

    addFilter([](void* data, ExWindow* window, ExCbInfo* cbinfo)->uint32 {
        dprint("[%s] WM_0x%04x\n", window->getName(), cbinfo->event->message);
        if (cbinfo->event->message == WM_CREATE) {
            cbinfo->event->lResult = 0;
            RECT r;
            // The right and bottom members contain the width and height of the window.
            GetClientRect(cbinfo->event->hwnd, &r);
            ExRect rc(r);
            dprint("GetClientRect %d,%d-%dx%d\n",
                   rc.x, rc.y, rc.w, rc.h);
            window->layout(rc);
            assert(data == window);
            WndTest* w = (WndTest*)data;
            w->initEdit(rc.x + 20, rc.y + 20, 640, 480);
            // To remove an anonymous callback, simply return Ex_Remove.
            return Ex_Break | Ex_Remove;
        }
        return Ex_Continue; }, this);

    initBtn(this, &btns0[0], "btns0-0");
    initBtn(this, &btns0[1], "btns0-1");
    initBtn(this, &btns0[2], "btns0-2");
    initBtn(this, &btns0[3], "btns0-3");
    initBtn(this, &btns0[4], "btns0-4");

    //showWindow(0, WS_POPUP | WS_VISIBLE);
    showWindow(0, WS_OVERLAPPEDWINDOW | WS_VISIBLE);
    return 0;
}
