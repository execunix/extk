/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <eximage.h>
#include <pngpriv.h>
#include <stdio.h>

#pragma comment(lib, "libpng.lib")

static void
png_read_data(png_structp png_ptr, png_bytep data, png_size_t length)
{
    HANDLE hFile = png_ptr->io_ptr;
    DWORD dwRead = 0;
    ReadFile(hFile, data, (DWORD)length, &dwRead, NULL);
    if (dwRead != length) {
        exerror(L"%s - read error.\n", __funcw__);
        png_error(png_ptr, "read error");
    }
}

static void
png_write_data(png_structp png_ptr, png_bytep data, png_size_t length)
{
    HANDLE hFile = png_ptr->io_ptr;
    DWORD dwWritten = 0;
    WriteFile(hFile, data, (DWORD)length, &dwWritten, NULL);
    if (dwWritten != length) {
        exerror(L"%s - write error.\n", __funcw__);
        png_error(png_ptr, "write error");
    }
}

static void
png_flush(png_structp png_ptr)
{
    HANDLE hFile = png_ptr->io_ptr;
    FlushFileBuffers(hFile);
}

int ExImage::savePng(HANDLE hFile)
{
    // TBD
    png_structp png_ptr = NULL;
    png_set_write_fn(png_ptr, (png_voidp)hFile, png_write_data, png_flush);
    return 0;
}

int ExImage::loadPng(HANDLE hFile, const wchar* fname, bool query)
{
    DWORD dwRead = 0;
    int jmpret = 0;
#if 0
    png_byte pbSig[8];
    ReadFile(hFile, pbSig, 8, &dwRead, NULL);
    if (!png_check_sig(pbSig, 8)) {
        return NULL;
    }
#endif
    png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if (!png_ptr) {
        exerror(L"%s(%s) - png_create_read_struct fail.\n", __funcw__, fname);
        return -1;
    }
    png_infop info_ptr = png_create_info_struct(png_ptr);
    if (!info_ptr) {
        exerror(L"%s(%s) - png_create_info_struct fail.\n", __funcw__, fname);
        png_destroy_read_struct(&png_ptr, NULL, NULL);
        return -1;
    }
//	png_set_error_fn(png_ptr, error_ptr, error_fn, warn_fn);
    png_byte* data = NULL;
    png_byte** ptrs = NULL;
    // try
    jmpret = setjmp(png_jmpbuf(png_ptr));
    // catch
    if (jmpret != 0) {
        png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
        this->clear();
        if (ptrs) free(ptrs);
        if (data) free(data);
        return -1;
    }
    png_set_read_fn(png_ptr, (png_voidp)hFile, png_read_data);
    png_set_sig_bytes(png_ptr, dwRead);

    png_uint_32 width;
    png_uint_32 height;
    int bit_depth;
    int color_type;
    int interlace_type;
    int compression_type;
    int filter_type;

    png_read_info(png_ptr, info_ptr);
    png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type, &interlace_type, &compression_type, &filter_type);

    /* convert palette/gray image to rgb */
    if (color_type == PNG_COLOR_TYPE_PALETTE) {
        png_set_palette_to_rgb(png_ptr);
    //	png_set_expand(png_ptr);
    }
    /* expand gray bit depth if needed */
    if (color_type == PNG_COLOR_TYPE_GRAY) {
        png_set_expand_gray_1_2_4_to_8(png_ptr);
    }
    /* transform transparency to alpha */
    if (png_get_valid(png_ptr, info_ptr, PNG_INFO_tRNS)) {
        png_set_tRNS_to_alpha(png_ptr);
    //	png_set_expand(png_ptr);
    }
    if (bit_depth == 16) {
        png_set_strip_16(png_ptr);
    }
    if (bit_depth < 8) {
        png_set_packing(png_ptr);
    //	png_set_expand(png_ptr);
    }
    /* convert grayscale to RGB */
    if (color_type == PNG_COLOR_TYPE_GRAY ||
        color_type == PNG_COLOR_TYPE_GRAY_ALPHA) {
        png_set_gray_to_rgb(png_ptr);
#if 0
    } else
        if (color_type == PNG_COLOR_TYPE_RGB ||
            color_type == PNG_COLOR_TYPE_RGB_ALPHA) {
            png_set_bgr(png_ptr);
#endif
    }
    if (interlace_type != PNG_INTERLACE_NONE) {
        png_set_interlace_handling(png_ptr);
    }

    png_set_filler(png_ptr, 0xff, PNG_FILLER_AFTER);

    png_color my_background = { 0, };
    png_color_16* image_background = NULL;

    if (png_get_bKGD(png_ptr, info_ptr, &image_background)) {
        png_set_background(png_ptr, image_background, PNG_BACKGROUND_GAMMA_FILE, 1, 1.0);
        my_background.red = (png_byte)image_background->red;
        my_background.green = (png_byte)image_background->green;
        my_background.blue = (png_byte)image_background->blue;
    } else {
        image_background = NULL;
    }
    double image_gamma;
    if (png_get_gAMA(png_ptr, info_ptr, &image_gamma)) {
        double screen_gamma = 1.0; // 2.2: PC bright, 2.0: PC dark, 1.0 Mac
        png_set_gamma(png_ptr, screen_gamma, image_gamma);
    }
    /* recheck header after setting EXPAND options */
    png_read_update_info(png_ptr, info_ptr);
    png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type, &interlace_type, &compression_type, &filter_type);
    if (bit_depth != 8) {
        exerror(L"%s(%s) - png bpp error.\n", __funcw__, fname);
        png_error(png_ptr, "png bpp error");
    }
    if (color_type == PNG_COLOR_TYPE_RGB ||
        color_type == PNG_COLOR_TYPE_RGB_ALPHA) {
        png_set_bgr(png_ptr);
    } else {
        exerror(L"%s(%s) - png rgb error.\n", __funcw__, fname);
        png_error(png_ptr, "png rgb error");
    }

    png_uint_32 rowbytes = png_get_rowbytes(png_ptr, info_ptr); // width * channels
    png_uint_32 channels = png_get_channels(png_ptr, info_ptr); // bpp = channels*8

#if 1 // compatible with cairo
    int type = Ex_IMAGE_DIRECT_8888;
#else
    int type = 0;
    if (color_type == PNG_COLOR_TYPE_RGB_ALPHA) {
        type = Ex_IMAGE_DIRECT_8888;
    } else {
        type = Ex_IMAGE_DIRECT_888;
    }
#endif
    int r = -1;
    if (query) {
        r = this->setInfo(width, height, type);
        goto png_cleanup;
    }
    if ((r = this->init(width, height, type)) != 0) {
        exerror(L"%s(%s) - image alloc fail.\n", __funcw__, fname);
        png_error(png_ptr, "image alloc fail");
        goto png_cleanup;
    }

    if (image_background) {
        uint32 r = image_background->red;
        uint32 g = image_background->green;
        uint32 b = image_background->blue;
        this->chroma = ExRGB(r, g, b);
    }
    ptrs = (png_byte**)malloc(this->height * sizeof(png_byte*));
    if (ptrs == NULL) {
        exerror(L"%s(%s) - malloc ptrs fail.\n", __funcw__, fname);
        png_error(png_ptr, "malloc ptrs fail");
    }
    for (int h = 0; h < this->height; h++) {
        ptrs[h] = this->bits + this->bpl*h;
    }
    png_read_image(png_ptr, ptrs);
    png_read_end(png_ptr, NULL);

png_cleanup:

    png_destroy_read_struct(&png_ptr, &info_ptr, NULL);

    if (ptrs) free(ptrs);
    if (data) free(data);

    return r;
}

