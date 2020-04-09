//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include "wndmain.h"
#define _USE_MATH_DEFINES
#include <math.h>

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
        ExRect rc = widget->getRect();
        if (widget->isOpaque()) {
            for (int i = 0; i < damage->n_rects; i++) {
                ExRect& dr = damage->rects[i];
                canvas->gc->blitRgb(dr.l, dr.t, dr.width(), dr.height(),
                                    &imgBkgd1, dr.l - rc.l, dr.t - rc.t);
            }
        } else if (imgBkgd1.crs) {
#if 1
            cairo_t* cr = canvas->cr;
            cairo_save(cr);
            canvas->setRegion(damage);
            cairo_clip(cr);
            cairo_set_source_surface(cr, imgBkgd1.crs, rc.l, rc.t);
            cairo_paint_with_alpha(cr, .75); // for alpha blend
            //cairo_paint(cr); // for opaque
            cairo_restore(cr);
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
    static uint color[5] = { 0, 0xff, 0xff00, 0xff0000, 0xffffff };
    for (int i = 0; i < damage->n_rects; i++) {
        ExRect& rc = damage->rects[i];
        canvas->gc->drawRect(&rc, color[id]);
    }
    id = (id < 4) ? id + 1 : 0;
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

#define USE_PATTERN_BTN 1
#define USE_ALPHA_BTN 1

void WndMain::onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
#if 0
    if (widget == &wgtBackBtn) {
        ExColor color = ExARGB(189, 77, 77, 0);
        canvas->gc->fillRect(&widget->getExtent(), color);
        return;
    }
#endif
    cairo_t* cr = canvas->cr;
    ExRect rc = widget->getRect();
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);
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
    uint color = ((uint)widget) & 0xffffff;
    double rvalue = ExRValue(color) / 255.;
    double gvalue = ExGValue(color) / 255.;
    double bvalue = ExBValue(color) / 255.;
#if USE_PATTERN_BTN
    cairo_pattern_t* crp = cairo_pattern_create_linear(rc.l, rc.t, rc.r, rc.b);
#if USE_ALPHA_BTN
    const double alpha = .75;
    if (widget->getFlags(Ex_PtrEntered)) {
        cairo_pattern_add_color_stop_rgba(crp, 1, 64 / 255., 128 / 255., 128 / 255., alpha);
        cairo_pattern_add_color_stop_rgba(crp, 0, 224 / 255., 224 / 255., 224 / 255., 1);
    } else {
        cairo_pattern_add_color_stop_rgba(crp, 1, 16 / 255., 64 / 255., 64 / 255., alpha);
        cairo_pattern_add_color_stop_rgba(crp, 0, 128 / 255., 128 / 255., 128 / 255., 1);
    }
#else
    if (widget->getFlags(Ex_PtrEntered)) {
        cairo_pattern_add_color_stop_rgb(crp, 1, 64 / 255., 128 / 255., 128 / 255.);
        cairo_pattern_add_color_stop_rgb(crp, 0, 224 / 255., 224 / 255., 224 / 255.);
    } else {
        cairo_pattern_add_color_stop_rgb(crp, 1, 16 / 255., 64 / 255., 64 / 255.);
        cairo_pattern_add_color_stop_rgb(crp, 0, 128 / 255., 128 / 255., 128 / 255.);
    }
#endif
    cairo_set_source(cr, crp);
#else//USE_PATTERN_BTN
#if USE_ALPHA_BTN
    const double alpha = .75;
    if (widget->getFlags(Ex_PtrEntered))
        cairo_set_source_rgba(cr, 112 / 255., 224 / 255., 224 / 255., alpha);
    else
        cairo_set_source_rgba(cr, 64 / 255., 128 / 255., 128 / 255., alpha);
#else
    if (widget->getFlags(Ex_PtrEntered))
        cairo_set_source_rgb(cr, 112 / 255., 224 / 255., 224 / 255.);
    else
        cairo_set_source_rgb(cr, 64 / 255., 128 / 255., 128 / 255.);
#endif
#endif//USE_PATTERN_BTN
    cairo_fill_preserve(cr);
    cairo_set_line_width(cr, 1.2);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
#if USE_ALPHA_BTN
    if (widget->getFlags(Ex_ButPressed))
        cairo_set_source_rgba(cr, rvalue, gvalue, bvalue, alpha);
    else
        cairo_set_source_rgba(cr, rvalue, gvalue, bvalue, alpha);
#else
    if (widget->getFlags(Ex_ButPressed))
        cairo_set_source_rgb(cr, rvalue, gvalue, bvalue);
    else
        cairo_set_source_rgb(cr, rvalue, gvalue, bvalue);
#endif
    cairo_stroke(cr);

    const wchar* text = widget->getName();
    cairo_set_font_face(cr, canvas->crf[0]);
    cairo_set_font_size(cr, 12);
    cairo_text_extents_t extents;
    cairo_text_extents(cr, text, &extents);
    cairo_move_to(cr, rc.l - extents.x_bearing, rc.t - extents.y_bearing);
    cairo_set_source_rgb(cr, 0, 0, 0);
    cairo_show_text(cr, text);

    cairo_restore(cr);
#if USE_PATTERN_BTN
    cairo_pattern_destroy(crp);
#endif//USE_PATTERN_BTN
}

void WndMain::onDrawPane(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) {
#if 0
    ExColor color = 0;
    if (widget == &panes[0]) color = ExARGB(189, 177, 77, 77);
    else if (widget == &panes[1]) color = ExARGB(189, 77, 177, 77);
    else if (widget == &panes[2]) color = ExARGB(189, 77, 77, 177);
    canvas->gc->fillRect(&widget->getExtent(), color);
#endif
    cairo_t* cr = canvas->cr;
    ExRect rc = widget->getRect();
    cairo_save(cr);
    canvas->setRegion(damage);
    cairo_clip(cr);

    int r = 77, g = 77, b = 77;
    if (widget == &panes[0]) r = 177;
    else if (widget == &panes[1]) g = 177;
    else if (widget == &panes[2]) b = 177;

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

    const double alpha = .5;
#if 1//USE_PATTERN_BTN
    cairo_pattern_t* crp = cairo_pattern_create_linear(rc.l, rc.t, rc.r, rc.b);
    if (widget->isOpaque()) {
        cairo_pattern_add_color_stop_rgb(crp, 1, r / 255., g / 255., b / 255.);
        cairo_pattern_add_color_stop_rgb(crp, 0, 128 / 255., 128 / 255., 128 / 255.);
    } else {
        cairo_pattern_add_color_stop_rgba(crp, 1, r / 255., g / 255., b / 255., alpha);
        cairo_pattern_add_color_stop_rgba(crp, 0, 128 / 255., 128 / 255., 128 / 255., 1);
    }
    cairo_set_source(cr, crp);
#else
    if (widget->isOpaque())
        cairo_set_source_rgb(cr, r / 255., g / 255., b / 255.);
    else
        cairo_set_source_rgba(cr, r / 255., g / 255., b / 255., alpha);
#endif
    cairo_fill_preserve(cr);
    cairo_set_line_width(cr, 1.);
    cairo_set_line_join(cr, CAIRO_LINE_JOIN_ROUND);
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND);
    cairo_set_antialias(cr, CAIRO_ANTIALIAS_GRAY);
    if (widget->isOpaque())
        cairo_set_source_rgb(cr, 160 / 255., 160 / 255., 160 / 255.);
    else
        cairo_set_source_rgba(cr, 160 / 255., 160 / 255., 160 / 255., alpha);
    cairo_stroke(cr);

    cairo_restore(cr);
#if 1//USE_PATTERN_BTN
    cairo_pattern_destroy(crp);
#endif
}

void WndMain::onDrawToy(ExCanvas* canvas, const WndMain* w, const ExRegion* damage) {
    static const double fs = 16.; // font_size
    static const wchar* strtbl[2] = {
        L"ExeCUnix Project for the Embedded Unix",
        L"C.H Park <execunix@gmail.com>"
    };

    cairo_t* cr = canvas->cr;
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
    double delta = rc.height()/2 * .9;
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
        double w = glyphs[num_glyphs - 1].x + fs / 2.;
        cairo_save(cr);
        canvas->setRegion(damage);
        cairo_clip(cr);
        cairo_translate(cr, p.x - w / 2., p.y + fs / 2.);
        cairo_set_font_face(cr, canvas->crf[1]);
        cairo_set_font_size(cr, fs);
        cairo_set_source_rgba(cr, 1, 1, 1, toy_alpha);
        cairo_show_glyphs(cr, glyphs, num_glyphs);
        cairo_glyph_free(glyphs);
        cairo_restore(cr);
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
        toy_alpha = .2;
        toy_delta = 1.;
        toy_scale = 1.;
    } else if (n <= 40) {
        toy_alpha = .2 + .8 * n / 40.;
        toy_delta = cos(n * 2 / M_PI) * (40 - n) / 40.;
    } else if (n <= 60) {
        return Ex_Continue;
    } else {
        n -= 60;
        toy_alpha = 1. - n / 40.;
        toy_scale = 1. + n / 20.;
    }
    toy.damage();
    return Ex_Continue;
}

void WndMain::onDrawBackBuf(ExCanvas* canvas, const ExWidget* w, const ExRegion* damage) {
    if (w == &wgtBackViewer &&
        wndBackBuf.canvas->gc->crs) {
        cairo_t* cr = canvas->cr;
        const ExRect& rc = w->getRect();
        cairo_save(cr);
        canvas->setRegion(damage);
        cairo_clip(cr);
        cairo_set_source_surface(cr, wndBackBuf.canvas->gc->crs, rc.l, rc.t);
        cairo_paint_with_alpha(cr, .75); // for alpha blend
        cairo_restore(cr);
        return;
    }
    if (w == &wndBackBuf &&
        imgBkgd1.crs) { // draw to wndBackBuf canvas
        cairo_t* cr = canvas->cr;
        cairo_save(cr);
        canvas->setRegion(damage);
        cairo_clip(cr);
        cairo_set_source_surface(cr, imgBkgd1.crs, -backBufCnt, -backBufCnt);
        cairo_paint_with_alpha(cr, .75); // for alpha blend
        cairo_restore(cr);
        return;
    }
}

int WndMain::onLayout(WndMain* widget, ExCbInfo* cbinfo) {
    const ExArea* ar = (ExArea*)cbinfo->data;
    dprintf(L"%s(%s) %d (%d,%d-%dx%d)\n", __funcw__, widget->getName(),
            cbinfo->subtype, ar->x, ar->y, ar->w, ar->h);
    ExArea a(0, 0, ar->w, ar->h);
    if (cbinfo->subtype == Ex_LayoutInit) {
        if (widget == this) {
            a.inset(a.w * 2 / 100, a.h * 2 / 100);
            ExArea a0(a.x, a.y, a.w, a.h * 12 / 100); a0.y += (a.h * 88 / 100);
            ExArea a1(a.x, a.y, a.w * 18 / 100, a.h * 84 / 100);
            ExArea a2(a.x, a.y, a.w * 18 / 100, a.h * 84 / 100); a2.x += (a.w * 82 / 100);
            panes[0].layout(a0); // do recurs here
            panes[1].layout(a1); // do recurs here
            panes[2].layout(a2); // do recurs here
        } else if (widget == &panes[0]) {
            int margin_w = a.w * 2 / 100; // 2 %
            int margin_h = a.h * 8 / 100; // 8 %
            a.inset(margin_w, margin_h);
            int gap_x = a.w * 3 / 100; // 3 %
            int grid_x = (a.w + gap_x) / 5;
            ExSize sz(grid_x - gap_x, a.h);
            ExPoint pt(a.x, a.y);
            for (int i = 0; i < 5; i++) {
                btns0[i].layout(ExArea(pt, sz));
                pt.x += grid_x;
            }
        } else if (widget == &panes[1] || widget == &panes[2]) {
            int margin_w = a.w * 8 / 100; // 8 %
            int margin_h = a.h * 3 / 100; // 3 %
            a.inset(margin_w, margin_h);
            int gap_y = a.h * 4 / 100; // 4 %
            int grid_y = (a.h + gap_y) / 6;
            ExSize sz(a.w, grid_y - gap_y);
            ExPoint pt(a.x, a.y);
            ExWidget* btns = widget == &panes[1] ? btns1 : btns2;
            for (int i = 0; i < 6; i++) {
                btns[i].layout(ExArea(pt, sz));
                pt.y += grid_y;
            }
        }
    }
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
            wgtCapture = widget;
        } else if (cbinfo->type == Ex_CbPtrMove &&
                   widget->getFlags(Ex_ButPressed)) {
            img_pt1 += (msg.pt - but_pt);
            but_pt = msg.pt;
            wgtBkgd.setPos(img_pt1);
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
                timer.start(100, 33);
            else
                timer.stop();
            return Ex_Continue;
        }
    }
    if (widget == &btns1[5]) {
        if (cbinfo->type == Ex_CbButRepeat) {
            dprintf(L"Ex_CbButRepeat %d\n", cbinfo->subtype);
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

        hWakeupNoti = CreateEvent(NULL, FALSE, TRUE, L"AppDemo"); // tbd
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
            if (((int&)t->userdata) % 2)
                SetEvent(hWakeupNoti);
            else
                SetEvent(hStorageNoti);
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
        addHandler(this, &WndMain::onHandler);
        i = 0;
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
    clip.offset(wgtBackViewer.getRect().ul);
    wgtBackViewer.damage(clip);
#endif
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
#if 0//DEBUG
    exDrawFuncTrap = ExDrawFunc(this, &WndMain::onDrawTrap);
#endif
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
    img_pt1 = wgtBkgd.area.pos;
    FLUSH_TEST();
    // ==> render() #2

    addCallback(this, &WndMain::onDestroyed, Ex_CbDestroyed);
    addCallback(&onUnrealized, this, Ex_CbUnrealized);
    addCallback(&onRealized, this, Ex_CbRealized);
    addCallback(this, &WndMain::onLayout, Ex_CbLayout);
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
        dprintf(L"timerTest: %d %d\n", ((int&)t->userdata)++, exTickCount);
        return Ex_Continue; }, (void*)0);
    timerTest.start(1, 1000);

    toy_alpha = .2;
    toy_delta = 1.;
    toy_scale = 1.;
    (int&)toy.userdata = 0;
    toy.drawFunc = ExDrawFunc(this, &WndMain::onDrawToy);
    toy.init(this, L"toy", &ExArea(360, 300, 600, 80));

    (int&)timerToy.userdata = 0;
    timerToy.setCallback(this, &WndMain::onTimerToy, this);
    timerToy.start(1, 50); // 20Hz

    addFilter(this, &WndMain::onFilter);
    addHandler(this, &WndMain::onHandler);

    wndBackBuf.init(L"wndBackBuf", 360, 240);
    wndBackBuf.canvas = new ExCanvas;
    wndBackBuf.canvas->init(&wndBackBuf);
    wndBackBuf.flushFunc = ExFlushFunc(this, &WndMain::onFlushBackBuf);
    wgtBackBtn.init(&wndBackBuf, L"wgtBackBtn", &ExArea(20, 20, 120, 40));
    wndBackBuf.drawFunc = ExDrawFunc(this, &WndMain::onDrawBackBuf);
    wgtBackBtn.drawFunc = ExDrawFunc(this, &WndMain::onDrawBtns);
    wndBackBuf.flush();

    wgtBackViewer.init(this, L"wgtBackViewer", &ExArea(80, 40, 360, 240));
    wgtBackViewer.drawFunc = ExDrawFunc(this, &WndMain::onDrawBackBuf);

    backBufUpdater.setCallback(this, &WndMain::onBackBufUpdater);
    backBufUpdater.start(1, 16); // 60Hz

    initInput();

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
#if DISP_AT_ONCE
    showWindow(0, WS_OVERLAPPEDWINDOW | WS_VISIBLE);
    return 0;
#else
    layout(area);
    return damage();
#endif
}

