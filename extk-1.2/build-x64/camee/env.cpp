/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#include "framework.h"
#include <stdio.h>
#include "env.h"

#if 1
static const char* dflt_url[MAXCAM] = {
    NULL,
};
#else
static const char* dflt_url[MAXCAM] = {
    "rtsp://183.96.28.98:30003/profile3/media.smp",
    "D:/media/movie/The QueensGambit 2020/1.mkv",
    "rtsp://183.96.28.98:30003/profile3/media.smp",
    "D:/media/movie/The QueensGambit 2020/2.mkv",
    "rtsp://183.96.28.98:30003/profile3/media.smp",
    "D:/media/movie/The QueensGambit 2020/3.mkv",
    "D:/media/movie/The QueensGambit 2020/4.mkv",
    "D:/media/movie/The QueensGambit 2020/5.mkv",
    "D:/media/movie/The QueensGambit 2020/6.mkv",
    "D:/media/movie/The QueensGambit 2020/7.mkv",
    "D:/media/movie/Lucifer/Lucifer.S01E08.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S01E09.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S01E10.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S01E11.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S01E12.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S01E13.Korsub.720p.H264.mp4",
    "D:/media/movie/penthouse/PH.E16.720p.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E07.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E08.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E09.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E10.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E11.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E12.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E13.Korsub.720p.H264.mp4",
    "D:/media/movie/Lucifer/Lucifer.S02E14.Korsub.720p.H264.mp4",
};
#endif

Env env;

int initEnv()
{
    env.mv.col = 5;
    env.mv.row = 5;
    env.mv.fps = 50;

    for (int i = 0; i < MAXCAM; i++) {
        strcpy(env.ci[i].url, dflt_url[i] ? dflt_url[i] : "");
    }

    loadEnv();

    return 0;
}

static const char* caminfo = ".\\caminfo.ini";

int loadEnv()
{
    char app[32];
    char val[256];

    env.mv.col = GetPrivateProfileIntA("VIEW", "COL", env.mv.col, caminfo);
    env.mv.row = GetPrivateProfileIntA("VIEW", "ROW", env.mv.row, caminfo);
    env.mv.fps = GetPrivateProfileIntA("VIEW", "FPS", env.mv.fps, caminfo);

    if (env.mv.col > 5) env.mv.col = 5;
    if (env.mv.row > 5) env.mv.row = 5;
    if (env.mv.fps > 60) env.mv.fps = 60;

    for (int i = 0; i < MAXCAM; i++) {
        snprintf(app, 32, "CAM-%d", i);
        if (GetPrivateProfileStringA(app, "URL", nullptr, val, 256, caminfo) > 0) {
            strcpy(env.ci[i].url, val);
        } else {
            //env.ci[i].url[0] = 0;
        }
    }

    return 0;
}

int saveEnv()
{
    char app[32];
    char val[256];

    snprintf(val, 32, "%d", env.mv.col);
    WritePrivateProfileStringA("VIEW", "COL", val, caminfo);

    snprintf(val, 32, "%d", env.mv.row);
    WritePrivateProfileStringA("VIEW", "ROW", val, caminfo);

    snprintf(val, 32, "%d", env.mv.fps);
    WritePrivateProfileStringA("VIEW", "FPS", val, caminfo);

    for (int i = 0; i < MAXCAM; i++) {
        snprintf(app, 32, "CAM-%d", i);
        const char* p = *env.ci[i].url ? env.ci[i].url : nullptr;
        WritePrivateProfileStringA(app, "URL", p, caminfo);
    }
    return 0;
}

