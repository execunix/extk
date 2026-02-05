//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wgtsetup.h"
#include "wndmain.h"
#include "wndtest.h"
#include <assert.h>

void WgtTitle::init(ExWindow* window) {
    ExRect rc;
    ExWidget::init(window, "WgtTitle", &rc.set(0, 0, 800, 36));
    setTitle("Welcome to Rectangles and Callbacks World.");
    setFlags(Ex_Selectable);
    addListener(this, &WgtTitle::onLayout, Ex_CbLayout);
    drawFunc = ExDrawFunc(this, &WgtTitle::onDrawTitle);
}

uint32 WgtTitle::onLayout(WgtTitle* widget, ExCbInfo* cbinfo) {
    //ExRect* expand = (ExRect*)cbinfo->data;
    return Ex_Continue;
}

void WgtTitle::onDrawTitle(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());

    cr.fill_rect_rgba(rc, ExCairo::Color(.2f, .2f, .2f, .5f));

    rc.w -= 48.f;
    cr.set_font(res.f.gothic_B.crf, rc.h * .5f);
    ExCairo::Point pt = cr.text_align(title, rc, ExCairo::Right | ExCairo::VCenter);
#if 0
    cr_move_to(cr, pt.x + 2.f, pt.y + 2.f);
    cr_set_source_rgb(cr, .2f, .2f, .2f);
    cr_text_path(cr, title);
    cr_set_line_width(cr, 2.f);
    cr_stroke(cr);
#else
    cr.show_text(title, ExCairo::Color(.2f), ExCairo::Point(pt.x + 2.f, pt.y + 2.f));
#endif
    cr.show_text(title, ExCairo::Color(1.f), pt);
}

static uint32 STDCALL
onUnrealized(void* data, ExWidget* w, ExCbInfo* cbinfo) {
    dprint("onUnrealized()\n");
    return Ex_Continue;
}

static uint32 STDCALL
onRealized(WndMain* data, ExWindow* w, ExCbInfo* cbinfo) {
    dprint("onRealized()\n");
    //GetLocalTime(&app.tm);
    return Ex_Continue;
}

static void STDCALL
onDrawBkgd(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    dprint("onDrawBkgd()\n");
}

void WndMain::onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    if (widget == this) {
        ExRegion rgn(*damage);
        rgn.subtract(ExBox(img_pt0.x, img_pt0.y, res.i.bg0.width + img_pt0.x, res.i.bg0.height + img_pt0.y));
#if 1
        for (int i = 0; i < rgn.n_boxes; i++) {
            //canvas->gc->fillBox(&rgn.boxes[i], 0U);
            canvas->gc->fillBox(&rgn.boxes[i], ((uint64)widget) & 0xffffff);
        }
#endif
        if (res.i.bg0.bits) {
            for (int i = 0; i < damage->n_boxes; i++) {
                const ExBox& bx = damage->boxes[i];
                canvas->gc->blitRgb(bx.l, bx.t, bx.width(), bx.height(),
                                    &res.i.bg0, bx.l - img_pt0.x, bx.t - img_pt0.y);
            }
        }
    } else if (widget == &wgtBkgd) {
        if (!res.i.bg1.bits) return;
        if (widget->isOpaque()) {
            const ExPoint& pt = widget->calcRect().u.pt;
            for (int i = 0; i < damage->n_boxes; i++) {
                const ExBox& bx = damage->boxes[i];
                canvas->gc->blitRgb(bx.l, bx.t, bx.width(), bx.height(),
                                    &res.i.bg1, bx.l - pt.x, bx.t - pt.y);
            }
        } else if (res.i.bg1.crs) {
            ExCairo::Rect rc(widget->calcRect());
            ExCairo cr(canvas, damage);
            cr_set_source_surface(cr, res.i.bg1.crs, rc.x, rc.y);
            cr_paint_with_alpha(cr, .75); // for alpha blend
        }
    }
}

void WndMain::onDrawTrap(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    static int id = 0;
    static uint32 color[7] = { 0xff, 0xff00, 0xff0000, 0xffff, 0xff00ff, 0xffff00, 0xffffff };
    for (int i = 0; i < damage->n_boxes; i++) {
        const ExBox& bx = damage->boxes[i];
        canvas->gc->drawBox(&bx, color[id]);
    }
    id = (id < 6) ? id + 1 : 0;
}

#define USE_PATTERN_BTN 1
#define USE_ALPHA_BTN 1

void WndMain::onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
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
#if USE_PATTERN_BTN
    cr_pattern_t* crp = cr_pattern_create_linear(rc.x, rc.y, p2.x, p2.y);
#if USE_ALPHA_BTN
    cr_pattern_add_color_stop_rgba(crp, 0.f, pc0.r, pc0.g, pc0.b, pc0.a);
    cr_pattern_add_color_stop_rgba(crp, 1.f, pc1.r, pc1.g, pc1.b, pc1.a);
#else
    cr_pattern_add_color_stop_rgb(crp, 0.f, pc0.r, pc0.g, pc0.b);
    cr_pattern_add_color_stop_rgb(crp, 1.f, pc1.r, pc1.g, pc1.b);
#endif
    cr_set_source(cr, crp);
#else//USE_PATTERN_BTN
#if USE_ALPHA_BTN
    cr_set_source_rgba(cr, pc0.r, pc0.g, pc0.b, .75f);
#else
    cr_set_source_rgb(cr, pc0.r, pc0.g, pc0.b);
#endif
#endif//USE_PATTERN_BTN
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
#if USE_ALPHA_BTN
    cr_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
#else
    cr_set_source_rgb(cr, lc.r, lc.g, lc.b);
#endif
    cr_stroke(cr);

    const char* text = widget->getName();
    cr.set_font(res.f.gothic.crf, 12.f);
    cr.show_text(text, ExCairo::Color(0.f), rc);

#if USE_PATTERN_BTN
    cr_pattern_destroy(crp);
#endif//USE_PATTERN_BTN
}

void WndMain::onDrawPane(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
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
    pc0.setv(128, 128, 128, 255);
    pc1.setv(77, 77, 77, 128);
    if (widget == &panes[0]) {
        pc1.r = FD8V(177);
    } else if (widget == &panes[1]) {
        pc1.g = FD8V(177);
    } else if (widget == &panes[2]) {
        pc1.b = FD8V(177);
    }
#if USE_PATTERN_BTN
    cr_pattern_t* crp = cr_pattern_create_linear(rc.x, rc.y, p2.x, p2.y);
    if (widget->isOpaque()) {
        cr_pattern_add_color_stop_rgb(crp, 0.f, pc0.r, pc0.g, pc0.b);
        cr_pattern_add_color_stop_rgb(crp, 1.f, pc1.r, pc1.g, pc1.b);
    } else {
        cr_pattern_add_color_stop_rgba(crp, 0.f, pc0.r, pc0.g, pc0.b, pc0.a);
        cr_pattern_add_color_stop_rgba(crp, 1.f, pc1.r, pc1.g, pc1.b, pc1.a);
    }
    cr_set_source(cr, crp);
#else//USE_PATTERN_BTN
    if (widget->isOpaque())
        cr_set_source_rgb(cr, pc1.r, pc1.g, pc1.b);
    else
        cr_set_source_rgba(cr, pc1.r, pc1.g, pc1.b, pc1.a);
#endif//USE_PATTERN_BTN
    cr_fill_preserve(cr);

    ExCairo::Color lc; // line color
    if (widget->getFlags(Ex_Focused)) {
        lc.setv(160, 255, 160, 224);
    } else {
        lc.setv(160, 160, 160, 128);
    }
    cr_set_line_width(cr, widget->getFlags(Ex_Focused) ? 3.f : 1.f);
    cr_set_line_join(cr, CR_LINE_JOIN_ROUND);
    cr_set_line_cap(cr, CR_LINE_CAP_ROUND);
    cr_set_antialias(cr, CR_ANTIALIAS_GRAY);
    if (widget->isOpaque())
        cr_set_source_rgb(cr, lc.r, lc.g, lc.b);
    else
        cr_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
    cr_stroke(cr);

#if USE_PATTERN_BTN
    cr_pattern_destroy(crp);
#endif//USE_PATTERN_BTN
}

void WndMain::onDrawToy(ExCanvas* canvas, const WndMain* w, const ExRegion* damage) {
    static const float fs = 16.; // font_size
    static const char* strtbl[2] = {
        "ExeCUnix Project for the Embedded Unix",
        "C.H Park <execunix@gmail.com>"
    };

    const ExBox& bx = w->calcBox();

    cr_status_t status;
    cr_matrix_t font_matrix, ctm;
    cr_matrix_init_scale(&ctm, fs, fs);
    cr_matrix_init_scale(&font_matrix, fs, fs);
    cr_font_options_t* options = cr_font_options_create();
    cr_glyph_t* glyphs = NULL;
    uint& textId = toy.userdata.u32[0];
    const char* str = strtbl[textId % 2];
    int num_glyphs = 0;
    int len = (int)strlen(str);
    float delta = bx.height()/2 * .9f;
    cr_scaled_font_t* scaled_font = cr_scaled_font_create(res.f.gothic_B.crf,
        &font_matrix, &ctm, options);
    status = cr_scaled_font_text_to_glyphs(scaled_font, 0, 0, str, len,
                    &glyphs, &num_glyphs);
    if (status == CR_STATUS_SUCCESS) {
        for (int i = 0; i < num_glyphs; i++) {
            glyphs[i].y += toy_delta * (i % 2 ? delta : -delta);
            glyphs[i].x *= toy_scale;
        }
        ExPoint p = bx.center();
        double w = glyphs[num_glyphs - 1].x + fs / 2.f;
        ExCairo cr(canvas, damage);
        cr_translate(cr, p.x - w / 2.f, p.y + fs / 2.f);
        cr.set_font(res.f.gothic_B.crf, fs);
        cr_set_source_rgba(cr, 1, 1, 1, toy_alpha);
        cr_show_glyphs(cr, glyphs, num_glyphs);
        cr_glyph_free(glyphs);
    }
    cr_scaled_font_destroy(scaled_font);
    cr_font_options_destroy(options);
}

uint32 WndMain::onTimerToy(WndMain* wnd, ExCbInfo* cbinfo) {
    uint& cnt = timerToy.u32[0];
    uint& textId = toy.userdata.u32[0];
    cnt++; // 0 ~ 100
    if (cnt > 100) {
        cnt = 0;
        textId++;
    }
    int n = cnt;
    if (n == 0) {
        toy_alpha = .2f;
        toy_delta = 1.f;
        toy_scale = 1.f;
    } else if (n <= 40) {
        toy_alpha = .2f + .8f * n / 40.f;
        toy_delta = (float)(cos(n * 2 / M_PI) * (40 - n) / 40.);
    } else if (n <= 60) {
        return Ex_Continue;
    } else {
        n -= 60;
        toy_alpha = 1.f - n / 40.f;
        toy_scale = 1.f + n / 20.f;
    }
    toy.damage();
    return Ex_Continue;
}

void WndMain::onDrawBackBuf(ExCanvas* canvas, const ExWidget* w, const ExRegion* damage) {
    if (w == &wgtBackViewer &&
        wndBackBuf.canvas->gc->crs) {
        ExCairo cr(canvas, damage);
        ExCairo::Rect rc(w->calcRect());
        cr_set_source_surface(cr, wndBackBuf.canvas->gc->crs, rc.x, rc.y);
        cr_paint_with_alpha(cr, .75); // for alpha blend
        return;
    }
    if (w == &wndBackBuf &&
        res.i.bg1.crs) { // draw to wndBackBuf canvas
        ExCairo cr(canvas, damage);
        ExCairo::Point pt(-backBufCnt, -backBufCnt);
        cr_set_source_surface(cr, res.i.bg1.crs, 1.5f * pt.x, pt.y);
        cr_paint_with_alpha(cr, .75); // for alpha blend
        return;
    }
}

uint32 WndMain::onLayout(WndMain* widget, ExCbInfo* cbinfo) {
    dprint("%s(%s) %d (%d,%d-%dx%d)\n", __func__, widget->getName(),
           cbinfo->subtype, widget->area.x, widget->area.y, widget->area.w, widget->area.h);
    ExRect ar(0, 0, widget->area.w, widget->area.h);
    ExRect rc;
    if (widget == this) {
        wgtTitle.layout(rc.set(ar.x, ar.y, ar.w, 36));
        ar.offset(0, 36, 0, 0);
        wgtMenu.layout(rc.set(ar.x, ar.y, ar.w, 30));
        ar.offset(0, 30, 0, 0);
        ar.inset(16, 16);
        ExRect a0(ar.x, ar.y, ar.w, ar.h * 12 / 100); a0.y += (ar.h * 88 / 100);
        ExRect a1(ar.x, ar.y, ar.w * 18 / 100, ar.h * 84 / 100);
        ExRect a2(ar.x, ar.y, ar.w * 18 / 100, ar.h * 84 / 100); a2.x += (ar.w * 82 / 100);
        panes[0].layout(a0); // do recurs here
        panes[1].layout(a1); // do recurs here
        panes[2].layout(a2); // do recurs here
        toy.setPos(ExPoint(ar.center().x - toy.area.w / 2,
                           ar.center().y - toy.area.h / 2));
#if 1
        ExBox opaqBox(0, 0, a0.w, a0.h);
        opaqBox.l += 8; opaqBox.t += 2;
        opaqBox.r -= 8; opaqBox.b -= 2;
        panes[0].setOpaqueRegion(ExRegion(opaqBox));
#else
        //panes[0].setFlags(Ex_Opaque);
#endif
    } else if (widget == &panes[0]) {
        float margin_w = ar.w * 2 / 100.f; // 2 %
        float margin_h = ar.h * 8 / 100.f; // 8 %
        ar.inset((int)margin_w, (int)margin_h);
        float gap_x = ar.w * 3 / 100.f; // 3 %
        float grid_x = (ar.w + gap_x) / 5;
        float p_x = (float)ar.x;
        ExSize sz((int)(grid_x - gap_x), ar.h);
        for (int i = 0; i < 5; i++) {
            btns0[i].layout(rc.set(ExPoint((int)p_x, ar.y), sz));
            p_x += grid_x;
        }
    } else if (widget == &panes[1] || widget == &panes[2]) {
        float margin_w = ar.w * 8 / 100.f; // 8 %
        float margin_h = ar.h * 3 / 100.f; // 3 %
        ar.inset((int)margin_w, (int)margin_h);
        float gap_y = ar.h * 4 / 100.f; // 4 %
        float grid_y = (ar.h + gap_y) / 6;
        float p_y = (float)ar.y;
        ExSize sz(ar.w, (int)(grid_y - gap_y));
        ExWidget* btns = widget == &panes[1] ? btns1 : btns2;
        for (int i = 0; i < 6; i++) {
            btns[i].layout(rc.set(ExPoint(ar.x, (int)p_y), sz));
            p_y += grid_y;
        }
    }
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

uint32 WndMain::onActMain(WndMain* widget, ExCbInfo* cbinfo) {
    if (widget == this) {
        static ExPoint but_pt(0);
        ExPoint msg_pt(cbinfo->event->msg.pt);
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg_pt; // memory press point
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            img_pt0 += (msg_pt - but_pt);
            but_pt = msg_pt;
            damage();
        }
        return Ex_Continue;
    } else if (widget == &panes[0]) {
        static ExPoint but_pt(0);
        ExPoint msg_pt(cbinfo->event->msg.pt);
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg_pt; // memory press point
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            ExPoint pt = widget->area.u.pt;
            pt += (msg_pt - but_pt);
            but_pt = msg_pt;
            widget->setPos(pt);
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

uint32 WndMain::onActBkgd(WndMain* widget, ExCbInfo* cbinfo) {
    if (widget == &wgtBkgd) {
        static ExPoint but_pt(0);
        ExPoint msg_pt(cbinfo->event->msg.pt);
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg_pt; // memory press point
            //widget->toFront();
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            ExPoint pt(wgtBkgd.area.u.pt);
            pt += (msg_pt - but_pt);
            but_pt = msg_pt;
            wgtBkgd.setPos(pt);
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

static uint32 STDCALL
onEnum(void* data, ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->type == Ex_CbEnumEnter) {
        dprint("enum: %s enter\n", widget->getName());
        return (widget->getFlags(Ex_Visible)) ? Ex_Continue : Ex_Discard;
    }
    if (cbinfo->type == Ex_CbEnumLeave) {
        dprint("enum: %s leave\n", widget->getName());
        return (widget->getFlags(Ex_Visible)) ? Ex_Continue : Ex_Discard;
    }
    dprint("enum: %s invalid *****************\n", widget->getName());
    return Ex_Break;
}

uint32 WndMain::onActBtns(ExWidget* widget, ExCbInfo* cbinfo) {
    dprint0("WndMain::onActBtns %s %d %d\n",
            widget->getName(), cbinfo->type, cbinfo->subtype);
    if (cbinfo->type == Ex_CbButPress) {
        giveFocus(widget);
    }
    if (widget == &btns0[0]) {
        if (cbinfo->type == Ex_CbActivate) {
            dprint("*** enumBackToFront\n");
            enumBackToFront(this, this, ExCallback(onEnum, (void*)NULL), NULL);
            dprint("*** enumFrontToBack\n");
            enumFrontToBack(this, this, ExCallback(onEnum, (void*)NULL), NULL);
            return Ex_Continue;
        }
    }
    if (widget == &btns0[1]) {
        if (cbinfo->type == Ex_CbActivate) {
            panes[2].setVisible(!panes[2].getFlags(Ex_Visible));
            return Ex_Continue;
        }
    }
    if (widget == &btns0[2]) {
        if ((cbinfo->type == Ex_CbActivate && cbinfo->subtype == 0) ||
            cbinfo->type == Ex_CbButRepeat) {
            panes[2].area.x -= 10;
            panes[2].setPos(panes[2].area.u.pt);
            dprint("repeat left %d\n", cbinfo->subtype);
            return Ex_Continue;
        }
    }
    if (widget == &btns0[3]) {
        if ((cbinfo->type == Ex_CbActivate && cbinfo->subtype == 0) ||
            cbinfo->type == Ex_CbButRepeat) {
            panes[2].area.x += 10;
            panes[2].setPos(panes[2].area.u.pt);
            dprint("repeat right %d\n", cbinfo->subtype);
            return Ex_Continue;
        }
    }
    if (widget == &btns0[4]) {
        if (cbinfo->type == Ex_CbActivate) {
            dprint("Ex_Halt\n");
            return Ex_Halt;
        }
    }
    if (widget == &btns1[0]) {
        if (cbinfo->type == Ex_CbActivate) {
            timer.u32[0] = !timer.u32[0];
            if (timer.u32[0])
                timer.start(100, 25);
            else
                timer.stop();
            return Ex_Continue;
        }
    }
    if (widget == &btns1[1]) {
        if (cbinfo->type == Ex_CbActivate) {
            WgtSetup* setup = new WgtSetup;
            setup->setFlags(Ex_FreeMemory);
            setup->init(this, 300, 200);
            return Ex_Continue;
        }
    }
    if (widget == &btns1[2]) {
        if (cbinfo->type == Ex_CbActivate) {
            static ExTimer setCursor;
            if (setCursor.u32[0] == 0) {
                setCursor.u32[0] = 1;
                setCursor.init(exWatchDisp, [](void* data, ExTimer* timer, ExCbInfo* cbinfo)->uint32 {
                    POINT pt;
                    setCursor.u32[1]++;
                    int n = setCursor.u32[1] & 1 ? -5 : 5;
                    GetCursorPos(&pt);
                    SetCursorPos(pt.x + n, pt.y + n);
                    return 0; }, NULL);
            }
            if (setCursor.u32[0] == 1) {
                setCursor.u32[0] = 2;
                setCursor.start(1000, 1000);
            } else if (setCursor.u32[0] == 2) {
                setCursor.u32[0] = 1;
                setCursor.stop();
            }
            return Ex_Continue;
        }
    }
    if (widget == &btns1[3]) {
        if (cbinfo->type == Ex_CbActivate) {
            WndTest* wndTest = new WndTest;
            wndTest->setFlags(Ex_FreeMemory);
            wndTest->start();
            return Ex_Continue;
        }
    }
    if (widget == &btns1[4]) {
        if (cbinfo->type == Ex_CbButRepeat) {
            dprint("Ex_CbButRepeat %d\n", cbinfo->subtype);
            return Ex_Continue;
        }
    }
    if (widget == &btns1[5]) {
        if (cbinfo->type == Ex_CbActivate) {
            if (!exDrawFuncTrap) {
                exDrawFuncTrap = ExDrawFunc(this, &WndMain::onDrawTrap);
            } else {
                exDrawFuncTrap = ExDrawFunc();
                damage();
            }
            return Ex_Continue;
        }
    }
    return Ex_Continue;
}

uint32 WndMain::onTimer(ExTimer* timer, ExCbInfo* cbinfo)
{
    int dx = state ? -2 : 2;
    int dy = state ? -1 : 1;
    panes[1].area.x += dx;
    panes[1].area.y += dy;
    dprint0("%s: %d,%d\n", __func__, panes[1].area.x, panes[1].area.y);
    if (state == 0 && panes[1].area.y > 480 ||
        state != 0 && panes[1].area.y < 0)
        state = !state;
    panes[1].setPos(panes[1].area.u.pt);
    return Ex_Continue;
}

static HANDLE hWakeupNoti;
static HANDLE hStorageNoti;

int WndMain::initIomux() {
    static ExTimer launchInputTimer;
    launchInputTimer.init(NULL, [](void* d, ExTimer* t, ExCbInfo*)->uint32 {
        dprint("launchInputTimer: %d\n", exWatchDisp->getTick());

        hWakeupNoti = CreateEvent(NULL, FALSE, FALSE, "AppDemo"); // tbd
        exWatchLast->ioAdd([](void* d, HANDLE handle)->uint32 {
            dprint("hWakeupNoti signaled...\n");
            return 0; }, (void*)NULL, hWakeupNoti, NULL);

        hStorageNoti = FindFirstChangeNotification("\\", TRUE, FILE_NOTIFY_CHANGE_DIR_NAME);
        exWatchLast->ioAdd([](void* d, HANDLE handle)->uint32 {
            dprint("hStorageNoti root fs changed...\n");
            FindNextChangeNotification(hStorageNoti);
            return 0; }, (void*)NULL, hStorageNoti, NULL);

        static ExTimer signalInputTimer;
        signalInputTimer.init(NULL, [](void* d, ExTimer* t, ExCbInfo*)->uint32 {
            (t->u32[0])++;
            // emulate initial state.
            if (!((t->u32[0]) % 5))
                SetEvent(hWakeupNoti);
            return Ex_Continue; }, NULL);
        signalInputTimer.start(1, 1000);
        return Ex_Continue; }, NULL);
    launchInputTimer.start(1000);
    return 0;
}

bool WndMain::initBtn(ExWidget* parent, ExWidget* btn, const char* name) {
    btn->init(parent, name, NULL);
    //btn->setFlags(Ex_Opaque); // test
    btn->setFlags(Ex_FocusRender);
    btn->setFlags(Ex_Selectable | Ex_AutoHighlight);
    btn->drawFunc = ExDrawFunc(this, &WndMain::onDrawBtns);
    btn->addListener(this, &WndMain::onActBtns, Ex_CbActivate);
    return true;
}

uint32 WndMain::onDestroyed(WndMain* w, ExCbInfo* cbinfo) {
    dprint("%s()\n", __func__);
    assert(w == this);
    timerToy.stop();
    timer.stop();
    finiRes();
    saveEnv();
    return Ex_Continue;
}

uint32 WndMain::onRbtnDown(WndMain* w, ExCbInfo* cbinfo) {
    if (cbinfo->event->message == WM_RBUTTONDOWN) {
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        ExWidget* w = getPointOwner(ExPoint(xPos, yPos));
        if (w == &wgtBackViewer ||
            w == &wgtBkgd) {
            w->toBack();
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

uint32 WndMain::onHandler(WndMain* w, ExCbInfo* cbinfo) {
    dprint("handler WM_0x%04x:0x%04x\n", cbinfo->event->message, cbinfo->event->msg.message);
    return Ex_Continue;
}

uint32 WndMain::onFilter(WndMain* w, ExCbInfo* cbinfo) {
    dprint("filter WM_0x%04x\n", cbinfo->event->message);
#if 1 // test
    // filter and handler can be installed intersection each other
    static int i = 0;
    ++i;
    if (i == 20) {
        removeHandler(ExCallback(this, &WndMain::onHandler));
    } else if (i == 40) {
        PostMessage(w->getHwnd(), WM_APP_TEST, 0, 0);
        addHandler(this, &WndMain::onHandler);
        i = 0;
    }
#endif
#if 1
    if (cbinfo->event->message == WM_SYSCOMMAND) {
        if (cbinfo->event->wParam == SC_MAXIMIZE) {
            env.wnd.show = SW_SHOWMAXIMIZED;
            return Ex_Continue;
        }
        if (cbinfo->event->wParam == SC_RESTORE) {
            env.wnd.show = SW_SHOWNORMAL;
            return Ex_Continue;
        }
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_WINDOWPOSCHANGED) {
        WINDOWPOS* wndpos = (WINDOWPOS*)cbinfo->event->lParam;
        if (env.wnd.show == SW_SHOWNORMAL) {
            env.wnd.w = wndpos->cx;
            env.wnd.h = wndpos->cy;
            env.wnd.x = wndpos->x;
            env.wnd.y = wndpos->y;
        }
        return Ex_Continue;
    }
    if (cbinfo->event->message == WM_ACTIVATE) {
        // extend the frame into the client area
        MARGINS margins;
        margins.cxLeftWidth = 8; // 0;
        margins.cxRightWidth = 8;
        margins.cyBottomHeight = 20;
        margins.cyTopHeight = 20;
        HRESULT hr = DwmExtendFrameIntoClientArea(hwnd, &margins);
        if (!SUCCEEDED(hr)) {
            dprint("%s: %s fail.\n", __func__, "DwmExtendFrameIntoClientArea");
        }
        //cbinfo->event->lResult = 0;
        return Ex_Continue;
    }
#endif
    if (cbinfo->event->message == WM_KEYDOWN) {
        ExCbInfo cbinfo2(0);
        switch (cbinfo->event->wParam) {
            case VK_UP:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_UP");
                moveFocus(Ex_DirUp);
                break;
            case VK_DOWN:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_DOWN");
                moveFocus(Ex_DirDown);
                break;
            case VK_LEFT:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_LEFT");
                moveFocus(Ex_DirLeft);
                break;
            case VK_RIGHT:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_RIGHT");
                moveFocus(Ex_DirRight);
                break;
            case VK_SPACE:
            case VK_RETURN:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_RETURN");
                wgtFocused->invokeListener(Ex_CbActivate, &cbinfo2(Ex_CbActivate, 0, event));
                break;
            case VK_ESCAPE:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_ESCAPE");
                return Ex_Halt;
            case VK_HOME:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_HOME");
                moveFocus(Ex_DirHome);
                break;
            case VK_BACK:
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_BACK");
                moveFocus(Ex_DirBack);
                break;
            case VK_TAB: {
                dprint("0x%04x %s\n", cbinfo->event->message, "VK_TAB");
                SHORT ks = GetKeyState(VK_SHIFT);
                moveFocus(ks & 0x100 ? Ex_DirTabPrev : Ex_DirTabNext);
                break;
            }
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

ExWidget* WndMain::moveFocus(int dir) {
    if (wgtFocused == NULL) {
        if (dir == Ex_DirHome || dir == Ex_DirDown || dir == Ex_DirRight || dir == Ex_DirTabNext)
            return giveFocus(this);
        return giveFocus(last());
    }
    switch (dir) {
        case Ex_DirHome: // tbd
            return giveFocus(&btns1[0]);
        case Ex_DirBack: // tbd
            return giveFocus(&btns1[0]);
    }
    ExWidget* focusmap[][9] = { // tbd
        // target     up         down       left       right      tabprev    tabnext
        { &btns0[0], &panes[1], &panes[1], &btns0[4], &btns0[1], &panes[2], &panes[1] },
        { &btns0[1], &panes[1], &panes[1], &btns0[0], &btns0[2], &panes[2], &panes[1] },
        { &btns0[2], &panes[1], &panes[1], &btns0[1], &btns0[3], &panes[2], &panes[1] },
        { &btns0[3], &panes[2], &panes[2], &btns0[2], &btns0[4], &panes[2], &panes[1] },
        { &btns0[4], &panes[2], &panes[2], &btns0[3], &btns0[0], &panes[2], &panes[1] },
        { &btns1[0], &btns1[5], &btns1[1], &panes[2], &panes[2], &panes[0], &panes[2] },
        { &btns1[1], &btns1[0], &btns1[2], &panes[2], &panes[2], &panes[0], &panes[2] },
        { &btns1[2], &btns1[1], &btns1[3], &panes[2], &panes[2], &panes[0], &panes[2] },
        { &btns1[3], &btns1[2], &btns1[4], &panes[2], &panes[2], &panes[0], &panes[2] },
        { &btns1[4], &btns1[3], &btns1[5], &panes[2], &panes[2], &panes[0], &panes[2] },
        { &btns1[5], &btns1[4], &btns1[0], &panes[2], &panes[2], &panes[0], &panes[2] },
        { &btns2[0], &btns2[5], &btns2[1], &panes[1], &panes[1], &panes[1], &panes[0] },
        { &btns2[1], &btns2[0], &btns2[2], &panes[1], &panes[1], &panes[1], &panes[0] },
        { &btns2[2], &btns2[1], &btns2[3], &panes[1], &panes[1], &panes[1], &panes[0] },
        { &btns2[3], &btns2[2], &btns2[4], &panes[1], &panes[1], &panes[1], &panes[0] },
        { &btns2[4], &btns2[3], &btns2[5], &panes[1], &panes[1], &panes[1], &panes[0] },
        { &btns2[5], &btns2[4], &btns2[0], &panes[1], &panes[1], &panes[1], &panes[0] },
        { NULL, },
    };
    int i = 0;
    while (focusmap[i][0] && focusmap[i][0] != wgtFocused) i++;
    if (!focusmap[i][0]) {
        dprint("Where did the focus go?\n");
        return giveFocus(&btns1[0]);
    }

    ExWidget* newFocus = NULL;
    switch (dir) {
        case Ex_DirUp: newFocus = focusmap[i][1]; break;
        case Ex_DirDown: newFocus = focusmap[i][2]; break;
        case Ex_DirLeft: newFocus = focusmap[i][3]; break;
        case Ex_DirRight: newFocus = focusmap[i][4]; break;
        case Ex_DirTabPrev: newFocus = focusmap[i][5]; break;
        case Ex_DirTabNext: newFocus = focusmap[i][6]; break;
    }
    if (!newFocus->isVisible()) {
        newFocus = this;
    }
    return giveFocus(newFocus);
}

uint32 WndMain::onFocused(WndMain* widget, ExCbInfo* cbinfo) {
    static ExWidget* losted[3] = { NULL, };
    if (cbinfo->type == Ex_CbLostFocus) {
        // memory focused child
        if (cbinfo->subtype == 0) {
            if (widget == this) {
                ;
            } else if (widget == &panes[0]) {
                losted[0] = wgtFocused;
            } else if (widget == &panes[1]) {
                losted[1] = wgtFocused;
            } else if (widget == &panes[2]) {
                losted[2] = wgtFocused;
            }
        }
    } else if (cbinfo->type == Ex_CbGotFocus) {
        // subtype 0 - indirect
        // subtype 1 - direct
        if (cbinfo->subtype == 1) {
            if (widget == this) {
                giveFocus(&panes[0]); // tbd - define home
            } else if (widget == &panes[0]) {
                giveFocus(losted[0] ? losted[0] : &btns0[0]);
            } else if (widget == &panes[1]) {
                giveFocus(losted[1] ? losted[1] : &btns1[0]);
            } else if (widget == &panes[2]) {
                giveFocus(losted[2] ? losted[2] : &btns2[0]);
            }
        }
    }
    return Ex_Continue;
}

void WndMain::onFlushBackBuf(WndMain* w, const ExRegion* updateRgn) {
    // updateRgn is filled after render call.
    wndBackBuf.render();
    // update to pseudo display.
#if 1
    wgtBackViewer.damage();
#else
    // When using a real secondary display ...
    ExBox clip(updateRgn->extent);
    clip.move(wgtBackViewer.calcRect().pt);
    wgtBackViewer.damage(clip);
#endif
}

uint32 WndMain::onBackViewMove(WndMain* widget, ExCbInfo* cbinfo) {
    static ExPoint but_pt(0);
    assert(widget == &wgtBackViewer);
    if (cbinfo->type == Ex_CbButPress) {
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        but_pt.set(xPos, yPos); // memory press point
        widget->toFront();
        wgtCapture = widget;
    } else if (cbinfo->type == Ex_CbPtrMove &&
               widget->getFlags(Ex_ButPressed)) {
        int xPos = LOWORD(cbinfo->event->lParam);
        int yPos = HIWORD(cbinfo->event->lParam);
        ExPoint pt(wgtBackViewer.area.u.pt);
        pt.x += xPos - but_pt.x;
        pt.y += yPos - but_pt.y;
        but_pt.set(xPos, yPos);
        wgtBackViewer.setPos(pt);
    }
    return Ex_Continue;
}

uint32 WndMain::onBackBufUpdater(ExTimer* timer, ExCbInfo* cbinfo) {
    backBufCnt++;
    if (backBufCnt > 500)
        backBufCnt = 0;
    ExRect ar = wgtBackBtn.area;
    if (ar.u.pt.x++ > 180)
        ar.u.pt.x = 0;
    wgtBackBtn.setArea(ar);
    // render backbuf
    wndBackBuf.damage();
    // flush to window
    wndBackBuf.flush();
    return Ex_Continue;
}

class FlushTest { // apitest
    int test;
public:
    void STDCALL onFlush(WndMain* w, const ExRegion* updateRgn) {}
};

#define FLUSH_TEST() //do { flush(); Sleep(1000); } while (0)
#define DISP_AT_ONCE 1

int WndMain::start() {
    ExRect rc;
    initEnv();
    initRes();
    this->init("AppDemoWndMain", env.wnd.w, env.wnd.h);

    // init canvas
    canvas = new ExCanvas;
    //canvas->init(this, &ExApp::smSize);
    canvas->init(this, ExSize(env.sm_w, env.sm_h));

    ExApp::mainWnd = this;

    backBufCnt = 0;
    img_pt0.set(0, 0);

    drawFunc = ExDrawFunc(&::onDrawBkgd, (void*)this); // test
    drawFunc = ExDrawFunc(this, &WndMain::onDrawBkgd);

    FlushTest flushTest;
    flushFunc = ExFlushFunc(&flushTest, &FlushTest::onFlush); // apitest
    flushFunc = ExFlushFunc(this, &WndMain::onExFlush); // apitest
    paintFunc = ExFlushFunc(this, &WndMain::onWmPaint); // apitest
    flushFunc = ExFlushFunc((ExWindow*)this, &ExWindow::onExFlush);
    paintFunc = ExFlushFunc((ExWindow*)this, &ExWindow::onWmPaint);
#if DISP_AT_ONCE
    ;
#else
    showWindow(0, WS_OVERLAPPEDWINDOW | WS_VISIBLE); // show logo
    // ==> render() #1
    Sleep(500); // test
#endif
    setFlags(Ex_Selectable);

    wgtBkgd.init(this, "res.i.bg1", &rc.set(300, 300, res.i.bg1.width, res.i.bg1.height));
    wgtBkgd.addListener(this, &WndMain::onActBkgd, Ex_CbActivate);
    wgtBkgd.drawFunc = ExDrawFunc(this, &WndMain::onDrawBkgd);
    wgtBkgd.setFlags(Ex_Selectable);
    //wgtBkgd.setFlags(Ex_Opaque);
    FLUSH_TEST();
    // ==> render() #2

    addListener(this, &WndMain::onDestroyed, Ex_CbDestroyed);
    addListener(&onUnrealized, this, Ex_CbUnrealized);
    addListener(&onRealized, this, Ex_CbRealized);
    addListener(this, &WndMain::onLayout, Ex_CbLayout);
    addListener(this, &WndMain::onFocused, Ex_CbGotFocus);
    addListener(this, &WndMain::onActMain, Ex_CbActivate);
    addListener([](void* data, ExWidget* widget, ExCbInfo* cbinfo)->uint32 {
        dprint("%s Activate %d,%d\n", widget->getName(), cbinfo->type, cbinfo->subtype);
        return Ex_Continue; }, this, Ex_CbActivate);

    panes[0].init(this, "pan0", &rc.set(20, 400, 760, 60));
    panes[1].init(this, "pan1", &rc.set(20, 20, 120, 360));
    panes[2].init(this, "pan2", &rc.set(660, 20, 120, 360));
    panes[0].drawFunc = ExDrawFunc(this, &WndMain::onDrawPane);
    panes[1].drawFunc = ExDrawFunc(this, &WndMain::onDrawPane);
    panes[2].drawFunc = ExDrawFunc(this, &WndMain::onDrawPane);
    panes[0].addListener(this, &WndMain::onLayout, Ex_CbLayout);
    panes[1].addListener(this, &WndMain::onLayout, Ex_CbLayout);
    panes[2].addListener(this, &WndMain::onLayout, Ex_CbLayout);
    panes[0].addListener(this, &WndMain::onFocused, Ex_CbGotFocus);
    panes[1].addListener(this, &WndMain::onFocused, Ex_CbGotFocus);
    panes[2].addListener(this, &WndMain::onFocused, Ex_CbGotFocus);
    panes[0].addListener(this, &WndMain::onFocused, Ex_CbLostFocus);
    panes[1].addListener(this, &WndMain::onFocused, Ex_CbLostFocus);
    panes[2].addListener(this, &WndMain::onFocused, Ex_CbLostFocus);
    panes[0].setFlags(Ex_FocusRender);
    panes[1].setFlags(Ex_FocusRender);
    panes[2].setFlags(Ex_FocusRender);

    panes[0].addListener(this, &WndMain::onActMain, Ex_CbActivate);
    panes[0].setFlags(Ex_Selectable);
    panes[2].setFlags(Ex_Visible, Ex_BitFalse);
    FLUSH_TEST();

    initBtn(&panes[0], &btns0[0], "btns0-0");
    initBtn(&panes[0], &btns0[1], "btns0-1");
    initBtn(&panes[0], &btns0[2], "btns0-2");
    initBtn(&panes[0], &btns0[3], "btns0-3");
    initBtn(&panes[0], &btns0[4], "btns0-4");

    initBtn(&panes[1], &btns1[0], "btns1-0");
    initBtn(&panes[1], &btns1[1], "btns1-1");
    initBtn(&panes[1], &btns1[2], "btns1-2");
    initBtn(&panes[1], &btns1[3], "btns1-3");
    initBtn(&panes[1], &btns1[4], "btns1-4");
    initBtn(&panes[1], &btns1[5], "btns1-5");

    initBtn(&panes[2], &btns2[0], "btns2-0");
    initBtn(&panes[2], &btns2[1], "btns2-1");
    initBtn(&panes[2], &btns2[2], "btns2-2");
    initBtn(&panes[2], &btns2[3], "btns2-3");
    initBtn(&panes[2], &btns2[4], "btns2-4");
    initBtn(&panes[2], &btns2[5], "btns2-5");

    FLUSH_TEST();

    timer.init(NULL, this, &WndMain::onTimer);

    static ExTimer timerTest;
    timerTest.init(NULL, [](void* d, ExWidget* w, ExCbInfo*)->uint32 {
        dprint("timerTest: %s\n", w->getName());
        return Ex_Continue; }, (void*)0, this); // test
    timerTest.init(NULL, [](void* d, ExTimer* t, ExCbInfo*)->uint32 {
        dprint("timerTest: %d %u %u\n", (t->u32[0])++, (ulong)*t, exWatchDisp->getTick());
        return Ex_Continue; }, (void*)0);
    timerTest.start(1, 1000);

    toy_alpha = .2f;
    toy_delta = 1.f;
    toy_scale = 1.f;
    toy.userdata.u32[0] = 0;
    toy.drawFunc = ExDrawFunc(this, &WndMain::onDrawToy);
    toy.init(this, "toy", &rc.set(360, 300, 600, 80));

    timerToy.u32[0] = 0;
    timerToy.init(NULL, this, &WndMain::onTimerToy, this);
    timerToy.start(1, 50); // 20Hz

    addFilter(this, &WndMain::onFilter);
    addHandler(this, &WndMain::onHandler);
    addHandler(this, &WndMain::onRbtnDown);

    wndBackBuf.init("wndBackBuf", 360, 240);
    wndBackBuf.canvas = new ExCanvas;
    wndBackBuf.canvas->init(&wndBackBuf);
    wndBackBuf.flushFunc = ExFlushFunc(this, &WndMain::onFlushBackBuf);
    wgtBackBtn.init(&wndBackBuf, "wgtBackBtn", &rc.set(20, 20, 120, 40));
    wndBackBuf.drawFunc = ExDrawFunc(this, &WndMain::onDrawBackBuf);
    wgtBackBtn.drawFunc = ExDrawFunc(this, &WndMain::onDrawBtns);
    wndBackBuf.flush();

    wgtBackViewer.init(this, "wgtBackViewer", &rc.set(80, 40, 360, 240));
    wgtBackViewer.addListener(this, &WndMain::onBackViewMove, Ex_CbActivate);
    wgtBackViewer.drawFunc = ExDrawFunc(this, &WndMain::onDrawBackBuf);
    wgtBackViewer.setFlags(Ex_Selectable);

    backBufUpdater.init(NULL, this, &WndMain::onBackBufUpdater);
    backBufUpdater.start(1, 25); // 40Hz

    initIomux();

    wgtMenu.init(this);
    wgtTitle.init(this);

#if DISP_AT_ONCE
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
            // To remove an anonymous callback, simply return Ex_Remove.
            return Ex_Break | Ex_Remove;
        }
#if 0 // window caption remove or change
        if (cbinfo->event->message == WM_NCCALCSIZE) {
            RECT* r = (RECT*)cbinfo->event->lParam;
            //NCCALCSIZE_PARAMS* rc = (NCCALCSIZE_PARAMS*)lParam;
            dprint("[0x%p] WM_NCCALCSIZE wParam=%d %d,%d-%d,%d\n",
                   cbinfo->event->hwnd, cbinfo->event->wParam,
                   r->left, r->top, r->right, r->bottom);
            //r->top += 31;
            //r->left += 8;
            //r->right -= 8;
            //r->bottom -= 8;
            cbinfo->event->lResult = 0;
            return Ex_Break;
        }
#endif
        return Ex_Continue; }, this);
    //showWindow(0, WS_POPUP | WS_VISIBLE);
    showWindow(0, WS_POPUP | WS_VISIBLE, env.wnd.x, env.wnd.y);
    //showWindow(0, WS_OVERLAPPEDWINDOW | WS_VISIBLE, env.wnd.x, env.wnd.y);
    //SetWindowTextA(hwnd, "AppDemo-extk-1.1");
    SetWindowText(hwnd, res.s.title);
    if (env.wnd.show == SW_SHOWMAXIMIZED) {
        ShowWindow(hwnd, SW_SHOWMAXIMIZED);
    }
    return 0;
#else
    layout(area);
    return damage();
#endif
}
