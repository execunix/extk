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
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawTitle(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawClock(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawBtns(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
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
    int STDCALL onDestroyed(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFocused(WndMain* widget, ExCbInfo* cbinfo);
    int STDCALL onActMain(WndMain* widget, ExCbInfo* cbinfo);
    int STDCALL onActBkgd(WndMain* widget, ExCbInfo* cbinfo);
    int STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawCamInfo(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawCamView(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onActCamInfo(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onActCamView(ExWidget* widget, ExCbInfo* cbinfo);
    int initCam(ExWidget* parent, int id);
    int STDCALL onVideoRefresh(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onHandler(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onFilter(WndMain* w, ExCbInfo* cbinfo);
    int STDCALL onTimer(ExTimer* timer, ExCbInfo* cbinfo);
public:
    int build();
    int InitInstance();
    static LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
};
