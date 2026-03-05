//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _lcdout_h_
#define _lcdout_h_

#include "view/wndmain.h"

class LcdOut {
protected:
    cr_surface_t* crs;
    cr_t*         cr;
public:
    void onFlush(WndMain* window, const ExRegion* updateRgn);
    bool fini();
    bool init();
};

extern LcdOut gLcdOut;

#endif // _lcdout_h_
