//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include "framework.h"
#include <ft2build.h>
#include <cairo-ft.h>
#include FT_FREETYPE_H
#include <assert.h>

static FT_Library ftLib;

Res res;

int Face::load(const char* name)
{
    assert(ftLib != NULL);

    char faceName[256];
    sprintf_s(faceName, 256, "%S/%s", res.path, name);

    if (FT_New_Face(ftLib, faceName, 0, &ftFace) != FT_Err_Ok) {
        dprint1("%s(%s) FT_New_Face fail", __func__, faceName);
        return -1;
    }
    if ((crf = cairo_ft_font_face_create_for_ft_face(ftFace, FT_LOAD_DEFAULT | FT_LOAD_NO_BITMAP)) == NULL) {
        dprint1("%s(%s) cairo_ft_font_face_create_for_ft_face fail", __func__, faceName);
        return -1;
    }
    return 0;
}

void Face::free()
{
    assert(ftLib != NULL);

    if (crf) {
        cairo_font_face_destroy(crf);
        crf = NULL;
    }
    if (ftFace) {
        FT_Done_Face(ftFace);
        ftFace = NULL;
    }
}

static int load(ExImage* img, const wchar* name)
{
    wchar pathname[256];
    swprintf_s(pathname, 256, L"%s/%s", res.path, name);
    if (img->load(pathname) != 0) {
        dprint(L"%s: load %s fail.\n", __funcw__, pathname);
        return -1;
    }
    return 0;
}

int initRes()
{
    struct _stat statbuf;
    swprintf_s(res.path, 256, L"%s/res", exModulePath);
    if (_wstat(res.path, &statbuf))
        swprintf_s(res.path, 256, L"%s/../../res", exModulePath);
    if (_wstat(res.path, &statbuf)) {
        dprint(L"%s: cant open res path\n", __funcw__);
        return -1;
    }

    assert(ftLib == NULL);
    FT_Init_FreeType(&ftLib);

    // font
    //
    res.f.gothic.load("font/NanumGothic.ttf");
    res.f.gothic_B.load("font/NanumGothicBold.ttf");
    res.f.square.load("font/NanumSquareB.ttf");
    res.f.square_B.load("font/NanumSquareEB.ttf");

    // color
    //
    res.c.bg = 0x202020;
    res.c.fg = 0xc0c0c0;

    // common button pattern color
    res.c.cbtn_pc_N[0].setv(88, 88, 88, 255); // normal 0
    res.c.cbtn_pc_N[1].setv(22, 22, 22, 33); // normal 1
    res.c.cbtn_pc_H[0].setv(199, 199, 199, 255); // highlight 0
    res.c.cbtn_pc_H[1].setv(66, 66, 66, 88); // highlight 1

    res.c.cam_info_pc[0].setv(199, 199, 0, 99);
    res.c.cam_info_pc[1].setv(0, 0, 0, 33);

    // common button line color
    res.c.cbtn_lc_N.setv(33, 33, 33, 255); // normal
    res.c.cbtn_lc_P.setv(255, 255, 255, 255); // pressed
    res.c.cbtn_lc_F.setv(64, 255, 64, 255); // focused

    // image
    //
    load(&res.i.bg0, L"img/S01090.bmp");
    load(&res.i.bg1, L"img/S01051.PNG");

    // string
    //
    res.s.title = L"AppDemo-extk-1.1";

    return 0;
}

int finiRes()
{
    res.f.gothic.free();
    res.f.gothic_B.free();
    res.f.square.free();
    res.f.square_B.free();

    assert(ftLib != NULL);
    FT_Done_FreeType(ftLib);
    ftLib = NULL;

    return 0;
}

