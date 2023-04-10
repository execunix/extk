/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "eximage.h"
#ifdef __linux__
#include <fcntl.h>
#endif

#define BMP24_CHROMA

#define BMP_BPL(w,bpp)  ((((w)*(bpp)+7)/8 + (sizeof(uint32)-1)) & ~(sizeof(uint32)-1))

#ifdef WIN32
bool ExImage::loadBmp(HANDLE hFile, const char_t* fname, bool query)
{
    BITMAPFILEHEADER bf;
    BITMAPINFOHEADER bi;
    //RGBQUAD* cm; // colormap
    DWORD dwRead;
    uint8* src_buf = NULL;

    memset(&bf, 0, sizeof(bf));
    memset(&bi, 0, sizeof(bi));
    if (!ReadFile(hFile, &bf, sizeof(bf), &dwRead, NULL) ||
        dwRead != sizeof(bf)) {
        goto bmp_cleanup;
    }
    if (!ReadFile(hFile, &bi, sizeof(bi), &dwRead, NULL) ||
        dwRead != sizeof(bi)) {
        goto bmp_cleanup;
    }
    if (bi.biBitCount != 32 &&
        bi.biBitCount != 24 &&
        bi.biBitCount != 16) {
        goto bmp_cleanup;
    }
    if (bi.biCompression != BI_RGB) {
        goto bmp_cleanup;
    }
    if (query) {
        return this->setInfo(bi.biWidth, bi.biHeight, Ex_IMAGE_DIRECT_8888);
    }
    if (this->init(bi.biWidth, bi.biHeight, Ex_IMAGE_DIRECT_8888) != true) {
        goto bmp_cleanup;
    }

    SetFilePointer(hFile, bf.bfOffBits, NULL, FILE_BEGIN);

    int32 src_bpl = BMP_BPL(bi.biWidth, bi.biBitCount);
    int32 src_width = bi.biWidth;
    int32 src_height = bi.biHeight;
    //int32 src_offbpl = src_bpl;
    src_buf = new uint8[src_bpl];
    if (src_buf == NULL)
        goto bmp_cleanup;
    uint8* dst_ptr = this->bits;
    int32 dst_offbpl = this->bpl;
    // If biHeight is positive, the bitmap is a bottom-up DIB and its origin is the lower left corner.
    // If biHeight is negative, the bitmap is a top-down DIB and its origin is the upper left corner.
    if (src_height > 0) {
        dst_ptr += this->bpl * (this->height - 1);
        dst_offbpl = -dst_offbpl;
    } else {
        src_height = -src_height;
    }
    int32 x_delta = src_width * this->bpp / 8;
    int32 y_count = src_height;

    if (bi.biBitCount == 16) {
        for (; y_count > 0; y_count--) {
            if (!ReadFile(hFile, src_buf, src_bpl, &dwRead, NULL) ||
                dwRead != src_bpl) goto bmp_cleanup;
            void* dp_end = dst_ptr + x_delta;
            UINT* dp = (UINT*)dst_ptr;
            WORD* sp = (WORD*)src_buf;
            while ((void*)dp < dp_end) {
                UINT c = *sp++;
                c = Ex555to8888(c);
                c |= 0xff000000;
                *dp++ = c;
            }
            dst_ptr += dst_offbpl;
        }
    } else if (bi.biBitCount == 24) {
        for (; y_count > 0; y_count--) {
            if (!ReadFile(hFile, src_buf, src_bpl, &dwRead, NULL) ||
                dwRead != src_bpl) goto bmp_cleanup;
            void* dp_end = dst_ptr + x_delta;
            UINT* dp = (UINT*)dst_ptr;
            BYTE* sp = (BYTE*)src_buf;
            while ((void*)dp < dp_end) {
                UINT b = *sp++;
                UINT g = *sp++;
                UINT r = *sp++;
                *dp++ = (0xff000000 | (r << 16) | (g << 8) | b);
                //*dp++ = ExARGB(0xff, sp[2], sp[1], sp[0]);
                //sp += 3;
            }
            dst_ptr += dst_offbpl;
        }
    } else if (bi.biBitCount == 32) {
        for (; y_count > 0; y_count--) {
            if (!ReadFile(hFile, src_buf, src_bpl, &dwRead, NULL) ||
                dwRead != src_bpl) goto bmp_cleanup;
            void* dp_end = dst_ptr + x_delta;
            UINT* dp = (UINT*)dst_ptr;
            UINT* sp = (UINT*)src_buf;
            while ((void*)dp < dp_end) {
                UINT c = *sp++;
                c |= 0xff000000;
                *dp++ = c;
            }
            dst_ptr += dst_offbpl;
        }
    }
    delete[] src_buf;
    return true;

bmp_cleanup:
    exerror("%s(%s) - error.\n", __func__, fname);
    if (src_buf)
        delete[] src_buf;
    this->clear();
    return false;
}
#else // compat linux
bool ExImage::loadBmp(int32 fd, const char_t* fname, bool query)
{
    BITMAPFILEHEADER bf;
    BITMAPINFOHEADER bi;
    //RGBQUAD* cm; // colormap
    uint32 cmap[256]; // colormap
    uint8* src_buf = NULL;

    do {
        memset(&bf, 0, sizeof(bf));
        memset(&bi, 0, sizeof(bi));
        if (read(fd, &bf, sizeof(bf)) != sizeof(bf)) {
            goto bmp_cleanup;
        }
        if (read(fd, &bi, sizeof(bi)) != sizeof(bi)) {
            goto bmp_cleanup;
        }
        if (bi.biBitCount < 8) {
            exerror("%s(%s) %d-bpp not support\n", __func__, fname, bi.biBitCount);
            goto bmp_cleanup;
        } else if (bi.biBitCount == 8) {
            if (read(fd, cmap, sizeof(cmap)) != sizeof(cmap)) {
                exerror("%s(%s) invalid colormap\n", __func__, fname);
                goto bmp_cleanup;
            }
            chroma &= 0xfefefe; // tolerant 1-bit
            for (int32 i = 0; i < 256; i++) {
                bool cc = (chroma && ((cmap[i] & 0xfefefe) == chroma));
                bool ac = ((cmap[i] & 0xfc000000) == 0xfc000000);
                // tbd - check endian
                if (!(cc || ac))
                    cmap[i] |= 0xff000000;
                else
                    cmap[i] = 0;
            }
        }
        if (bi.biCompression != BI_RGB) {
            exerror("%s(%s) not rgb bitmap\n", __func__, fname);
            goto bmp_cleanup;
        }
        if (query) {
            return this->setInfo(bi.biWidth, bi.biHeight, Ex_IMAGE_DIRECT_8888);
        }
        if (this->init(bi.biWidth, bi.biHeight, Ex_IMAGE_DIRECT_8888) != true) {
            goto bmp_cleanup;
        }

        if (lseek(fd, bf.bfOffBits, SEEK_SET) < 0)
            exerror("%s(%s) - %s fail. %s\n", __func__, fname, "seek", exstrerr());

        int32 src_bpl = BMP_BPL(bi.biWidth, bi.biBitCount);
        int32 src_width = bi.biWidth;
        int32 src_height = bi.biHeight;
        //int32 src_offbpl = src_bpl;
        src_buf = new uint8[src_bpl];
        if (src_buf == NULL)
            goto bmp_cleanup;
        uint8* dst_ptr = this->bits;
        int32 dst_offbpl = this->bpl;
        // If biHeight is positive, the bitmap is a bottom-up DIB and its origin is the lower left corner.
        // If biHeight is negative, the bitmap is a top-down DIB and its origin is the upper left corner.
        if (src_height > 0) {
            dst_ptr += this->bpl * (this->height - 1);
            dst_offbpl = -dst_offbpl;
        } else {
            src_height = -src_height;
        }
        int32 x_delta = src_width * this->bpp / 8;
        int32 y_count = src_height;

        if (bi.biBitCount == 8) {
            for (; y_count > 0; y_count--) {
                if (read(fd, src_buf, src_bpl) != src_bpl)
                    goto bmp_cleanup;
                void* dp_end = dst_ptr + x_delta;
                uint32* dp = (uint32*)dst_ptr;
                uint8* sp = (uint8*)src_buf;
                while ((void*)dp < dp_end) {
                    uint8 c = *sp++;
                    *dp++ = cmap[c];
                }
                dst_ptr += dst_offbpl;
            }
        } else if (bi.biBitCount == 16) {
            for (; y_count > 0; y_count--) {
                if (read(fd, src_buf, src_bpl) != src_bpl)
                    goto bmp_cleanup;
                void* dp_end = dst_ptr + x_delta;
                uint32* dp = (uint32*)dst_ptr;
                uint16* sp = (uint16*)src_buf;
                while ((void*)dp < dp_end) {
                    uint32 c = *sp++;
                    c = Ex555to8888(c);
                    c |= 0xff000000;
                    *dp++ = c;
                }
                dst_ptr += dst_offbpl;
            }
        } else if (bi.biBitCount == 24) {
            for (; y_count > 0; y_count--) {
                if (read(fd, src_buf, src_bpl) != src_bpl)
                    goto bmp_cleanup;
                void* dp_end = dst_ptr + x_delta;
                uint32* dp = (uint32*)dst_ptr;
                uint8* sp = src_buf;
                while ((void*)dp < dp_end) {
                    uint32 b = *sp++;
                    uint32 g = *sp++;
                    uint32 r = *sp++;
#ifdef BMP24_CHROMA
                    uint32 rgb = (r << 16) | (g << 8) | b;
                    if (!(chroma && chroma == rgb))
                        rgb |= 0xff000000;
                    else
                        rgb = 0;
                    *dp++ = rgb;
#else
                    *dp++ = (0xff000000 | (r << 16) | (g << 8) | b);
                    //*dp++ = ExARGB(0xff, sp[2], sp[1], sp[0]);
                    //sp += 3;
#endif
                }
                dst_ptr += dst_offbpl;
            }
        } else if (bi.biBitCount == 32) {
            for (; y_count > 0; y_count--) {
                if (read(fd, src_buf, src_bpl) != src_bpl)
                    goto bmp_cleanup;
                void* dp_end = dst_ptr + x_delta;
                uint32* dp = (uint32*)dst_ptr;
                uint32* sp = (uint32*)src_buf;
                while ((void*)dp < dp_end) {
                    uint32 rgb = *sp++;
#ifdef BMP32_CHROMA
                    if (!(chroma && chroma == rgb))
                        rgb |= 0xff000000;
                    else
                        rgb = 0;
#else
                    rgb |= 0xff000000;
#endif
                    *dp++ = rgb;
                }
                dst_ptr += dst_offbpl;
            }
        }
        delete[] src_buf;
        return true;
    } while (0);

bmp_cleanup:
    exerror("%s(%s) - error.\n", __func__, fname);
    if (src_buf)
        delete[] src_buf;
    this->clear();
    return false;
}
#endif
