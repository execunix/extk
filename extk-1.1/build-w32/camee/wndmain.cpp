#include "framework.h"
#include "wndmain.h"
#include "common.h"

void WgtTitle::init(ExWindow* window)
{
    ExWidget::init(window, L"WgtTitle", &ExRect(0, 0, 800, 30));
    setTitle(res.s.title/*L"주정차검지"*/);
    setFlags(Ex_Selectable);
    addCallback(this, &WgtTitle::onLayout, Ex_CbLayout);
    drawFunc = ExDrawFunc(this, &WgtTitle::onDrawTitle);

    wgtClock.init(this, L"AM 12:34:56", NULL);
    wgtClock.drawFunc = ExDrawFunc(this, &WgtTitle::onDrawClock);

    wgtClose.init(this, L"X", NULL);
    wgtClose.setFlags(Ex_Selectable | Ex_AutoHighlight);
    wgtClose.drawFunc = ExDrawFunc(this, &WgtTitle::onDrawBtns);
    wgtClose.addCallback(this, &WgtTitle::onActBtns, Ex_CbActivate);

    wgtMinMax.init(this, L"ㅁ", NULL);
    wgtMinMax.setFlags(Ex_Selectable | Ex_AutoHighlight);
    wgtMinMax.drawFunc = ExDrawFunc(this, &WgtTitle::onDrawBtns);
    wgtMinMax.addCallback(this, &WgtTitle::onActBtns, Ex_CbActivate);
}

int WgtTitle::onLayout(ExWidget* widget, ExCbInfo* cbinfo)
{
    ExRect ar(0, 0, widget->area.w, widget->area.h);
    if (widget == this) {
        int h = ar.h;
        ar.inset(3, 3);
        int x = ar.w - ar.h;
        wgtClose.layout(ExRect(x, ar.y, ar.h, ar.h)); x -= h;
        wgtMinMax.layout(ExRect(x, ar.y, ar.h, ar.h)); x -= 300;
        wgtClock.layout(ExRect(x, ar.y, 290, ar.h));
    }
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

void WgtTitle::onDrawTitle(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());

    cr.fill_rect_rgba(rc, ExCairo::Color(.2f, .2f, .2f, .5f));

    rc.x += 48.f;
    cr.set_font(res.f.square_B.crf, rc.h * .5f);
    ExCairo::Point pt = cr.text_align(title, rc, ExCairo::Left | ExCairo::VCenter);
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

void WgtTitle::onDrawClock(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    ::onDrawBtns(NULL, canvas, widget, damage);
}

void WgtTitle::onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    ::onDrawBtns(NULL, canvas, widget, damage);
}

int WgtTitle::onActBtns(ExWidget* widget, ExCbInfo* cbinfo)
{
    if (widget == &wgtClose) {
        if (cbinfo->type == Ex_CbActivate) {
            dprintf(L"Ex_Halt\n");
            return Ex_Halt;
        }
    }
    if (widget == &wgtMinMax) {
        if (cbinfo->type == Ex_CbActivate) {
            dprintf(L"wgtMinMax\n");
            return Ex_Continue;
        }
    }
    return Ex_Continue;
}

static ExInput* inp1;
static ExInput* inp2;
static HANDLE hWakeupNoti;
static HANDLE hStorageNoti;

int WndMain::initInput()
{
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

static int STDCALL
onUnrealized(void* data, ExWidget* w, ExCbInfo* cbinfo)
{
    dprintf(L"onUnrealized()\n");
    return Ex_Continue;
}

static int STDCALL
onRealized(WndMain* data, ExWindow* w, ExCbInfo* cbinfo)
{
    dprintf(L"onRealized()\n");
    //GetLocalTime(&app.tm);
    return Ex_Continue;
}

void WndMain::onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    if (widget == this) {
#if 1
        ExRegion rgn(*damage);
        for (int i = 0; i < rgn.n_boxes; i++)
            canvas->gc->fillBox(&rgn.boxes[i], res.c.bg);
#else
        ExRegion rgn(*damage);
        rgn.subtract(ExBox(img_pt0.x, img_pt0.y, res.i.bg0.width + img_pt0.x, res.i.bg0.height + img_pt0.y));
        for (int i = 0; i < rgn.n_boxes; i++)
            canvas->gc->fillBox(&rgn.boxes[i], res.c.bg);
        if (res.i.bg0.bits) {
            for (int i = 0; i < damage->n_boxes; i++) {
                const ExBox& bx = damage->boxes[i];
                canvas->gc->blitRgb(bx.l, bx.t, bx.width(), bx.height(),
                                    &res.i.bg0, bx.l - img_pt0.x, bx.t - img_pt0.y);
            }
        }
#endif
    } else if (widget == &wgtBkgd) {
        if (!res.i.bg1.bits) return;
        if (widget->isOpaque()) {
            const ExPoint& pt = widget->calcRect().pt;
            for (int i = 0; i < damage->n_boxes; i++) {
                const ExBox& bx = damage->boxes[i];
                canvas->gc->blitRgb(bx.l, bx.t, bx.width(), bx.height(),
                                    &res.i.bg1, bx.l - pt.x, bx.t - pt.y);
            }
        } else if (res.i.bg1.crs) {
            ExCairo::Rect rc(widget->calcRect());
            ExCairo cr(canvas, damage);
            cairo_set_source_surface(cr, res.i.bg1.crs, rc.x, rc.y);
            cairo_paint_with_alpha(cr, .75); // for alpha blend
        }
    }
}

int WndMain::onLayout(ExWidget* widget, ExCbInfo* cbinfo)
{
    dprintf(L"%s(%s) %d (%d,%d-%dx%d)\n", __funcw__, widget->getName(),
            cbinfo->subtype, widget->area.x, widget->area.y, widget->area.w, widget->area.h);
    ExRect ar(0, 0, widget->area.w, widget->area.h);
    if (widget == this) {
        wgtTitle.layout(ExRect(ar.x, ar.y, ar.w, 30));
        ar.offset(0, 30, 0, 0);
        ar.inset(4, 3);

        // deploy view m x n
        const int m = env.mv.col;
        const int n = env.mv.row;
        int w = (ar.w + 4) / m;
        int h = (ar.h + 3) / n;
        for (int i = 0; i < n; i++) {
            int y = ar.y + h * i;
            for (int j = 0; j < m; j++) {
                int x = ar.x + w * j;
                camView[m * i + j].layout(ExRect(x, y, w - 4, h - 3));
                camInfo[m * i + j].layout(ExRect(0, 0, w - 4, 21));
            }
        }
        for (int i = 0; i < MAXCAM; i++) {
            ffctx[i]->rtDisp.w = camView[i].area.w;
            ffctx[i]->rtDisp.h = camView[i].area.h;
        }

        //wgtMenu.layout(ExRect(ar.x, ar.y, ar.w, 30));
        //ExRect a0(ar.x, ar.y, ar.w, ar.h * 12 / 100); a0.y += (ar.h * 88 / 100);
        //ExRect a1(ar.x, ar.y, ar.w * 18 / 100, ar.h * 84 / 100);
        //ExRect a2(ar.x, ar.y, ar.w * 18 / 100, ar.h * 84 / 100); a2.x += (ar.w * 82 / 100);
        //panes[0].layout(a0); // do recurs here
        //panes[1].layout(a1); // do recurs here
        //panes[2].layout(a2); // do recurs here

    } else if (widget == &panes[0]) {
        float margin_w = ar.w * 2 / 100.f; // 2 %
        float margin_h = ar.h * 8 / 100.f; // 8 %
        ar.inset((int)margin_w, (int)margin_h);
        float gap_x = ar.w * 3 / 100.f; // 3 %
        float grid_x = (ar.w + gap_x) / 5;
        float p_x = (float)ar.x;
        ExSize sz((int)(grid_x - gap_x), ar.h);
        for (int i = 0; i < 5; i++) {
            btns0[i].layout(ExRect(ExPoint((int)p_x, ar.y), sz));
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
            btns[i].layout(ExRect(ExPoint(ar.x, (int)p_y), sz));
            p_y += grid_y;
        }
    }
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

int WndMain::onActMain(WndMain* widget, ExCbInfo* cbinfo)
{
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
            ExPoint pt = widget->area.pt;
            pt += (msg_pt - but_pt);
            but_pt = msg_pt;
            widget->setPos(pt);
        }
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WndMain::onDestroyed(WndMain* w, ExCbInfo* cbinfo)
{
    dprintf(L"%s()\n", __funcw__);
    assert(w == this);
    timerMain.stop();
    finiRes();
    saveEnv();
    return Ex_Continue;
}

int WndMain::onHandler(WndMain* w, ExCbInfo* cbinfo)
{
    dprintf(L"handler WM_0x%04x:0x%04x\n", cbinfo->event->message, cbinfo->event->msg.message);
    return Ex_Continue;
}

int WndMain::onFilter(WndMain* w, ExCbInfo* cbinfo)
{
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
    if (cbinfo->event->message == WM_DISPLAYCHANGE) {
        InvalidateRect(hwnd, NULL, FALSE);
        return Ex_Continue;
    }
    return Ex_Continue;
}

int WndMain::onTimer(ExTimer* timer, ExCbInfo* cbinfo)
{
    if ((int&)timerMain.userdata == 0x1234) {
        (int&)timerMain.userdata = 0xffff;

        ffstartup();

    }
    return Ex_Continue;
}

int WndMain::onFocused(WndMain* widget, ExCbInfo* cbinfo)
{
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

void WndMain::onDrawCamInfo(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());

    //cr.fill_rect_rgba(rc, ExCairo::Color(.5f, .1f, .5f, .3f));
    ExCairo::Color* pc = res.c.cam_info_pc; // pattern color
    cairo_pattern_t* crp = cairo_pattern_create_linear(rc.x, rc.y, rc.x + 120., rc.y + 22.);
    cairo_pattern_add_color_stop_rgba(crp, 0., pc[0].r, pc[0].g, pc[0].b, pc[0].a);
    cairo_pattern_add_color_stop_rgba(crp, 1., pc[1].r, pc[1].g, pc[1].b, pc[1].a);
    cairo_rectangle(cr, rc.x, rc.y, 120., 22.);
    cairo_set_source(cr, crp);
    cairo_fill(cr);
    cairo_pattern_destroy(crp);

    rc.x += 6.f;
    cr.set_font(res.f.gothic.crf, 12);
    wchar buf[32];
    swprintf_s(buf, 32, L"Cam#%d Info...", widget->id); // tbd
    ExCairo::Point pt = cr.text_align(buf, rc, ExCairo::Left | ExCairo::VCenter);
    cr.show_text(buf, ExCairo::Color(1.f), pt);
}

void WndMain::onDrawCamView(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    FFCtx* ff = ffctx[widget->id];
    assert(ff != NULL);
    Texture* tex = &ff->scale_tex[ff->scale_idx];
    if (tex && tex->h && tex->bpl && tex->bits) {
#if 1 // test
        ExImage* im = canvas->gc;
        ExRect rc(widget->calcRect());

        /* What is the probability that the codec thread will finish both pictures
         * #2 and #1 at the same time while the gui thread is viewing picture #1?
         * There is no such possibility. So there is no need to use mutex.
         */

        //vid_lock(widget->id);
        tex->copyNoClip(im->bits, im->bpl, rc.x, rc.y, rc.w, rc.h);
        //vid_unlock(widget->id);
#else
        cairo_status_t status;
        cairo_format_t format = CAIRO_FORMAT_ARGB32;
        int stride = cairo_format_stride_for_width(format, tex->w);
        cairo_surface_t* crs = cairo_image_surface_create_for_data(tex->bits, format, tex->w, tex->h, stride);
        assert(stride == tex->bpl);
        status = cairo_surface_status(crs);
        if (status != CAIRO_STATUS_SUCCESS) {
            dprint1("%s: %s\n", __func__, cairo_status_to_string(status));
        } else {
            ExCairo cr(canvas, damage);
            ExCairo::Rect rc(widget->calcRect());
            #if 1 // scale
            if (rc.w != tex->w ||
                rc.h != tex->h) {
                double scale_x = 1. * rc.w / tex->w;
                double scale_y = 1. * rc.h / tex->h;
                cairo_translate(cr, rc.x, rc.y);
                cairo_scale(cr, scale_x, scale_y);
                cairo_translate(cr, -rc.x, -rc.y);
            }
            #endif
            cairo_set_source_surface(cr, crs, rc.x, rc.y);
            cairo_paint(cr);
        }
        cairo_surface_destroy(crs);
#endif
        return;
    }

    ExCairo cr(canvas, damage);
    ExCairo::Rect rc(widget->calcRect());

    cr.fill_rect_rgba(rc, ExCairo::Color(.2f, .2f, .2f, .5f));

    rc.x += 6.f;
    cr.set_font(res.f.gothic.crf, 18);
    wchar buf[32];
    swprintf_s(buf, 32, L"Cam#%d View...", widget->id); // tbd
    ExCairo::Point pt = cr.text_align(buf, rc, ExCairo::Left | ExCairo::VCenter);
    cr.show_text(buf, ExCairo::Color(1.f), pt);
}

int WndMain::onActCamInfo(ExWidget* widget, ExCbInfo* cbinfo)
{
    ExPoint msg_pt(cbinfo->event->msg.pt);
    dprintf(L"%s CamInfo-%d event type %d\n", __funcw__, widget->id, cbinfo->type);
    if (cbinfo->type == Ex_CbButPress) {
    } else if (cbinfo->type == Ex_CbPtrMove &&
               widget->getFlags(Ex_ButPressed)) {
    }
    return Ex_Continue;
}

int WndMain::onActCamView(ExWidget* widget, ExCbInfo* cbinfo)
{
    ExPoint msg_pt(cbinfo->event->msg.pt);
    dprintf(L"%s CamInfo-%d event type %d\n", __funcw__, widget->id, cbinfo->type);
    if (cbinfo->type == Ex_CbActivate) {
        selected_audio_ctx_id = widget->id;
    }
    return Ex_Continue;
}

int WndMain::initCam(ExWidget* parent, int id)
{
    ExWidget* view = &camView[id];
    ExWidget* info = &camInfo[id];
    wchar name[32];

    swprintf_s(name, 32, L"CamView%d", id);
    view->init(parent, name, NULL);

    swprintf_s(name, 32, L"CamInfo%d", id);
    info->init(view, name, NULL);

    view->id = id;
    view->setFlags(Ex_FocusRender);
    view->setFlags(Ex_Selectable | Ex_AutoHighlight);
    view->drawFunc = ExDrawFunc(this, &WndMain::onDrawCamView);
    view->addCallback(this, &WndMain::onActCamView, Ex_CbActivate);

    info->id = id;
    info->setFlags(Ex_FocusRender);
    info->setFlags(Ex_Selectable | Ex_AutoHighlight);
    info->drawFunc = ExDrawFunc(this, &WndMain::onDrawCamInfo);
    info->addCallback(this, &WndMain::onActCamInfo, Ex_CbActivate);

    return 0;
}

int WndMain::onVideoRefresh(WndMain* w, ExCbInfo* cbinfo)
{
    for (int i = 0; i < MAXCAM; i++) {
        FFCtx* ff = ffctx[i];
        assert(ff != NULL);
        if (ff->refresh_tid) {
            if (pts[i] != ff->vtinfo->pts) {
                pts[i] = ff->vtinfo->pts;
                camView[i].damage();
            }
        }
    }
    return Ex_Continue;
}

int WndMain::build()
{
    if (initEnv() != 0) {
        dprintf(L"%s: %s fail.\n", __funcw__, L"initEnv");
        return -1;
    }

    // tbd - check res
    if (initRes() != 0) {
        dprintf(L"%s: %s fail.\n", __funcw__, L"initRes");
        return -1;
    }

    canvas = new ExCanvas;
    //canvas->init(this, &ExSize(MAX_W, MAX_H));
    canvas->init(this, &ExSize(env.sm_w, env.sm_h));

    drawFunc = ExDrawFunc(this, &WndMain::onDrawBkgd);

    flushFunc = ExFlushFunc((ExWindow*)this, &ExWindow::onExFlush);
    paintFunc = ExFlushFunc((ExWindow*)this, &ExWindow::onWmPaint);

    setFlags(Ex_Selectable);

    addCallback(this, &WndMain::onDestroyed, Ex_CbDestroyed);
    addCallback(&onUnrealized, this, Ex_CbUnrealized);
    addCallback(&onRealized, this, Ex_CbRealized);
    addCallback(this, &WndMain::onLayout, Ex_CbLayout);
    addCallback(this, &WndMain::onFocused, Ex_CbGotFocus);
    addCallback(this, &WndMain::onActMain, Ex_CbActivate);
    addCallback([](void* data, ExWidget* widget, ExCbInfo* cbinfo)->int {
        dprintf(L"%s Mouse %d,%d\n", widget->getName(), cbinfo->type, cbinfo->subtype);
        return Ex_Continue; }, this, Ex_CbActivate); // Enter/Move/Leave/...

    for (int i = 0; i < MAXCAM; i++) {
        pts[i] = 0.;
        initCam(this, i);
        // tbd - init ffctx
    }

    int repeat = 1000 / (env.mv.fps ? env.mv.fps : 30);

    (int&)timerVideoRefresh.userdata = 0;
    timerVideoRefresh.setCallback(this, &WndMain::onVideoRefresh, this);
    timerVideoRefresh.start(1, repeat);

    initInput();

    //wgtMenu.init(this);
    wgtTitle.init(this);

    addFilter([](void* data, ExWindow* window, ExCbInfo* cbinfo)->int {
        dprintf(L"[%s] WM_0x%04x\n", window->getName(), cbinfo->event->message);
        if (cbinfo->event->message == WM_CREATE) {
            cbinfo->event->lResult = 0;
            RECT r;
            // The right and bottom members contain the width and height of the window.
            GetClientRect(cbinfo->event->hwnd, &r);
            ExRect rc(r);
            dprintf(L"GetClientRect %d,%d-%dx%d\n",
                    rc.x, rc.y, rc.w, rc.h);
            window->layout(rc);
            // To remove an anonymous callback, simply return Ex_Remove.
            return Ex_Break | Ex_Remove;
        }
#if 0 // window caption remove or change
        if (cbinfo->event->message == WM_NCCALCSIZE) {
            RECT* r = (RECT*)cbinfo->event->lParam;
            //NCCALCSIZE_PARAMS* rc = (NCCALCSIZE_PARAMS*)lParam;
            dprintf(L"[0x%p] WM_NCCALCSIZE wParam=%d %d,%d-%d,%d\n",
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

    timerMain.setCallback(this, &WndMain::onTimer);
    (int&)timerMain.userdata = 0x1234;
    timerMain.start(1);

    return 0;
}

