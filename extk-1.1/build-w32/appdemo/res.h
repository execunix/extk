//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#pragma once

#include <ex.h>

#ifndef FT_FREETYPE_H
typedef struct FT_FaceRec_* FT_Face;
#endif

struct Face {
    cairo_font_face_t* crf;
    FT_Face ftFace;

    int load(const char* name);
    void free();
};

struct Res {
    char path[256];

    struct Fonts {
        Face gothic;
        Face gothic_B;
        Face square;
        Face square_B;
    } f;

    struct Colors {
        uint32 bg;
        uint32 fg;

        // common button pattern color
        // [0] pattern color offset 0.f
        // [1] pattern color offset 1.f
        ExCairo::Color cbtn_pc_N[2]; // normal
        ExCairo::Color cbtn_pc_H[2]; // highlight

        ExCairo::Color cam_info_pc[2];

        // common button line color
        ExCairo::Color cbtn_lc_N; // normal
        ExCairo::Color cbtn_lc_P; // pressed
        ExCairo::Color cbtn_lc_F; // focused

    } c;

    struct Images {
        ExImage bg0;
        ExImage bg1;
    } i;

    struct Strings {
        const char* title;
    } s;

};

int initRes();
//int loadRes();
//int saveRes();
int finiRes();

extern Res res;
