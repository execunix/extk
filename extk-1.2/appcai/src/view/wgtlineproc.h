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
    int onDestroyed(WgtLineProc* w, ExCbInfo* cbinfo);
    int onLayout(ExWidget* widget, ExCbInfo* cbinfo);
    int onFocused(WgtLineProc* widget, ExCbInfo* cbinfo);
    int onActMain(WgtLineProc* widget, ExCbInfo* cbinfo);
    int onActBkgd(WgtLineProc* widget, ExCbInfo* cbinfo);
    int onActBtns(ExWidget* widget, ExCbInfo* cbinfo);
    void onDrawBkgd(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    void onDrawCamInfo(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    void onDrawCamView(ExCanvas* canvas, const ExVision* widget, const ExRegion* damage);
    int onActCamInfo(ExWidget* widget, ExCbInfo* cbinfo);
    int onActCamView(ExWidget* widget, ExCbInfo* cbinfo);
    int onHandler(WgtLineProc* w, ExCbInfo* cbinfo);
    int onFilter(WgtLineProc* w, ExCbInfo* cbinfo);
    int onTimer(ExTimer* timer, ExCbInfo* cbinfo);
public:
    int build();
};
