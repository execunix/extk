#pragma once

#include <ex.h>
#include "ffctx.h"

class WgtTitle : public ExWidget {
public:
    wchar title[256];
    ExWidget wgtClock;
    ExWidget wgtClose;
    ExWidget wgtMinMax;
public:
    ~WgtTitle() {}
    WgtTitle() : ExWidget() {}
public:
    void init(ExWindow* window);
    void setTitle(const wchar* str) {
        wcsncpy(title, str, 255);
        title[255] = 0;
    }
    int onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    void onDrawTitle(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    void onDrawClock(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    void onDrawBtns(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    int onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
};

class WndMain : public ExWindow {
public:
    double pts[MAXCAM];
    ExWidget camView[MAXCAM];
    ExWidget camInfo[MAXCAM];
    ExWidget panes[3];
    ExWidget btns0[5];
    ExWidget btns1[6];
    ExWidget btns2[6];
    ExWidget wgtBkgd;
    ExPoint img_pt0;
    ExTimer timerMain;
    ExWindow wndBackBuf;
    ExWidget wgtBackBtn;
    ExWidget wgtBackViewer;
    ExTimer backBufUpdater;
    int backBufCnt;
    //WgtMenu wgtMenu;
    WgtTitle wgtTitle;
    const UINT WM_APP_TEST = ExRegAppMessage();
    ExTimer timerVideoRefresh;
public:
    ~WndMain() {}
    WndMain() : ExWindow() {}
public:
    int initInput();
    int onDestroyed(WndMain* w, ExCbInfo* cbinfo);
    int onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    int onFocused(WndMain* widget, ExCbInfo* cbinfo);
    int onActMain(WndMain* widget, ExCbInfo* cbinfo);
    int onActBkgd(WndMain* widget, ExCbInfo* cbinfo);
    int onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void onDrawBkgd(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    void onDrawCamInfo(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    void onDrawCamView(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    int onActCamInfo(ExWidget* widget, ExCbInfo* cbinfo);
    int onActCamView(ExWidget* widget, ExCbInfo* cbinfo);
    int initCam(ExWidget* parent, int id);
    int onVideoRefresh(WndMain* w, ExCbInfo* cbinfo);
    int onHandler(WndMain* w, ExCbInfo* cbinfo);
    int onFilter(WndMain* w, ExCbInfo* cbinfo);
    int onTimer(ExTimer* timer, ExCbInfo* cbinfo);
public:
    int build();
    int InitInstance();
    static LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
};
