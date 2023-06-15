//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//


#include "res.h"
#include "env.h"
#include <sys/stat.h>
//#include "framework.h"

Res res;

static bool img_init(ExImage* img, const char_t* name)
{
    char_t pathname[256];
    sprintf_s(pathname, 256, "%s/%s", res.path, name);
    bool result = img->load(pathname);
    if (result != true) {
        dprint("%s: %s fail.\n", __func__, pathname);
    }
    return result;
}

bool initRes()
{
    bool hasResPath = true;
    struct _stat statbuf;
    sprintf_s(res.path, 256, "%s/res", exModulePath);
    if (_stat(res.path, &statbuf) != 0) {
        sprintf_s(res.path, 256, "%s/../../res", exModulePath);
        if (_stat(res.path, &statbuf) != 0) {
            dprint("%s: cant open res path\n", __func__);
            hasResPath = false;
        }
    }

    ExCairo::Face::initFtLib();

    // font
    //
    if (hasResPath == true) {
        res.f.gothic.load(res.path, "font/NanumGothic.ttf");
        res.f.gothic_B.load(res.path, "font/NanumGothicBold.ttf");
        res.f.square.load(res.path, "font/NanumSquareB.ttf");
        res.f.square_B.load(res.path, "font/NanumSquareEB.ttf");
    }

    // color
    //
    res.c.bg = 0x202020U;
    res.c.fg = 0xc0c0c0U;

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
    img_init(&res.i.bg0, "img/S01090.bmp");
    img_init(&res.i.bg1, "img/S01051.PNG");

    // string
    //
    res.s.title = "AppDemo-extk-1.1";

    return hasResPath;
}

bool finiRes()
{
    res.f.gothic.free();
    res.f.gothic_B.free();
    res.f.square.free();
    res.f.square_B.free();

    ExCairo::Face::finiFtLib();

    return true;
}

