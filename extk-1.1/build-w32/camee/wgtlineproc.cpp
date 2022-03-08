#include "framework.h"
#include "wgtlineproc.h"
#include "common.h"

void layout_horz(ExRect r, int n, floatt* f, ExWidget* w)
{
}

void WgtLineProc::onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
{
    if (widget == this) {
        ExRegion rgn(*damage);
        for (int i = 0; i < rgn.n_boxes; i++)
            canvas->gc->fillBox(&rgn.boxes[i], res.c.bg);
    }
}

int WgtLineProc::onDestroyed(WgtLineProc* w, ExCbInfo* cbinfo)
{
    dprintf(L"%s()\n", __funcw__);

    return Ex_Continue;
}

int WgtLineProc::onLayout(ExWidget* widget, ExCbInfo* cbinfo)
{
    dprintf(L"%s(%s) %d (%d,%d-%dx%d)\n", __funcw__, widget->getName(),
            cbinfo->subtype, widget->area.x, widget->area.y, widget->area.w, widget->area.h);
    ExRect ar(0, 0, widget->area.w, widget->area.h);
    if (widget == this) {
        //ar.offset(0, 30, 0, 0);
        ar.inset(1, 1);
        ExRect rt[3]; // layout horz 25% 35% 40%
        rt[0].set(ar.x, ar.y, ar.w * 25 / 100 - 1, ar.h);
        rt[1].set(rt[0].right(), ar.y, ar.w * 30 / 100 - 1, ar.h);
        rt[2].set(rt[1].right(), ar.y, ar.w - rt[1].right(), ar.h);
        detectTargetSearch.layout(rt[0]);
        detectPendingList.layout(rt[1]);
        detectHistory.layout(rt[2]);

    }
    cbinfo->subtype = Ex_LayoutDone;
    return Ex_Continue;
}

#if 0
int WgtLineProc::onFilter(WgtLineProc* w, ExCbInfo* cbinfo)
{
    dprintf(L"filter WM_0x%04x\n", cbinfo->event->message);
    return Ex_Continue;
}

int WgtLineProc::onTimer(ExTimer* timer, ExCbInfo* cbinfo)
{
    if ((int&)timerMain.userdata == 0x1234) {
        (int&)timerMain.userdata = 0xffff;
    }
    return Ex_Continue;
}

void WgtLineProc::onDrawCamInfo(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
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

void WgtLineProc::onDrawCamView(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage)
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

int WgtLineProc::onActCamInfo(ExWidget* widget, ExCbInfo* cbinfo)
{
    ExPoint msg_pt(cbinfo->event->msg.pt);
    dprintf(L"%s CamInfo-%d event type %d\n", __funcw__, widget->id, cbinfo->type);
    if (cbinfo->type == Ex_CbButPress) {
    } else if (cbinfo->type == Ex_CbPtrMove &&
               widget->getFlags(Ex_ButPressed)) {
    }
    return Ex_Continue;
}

int WgtLineProc::onActCamView(ExWidget* widget, ExCbInfo* cbinfo)
{
    ExPoint msg_pt(cbinfo->event->msg.pt);
    dprintf(L"%s CamInfo-%d event type %d\n", __funcw__, widget->id, cbinfo->type);
    if (cbinfo->type == Ex_CbActivate) {
        selected_audio_ctx_id = widget->id;
    }
    return Ex_Continue;
}
#endif

int WgtLineProc::build()
{
    drawFunc = ExDrawFunc(this, &WgtLineProc::onDrawBkgd);
    addCallback(this, &WgtLineProc::onDestroyed, Ex_CbDestroyed);
    addCallback(this, &WgtLineProc::onLayout, Ex_CbLayout);

#if 0
    setFlags(Ex_Selectable);

    addCallback(this, &WgtLineProc::onFocused, Ex_CbGotFocus);
    addCallback(this, &WgtLineProc::onActMain, Ex_CbActivate);
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
    timerVideoRefresh.setCallback(this, &WgtLineProc::onVideoRefresh, this);
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

    timerMain.setCallback(this, &WgtLineProc::onTimer);
    (int&)timerMain.userdata = 0x1234;
    timerMain.start(1);
#endif
    return 0;
}

