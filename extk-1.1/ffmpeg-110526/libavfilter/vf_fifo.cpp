/*
 * Copyright (c) 2007 Bobby Bingham
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

/**
 * @file
 * FIFO buffering video filter
 */

#include "avfilter.h"

typedef struct BufPic {
    AVFilterBufferRef *picref;
    struct BufPic     *next;
} BufPic;

typedef struct {
    BufPic  root;
    BufPic *last;   ///< last buffered picture
} FifoContext;

static av_cold int init(AVFilterContext *ctx, const char *args, void *opaque)
{
    FifoContext *fifo = (FifoContext*)ctx->priv;
    fifo->last = &fifo->root;

    av_log(ctx, AV_LOG_INFO, "\n");
    return 0;
}

static av_cold void uninit(AVFilterContext *ctx)
{
    FifoContext *fifo = (FifoContext*)ctx->priv;
    BufPic *pic, *tmp;

    for (pic = fifo->root.next; pic; pic = tmp) {
        tmp = pic->next;
        avfilter_unref_buffer(pic->picref);
        av_free(pic);
    }
}

static void start_frame(AVFilterLink *inlink, AVFilterBufferRef *picref)
{
    FifoContext *fifo = (FifoContext*)inlink->dst->priv;

    fifo->last->next = (BufPic*)av_mallocz(sizeof(BufPic));
    fifo->last = fifo->last->next;
    fifo->last->picref = picref;
}

static void end_frame(AVFilterLink *inlink) { }

static void draw_slice(AVFilterLink *inlink, int y, int h, int slice_dir) { }

static int request_frame(AVFilterLink *outlink)
{
    FifoContext *fifo = (FifoContext*)outlink->src->priv;
    BufPic *tmp;
    int ret;

    if (!fifo->root.next) {
        if ((ret = avfilter_request_frame(outlink->src->inputs[0]) < 0))
            return ret;
    }

    /* by doing this, we give ownership of the reference to the next filter,
     * so we don't have to worry about dereferencing it ourselves. */
    avfilter_start_frame(outlink, fifo->root.next->picref);
    avfilter_draw_slice (outlink, 0, outlink->h, 1);
    avfilter_end_frame  (outlink);

    if (fifo->last == fifo->root.next)
        fifo->last = &fifo->root;
    tmp = fifo->root.next->next;
    av_free(fifo->root.next);
    fifo->root.next = tmp;

    return 0;
}

static AVFilterPad inputs[] = {
  { /*.name             = */"default",
    /*.type             = */AVMEDIA_TYPE_VIDEO,
    /*.min_perms        = */0,
    /*.rej_perms        = */AV_PERM_REUSE2,
    /*.start_frame      = */start_frame,
    /*.get_video_buffer = */avfilter_null_get_video_buffer,
    /*.get_audio_buffer = */NULL,
    /*.end_frame        = */end_frame,
    /*.draw_slice       = */draw_slice,
    /*.filter_samples   = */NULL,
    /*.poll_frame       = */NULL,
    /*.request_frame    = */NULL,
    /*.config_props     = */NULL },
  { /*.name = */NULL, }};

static AVFilterPad outputs[] = {
  { /*.name             = */"default",
    /*.type             = */AVMEDIA_TYPE_VIDEO,
    /*.min_perms        = */0,
    /*.rej_perms        = */0,
    /*.start_frame      = */NULL,
    /*.get_video_buffer = */NULL,
    /*.get_audio_buffer = */NULL,
    /*.end_frame        = */NULL,
    /*.draw_slice       = */NULL,
    /*.filter_samples   = */NULL,
    /*.poll_frame       = */NULL,
    /*.request_frame    = */request_frame, },
  { /*.name = */NULL, }};

AVFilter avfilter_vf_fifo = {
    "fifo",
    sizeof(FifoContext),
    init,
    uninit,
	NULL, // query_formats
    inputs,
    outputs,
    NULL_IF_CONFIG_SMALL("Buffer input images and send them when they are requested."),
};
