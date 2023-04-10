#pragma once

#include <ex.h>
#include "ffctx.h"

class WgtLineProc : public ExWidget {
public:
    ExWidget detectTargetSearch;

    ExWidget detectPendingList;

    ExWidget detectHistory;

    ExWidget carNumber;
    ExWidget carNumberBtn;
    ExWidget detectTime;
    ExWidget prevDataBtn;
    ExWidget nextDataBtn;

    ExWidget firstDetectZoomInImage;
    ExWidget firstDetectZoomOutImage;
    ExWidget firstDetectZoomInCutBtn;
    ExWidget firstDetectZoomOutCutBtn;
    ExWidget firstDetectTime;
    ExWidget firstDetectImageHeadBtn;
    ExWidget firstDetectImagePrevBtn;
    ExWidget firstDetectImageNextBtn;
    ExWidget firstDetectImageTailBtn;
    ExWidget firstDetectImageFraction;

    ExWidget lastDetectZoomInImage;
    ExWidget lastDetectZoomOutImage;
    ExWidget lastDetectZoomInCutBtn;
    ExWidget lastDetectZoomOutCutBtn;
    ExWidget lastDetectTime;
    ExWidget lastDetectImageHeadBtn;
    ExWidget lastDetectImagePrevBtn;
    ExWidget lastDetectImageNextBtn;
    ExWidget lastDetectImageTailBtn;
    ExWidget lastDetectImageFraction;

    ExWidget detectCameraInfo;
    ExWidget detectCameraInfoBtn;
    ExWidget detectCameraView;

    ExWidget fileSavePath;
    ExWidget fileSavePathBtn;
    ExWidget finalFileFormat;
    ExWidget detectFinalFile;
    ExWidget detectFinalFileOpenBtn;
    ExWidget detectFinalFileViewBtn;

public:
    ~WgtLineProc() {}
    WgtLineProc() : ExWidget() {}
public:
    int initInput();
    int STDCALL onDestroyed(WgtLineProc* w, ExCbInfo* cbinfo);
    int STDCALL onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onFocused(WgtLineProc* widget, ExCbInfo* cbinfo);
    int STDCALL onActMain(WgtLineProc* widget, ExCbInfo* cbinfo);
    int STDCALL onActBkgd(WgtLineProc* widget, ExCbInfo* cbinfo);
    int STDCALL onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void STDCALL onDrawBkgd(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawCamInfo(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    void STDCALL onDrawCamView(ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage);
    int STDCALL onActCamInfo(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onActCamView(ExWidget* widget, ExCbInfo* cbinfo);
    int STDCALL onHandler(WgtLineProc* w, ExCbInfo* cbinfo);
    int STDCALL onFilter(WgtLineProc* w, ExCbInfo* cbinfo);
    int STDCALL onTimer(ExTimer* timer, ExCbInfo* cbinfo);
public:
    int build();
};
