/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#include "ffctx.h"

extern "C" {
#include "libavcodec/avcodec.h"
#include "libavfilter/avfilter.h"
#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
#include "libavutil/display.h"
#include "libavutil/opt.h"
}

// merge cmdutils.c
//

void FFCtx::init_opts(void)
{
    av_dict_set(&sws_dict, "flags", "bicubic", 0);
}

void FFCtx::uninit_opts(void)
{
    av_dict_free(&swr_opts);
    av_dict_free(&sws_dict);
    av_dict_free(&format_opts);
    av_dict_free(&codec_opts);

    sws_dict = NULL;
    swr_opts = NULL;
    format_opts = NULL;
    codec_opts = NULL;
}

void FFCtx::exit_program(int ret)
{
    dprintf(L"call exit_program(%d)\n", ret);
    PostQuitMessage(0);
    //exit(ret);
}

void FFCtx::print_error(const char* filename, int err)
{
    char errbuf[128];
    const char* errbuf_ptr = errbuf;

    if (av_strerror(err, errbuf, sizeof(errbuf)) < 0)
        errbuf_ptr = strerror(AVUNERROR(err));
    av_log(NULL, AV_LOG_ERROR, "%s: %s\n", filename, errbuf_ptr);
}

int FFCtx::check_stream_specifier(AVFormatContext* s, AVStream* st, const char* spec)
{
    int ret = avformat_match_stream_specifier(s, st, spec);
    if (ret < 0)
        av_log(s, AV_LOG_ERROR, "Invalid stream specifier: %s.\n", spec);
    return ret;
}

AVDictionary* FFCtx::filter_codec_opts(AVDictionary* opts, AVCodecID codec_id,
                                       AVFormatContext* s, AVStream* st, const AVCodec* codec)
{
    AVDictionary* ret = NULL;
    const AVDictionaryEntry* t = NULL;
    int            flags = s->oformat ? AV_OPT_FLAG_ENCODING_PARAM
        : AV_OPT_FLAG_DECODING_PARAM;
    char          prefix = 0;
    const AVClass* cc = avcodec_get_class();

    if (!codec)
        codec = s->oformat ? avcodec_find_encoder(codec_id)
        : avcodec_find_decoder(codec_id);

    switch (st->codecpar->codec_type) {
        case AVMEDIA_TYPE_VIDEO:
            prefix = 'v';
            flags |= AV_OPT_FLAG_VIDEO_PARAM;
            break;
        case AVMEDIA_TYPE_AUDIO:
            prefix = 'a';
            flags |= AV_OPT_FLAG_AUDIO_PARAM;
            break;
        case AVMEDIA_TYPE_SUBTITLE:
            prefix = 's';
            flags |= AV_OPT_FLAG_SUBTITLE_PARAM;
            break;
    }

    while (t = av_dict_get(opts, "", t, AV_DICT_IGNORE_SUFFIX)) {
        const AVClass* priv_class;
        char* p = strchr(t->key, ':');

        /* check stream specification in opt name */
        if (p)
            switch (check_stream_specifier(s, st, p + 1)) {
                case  1: *p = 0; break;
                case  0:         continue;
                default:         exit_program(1);
            }

        if (av_opt_find(&cc, t->key, NULL, flags, AV_OPT_SEARCH_FAKE_OBJ) ||
            !codec ||
            ((priv_class = codec->priv_class) &&
             av_opt_find(&priv_class, t->key, NULL, flags,
                         AV_OPT_SEARCH_FAKE_OBJ)))
            av_dict_set(&ret, t->key, t->value, 0);
        else if (t->key[0] == prefix &&
                 av_opt_find(&cc, t->key + 1, NULL, flags,
                             AV_OPT_SEARCH_FAKE_OBJ))
            av_dict_set(&ret, t->key + 1, t->value, 0);

        if (p)
            *p = ':';
    }
    return ret;
}

AVDictionary** FFCtx::setup_find_stream_info_opts(AVFormatContext* s,
                                                  AVDictionary* codec_opts)
{
    unsigned int i;
    AVDictionary** opts;

    if (!s->nb_streams)
        return NULL;
    opts = (AVDictionary**)av_calloc(s->nb_streams, sizeof(*opts));
    if (!opts) {
        av_log(NULL, AV_LOG_ERROR,
               "Could not alloc memory for stream options.\n");
        exit_program(1);
    }
    for (i = 0; i < s->nb_streams; i++)
        opts[i] = filter_codec_opts(codec_opts, s->streams[i]->codecpar->codec_id,
                                    s, s->streams[i], NULL);
    return opts;
}

void* FFCtx::grow_array(void* array, int elem_size, int* size, int new_size)
{
    if (new_size >= INT_MAX / elem_size) {
        av_log(NULL, AV_LOG_ERROR, "Array too big.\n");
        exit_program(1);
    }
    if (*size < new_size) {
        uint8_t* tmp = (uint8_t*)av_realloc_array(array, new_size, elem_size);
        if (!tmp) {
            av_log(NULL, AV_LOG_ERROR, "Could not alloc buffer.\n");
            exit_program(1);
        }
        memset(tmp + *size * elem_size, 0, (new_size - *size) * elem_size);
        *size = new_size;
        return tmp;
    }
    return array;
}

void* FFCtx::allocate_array_elem(void* ptr, size_t elem_size, int* nb_elems)
{
    void* new_elem;

    if (!(new_elem = av_mallocz(elem_size)) ||
        av_dynarray_add_nofree(ptr, nb_elems, new_elem) < 0) {
        av_log(NULL, AV_LOG_ERROR, "Could not alloc buffer.\n");
        exit_program(1);
    }
    return new_elem;
}

double FFCtx::get_rotation(int32_t* displaymatrix)
{
    double theta = 0;
    if (displaymatrix)
        theta = -round(av_display_rotation_get((int32_t*)displaymatrix));

    theta -= 360 * floor(theta / 360 + 0.9 / 360);

    if (fabs(theta - 90 * round(theta / 90)) > 2)
        av_log(NULL, AV_LOG_WARNING, "Odd rotation angle.\n"
               "If you want to help, upload a sample "
               "of this file to https://streams.videolan.org/upload/ "
               "and contact the ffmpeg-devel mailing list. (ffmpeg-devel@ffmpeg.org)");

    return theta;
}

void FFCtx::log_callback(void* ptr, int level, const char* fmt, va_list vl)
{
#if 1//defined(_DEBUG)
    va_list vl2;
    char line[1024];
    static int print_prefix = 1;

    va_copy(vl2, vl);
    av_log_default_callback(ptr, level, fmt, vl);
    av_log_format_line(ptr, level, fmt, vl2, line, sizeof(line), &print_prefix);
    va_end(vl2);
    if (AV_LOG_DEBUG >= level) {
        OutputDebugStringA(line);
    }
#endif
}

FFCtx::~FFCtx()
{
    CloseHandle(hSigVideo);

    video_tex[2].detach();
    video_tex[1].detach();
    video_tex[0].detach();
    VideoTexInfoDestroy(hFileMap, vtinfo);

    if (vid_mutex)
        SRWMutexDestroy(vid_mutex);
}

FFCtx::FFCtx(int id)
{
    // merge cmdutils.c
    //
    sws_dict = NULL;
    swr_opts = NULL;
    format_opts = NULL;
    codec_opts = NULL;

    // added for multiple contexts
    //
    ctx_id = id;
    refresh_tid = NULL;
    remaining_time = 0.;

    vid_mutex = SRWMutexCreate();

    do {
        wchar_t name[256];
        _snwprintf(name, 256, L"/ffctx_camee/video_tex_%03d", id);
        vtinfo = VideoTexInfoCreate(&hFileMap, name);
        assert(vtinfo);

        int size = vtinfo->pitch * vtinfo->height;
        uint8* bits = (uint8*)vtinfo + vtinfo->offset;
        video_tex[0].attach(CAP_W, CAP_H, bits + size * 0);
        video_tex[1].attach(CAP_W, CAP_H, bits + size * 1);
        video_tex[2].attach(CAP_W, CAP_H, bits + size * 2);

        vtinfo->id = id;
        vtinfo->index = 0;
        vtinfo->pts = 0.0;

        _snwprintf(name, 256, L"/ffctx_camee/hSigVideo_%03d", id);
        hSigVideo = CreateEvent(NULL, FALSE, FALSE, name);

    } while (0);

    scale_tex[0].alloc(CAP_W, CAP_H);
    scale_tex[1].alloc(CAP_W, CAP_H);
    scale_idx = 0;

    rtDisp.x = 0;
    rtDisp.y = 0;
    rtDisp.w = 0;
    rtDisp.h = 0;

}

FFCtx* ffctx[MAXCAM];

int selected_audio_ctx_id = 1;

