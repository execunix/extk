/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#pragma once

#include <exgeomet.h>
#include "env.h"


/**
 *  Synchronization functions which can time out return this value
 *  if they time out.
 */
#define MUTEX_TIMEDOUT  1

/**
 *  This is the timeout value which corresponds to never time out.
 */
#define MUTEX_MAXWAIT   (~(uint32)0)


typedef struct SRWMutex {
    SRWLOCK srw;
    /* SRW Locks are not recursive, that has to be handled by myself */
    DWORD count;
    DWORD owner;
} SRWMutex;

SRWMutex* SRWMutexCreate(void);
void SRWMutexDestroy(SRWMutex* mutex);
int SRWMutexLock(SRWMutex* mutex);
int SRWMutexTryLock(SRWMutex* mutex);
int SRWMutexUnlock(SRWMutex* mutex);


typedef struct SRWCond {
    CONDITION_VARIABLE cond;
} SRWCond;

SRWCond* SRWCondCreate(void);
void SRWCondDestroy(SRWCond* cond);
int SRWCondSignal(SRWCond* cond);
int SRWCondBroadcast(SRWCond* cond);
int SRWCondWaitTimeout(SRWCond* cond, SRWMutex* mutex, uint32 ms);
int SRWCondWait(SRWCond* cond, SRWMutex* mutex);

// shmem
//
struct VideoTexInfo {
    DWORD magic;
    DWORD size;

    int count;
    int pitch;
    int width;
    int height;
    int offset;

    int id;
    int index;
    double pts; // presentation timestamp for the frame

};

void VideoTexInfoDestroy(HANDLE hmap, void* addr);
VideoTexInfo* VideoTexInfoCreate(HANDLE* hmap, const wchar_t* name);


#define MIX_MAXVOLUME 128

/* Define a four character code as a uint32 */
#define FOURCC(A, B, C, D) \
    (((uint32)((uint8)((A))) << 0) | \
     ((uint32)((uint8)((B))) << 8) | \
     ((uint32)((uint8)((C))) << 16) | \
     ((uint32)((uint8)((D))) << 24))


#define ALPHA_OPAQUE 255
#define ALPHA_TRANSPARENT 0

typedef enum {
    PIXELFORMAT_UNKNOWN,
    PIXELFORMAT_ARGB8888,
    PIXELFORMAT_RGBA8888,
    PIXELFORMAT_ABGR8888,
    PIXELFORMAT_BGRA8888,
    PIXELFORMAT_RGB24,
    PIXELFORMAT_BGR24,
    PIXELFORMAT_IYUV,
    PIXELFORMAT_YUY2,
    PIXELFORMAT_UYVY,
    PIXELFORMAT_YVYU,
    PIXELFORMAT_NV12,
    PIXELFORMAT_NV21,
} PixelFormatEnum;


/*
 * comnpat with sdl_render
 */

typedef enum {
    FLIP_NONE       = 0x00000000,   /**< Do not flip */
    FLIP_HORIZONTAL = 0x00000001,   /**< flip horizontally */
    FLIP_VERTICAL   = 0x00000002    /**< flip vertically */
} RendererFlip;

struct Texture { // 32bpp only
    int w, h;
    int bpl;
    uint8* bits;
    ~Texture() { if (bits) free(bits); }
    Texture() : w(0), h(0), bpl(0), bits(NULL) {}
    int alloc(int w, int h);
    int realloc(int w, int h);
    static int calc_pitch(int w) {
        return ((w * 8 + 7) / 8) * 4;
    }
    void detach() {
        w = h = bpl = 0;
        bits = NULL;
    }
    void attach(int w, int h, uint8* bits);
    void copyNoClip(uint8* dbits, int dbpl, int dx, int dy, int sw, int sh) const;
    static void scaleNoClip(Texture* dst_tex, const Texture* src_tex, const int width, const int height);
    void scaleNoClip(const Texture* src_tex, int width, int height) {
        scaleNoClip(this, src_tex, width, height);
    }
};


#ifdef __cplusplus
extern "C" {
#endif

int UpdateTexture(Texture* texture, const ExRect* rect, const void* pixels, int pitch);

int UpdateYUVTexture(Texture* texture,
                     const ExRect* rect,
                     const uint8* Yplane, int Ypitch,
                     const uint8* Uplane, int Upitch,
                     const uint8* Vplane, int Vpitch);

int UpdateNVTexture(Texture* texture,
                    const ExRect* rect,
                    const uint8* Yplane, int Ypitch,
                    const uint8* UVplane, int UVpitch);

int LockTexture(Texture* texture, const ExRect* rect, void** pixels, int* pitch);

void UnlockTexture(Texture* texture);

int RenderCopy(Texture* texture, const ExRect* srcrect, const ExRect* dstrect);

int RenderCopyEx(Texture* texture,
                 const ExRect* srcrect,
                 const ExRect* dstrect,
                 const double angle,
                 const ExPoint* center,
                 const RendererFlip flip);

void DestroyTexture(Texture* texture);

void _YUV420SToRGB32(const uint8_t* Y,
                     const uint8_t* U,
                     const uint8_t* V,
                     int dUV,
                     uint32_t* rgb,
                     int width,
                     int height,
                     int y_stride,
                     int uv_stride);
void _YV12ToRGB32(const void* yv12, void* rgb, int width, int height);
void _YU12ToRGB32(const void* yu12, void* rgb, int width, int height);

#ifdef __cplusplus
}
#endif

