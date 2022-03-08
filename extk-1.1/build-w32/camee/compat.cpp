/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#include <windows.h>
#include <stdlib.h>
#include <tchar.h>
#include <io.h>
#include <assert.h>
#include "compat.h"

int
debug_printf_xxx(const wchar_t* fmt, ...)
{
    wchar_t buf[1024];
    va_list arg;
    va_start(arg, fmt);
    int len = _vsnwprintf(buf, 1024, fmt, arg);
    va_end(arg);
    OutputDebugString(buf);
    return len;
}

SRWMutex* SRWMutexCreate(void)
{
    SRWMutex* mutex;

    /* Relies on SRWLOCK_INIT == 0. */
    mutex = (SRWMutex*)calloc(1, sizeof(*mutex));
    if (!mutex) {
        dprintf(L"Out of memory\n");
    } else {
        InitializeSRWLock(&mutex->srw);
    }

    return mutex;
}

void SRWMutexDestroy(SRWMutex* mutex)
{
    if (mutex) {
        /* There are no kernel allocated resources */
        free(mutex);
    }
}

int SRWMutexLock(SRWMutex* mutex)
{
    DWORD this_thread;

    if (mutex == NULL) {
        dprintf(L"Passed a NULL mutex\n");
        return -1;
    }

    this_thread = GetCurrentThreadId();
    if (mutex->owner == this_thread) {
        ++mutex->count;
    } else {
        /* The order of operations is important.
           We set the locking thread id after we obtain the lock
           so unlocks from other threads will fail.
         */
        AcquireSRWLockExclusive(&mutex->srw);
        assert(mutex->count == 0 && mutex->owner == 0);
        mutex->owner = this_thread;
        mutex->count = 1;
    }
    return 0;
}

int SRWMutexTryLock(SRWMutex* mutex)
{
    DWORD this_thread;
    int retval = 0;

    if (mutex == NULL) {
        dprintf(L"Passed a NULL mutex\n");
        return -1;
    }

    this_thread = GetCurrentThreadId();
    if (mutex->owner == this_thread) {
        ++mutex->count;
    } else {
        if (TryAcquireSRWLockExclusive(&mutex->srw) != 0) {
            assert(mutex->count == 0 && mutex->owner == 0);
            mutex->owner = this_thread;
            mutex->count = 1;
        } else {
            retval = MUTEX_TIMEDOUT;
        }
    }
    return retval;
}

int SRWMutexUnlock(SRWMutex* mutex)
{
    if (mutex == NULL) {
        dprintf(L"Passed a NULL mutex\n");
        return -1;
    }

    if (mutex->owner == GetCurrentThreadId()) {
        if (--mutex->count == 0) {
            mutex->owner = 0;
            ReleaseSRWLockExclusive(&mutex->srw);
        }
    } else {
        dprintf(L"mutex not owned by this thread\n");
        return -1;
    }

    return 0;
}


SRWCond* SRWCondCreate(void)
{
    SRWCond* cond;

    /* Relies on CONDITION_VARIABLE_INIT == 0. */
    cond = (SRWCond*)calloc(1, sizeof(*cond));
    if (!cond) {
        dprintf(L"Out of memory\n");
    }

    return (SRWCond*)cond;
}

void SRWCondDestroy(SRWCond* cond)
{
    if (cond) {
        /* There are no kernel allocated resources */
        free(cond);
    }
}

int SRWCondSignal(SRWCond* cond)
{
    if (!cond) {
        dprintf(L"Passed a NULL condition variable\n");
        return -1;
    }

    WakeConditionVariable(&cond->cond);

    return 0;
}

int SRWCondBroadcast(SRWCond* cond)
{
    if (!cond) {
        dprintf(L"Passed a NULL condition variable\n");
        return -1;
    }

    WakeAllConditionVariable(&cond->cond);

    return 0;
}

int SRWCondWaitTimeout(SRWCond* cond, SRWMutex* mutex, uint32 ms)
{
    DWORD timeout;
    int ret;

    if (!cond) {
        dprintf(L"Passed a NULL condition variable\n");
        return -1;
    }
    if (!mutex) {
        dprintf(L"Passed a NULL mutex\n");
        return -1;
    }

    if (mutex->count != 1 || mutex->owner != GetCurrentThreadId()) {
        dprintf(L"Passed mutex is not locked or locked recursively\n");
        return -1;
    }

    if (ms == MUTEX_MAXWAIT) {
        timeout = INFINITE;
    } else {
        timeout = (DWORD)ms;
    }

    /* The mutex must be updated to the released state */
    mutex->count = 0;
    mutex->owner = 0;

    if (SleepConditionVariableSRW(&cond->cond, &mutex->srw, timeout, 0) == FALSE) {
        if (GetLastError() == ERROR_TIMEOUT) {
            ret = MUTEX_TIMEDOUT;
        } else {
            dprintf(L"SleepConditionVariableSRW() failed\n");
            ret = -1;
        }
    } else {
        ret = 0;
    }

    /* The mutex is owned by us again, regardless of status of the wait */
    assert(mutex->count == 0 && mutex->owner == 0);
    mutex->count = 1;
    mutex->owner = GetCurrentThreadId();

    return ret;
}

int SRWCondWait(SRWCond* cond, SRWMutex* mutex)
{
    return SRWCondWaitTimeout(cond, mutex, MUTEX_MAXWAIT);
}


// shmem
//
void VideoTexInfoDestroy(HANDLE hmap, void* addr)
{
    assert(((VideoTexInfo*)addr)->magic == 11114444);

    UnmapViewOfFile(addr);
    CloseHandle(hmap);
}

VideoTexInfo* VideoTexInfoCreate(HANDLE* hmap, const wchar_t* name)
{
    int count = 3;
    int pitch = Texture::calc_pitch(CAP_W);
    DWORD size = 1024 + CAP_H * pitch * count;

    *hmap = CreateFileMapping(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0, size, name);
    if (*hmap == NULL) {
        dprintf(L"%s(%d,%s) %s fail.\n", __funcw__, size, name, L"CreateFileMapping");
        return NULL;
    }

    VideoTexInfo* vtinfo = (VideoTexInfo*)MapViewOfFile(*hmap, FILE_MAP_ALL_ACCESS, 0, 0, size);
    if (vtinfo == NULL) {
        dprintf(L"%s(%d,%s) %s fail.\n", __funcw__, size, name, L"MapViewOfFile");
        CloseHandle(*hmap);
        return NULL;
    }

    vtinfo->magic = 11114444;
    vtinfo->size = size;

    vtinfo->count = count;
    vtinfo->pitch = pitch;
    vtinfo->width = CAP_W;
    vtinfo->height = CAP_H;
    vtinfo->offset = 1024;

    vtinfo->id = 0;
    vtinfo->index = 0;
    vtinfo->pts = 0.0;

    return vtinfo;
}

// texture
//

int UpdateTexture(Texture* texture, const ExRect* rect, const void* pixels, int pitch)
{
    dprintf(L"UpdateTexture()\n");
    //memcpy(texture->bits, pixels, pitch * texture->h);
    return 0;
}

int UpdateYUVTexture(Texture* texture,
                     const ExRect* rect,
                     const uint8* Yplane, int Ypitch,
                     const uint8* Uplane, int Upitch,
                     const uint8* Vplane, int Vpitch)
{
    //int i = 0;
    dprintf(L"UpdateYUVTexture()\n");
    //memcpy(texture->bits + i, Yplane, Ypitch * texture->h);
    //i += Ypitch * texture->h;
    //memcpy(texture->bits + i, Uplane, Upitch * texture->h);
    //i += Upitch * texture->h;
    //memcpy(texture->bits + i, Vplane, Vpitch * texture->h);
    //i += Vpitch * texture->h;
    return 0;
}

int UpdateNVTexture(Texture* texture,
                    const ExRect* rect,
                    const uint8* Yplane, int Ypitch,
                    const uint8* UVplane, int UVpitch)
{
    dprintf(L"UpdateNVTexture()\n");
    return 0;
}

int LockTexture(Texture* texture, const ExRect* rect, void** pixels, int* pitch)
{
    dprintf(L"LockTexture()\n");
    return 0;
}

void UnlockTexture(Texture* texture)
{
    dprintf(L"UnlockTexture()\n");
}

int RenderCopy(Texture* texture, const ExRect* srcrect, const ExRect* dstrect)
{
    dprintf(L"RenderCopy()\n");
    return 0;
}

int RenderCopyEx(Texture* texture,
                 const ExRect* srcrect,
                 const ExRect* dstrect,
                 const double angle,
                 const ExPoint* center,
                 const RendererFlip flip)
{
    dprintf(L"RenderCopyEx()\n");
    return 0;
}

void DestroyTexture(Texture* texture)
{
    dprintf(L"DestroyTexture()\n");
}

int Texture::alloc(int w, int h)
{
    //format = PIXELFORMAT_ARGB8888;
    this->w = w;
    this->h = h;
    bpl = calc_pitch(w);
    if (bits)
        free(bits);
    if (bpl * h) {
        bits = (uint8*)malloc(bpl * h);
        memset(bits, 0, bpl * h);
    } else {
        bits = NULL;
    }
    return bits ? 0 : -1;
}

int Texture::realloc(int w, int h)
{
    if (bits && this->w == w && this->h == h)
        return 0;
    return alloc(w, h);
}

void Texture::attach(int w, int h, uint8* bits)
{
    assert(this->bits == NULL);
    this->w = w;
    this->h = h;
    bpl = calc_pitch(w);
    this->bits = bits;
}

void Texture::copyNoClip(uint8* dbits, int dbpl, int dx, int dy, int sw, int sh) const
{
    uint8* sbits = bits;
    assert(sbits != dbits);
    dbits += dx * sizeof(uint32) + dy * dbpl;
    while (sh--) {
        memcpy(dbits, sbits, sw * sizeof(uint32));
        dbits += dbpl;
        sbits += bpl;
    }
}

// scaler : nearest-neighbor interpolation
//
void Texture::scaleNoClip(Texture* dst_tex, const Texture* src_tex, const int width, const int height)
{
    uint8* dbits = dst_tex->bits;
    const uint8* sbits = src_tex->bits;
    int digit_height = (src_tex->h / height) * src_tex->bpl;
    int fract_height = (src_tex->h % height);
    int error_height = 0;
    const uint8* prev_src = NULL;

    for (int i = 0; i < height; i++) {
        if (sbits == prev_src) {
            memcpy(dbits, dbits - dst_tex->bpl, width * sizeof(uint32));
        } else {
            uint32* dp = (uint32*)dbits;
            const uint32* sp = (uint32*)sbits;
            int digit_width = src_tex->w / width;
            int fract_width = src_tex->w % width;
            int error_width = 0;
            for (int j = 0; j < width; j++) {
                *dp++ = *sp;
                sp += digit_width;
                error_width += fract_width;
                if (error_width >= width) {
                    error_width -= width;
                    sp++;
                }
            }
            prev_src = sbits;
        }
        dbits += dst_tex->bpl;
        sbits += digit_height;
        error_height += fract_height;
        if (error_height >= height) {
            error_height -= height;
            sbits += src_tex->bpl;
        }
    }
}


// tbd - free_texture

// yuv to rgb (aosp/device/generic/goldfish/camera)
//
#if 1

/* An union that simplifies breaking 32 bit RGB into separate R, G, and B colors.
 */
typedef union RGB32_t {
    uint32_t    color;
    struct {
#if __BYTE_ORDER == __LITTLE_ENDIAN
        uint8_t r; uint8_t g; uint8_t b; uint8_t a;
#else   // __BYTE_ORDER
        uint8_t a; uint8_t b; uint8_t g; uint8_t r;
#endif  // __BYTE_ORDER
    };
} RGB32_t;

/* Clips a value to the unsigned 0-255 range, treating negative values as zero.
 */
static inline int
clamp(int x)
{
    if (x > 255) return 255;
    if (x < 0)   return 0;
    return x;
}

/*
 * YUV -> RGB conversion macros
 */

/* "Optimized" macros that take specialy prepared Y, U, and V values:
 *  C = Y - 16
 *  D = U - 128
 *  E = V - 128
 */
#define YUV2RO(C, D, E) clamp((298 * (C) + 409 * (E) + 128) >> 8)
#define YUV2GO(C, D, E) clamp((298 * (C) - 100 * (D) - 208 * (E) + 128) >> 8)
#define YUV2BO(C, D, E) clamp((298 * (C) + 516 * (D) + 128) >> 8)

 /* Converts YUV color to RGB32. */
static inline uint32_t
YUVToRGB32(int y, int u, int v)
{
    /* Calculate C, D, and E values for the optimized macro. */
    y -= 16; u -= 128; v -= 128;
    RGB32_t rgb;
    rgb.r = YUV2RO(y, u, v) & 0xff;
    rgb.g = YUV2GO(y, u, v) & 0xff;
    rgb.b = YUV2BO(y, u, v) & 0xff;
    return rgb.color;
}

void _YUV420SToRGB32(const uint8_t* Y,
                     const uint8_t* U,
                     const uint8_t* V,
                     int dUV,
                     uint32_t* rgb,
                     int width,
                     int height,
                     int y_stride,
                     int uv_stride)
{
    const uint8_t* Y_pos = Y;
    const uint8_t* U_pos = U;
    const uint8_t* V_pos = V;

    for (int y = 0; y < height; y++) {
        Y = Y_pos + y_stride * y;
        U = U_pos + uv_stride * (y / 2);
        V = V_pos + uv_stride * (y / 2);
        for (int x = 0; x < width; x += 2, U += dUV, V += dUV) {
            const uint8_t nU = *U;
            const uint8_t nV = *V;
            *rgb = YUVToRGB32(*Y, nU, nV);
            Y++; rgb++;
            *rgb = YUVToRGB32(*Y, nU, nV);
            Y++; rgb++;
        }
    }
}

// Align |value| to the next larger value that is divisible by |alignment|
// |alignment| has to be a power of 2.
inline int align(int value, int alignment) {
    return (value + alignment - 1) & (~(alignment - 1));
}

/* The YV12 and YU12 formats require that the row strides are aligned to 16 byte
 * boundaries as per the format specification at:
 * https://developer.android.com/reference/android/graphics/ImageFormat.html#YV12
 *
 * This means that we can't just use the width or assume that pixels are
 * tightly packed, we have to calculate aligned strides and use them to find the
 * next row.
 */
void _YV12ToRGB32(const void* yv12, void* rgb, int width, int height)
{
    // See note above about alignment
    const int y_stride = align(width, 16);
    const int uv_stride = align(y_stride / 2, 16);
    const uint8_t* Y = reinterpret_cast<const uint8_t*>(yv12);
    const uint8_t* V = Y + y_stride * height;
    const uint8_t* U = V + uv_stride * (height / 2);
    _YUV420SToRGB32(Y, U, V, 1, reinterpret_cast<uint32_t*>(rgb), width, height,
                    y_stride, uv_stride);
}

void _YU12ToRGB32(const void* yu12, void* rgb, int width, int height)
{
    // See note above about alignment
    const int y_stride = align(width, 16);
    const int uv_stride = align(y_stride / 2, 16);
    const uint8_t* Y = reinterpret_cast<const uint8_t*>(yu12);
    const uint8_t* U = Y + y_stride * height;
    const uint8_t* V = U + uv_stride * (height / 2);
    _YUV420SToRGB32(Y, U, V, 1, reinterpret_cast<uint32_t*>(rgb), width, height,
                    y_stride, uv_stride);
}

#endif

