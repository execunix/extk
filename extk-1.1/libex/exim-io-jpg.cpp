/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifdef __linux__
#include <fcntl.h>
#endif
#include <stdio.h>
#include <setjmp.h>
#include <jpeglib.h>
#include "eximage.h"

#if defined(_MSC_VER)
#pragma comment(lib, "libjpeg.lib")
#endif

static jmp_buf jpg_setjmp_buffer;

static void jpg_error_exit(j_common_ptr cinfo)
{
    char buffer[JMSG_LENGTH_MAX];
    (*cinfo->err->format_message)(cinfo, buffer);
    dprint1("jpg_error: %s\n", buffer);
    longjmp(jpg_setjmp_buffer, 1);
}

#ifdef WIN32
int ExImage::loadJpg(HANDLE hFile, const wchar* fname, bool query)
{
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    JSAMPARRAY buffer;
    int row_stride;
    FILE* infile;
    int r = -1;

    if ((infile = _wfopen(fname, L"rb")) == NULL) {
        exerror(L"%s(%s) - open fail.\n", __funcw__, fname);
        return -1;
    }
    cinfo.err = jpeg_std_error(&jerr);
    jerr.error_exit = jpg_error_exit;
    if (setjmp(jpg_setjmp_buffer)) {
        jpeg_destroy_decompress(&cinfo);
        fclose(infile);
        this->clear();
        return -1;
    }
    jpeg_create_decompress(&cinfo);
    jpeg_stdio_src(&cinfo, infile);
    jpeg_read_header(&cinfo, TRUE);

    cinfo.out_color_space = JCS_RGB;
    cinfo.dct_method = JDCT_FASTEST;
    cinfo.do_fancy_upsampling = FALSE;
    cinfo.two_pass_quantize = FALSE;
    cinfo.scale_num = 1;
    cinfo.scale_denom = 2;
    jpeg_calc_output_dimensions(&cinfo);
    if (cinfo.progressive_mode) {
        exerror(L"%s(%s) - progressive_mode.\n", __funcw__, fname);
        goto jpg_cleanup;
    }
    if (query) {
        r = this->setInfo(cinfo.output_width, cinfo.output_height, Ex_IMAGE_DIRECT_8888);
        goto jpg_cleanup;
    }
    if ((r = this->init(cinfo.output_width, cinfo.output_height, Ex_IMAGE_DIRECT_8888)) != 0) {
        goto jpg_cleanup;
    }
    jpeg_start_decompress(&cinfo);
    row_stride = cinfo.output_width * cinfo.output_components;
    buffer = (*cinfo.mem->alloc_sarray)((j_common_ptr)&cinfo, JPOOL_IMAGE, row_stride, 1);
    while (cinfo.output_scanline < cinfo.output_height) {
        uint8* dst_ptr = this->bits + this->bpl * cinfo.output_scanline;
        uint8* src_ptr = buffer[0];
        jpeg_read_scanlines(&cinfo, buffer, 1);
        for (uint x = 0; x < cinfo.output_width; x++) {
            *dst_ptr++ = src_ptr[2];
            *dst_ptr++ = src_ptr[1];
            *dst_ptr++ = src_ptr[0];
            *dst_ptr++ = 0xff;
            src_ptr += 3;
        }
    }
    jpeg_finish_decompress(&cinfo);
jpg_cleanup:
    jpeg_destroy_decompress(&cinfo);
    fclose(infile);
    if (jerr.num_warnings) {
        dprint("jerr.num_warnings=%d\n", jerr.num_warnings);
    }
    return r;
}
#else // compat linux
int ExImage::loadJpg(int fd, const char* fname, bool query)
{
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    JSAMPARRAY buffer;
    int row_stride;
    FILE* infile;
    int r = -1;

    if ((infile = fopen(fname, "rb")) == NULL) {
        exerror("%s(%s) - open fail.\n", __func__, fname);
        return -1;
    }
    cinfo.err = jpeg_std_error(&jerr);
    jerr.error_exit = jpg_error_exit;
    if (setjmp(jpg_setjmp_buffer)) {
        jpeg_destroy_decompress(&cinfo);
        fclose(infile);
        this->clear();
        return -1;
    }
    jpeg_create_decompress(&cinfo);
    jpeg_stdio_src(&cinfo, infile);
    jpeg_read_header(&cinfo, TRUE);

    cinfo.out_color_space = JCS_RGB;
    cinfo.dct_method = JDCT_FASTEST;
    cinfo.do_fancy_upsampling = FALSE;
    cinfo.two_pass_quantize = FALSE;
    cinfo.scale_num = 1;
    cinfo.scale_denom = 2;
    jpeg_calc_output_dimensions(&cinfo);
    if (cinfo.progressive_mode) {
        exerror("%s(%s) - progressive_mode.\n", __func__, fname);
        goto jpg_cleanup;
    }
    if (query) {
        r = this->setInfo(cinfo.output_width, cinfo.output_height, Ex_IMAGE_DIRECT_8888);
        goto jpg_cleanup;
    }
    if ((r = this->init(cinfo.output_width, cinfo.output_height, Ex_IMAGE_DIRECT_8888)) != 0) {
        goto jpg_cleanup;
    }
    jpeg_start_decompress(&cinfo);
    row_stride = cinfo.output_width * cinfo.output_components;
    buffer = (*cinfo.mem->alloc_sarray)((j_common_ptr)&cinfo, JPOOL_IMAGE, row_stride, 1);
    while (cinfo.output_scanline < cinfo.output_height) {
        uint8* dst_ptr = this->bits + this->bpl * cinfo.output_scanline;
        uint8* src_ptr = buffer[0];
        jpeg_read_scanlines(&cinfo, buffer, 1);
        for (uint x = 0; x < cinfo.output_width; x++) {
            *dst_ptr++ = src_ptr[2];
            *dst_ptr++ = src_ptr[1];
            *dst_ptr++ = src_ptr[0];
            *dst_ptr++ = 0xff;
            src_ptr += 3;
        }
    }
    jpeg_finish_decompress(&cinfo);
jpg_cleanup:
    jpeg_destroy_decompress(&cinfo);
    fclose(infile);
    if (jerr.num_warnings) {
        dprint("jerr.num_warnings=%d\n", jerr.num_warnings);
    }
    return r;
}
#endif
