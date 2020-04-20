//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtsetup.h"

static void STDCALL
fillRect(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->getRect());
    ExCairo::Color fc; // fill color
    floatt alpha = (int)data / 100.f;
    fc.set(0.f, 0.f, 0.f, alpha);
    cr.fill_rect_rgba(rc, fc);
}

static void STDCALL
drawName(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->getRect());
    ExCairo::Color fc; // fill color
    fc.set(0.f, 0.f, 0.f, .8f);
    cr.fill_rect_rgba(rc, fc);
    const wchar* text = widget->getName();
    cr.set_font(canvas->crf[0], 12.f);
    cr.show_text(text, ExCairo::Color(1.f), rc);
}

void WgtPage1::fini() {

}

void WgtPage1::init(ExWidget* parent, ExRect& rc) {
    ExWidget::init(parent, L"WgtPage1", &rc);
    //setFlags(Ex_Visible, Ex_BitTrue); // default
    drawFunc = ExDrawFunc(fillRect, (void*)50);
    label1.init(this, L"label1", &ExRect(10, 10, 100, 30));
    label1.drawFunc = ExDrawFunc(fillRect, (void*)50);
    button1.init(this, L"button1", &ExRect(10, 50, 100, 30));
    button1.drawFunc = ExDrawFunc(fillRect, (void*)50);
}

void WgtPage2::fini() {

}

void WgtPage2::init(ExWidget* parent, ExRect& rc) {
    ExWidget::init(parent, L"WgtPage2", &rc);
    setFlags(Ex_Visible, Ex_BitFalse); // delay realize
    drawFunc = ExDrawFunc(fillRect, (void*)50);
    label1.init(this, L"label1", &ExRect(10, 10, 100, 30));
    label1.drawFunc = ExDrawFunc(fillRect, (void*)50);
    button1.init(this, L"button1", &ExRect(10, 50, 100, 30));
    button1.drawFunc = ExDrawFunc(fillRect, (void*)50);
}

void WgtPage3::fini() {

}

void WgtPage3::init(ExWidget* parent, ExRect& rc) {
    ExWidget::init(parent, L"WgtPage3", &rc);
    setFlags(Ex_Visible, Ex_BitFalse); // delay realize
    drawFunc = ExDrawFunc(fillRect, (void*)50);
    label1.init(this, L"label1", &ExRect(10, 10, 100, 30));
    label1.drawFunc = ExDrawFunc(fillRect, (void*)50);
    button1.init(this, L"button1", &ExRect(10, 50, 100, 30));
    button1.drawFunc = ExDrawFunc(fillRect, (void*)50);
}

void WgtSetup::onDrawSetup(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->getRect());
    ExCairo::Color fc; // fill color
    fc.set(0.f, 0.f, 0.f, .75f);
    cr.fill_rect_rgba(rc, fc);

    // tbd - border
}

int WgtSetup::onActivate(ExWidget* widget, ExCbInfo* cbinfo) {
    if (widget == &close) {
        if (cbinfo->type == Ex_CbActivate) {
            destroy();
            return Ex_Continue;
        }
    }
    return Ex_Continue;
}

int WgtSetup::onFocused(ExWidget* widget, ExCbInfo* cbinfo) {
    return Ex_Continue;
}

int WgtSetup::onHandler(ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->event->message == WM_COMMAND) {
        dprintf(L"WM_COMMAND: %d\n", cbinfo->event->wParam);
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WgtSetup::onFilter(ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->event->message == WM_MOUSEMOVE) {
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_LBUTTONDOWN) {
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_KEYDOWN) {
        switch (cbinfo->event->wParam) {
            case VK_UP:
                break;
            case VK_DOWN:
                break;
            case VK_LEFT:
                break;
            case VK_RIGHT:
                break;
            case VK_HOME:
                break;
            case VK_END:
                break;
            case VK_SPACE:
            case VK_RETURN: {
                PostMessage(getWindow()->getHwnd(), WM_COMMAND, 12345, 0);
                break;
            }
            case VK_ESCAPE: {
                break;
            }
            case VK_TAB: {
                break;
            }
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WgtSetup::onLayout(ExWidget* widget, ExCbInfo* cbinfo) {
    ExRect& expand = *(ExRect*)cbinfo->data;
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

void WgtSetup::fini() {
    dprintf(L"%s\n", __funcw__);
}

void WgtSetup::init(ExWidget* parent, int x, int y) {
    ExWidget::init(parent, L"WgtSetup", &ExRect(x, y, 450, 240));
    ExWindow* window = parent->getWindow();
    window->addFilter(this, &WgtSetup::onFilter);
    window->addHandler(this, &WgtSetup::onHandler);
    addCallback(this, &WgtSetup::onLayout, Ex_CbLayout);
    drawFunc = ExDrawFunc(fillRect, (void*)50);
    setFlags(Ex_Selectable);

    tab1.init(this, L"tab1", &ExRect(10, 10, 80, 40));
    tab1.drawFunc = ExDrawFunc(drawName, NULL);
    tab2.init(this, L"tab2", &ExRect(110, 10, 80, 40));
    tab2.drawFunc = ExDrawFunc(drawName, NULL);
    tab3.init(this, L"tab3", &ExRect(210, 10, 80, 40));
    tab3.drawFunc = ExDrawFunc(drawName, NULL);
    close.init(this, L"close", &ExRect(310, 10, 80, 40));
    close.setFlags(Ex_Selectable);
    close.drawFunc = ExDrawFunc(drawName, NULL);
    close.addCallback(this, &WgtSetup::onActivate, Ex_CbActivate);

    ExRect rc(10, 50, 360, 180);
    page1.init(this, rc);
    page2.init(this, rc);
    page3.init(this, rc);
}

