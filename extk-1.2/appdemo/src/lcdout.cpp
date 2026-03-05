//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "lcdout.h"
#include "env.h"

LcdOut gLcdOut;

#ifdef __linux__

void LcdOut::onFlush(WndMain* window, const ExRegion* updateRgn)
{
    // updateRgn is filled after render call.
    (void)window->render();

    cr_save(cr);

    if (env.fb0_rotate != 0) {
#ifdef CONF_X11
        cr_translate(cr, static_cast<float64>(env.fb0_w) / 2., static_cast<float64>(env.fb0_h) / 2.);
        cr_rotate(cr, (static_cast<float64>(env.fb0_rotate) * M_PI) / 180.);
        cr_translate(cr, -static_cast<float64>(env.fb0_w) / 2., -static_cast<float64>(env.fb0_h) / 2.);
#else
        cr_translate(cr, static_cast<float64>(env.fb0_w) / 2., static_cast<float64>(env.fb0_h) / 2.);
        cr_rotate(cr, (static_cast<float64>(env.fb0_rotate) * M_PI) / 180.);
        cr_translate(cr, -static_cast<float64>(env.fb0_h) / 2., -static_cast<float64>(env.fb0_w) / 2.);
#endif
    }

#if defined(CLIP_EXTENT)
    const ExCairo::Rect clip_rc(static_cast<float64>(updateRgn->extent.u.ul.x),
                                static_cast<float64>(updateRgn->extent.u.ul.y),
                                static_cast<float64>(updateRgn->extent.width()),
                                static_cast<float64>(updateRgn->extent.height()));
    cr_rectangle(cr, clip_rc.x, clip_rc.y, clip_rc.w, clip_rc.h);
#else
    for (int32 i = 0; i < updateRgn->n_boxes; i++) {
        const ExCairo::Rect clip_rc(updateRgn->boxes[i].u.ul.x,
                                    updateRgn->boxes[i].u.ul.y,
                                    updateRgn->boxes[i].width(),
                                    updateRgn->boxes[i].height());
        cr_rectangle(cr, clip_rc.x, clip_rc.y, clip_rc.w, clip_rc.h);
    }
#endif
    cr_clip(cr);

    cr_set_source_surface(cr, cr_get_target(window->canvas->cr), 0., 0.);
    cr_paint(cr);

    cr_restore(cr);

#ifdef CONF_X11
    GC gc = XCreateGC(env.display, env.top, 0, nullptr);
    XPutImage(env.display, env.top, gc, env.ximg, 0, 0, 0, 0,
              env.ximg->width, env.ximg->height);
    XFlush(env.display);
    XFreeGC(env.display, gc);
#endif // CONF_X11

    env.gui_tick = ExWatch::getTickCount() - ExWatch::tickAppLaunch;
}

bool LcdOut::fini()
{
    if (cr != nullptr) {
        cr_destroy(cr);
        cr = nullptr;
    }
    if (crs != nullptr) {
        cr_surface_destroy(crs);
        crs = nullptr;
    }
#ifdef CONF_X11
    if (env.ximg != nullptr) {
        if (env.ximg->data != nullptr) {
            ExHeapManager<uint8>::deallocate(env.ximg->data);
            env.ximg->data = nullptr;
            env.fb0_bits = nullptr;
        }
        XDestroyImage(env.ximg);
        env.ximg = nullptr;
    }
#endif // CONF_X11
    return true;
}

bool LcdOut::init()
{
    bool result = false;

    cr = nullptr;
    crs = nullptr;

#ifdef CONF_X11
    // TechNote:
    // XCreateImage() are not allocate data memory automatically.
    // Importand!!! bitmap_pad must be 8 (it means bits).
    // If bytes_per_line = 0, then Xlib calculates the value of bytes_per_line itself.
    // After use XImage, call free(ximage->data) and XDestroyImage(ximage);
    XImage* ximage = nullptr;
    int32 bitmap_pad = 8; // 8-bits alignment
    int32 bytes_per_line = 0;
    size_t buf_size;

    ximage = XCreateImage(env.display, env.visual, env.depth, ZPixmap, 0, nullptr,
                          env.fb0_w, env.fb0_h, bitmap_pad, bytes_per_line);
    if (ximage == nullptr) {
        dprint("XCreateImage() error.\n");
        goto xinit_error;
    }
    if (ximage->bitmap_unit == 0) {
        dprint("XImage format error. bitmap_unit is zero.\n");
        XDestroyImage(ximage);
        goto xinit_error;
    }
    buf_size = ximage->bytes_per_line * ximage->height;
    env.fb0_bits = ExHeapManager<uint8>::allocate(buf_size);
    if (env.fb0_bits == nullptr) {
        dprint("alloc ximage.data error.\n");
        XDestroyImage(ximage);
        goto xinit_error;
    }
    (void)memset(env.fb0_bits, 0x7f, buf_size);
    env.fb0_bpp = ximage->bits_per_pixel;
    env.fb0_bpl = ximage->bytes_per_line;
    ximage->data = reinterpret_cast<char*>(env.fb0_bits);
    env.ximg = ximage;
xinit_error:
#endif // CONF_X11

    cr_status_t status;
    const cr_format_t format = CR_FORMAT_ARGB32;
    const int32 stride = cr_format_stride_for_width(format, env.fb0_w);
    crs = cr_image_surface_create_for_data(env.fb0_bits, format,
                                           env.fb0_w, env.fb0_h, stride);
    exassert2(stride == env.fb0_bpl, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    //static const cr_user_data_key_t key;
    //cr_surface_set_user_data(gc->crs, &key, gc->bits, (cr_destroy_func_t)free);
    //cr_content_t crc_image = cr_surface_get_content(gc->crs);
    //exassert2(crc_image == CR_CONTENT_COLOR_ALPHA, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    status = cr_surface_status(crs);
    if (status == CR_STATUS_SUCCESS) {
        cr = cr_create(crs);
        status = cr_status(cr);
        if (status == CR_STATUS_SUCCESS) {
            result = true;
        }
    }
    return result;
}

#endif // __linux__
