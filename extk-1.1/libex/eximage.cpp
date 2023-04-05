/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include "eximage.h"
#ifdef __linux__
#include <strings.h>
#include <fcntl.h>
#endif
#include <assert.h>

ExImage::~ExImage()
{
    if (crs)
        cairo_surface_destroy(crs);
    if (bits)
        free(bits);
}

ExImage* // static
ExImage::create(int width, int height, int type)
{
    ExImage* image = new ExImage;
    assert(image != NULL);
    image->flags |= Ex_ImageFreeMemory;
    if (image->init(width, height, type)) {
        delete image;
        image = NULL;
    }
    return image;
}

int ExImage::init(int width, int height, int type)
{
    setInfo(width, height, type);
    this->flags |= Ex_ImageAlloc;
    if ((this->bits = (uint8*)malloc(getBitsSize())) == NULL) {
        exerror("%s(%d,%d,%08x) - malloc fail.\n", __func__, width, height, type);
        this->clear();
        return -1;
    }
    return 0;
}

int ExImage::setInfo(int width, int height, int type)
{
    assert(this->bits == NULL);
    int bpp = getBitsPerPixel(type);
    if (bpp == 0 || width <= 0 || height <= 0) {
        exerror("%s(%d,%d,%08x) - invalid param.\n", __func__, width, height, type);
        return -1;
    }
    this->flags |= Ex_ImageQuery;
    this->type = type;
    this->bpp = bpp;
    this->bpl = getBytesPerLine(width, bpp);
    this->width = width;
    this->height = height;
    return 0;
}

#ifdef WIN32
int ExImage::load(const char* fname, bool query)
{
    if (crs != NULL || bits != NULL) {
        exerror("%s - loaded\n", __func__);
        clear();
    }
    if (!(fname && *fname)) {
        exerror("%s - invalid filename.\n", __func__);
        return -1;
    }
    const char* ext = NULL;
    for (const char* p = fname; *p; p++)
        if (*p == '.') ext = p + 1;
    if (ext == NULL) {
        exerror("%s(%s) - invalid extension.\n", __func__, fname);
        return NULL;
    }
    HANDLE hFile = CreateFile(fname, GENERIC_READ, 0, NULL,
                              OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (hFile == INVALID_HANDLE_VALUE) {
        exerror("%s(%s) - CreateFile fail.\n", __func__, fname);
        return NULL;
    }
    int r = -1;
    DWORD dwRead = 0;
    unsigned char hdr[8];
    ReadFile(hFile, hdr, 8, &dwRead, NULL);
    SetFilePointer(hFile, 0, NULL, FILE_BEGIN);
    if (_strnicmp(ext, "png", 3) == 0) {
        assert(hdr[0] == 0x89 && hdr[1] == 'P' && hdr[2] == 'N' && hdr[3] == 'G');
        this->format = Ex_IMM_PNG;
        r = this->loadPng(hFile, fname, query);
        goto clean;
    }
#if 1
    if (_strnicmp(ext, "bmp", 3) == 0) {
        assert(hdr[0] == 'B' && hdr[1] == 'M');
        this->format = Ex_IMM_BMP;
        r = this->loadBmp(hFile, fname, query);
        goto clean;
    }
    if (_strnicmp(ext, "jp", 2) == 0) {
        CloseHandle(hFile);
        assert(hdr[0] == 0xff && hdr[1] == 0xd8);
        this->format = Ex_IMM_JPG;
        r = this->loadJpg(NULL, fname, query);
        goto done;
    }
#endif
    exerror("%s(%s) - unknown image format.\n", __func__, fname);
clean:
    CloseHandle(hFile);
done:
    if (r == 0 && bpp == 32 &&
        type == Ex_IMAGE_DIRECT_8888 &&
        format == Ex_IMM_PNG) {
        preMultiply();
    }
    if (r == 0) {
        cairo_status_t status;
        cairo_format_t format = CAIRO_FORMAT_ARGB32;
        int stride = cairo_format_stride_for_width(format, width);
        crs = cairo_image_surface_create_for_data(bits, format, width, height, stride);
        assert(stride == bpl);
        status = cairo_surface_status(crs);
        if (status != CAIRO_STATUS_SUCCESS) {
            exerror("%s: %s\n", __func__, cairo_status_to_string(status));
            //cairo_surface_destroy(crs);
            clear();
            return -1;
        }
    }
    return r;
}
#else // compat linux
int ExImage::load(const char* fname, bool query)
{
    if (crs != NULL || bits != NULL) {
        exerror("%s - loaded\n", __func__);
        clear();
    }
    if (!(fname && *fname)) {
        exerror("%s - invalid filename.\n", __func__);
        return -1;
    }
    const char* ext = NULL;
    for (const char* p = fname; *p; p++)
        if (*p == '.') ext = p + 1;
    if (ext == NULL) {
        exerror("%s(%s) - invalid extension.\n", __func__, fname);
        return -1;
    }
    int fd = open(fname, O_RDONLY);
    if (fd < 0) {
        exerror("%s(%s) - %s fail. %s\n", __func__, fname, "open", strerror(errno));
        return -1;
    }
    int r = -1;
    unsigned char hdr[8];
    if (read(fd, hdr, 8) < 4)
        exerror("%s(%s) - %s fail. %s\n", __func__, fname, "read", strerror(errno));
    if (lseek(fd, 0, SEEK_SET) != 0)
        exerror("%s(%s) - %s fail. %s\n", __func__, fname, "seek", strerror(errno));
    if (strncasecmp(ext, "png", 3) == 0) {
        assert(hdr[0] == 0x89 && hdr[1] == 'P' && hdr[2] == 'N' && hdr[3] == 'G');
        this->format = Ex_IMM_PNG;
        r = this->loadPng(fd, fname, query);
        goto clean;
    }
#if 1
    if (strncasecmp(ext, "bmp", 3) == 0) {
        assert(hdr[0] == 'B' && hdr[1] == 'M');
        this->format = Ex_IMM_BMP;
        r = this->loadBmp(fd, fname, query);
        goto clean;
    }
    if (strncasecmp(ext, "jp", 2) == 0) {
        close(fd);
        assert(hdr[0] == 0xff && hdr[1] == 0xd8);
        this->format = Ex_IMM_JPG;
        r = this->loadJpg(0, fname, query);
        goto done;
    }
#endif
    exerror("%s(%s) - unknown image format.\n", __func__, fname);
clean:
    close(fd);
done:
    if (r == 0 && bpp == 32 &&
        type == Ex_IMAGE_DIRECT_8888 &&
        format == Ex_IMM_PNG) {
        preMultiply();
    }
    if (r == 0) {
        cairo_status_t status;
        cairo_format_t format = CAIRO_FORMAT_ARGB32;
        int stride = cairo_format_stride_for_width(format, width);
        crs = cairo_image_surface_create_for_data(bits, format, width, height, stride);
        assert(stride == bpl);
        status = cairo_surface_status(crs);
        if (status != CAIRO_STATUS_SUCCESS) {
            exerror("%s: %s\n", __func__, cairo_status_to_string(status));
            //cairo_surface_destroy(crs);
            clear();
            return -1;
        }
    }
    return r;
}
#endif

void ExImage::preMultiply()
{
    // color_type == PNG_COLOR_TYPE_RGB_ALPHA
    for (int h = 0; h < height; h++) {
        uint8* dp = bits + bpl * h;
        for (int w = 0; w < width; w++) {
            /* Premultiplies data and converts RGBA bytes => native endian */
            uint32 color = *(uint32*)dp;
            uint32 alpha = color >> 24;
            if (alpha == 0) {
                *(uint32*)dp = 0;
            } else if (alpha != 0xff) {
#if 1 // rb simd
                uint32 t1 = color & 0x00ff00ff; // rb
                uint32 t2 = (color >> 8) & 0xff; // g
                color &= 0xff000000;
                t1 = (t1*alpha) + 0x00800080;
                t1 = (t1 + ((t1 >> 8) & 0x00ff00ff)) >> 8;
                t2 = (t2*alpha) + 0x80;
                t2 = (t2 + (t2 >> 8)) >> 8;
                color |= ((t1 & 0x00ff00ff) | (t2 << 8));
#else
                uint32 t1 = color & 0xff;
                uint32 t2 = (color >> 8) & 0xff;
                uint32 t3 = (color >> 16) & 0xff;
                color &= 0xff000000;
                t1 = (t1*alpha) + 0x80;
                t1 = (t1 + (t1 >> 8)) >> 8;
                t2 = (t2*alpha) + 0x80;
                t2 = (t2 + (t2 >> 8)) >> 8;
                t3 = (t3*alpha) + 0x80;
                t3 = (t3 + (t3 >> 8)) >> 8;
                color |= (t1 | (t2 << 8) | (t3 << 16));
#endif
                *(uint32*)dp = color;
            }
            dp += 4;
        } // for w
    } // for h
}
