//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtsetup.h"

static void STDCALL
fillRect(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());
    ExCairo::Color fc; // fill color
    double alpha = (uint64)data / 100.f;
    fc.set(.8f, .8f, .8f, alpha);
    cr.fill_rect_rgba(rc, fc);
}

static void STDCALL
drawName(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());
    ExCairo::Color fc; // fill color
    fc.set(.5f, .5f, .5f, .8f);
    cr.fill_rect_rgba(rc, fc);
    const char* text = widget->getName();
    cr.set_font(res.f.gothic.crf, 12.f);
    cr.show_ucs2(mbs2wcs(text), ExCairo::Color(1.f), rc);
}

void WgtPage1::fini() {

}

void WgtPage1::init(ExWidget* parent, ExRect& rc) {
    ExWidget::init(parent, "WgtPage1", &rc);
    //setFlags(Ex_Visible, Ex_BitTrue); // default
    drawFunc = ExDrawFunc(fillRect, (void*)30);
    label1.init(this, "label1", &rc.set(10, 10, 100, 30));
    label1.drawFunc = ExDrawFunc(drawName, (void*)30);
    button1.init(this, "button1", &rc.set(10, 50, 100, 30));
    button1.drawFunc = ExDrawFunc(drawName, (void*)30);
}

void WgtPage2::fini() {

}

void WgtPage2::init(ExWidget* parent, ExRect& rc) {
    ExWidget::init(parent, "WgtPage2", &rc);
    setFlags(Ex_Visible, Ex_BitFalse); // delay realize
    drawFunc = ExDrawFunc(fillRect, (void*)50);
    label1.init(this, "label1", &rc.set(10, 10, 100, 30));
    label1.drawFunc = ExDrawFunc(drawName, (void*)50);
    button1.init(this, "button1", &rc.set(10, 50, 100, 30));
    button1.drawFunc = ExDrawFunc(drawName, (void*)50);
}

void WgtPage3::fini() {

}

void WgtPage3::init(ExWidget* parent, ExRect& rc) {
    ExWidget::init(parent, "WgtPage3", &rc);
    setFlags(Ex_Visible, Ex_BitFalse); // delay realize
    drawFunc = ExDrawFunc(fillRect, (void*)50);
    label1.init(this, "label1", &rc.set(10, 10, 100, 30));
    label1.drawFunc = ExDrawFunc(drawName, (void*)50);
    button1.init(this, "button1", &rc.set(10, 50, 100, 30));
    button1.drawFunc = ExDrawFunc(drawName, (void*)50);
}

void WgtSetup::onDrawSetup(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());
    ExCairo::Color fc; // fill color
    fc.set(0.f, 0.f, 0.f, .75f);
    cr.fill_rect_rgba(rc, fc);

    // tbd - border
}

int WgtSetup::onTitleMove(ExWidget* widget, ExCbInfo* cbinfo) {
    ExWindow* window = getWindow();
    if (widget == &title && window) {
        static ExPoint but_pt(0);
        ExPoint msg_pt(cbinfo->event->msg.pt);
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg_pt; // memory press point
            toFront();
            window->wgtCapture = widget;
        }
        else if (cbinfo->type == Ex_CbPtrMove &&
            widget->getFlags(Ex_ButPressed)) {
            ExPoint pt(this->area.u.pt);
            pt += (msg_pt - but_pt);
            but_pt = msg_pt;
            this->setPos(pt);
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WgtSetup::onActivate(ExWidget* widget, ExCbInfo* cbinfo) {
    if (widget == &close) {
        if (cbinfo->type == Ex_CbActivate) {
#if 1
            PostMessage(getWindow()->getHwnd(), WM_CbRemove, 0, (LPARAM)this);
#else
            ExWindow* window = parent->getWindow();
            window->removeHandler(ExCallback(this, &WgtSetup::onHandler));
            window->removeFilter(ExCallback(this, &WgtSetup::onFilter));
#endif
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
    if (cbinfo->event->message == WM_CbRemove &&
        cbinfo->event->lParam == (LPARAM)this) {
        dprint("WgtSetup::onHandler - WM_CbRemove\n");
        return Ex_Remove;
    }
    if (cbinfo->event->message == WM_COMMAND) {
        dprint("WM_COMMAND: %d\n", cbinfo->event->wParam);
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WgtSetup::onFilter(ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->event->message == WM_CbRemove &&
        cbinfo->event->lParam == (LPARAM)this) {
        dprint("WgtSetup::onFilter - WM_CbRemove\n");
        return Ex_Remove;
    }
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
    ExRect* expand = (ExRect*)cbinfo->data;
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

void WgtSetup::fini() {
    dprint("%s\n", __func__);
}

void WgtSetup::init(ExWidget* parent, int x, int y) {
    ExRect rc;
    ExWidget::init(parent, "WgtSetup", &rc.set(x, y, 450, 300));
    ExWindow* window = parent->getWindow();
    window->addFilter(this, &WgtSetup::onFilter);
    window->addHandler(this, &WgtSetup::onHandler);
    addListener(this, &WgtSetup::onLayout, Ex_CbLayout);
    drawFunc = ExDrawFunc(fillRect, (void*)20);
    setFlags(Ex_Selectable);
    //select = ExBox(9999);

    title.init(this, "Setup", &rc.set(2, 2, 386, 40));
    title.drawFunc = ExDrawFunc(drawName, (void*)NULL);
    title.setFlags(Ex_Selectable);
    title.addListener(this, &WgtSetup::onTitleMove, Ex_CbActivate);
    close.init(this, "close", &rc.set(400, 2, 46, 40));
    close.drawFunc = ExDrawFunc(drawName, (void*)NULL);
    close.setFlags(Ex_Selectable);
    close.addListener(this, &WgtSetup::onActivate, Ex_CbActivate);

    tab1.init(this, "tab1", &rc.set(10, 60, 80, 40));
    tab1.drawFunc = ExDrawFunc(drawName, (void*)NULL);
    tab2.init(this, "tab2", &rc.set(110, 60, 80, 40));
    tab2.drawFunc = ExDrawFunc(drawName, (void*)NULL);
    tab3.init(this, "tab3", &rc.set(210, 60, 80, 40));
    tab3.drawFunc = ExDrawFunc(drawName, (void*)NULL);

    rc.set(10, 100, 360, 180);
    page1.init(this, rc);
    page2.init(this, rc);
    page3.init(this, rc);
}

