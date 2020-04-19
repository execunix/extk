//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wndmain.h"

void WgtTitle::init(ExWindow* window) {
    ExWidget::init(window, L"WgtTitle", &ExArea(0, 0, 800, 36));
    setTitle(L"Welcome to Rectangles and Callbacks World.");
    setFlags(Ex_Selectable);
    addCallback(this, &WgtTitle::onLayout, Ex_CbLayout);
    drawFunc = ExDrawFunc(this, &WgtTitle::onDrawTitle);
}

int WgtTitle::onLayout(WgtTitle* widget, ExCbInfo* cbinfo) {
    //ExArea& expand = *(ExArea*)cbinfo->data;
    return Ex_Continue;
}

void WgtTitle::onDrawTitle(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->getRect());

    cr.fill_rect_rgba(rc, ExCairo::Color(.2f, .2f, .2f, .5f));

    rc.r -= 48.f;
    cr.set_font(canvas->crf[1], rc.height() * .5f);
    ExCairo::Point pt = cr.text_align(title, rc, ExCairo::Right | ExCairo::VCenter);
#if 0
    cairo_move_to(cr, pt.x + 2.f, pt.y + 2.f);
    cairo_set_source_rgb(cr, .2f, .2f, .2f);
    cairo_text_path(cr, title);
    cairo_set_line_width(cr, 2.f);
    cairo_stroke(cr);
#else
    cr.show_text(title, ExCairo::Color(.2f), ExCairo::Point(pt.x + 2.f, pt.y + 2.f));
#endif
    cr.show_text(title, ExCairo::Color(1.f), pt);
}

static int STDCALL
onUnrealized(void* data, ExWidget* w, ExCbInfo* cbinfo) {
    dprintf(L"onUnrealized()\n");
    return Ex_Continue;
}

static int STDCALL
onRealized(WndMain* data, ExWindow* w, ExCbInfo* cbinfo) {
    dprintf(L"onRealized()\n");
    //GetLocalTime(&app.tm);
    return Ex_Continue;
}

static void STDCALL
onDrawBkgd(void* data, ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    dprintf(L"onDrawBkgd()\n");
}

void WndMain::onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    if (widget == this) {
        ExRegion rgn(*damage);
        rgn.subtract(ExRect(img_pt0.x, img_pt0.y, imgBkgd0.width + img_pt0.x, imgBkgd0.height + img_pt0.y));
        for (int i = 0; i < rgn.n_rects; i++)
            canvas->gc->fillRect(&rgn.rects[i], ((uint)widget) & 0xffffff);
        if (imgBkgd0.bits) {
            for (int i = 0; i < damage->n_rects; i++) {
                ExRect& dr = damage->rects[i];
                canvas->gc->blitRgb(dr.l, dr.t, dr.width(), dr.height(),
                                    &imgBkgd0, dr.l - img_pt0.x, dr.t - img_pt0.y);
            }
        }
    } else if (widget == &wgtBkgd) {
        if (!imgBkgd1.bits) return;
        if (widget->isOpaque()) {
            const ExRect& rc = widget->getRect();
            for (int i = 0; i < damage->n_rects; i++) {
                const ExRect& dr = damage->rects[i];
                canvas->gc->blitRgb(dr.l, dr.t, dr.width(), dr.height(),
                                    &imgBkgd1, dr.l - rc.l, dr.t - rc.t);
            }
        } else if (imgBkgd1.crs) {
            ExCairo::Rect rc(widget->getRect());
#if 1
            ExCairo cr(canvas, damage);
            cairo_set_source_surface(cr, imgBkgd1.crs, rc.l, rc.t);
            cairo_paint_with_alpha(cr, .75); // for alpha blend
            //cairo_paint(cr); // for opaque
#else // test
            //canvas->gc->blitAlphaOver(dr.l, dr.t, dr.width(), dr.height(),
            //                          &imgBkgd1, dr.l - rc.l, dr.t - rc.t);
#endif
        }
    }
}

void WndMain::onDrawTrap(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
#if 1
    static int id = 0;
    static uint32 color[7] = { 0xff, 0xff00, 0xff0000, 0xffff, 0xff00ff, 0xffff00, 0xffffff };
    for (int i = 0; i < damage->n_rects; i++) {
        ExRect& rc = damage->rects[i];
        canvas->gc->drawRect(&rc, color[id]);
    }
    id = (id < 6) ? id + 1 : 0;
#else
    cairo_t* cr = canvas->cr;
    for (int i = 0; i < damage->n_rects; i++) {
        cairo_new_path(cr);
        ExRect& rc = damage->rects[i];
        cairo_move_to(cr, rc.l + 1, rc.t + 1);
        cairo_line_to(cr, rc.r - 1, rc.t + 1);
        cairo_line_to(cr, rc.r - 1, rc.b - 1);
        cairo_line_to(cr, rc.l + 1, rc.b - 1);
        //cairo_line_to(cr, rc.l + 1, rc.t + 1);
        cairo_close_path(cr);

        cairo_set_line_width(cr, .5);
        //cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
        //cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
        cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
        cairo_set_source_rgba(cr, 0., 0., 0., 1.);
        cairo_stroke(cr);
    }
#endif
}

#define USE_PATTERN_BTN 0
#define USE_ALPHA_BTN 0

void WndMain::onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
#if 0
    if (widget == &wgtBackBtn) {
        uint32 color = ExARGB(189, 77, 77, 0);
        canvas->gc->fillRect(&widget->getExtent(), color);
        return;
    }
#endif
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->getRect());
    cairo_new_path(cr);
    cairo_move_to(cr, rc.l + 4, rc.t + 1);
    cairo_line_to(cr, rc.r - 4, rc.t + 1);
    cairo_line_to(cr, rc.r - 1, rc.t + 4);
    cairo_line_to(cr, rc.r - 1, rc.b - 4);
    cairo_line_to(cr, rc.r - 4, rc.b - 1);
    cairo_line_to(cr, rc.l + 4, rc.b - 1);
    cairo_line_to(cr, rc.l + 1, rc.b - 4);
    cairo_line_to(cr, rc.l + 1, rc.t + 4);
    cairo_close_path(cr);

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
    cairo_pattern_t* crp = cairo_pattern_create_linear(rc.l, rc.t, rc.r, rc.b);
#if USE_ALPHA_BTN
    cairo_pattern_add_color_stop_rgba(crp, 0.f, pc0.r, pc0.g, pc0.b, pc0.a);
    cairo_pattern_add_color_stop_rgba(crp, 1.f, pc1.r, pc1.g, pc1.b, pc1.a);
#else
    cairo_pattern_add_color_stop_rgb(crp, 0.f, pc0.r, pc0.g, pc0.b);
    cairo_pattern_add_color_stop_rgb(crp, 1.f, pc1.r, pc1.g, pc1.b);
#endif
    cairo_set_source(cr, crp);
#else//USE_PATTERN_BTN
#if USE_ALPHA_BTN
    cairo_set_source_rgba(cr, pc0.r, pc0.g, pc0.b, .75f);
#else
    cairo_set_source_rgb(cr, pc0.r, pc0.g, pc0.b);
#endif
#endif//USE_PATTERN_BTN
    cairo_fill_preserve(cr);

    ExCairo::Color lc; // line color
    if (widget->getFlags(Ex_Focused)) {
        lc.setv(64, 255, 64, 255);
    } else if (widget->getFlags(Ex_ButPressed)) {
        lc.setv(255, 255, 255, 255);
    } else {
        uint32 c = ((uint)widget) & 0xffffff;
        lc.setv(ExRValue(c), ExGValue(c), ExBValue(c), 255);
    }
    cairo_set_line_width(cr, widget->getFlags(Ex_Focused) ? 3.6f : 1.2f);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
#if USE_ALPHA_BTN
    cairo_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
#else
    cairo_set_source_rgb(cr, lc.r, lc.g, lc.b);
#endif
    cairo_stroke(cr);

    const wchar* text = widget->getName();
    cr.set_font(canvas->crf[0], 12.f);
    cr.show_text(text, ExCairo::Color(0.f), rc);

#if USE_PATTERN_BTN
    cairo_pattern_destroy(crp);
#endif//USE_PATTERN_BTN
}

void WndMain::onDrawPane(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->getRect());

    cairo_new_path(cr);
    cairo_move_to(cr, rc.l + 4, rc.t + 1);
    cairo_line_to(cr, rc.r - 4, rc.t + 1);
    cairo_line_to(cr, rc.r - 1, rc.t + 4);
    cairo_line_to(cr, rc.r - 1, rc.b - 4);
    cairo_line_to(cr, rc.r - 4, rc.b - 1);
    cairo_line_to(cr, rc.l + 4, rc.b - 1);
    cairo_line_to(cr, rc.l + 1, rc.b - 4);
    cairo_line_to(cr, rc.l + 1, rc.t + 4);
    cairo_close_path(cr);

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
    cairo_pattern_t* crp = cairo_pattern_create_linear(rc.l, rc.t, rc.r, rc.b);
    if (widget->isOpaque()) {
        cairo_pattern_add_color_stop_rgb(crp, 0.f, pc0.r, pc0.g, pc0.b);
        cairo_pattern_add_color_stop_rgb(crp, 1.f, pc1.r, pc1.g, pc1.b);
    } else {
        cairo_pattern_add_color_stop_rgba(crp, 0.f, pc0.r, pc0.g, pc0.b, pc0.a);
        cairo_pattern_add_color_stop_rgba(crp, 1.f, pc1.r, pc1.g, pc1.b, pc1.a);
    }
    cairo_set_source(cr, crp);
#else//USE_PATTERN_BTN
    if (widget->isOpaque())
        cairo_set_source_rgb(cr, pc1.r, pc1.g, pc1.b);
    else
        cairo_set_source_rgba(cr, pc1.r, pc1.g, pc1.b, pc1.a);
#endif//USE_PATTERN_BTN
    cairo_fill_preserve(cr);

    ExCairo::Color lc; // line color
    if (widget->getFlags(Ex_Focused)) {
        lc.setv(160, 255, 160, 224);
    } else {
        lc.setv(160, 160, 160, 128);
    }
    cairo_set_line_width(cr, widget->getFlags(Ex_Focused) ? 3.f : 1.f);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
    if (widget->isOpaque())
        cairo_set_source_rgb(cr, lc.r, lc.g, lc.b);
    else
        cairo_set_source_rgba(cr, lc.r, lc.g, lc.b, lc.a);
    cairo_stroke(cr);

#if USE_PATTERN_BTN
    cairo_pattern_destroy(crp);
#endif//USE_PATTERN_BTN
}

void WndMain::onDrawToy(ExCanvas* canvas, const WndMain* w, const ExRegion* damage) {
    static const float fs = 16.; // font_size
    static const wchar* strtbl[2] = {
        L"ExeCUnix Project for the Embedded Unix",
        L"C.H Park <execunix@gmail.com>"
    };

    ExRect rc = w->getRect();

    cairo_status_t status;
    cairo_matrix_t font_matrix, ctm;
    cairo_matrix_init_scale(&ctm, fs, fs);
    cairo_matrix_init_scale(&font_matrix, fs, fs);
    cairo_font_options_t* options = cairo_font_options_create();
    cairo_glyph_t* glyphs = NULL;
    int& textId = (int&)toy.userdata;
    const wchar* str = strtbl[textId % 2];
    int num_glyphs = 0;
    int len = wcslen(str);
    float delta = rc.height()/2 * .9f;
    cairo_scaled_font_t* scaled_font = cairo_scaled_font_create(canvas->crf[1],
        &font_matrix, &ctm, options);
    status = cairo_scaled_font_text_to_glyphs(scaled_font, 0, 0, str, len,
        &glyphs, &num_glyphs, NULL, NULL, NULL);
    if (status == CAIRO_STATUS_SUCCESS) {
        for (int i = 0; i < num_glyphs; i++) {
            glyphs[i].y += toy_delta * (i % 2 ? delta : -delta);
            glyphs[i].x *= toy_scale;
        }
        ExPoint p = rc.center();
        float w = glyphs[num_glyphs - 1].x + fs / 2.f;
        ExCairo cr(canvas, damage);
        cairo_translate(cr, p.x - w / 2.f, p.y + fs / 2.f);
        cr.set_font(canvas->crf[1], fs);
        cairo_set_source_rgba(cr, 1, 1, 1, toy_alpha);
        cairo_show_glyphs(cr, glyphs, num_glyphs);
        cairo_glyph_free(glyphs);
    }
    cairo_scaled_font_destroy(scaled_font);
    cairo_font_options_destroy(options);
}

int WndMain::onTimerToy(WndMain* wnd, ExCbInfo* cbinfo) {
    int& cnt = (int&)timerToy.userdata;
    int& textId = (int&)toy.userdata;
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
        toy_delta = (floatt)(cos(n * 2 / M_PI) * (40 - n) / 40.);
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
        ExCairo::Rect rc(w->getRect());
        cairo_set_source_surface(cr, wndBackBuf.canvas->gc->crs, rc.l, rc.t);
        cairo_paint_with_alpha(cr, .75); // for alpha blend
        return;
    }
    if (w == &wndBackBuf &&
        imgBkgd1.crs) { // draw to wndBackBuf canvas
        ExCairo cr(canvas, damage);
        ExCairo::Point pt(-backBufCnt, -backBufCnt);
        cairo_set_source_surface(cr, imgBkgd1.crs, 1.5f * pt.x, pt.y);
        cairo_paint_with_alpha(cr, .75); // for alpha blend
        return;
    }
}

int WndMain::onLayout(WndMain* widget, ExCbInfo* cbinfo) {
    dprintf(L"%s(%s) %d (%d,%d-%dx%d)\n", __funcw__, widget->getName(),
            cbinfo->subtype, widget->area.x, widget->area.y, widget->area.w, widget->area.h);
    ExArea ar(0, 0, widget->area.w, widget->area.h);
    if (widget == this) {
        wgtTitle.layout(ExArea(ar.x, ar.y, ar.w, 36));
        ar.offset(0, 36, 0, 0);
        wgtMenu.layout(ExArea(ar.x, ar.y, ar.w, 30));
        ar.offset(0, 30, 0, 0);
        ar.inset(16, 16);
        ExArea a0(ar.x, ar.y, ar.w, ar.h * 12 / 100); a0.y += (ar.h * 88 / 100);
        ExArea a1(ar.x, ar.y, ar.w * 18 / 100, ar.h * 84 / 100);
        ExArea a2(ar.x, ar.y, ar.w * 18 / 100, ar.h * 84 / 100); a2.x += (ar.w * 82 / 100);
        panes[0].layout(a0); // do recurs here
        panes[1].layout(a1); // do recurs here
        panes[2].layout(a2); // do recurs here
        toy.setPos(ExPoint(ar.center().x - toy.area.w / 2,
                           ar.center().y - toy.area.h / 2));
    } else if (widget == &panes[0]) {
        float margin_w = ar.w * 2 / 100.f; // 2 %
        float margin_h = ar.h * 8 / 100.f; // 8 %
        ar.inset((int)margin_w, (int)margin_h);
        float gap_x = ar.w * 3 / 100.f; // 3 %
        float grid_x = (ar.w + gap_x) / 5;
        float p_x = (float)ar.x;
        ExSize sz((int)(grid_x - gap_x), ar.h);
        for (int i = 0; i < 5; i++) {
            btns0[i].layout(ExArea(ExPoint((int)p_x, ar.y), sz));
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
            btns[i].layout(ExArea(ExPoint(ar.x, (int)p_y), sz));
            p_y += grid_y;
        }
    }
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

int WndMain::onActMain(WndMain* widget, ExCbInfo* cbinfo) {
    if (widget == this) {
        static ExPoint but_pt(0);
        MSG& msg = cbinfo->event->msg;
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg.pt; // memory press point
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            img_pt0 += (msg.pt - but_pt);
            but_pt = msg.pt;
            damage();
        }
        return Ex_Continue;
    } else if (widget == &panes[0]) {
        static ExPoint but_pt(0);
        MSG& msg = cbinfo->event->msg;
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg.pt; // memory press point
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            ExPoint pt = widget->area.pos;
            pt += (msg.pt - but_pt);
            but_pt = msg.pt;
            widget->setPos(pt);
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WndMain::onActBkgd(WndMain* widget, ExCbInfo* cbinfo) {
    if (widget == &wgtBkgd) {
        static ExPoint but_pt(0);
        MSG& msg = cbinfo->event->msg;
        if (cbinfo->type == Ex_CbButPress) {
            but_pt = msg.pt; // memory press point
            widget->toFront();
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            ExPoint pt(wgtBkgd.area.pos);
            pt += (msg.pt - but_pt);
            but_pt = msg.pt;
            wgtBkgd.setPos(pt);
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

static int STDCALL
onEnum(void* data, ExWidget* widget, ExCbInfo* cbinfo) {
    if (cbinfo->type == Ex_CbEnumEnter) {
        dprintf(L"enum: %s enter\n", widget->getName());
        return (widget->getFlags(Ex_Visible)) ? Ex_Continue : Ex_Discard;
    }
    if (cbinfo->type == Ex_CbEnumLeave) {
        dprintf(L"enum: %s leave\n", widget->getName());
        return (widget->getFlags(Ex_Visible)) ? Ex_Continue : Ex_Discard;
    }
    dprintf(L"enum: %s invalid *****************\n", widget->getName());
    return Ex_Break;
}

int WndMain::onActBtns(ExWidget* widget, ExCbInfo* cbinfo) {
    dprint0(L"WndMain::onActBtns %s %d %d\n",
            widget->getName(), cbinfo->type, cbinfo->subtype);
    if (cbinfo->type == Ex_CbButPress) {
        giveFocus(widget);
    }
    if (widget == &btns0[0]) {
        if (cbinfo->type == Ex_CbActivate) {
            dprintf(L"*** enumBackToFront\n");
            enumBackToFront(this, this, ExCallback(onEnum, (void*)NULL), NULL);
            dprintf(L"*** enumFrontToBack\n");
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
            panes[2].setPos(panes[2].area.pos);
            dprintf(L"repeat left %d\n", cbinfo->subtype);
            return Ex_Continue;
        }
    }
    if (widget == &btns0[3]) {
        if ((cbinfo->type == Ex_CbActivate && cbinfo->subtype == 0) ||
            cbinfo->type == Ex_CbButRepeat) {
            panes[2].area.x += 10;
            panes[2].setPos(panes[2].area.pos);
            dprintf(L"repeat right %d\n", cbinfo->subtype);
            return Ex_Continue;
        }
    }
    if (widget == &btns0[4]) {
        if (cbinfo->type == Ex_CbActivate) {
            dprintf(L"Ex_Halt\n");
            return Ex_Halt;
        }
    }
    if (widget == &btns1[0]) {
        if (cbinfo->type == Ex_CbActivate) {
            (int&)timer.userdata = !(int&)timer.userdata;
            if (timer.userdata)
                timer.start(100, 25);
            else
                timer.stop();
            return Ex_Continue;
        }
    }
    if (widget == &btns1[4]) {
        if (cbinfo->type == Ex_CbButRepeat) {
            dprintf(L"Ex_CbButRepeat %d\n", cbinfo->subtype);
            return Ex_Continue;
        }
    }
    if (widget == &btns1[5]) {
        if (cbinfo->type == Ex_CbActivate) {
            if (!exDrawFuncTrap) {
                exDrawFuncTrap = ExDrawFunc(this, &WndMain::onDrawTrap);
            } else {
                exDrawFuncTrap = ExDrawFunc(NULL, NULL);
                damage();
            }
            return Ex_Continue;
        }
    }
    return Ex_Continue;
}

int WndMain::onTimer(ExTimer* timer, ExCbInfo* cbinfo)
{
    int dx = state ? -2 : 2;
    int dy = state ? -1 : 1;
    panes[1].area.x += dx;
    panes[1].area.y += dy;
    dprint0(L"%s: %d,%d\n", __funcw__, panes[1].area.x, panes[1].area.y);
    if (state == 0 && panes[1].area.y > 480 ||
        state != 0 && panes[1].area.y < 0)
        state = !state;
    panes[1].setPos(panes[1].area.pos);
    return Ex_Continue;
}

static ExInput* inp1;
static ExInput* inp2;
static HANDLE hWakeupNoti;
static HANDLE hStorageNoti;

int WndMain::initInput() {
    static ExTimer launchInputTimer;
    launchInputTimer.setCallback([](void* d, ExTimer* t, ExCbInfo*)->int {
        dprintf(L"launchInputTimer: %d\n", exTickCount);

        hWakeupNoti = CreateEvent(NULL, FALSE, FALSE, L"AppDemo"); // tbd
        inp1 = ExInput::add(hWakeupNoti, [](void* d, ExInput* input, ExCbInfo* cbinfo)->int {
            dprintf(L"hWakeupNoti signaled...\n");
            return Ex_Continue; }, NULL);

        hStorageNoti = FindFirstChangeNotification(L"\\", TRUE, FILE_NOTIFY_CHANGE_DIR_NAME);
        inp2 = ExInput::add(hStorageNoti, [](void* d, ExInput* input, ExCbInfo* cbinfo)->int {
            dprintf(L"hStorageNoti root fs changed...\n");
            FindNextChangeNotification(hStorageNoti);
            return Ex_Continue; }, NULL);

        static ExTimer signalInputTimer;
        signalInputTimer.setCallback([](void* d, ExTimer* t, ExCbInfo*)->int {
            ((int&)t->userdata)++;
            // emulate initial state.
            if (!(((int&)t->userdata) % 5))
                SetEvent(hWakeupNoti);
            return Ex_Continue; }, NULL);
        signalInputTimer.start(1, 1000);
        return Ex_Continue; }, NULL);
    launchInputTimer.start(1000);
    return 0;
}

int WndMain::initCanvas() {
    canvas = new ExCanvas;
    canvas->init(this, &ExApp::smSize);

    char faceName[256];
    sprintf(faceName, "%S/%s", respath, "NanumGothic.ttf");
    if (canvas->newFace(0, faceName) != 0)
        return -1;
    sprintf(faceName, "%S/%s", respath, "NanumGothicBold.ttf");
    if (canvas->newFace(1, faceName) != 0)
        return -1;
    return 0;
}

int WndMain::initBtn(ExWidget* parent, ExWidget* btn, const wchar* name) {
    btn->init(parent, name, NULL);
    //btn->setFlags(Ex_Opaque); // test
    btn->setFlags(Ex_FocusRender);
    btn->setFlags(Ex_Selectable | Ex_AutoHighlight);
    btn->drawFunc = ExDrawFunc(this, &WndMain::onDrawBtns);
    btn->addCallback(this, &WndMain::onActBtns, Ex_CbActivate);
    return 0;
}

int WndMain::onDestroyed(WndMain* w, ExCbInfo* cbinfo) {
    dprintf(L"%s()\n", __funcw__);
    assert(w == this);
    timerToy.stop();
    timer.stop();
    return Ex_Continue;
}

int WndMain::onRbtnDown(WndMain* w, ExCbInfo* cbinfo) {
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

int WndMain::onHandler(WndMain* w, ExCbInfo* cbinfo) {
    dprintf(L"handler WM_0x%04x:0x%04x\n", cbinfo->event->message, cbinfo->event->msg.message);
    return Ex_Continue;
}

int WndMain::onFilter(WndMain* w, ExCbInfo* cbinfo) {
    dprintf(L"filter WM_0x%04x\n", cbinfo->event->message);
    static int i = 0;
    ++i;
    if (i == 20) {
        removeHandler(ExCallback(this, &WndMain::onHandler));
    } else if (i == 40) {
        PostMessage(w->getHwnd(), WM_APP_TEST, 0, 0);
        addHandler(this, &WndMain::onHandler);
        i = 0;
    }
    if (cbinfo->event->message == WM_KEYDOWN) {
        switch (cbinfo->event->wParam) {
            case VK_UP:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_UP");
                moveFocus(Ex_DirUp);
                break;
            case VK_DOWN:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_DOWN");
                moveFocus(Ex_DirDown);
                break;
            case VK_LEFT:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_LEFT");
                moveFocus(Ex_DirLeft);
                break;
            case VK_RIGHT:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_RIGHT");
                moveFocus(Ex_DirRight);
                break;
            case VK_SPACE:
            case VK_RETURN:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_RETURN");
                wgtFocused->invokeCallback(Ex_CbActivate, &ExCbInfo(Ex_CbActivate, 0, event));
                break;
            case VK_ESCAPE:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_ESCAPE");
                return Ex_Halt;
            case VK_HOME:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_HOME");
                moveFocus(Ex_DirHome);
                break;
            case VK_BACK:
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_BACK");
                moveFocus(Ex_DirBack);
                break;
            case VK_TAB: {
                dprintf(L"0x%04x %s\n", cbinfo->event->message, L"VK_TAB");
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
        dprintf(L"Where did the focus go?\n");
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

int WndMain::onFocused(WndMain* widget, ExCbInfo* cbinfo) {
    static ExWidget* losted[3] = { NULL, };
    if (cbinfo->type == Ex_CbLostFocus) {\
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
    ExRect clip(updateRgn->extent);
    clip.move(wgtBackViewer.getRect().ul);
    wgtBackViewer.damage(clip);
#endif
}

int WndMain::onBackViewMove(WndMain* widget, ExCbInfo* cbinfo) {
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
        ExPoint pt(wgtBackViewer.area.pos);
        pt.x += xPos - but_pt.x;
        pt.y += yPos - but_pt.y;
        but_pt.set(xPos, yPos);
        wgtBackViewer.setPos(pt);
    }
    return Ex_Continue;
}

int WndMain::onBackBufUpdater(ExTimer* timer, ExCbInfo* cbinfo) {
    backBufCnt++;
    if (backBufCnt > 500)
        backBufCnt = 0;
    ExArea ar = wgtBackBtn.area;
    if (ar.pos.x++ > 180)
        ar.pos.x = 0;
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
    this->init(L"WndMain", 1280, 720);

    struct _stat statbuf;
    swprintf(respath, L"%s/res", exModulePath);
    if (_wstat(respath, &statbuf))
        swprintf(respath, L"%s/../../res", exModulePath);

    if (initCanvas() != 0) {
        return -1;
    }
    wchar fname[256];
    swprintf(fname, L"%s/%s", respath, L"S01090.bmp");
    if (imgBkgd0.load(fname) != 0) {
        dprintf(L"%s: imgBkgd0.load(%s) fail\n", __funcw__, fname);
        return -1;
    }
    swprintf(fname, L"%s/%s", respath, L"S01051.PNG");
    if (imgBkgd1.load(fname) != 0) {
        dprintf(L"%s: imgBkgd1.load(%s) fail\n", __funcw__, fname);
        return -1;
    }

    ExApp::mainWnd = this;

    backBufCnt = 0;
    img_pt0.set(0, 0);

    drawFunc = ExDrawFunc(&::onDrawBkgd, this); // test
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

    wgtBkgd.init(this, L"imgBkgd1", &ExArea(300, 300, imgBkgd1.width, imgBkgd1.height));
    wgtBkgd.addCallback(this, &WndMain::onActBkgd, Ex_CbActivate);
    wgtBkgd.drawFunc = ExDrawFunc(this, &WndMain::onDrawBkgd);
    wgtBkgd.setFlags(Ex_Selectable);
    //wgtBkgd.setFlags(Ex_Opaque);
    FLUSH_TEST();
    // ==> render() #2

    addCallback(this, &WndMain::onDestroyed, Ex_CbDestroyed);
    addCallback(&onUnrealized, this, Ex_CbUnrealized);
    addCallback(&onRealized, this, Ex_CbRealized);
    addCallback(this, &WndMain::onLayout, Ex_CbLayout);
    addCallback(this, &WndMain::onFocused, Ex_CbGotFocus);
    addCallback(this, &WndMain::onActMain, Ex_CbActivate);
    addCallback([](void* data, ExWidget* widget, ExCbInfo* cbinfo)->int {
        dprintf(L"%s Activate %d,%d\n", widget->getName(), cbinfo->type, cbinfo->subtype);
        return Ex_Continue; }, this, Ex_CbActivate);

    panes[0].init(this, L"pan0", &ExArea(20, 400, 760, 60));
    panes[1].init(this, L"pan1", &ExArea(20, 20, 120, 360));
    panes[2].init(this, L"pan2", &ExArea(660, 20, 120, 360));
    panes[0].drawFunc = ExDrawFunc(this, &WndMain::onDrawPane);
    panes[1].drawFunc = ExDrawFunc(this, &WndMain::onDrawPane);
    panes[2].drawFunc = ExDrawFunc(this, &WndMain::onDrawPane);
    panes[0].addCallback(this, &WndMain::onLayout, Ex_CbLayout);
    panes[1].addCallback(this, &WndMain::onLayout, Ex_CbLayout);
    panes[2].addCallback(this, &WndMain::onLayout, Ex_CbLayout);
    panes[0].addCallback(this, &WndMain::onFocused, Ex_CbGotFocus);
    panes[1].addCallback(this, &WndMain::onFocused, Ex_CbGotFocus);
    panes[2].addCallback(this, &WndMain::onFocused, Ex_CbGotFocus);
    panes[0].addCallback(this, &WndMain::onFocused, Ex_CbLostFocus);
    panes[1].addCallback(this, &WndMain::onFocused, Ex_CbLostFocus);
    panes[2].addCallback(this, &WndMain::onFocused, Ex_CbLostFocus);
    panes[0].setFlags(Ex_FocusRender);
    panes[1].setFlags(Ex_FocusRender);
    panes[2].setFlags(Ex_FocusRender);

    panes[0].addCallback(this, &WndMain::onActMain, Ex_CbActivate);
    panes[0].setFlags(Ex_Selectable);
#if 1
    ExRect opaqRect = panes[0].getRect();
    opaqRect.l += 8;
    opaqRect.r -= 8;
    panes[0].setOpaqueRegion(ExRegion(opaqRect));
#else
    panes[0].setFlags(Ex_Opaque);
#endif
    panes[2].setFlags(Ex_Visible, Ex_BitFalse);
    FLUSH_TEST();

    initBtn(&panes[0], &btns0[0], L"btns0-0");
    initBtn(&panes[0], &btns0[1], L"btns0-1");
    initBtn(&panes[0], &btns0[2], L"btns0-2");
    initBtn(&panes[0], &btns0[3], L"btns0-3");
    initBtn(&panes[0], &btns0[4], L"btns0-4");

    initBtn(&panes[1], &btns1[0], L"btns1-0");
    initBtn(&panes[1], &btns1[1], L"btns1-1");
    initBtn(&panes[1], &btns1[2], L"btns1-2");
    initBtn(&panes[1], &btns1[3], L"btns1-3");
    initBtn(&panes[1], &btns1[4], L"btns1-4");
    initBtn(&panes[1], &btns1[5], L"btns1-5");

    initBtn(&panes[2], &btns2[0], L"btns2-0");
    initBtn(&panes[2], &btns2[1], L"btns2-1");
    initBtn(&panes[2], &btns2[2], L"btns2-2");
    initBtn(&panes[2], &btns2[3], L"btns2-3");
    initBtn(&panes[2], &btns2[4], L"btns2-4");
    initBtn(&panes[2], &btns2[5], L"btns2-5");

    FLUSH_TEST();

    timer.setCallback(this, &WndMain::onTimer);

    static ExTimer timerTest;
    timerTest.setCallback([](void* d, ExWidget* w, ExCbInfo*)->int {
        dprintf(L"timerTest: %s\n", w->getName());
        return Ex_Continue; }, (void*)0, this); // test
    timerTest.setCallback([](void* d, ExTimer* t, ExCbInfo*)->int {
        dprintf(L"timerTest: %d %u %u\n", ((int&)t->userdata)++, (ulong)*t, exTickCount);
        return Ex_Continue; }, (void*)0);
    timerTest.start(1, 1000);

    toy_alpha = .2f;
    toy_delta = 1.f;
    toy_scale = 1.f;
    (int&)toy.userdata = 0;
    toy.drawFunc = ExDrawFunc(this, &WndMain::onDrawToy);
    toy.init(this, L"toy", &ExArea(360, 300, 600, 80));

    (int&)timerToy.userdata = 0;
    timerToy.setCallback(this, &WndMain::onTimerToy, this);
    timerToy.start(1, 50); // 20Hz

    addFilter(this, &WndMain::onFilter);
    addHandler(this, &WndMain::onHandler);
    addHandler(this, &WndMain::onRbtnDown);

    wndBackBuf.init(L"wndBackBuf", 360, 240);
    wndBackBuf.canvas = new ExCanvas;
    wndBackBuf.canvas->init(&wndBackBuf);
    wndBackBuf.flushFunc = ExFlushFunc(this, &WndMain::onFlushBackBuf);
    wgtBackBtn.init(&wndBackBuf, L"wgtBackBtn", &ExArea(20, 20, 120, 40));
    wndBackBuf.drawFunc = ExDrawFunc(this, &WndMain::onDrawBackBuf);
    wgtBackBtn.drawFunc = ExDrawFunc(this, &WndMain::onDrawBtns);
    wndBackBuf.flush();

    wgtBackViewer.init(this, L"wgtBackViewer", &ExArea(80, 40, 360, 240));
    wgtBackViewer.addCallback(this, &WndMain::onBackViewMove, Ex_CbActivate);
    wgtBackViewer.drawFunc = ExDrawFunc(this, &WndMain::onDrawBackBuf);
    wgtBackViewer.setFlags(Ex_Selectable);

    backBufUpdater.setCallback(this, &WndMain::onBackBufUpdater);
    backBufUpdater.start(1, 25); // 40Hz

    initInput();

    wgtMenu.init(this);
    wgtTitle.init(this);

#if DISP_AT_ONCE
    addFilter([](void* data, ExWindow* window, ExCbInfo* cbinfo)->int {
        dprintf(L"[%s] WM_0x%04x\n", window->getName(), cbinfo->event->message);
        if (cbinfo->event->message == WM_CREATE) {
            cbinfo->event->lResult = 0;
            ExRect rc;
            GetClientRect(cbinfo->event->hwnd, rc);
            dprintf(L"GetClientRect %d,%d-%d,%d\n",
                    rc.l, rc.t, rc.r, rc.b);
            window->layout(ExArea(rc));
            // To remove an anonymous callback, simply return Ex_Remove.
            return Ex_Break | Ex_Remove;
        }
#if 0 // window caption remove or change
        if (cbinfo->event->message == WM_NCCALCSIZE) {
            RECT* rc = (RECT*)cbinfo->event->lParam;
            //NCCALCSIZE_PARAMS* rc = (NCCALCSIZE_PARAMS*)lParam;
            dprintf(L"[0x%p] WM_NCCALCSIZE wParam=%d %d,%d-%d,%d\n",
                    cbinfo->event->hwnd, cbinfo->event->wParam,
                    rc->left, rc->top, rc->right, rc->bottom);
            //rc->top += 31;
            //rc->left += 8;
            //rc->right -= 8;
            //rc->bottom -= 8;
            cbinfo->event->lResult = 0;
            return Ex_Break;
        }
#endif
        return Ex_Continue; }, this);
    showWindow(0, WS_OVERLAPPEDWINDOW | WS_VISIBLE);
    return 0;
#else
    layout(area);
    return damage();
#endif
}

