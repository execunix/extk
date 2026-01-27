/*
 * Video splitter
 * copyright (c) 2007 Bobby Bingham
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

#include "avfilter.h"

static void start_frame(AVFilterLink *link, AVFilterBufferRef *picref)
{
    avfilter_start_frame(link->dst->outputs[0],
                         avfilter_ref_buffer(picref, ~AV_PERM_WRITE));
    avfilter_start_frame(link->dst->outputs[1],
                         avfilter_ref_buffer(picref, ~AV_PERM_WRITE));
}

static void end_frame(AVFilterLink *link)
{
    avfilter_end_frame(link->dst->outputs[0]);
    avfilter_end_frame(link->dst->outputs[1]);

    avfilter_unref_buffer(link->cur_buf);
}

static void draw_slice(AVFilterLink *link, int y, int h, int slice_dir)
{
    avfilter_draw_slice(link->dst->outputs[0], y, h, slice_dir);
    avfilter_draw_slice(link->dst->outputs[1], y, h, slice_dir);
}

static AVFilterPad inputs[] = {
  { /*.name             = */"default",
    /*.type             = */AVMEDIA_TYPE_VIDEO,
    /*.min_perms        = */0,
    /*.rej_perms        = */0,
    /*.start_frame      = */start_frame,
    /*.get_video_buffer = */avfilter_null_get_video_buffer,
    /*.get_audio_buffer = */NULL,
    /*.end_frame        = */end_frame,
    /*.draw_slice       = */draw_slice, },
  { /*.name = */NULL, }};

static AVFilterPad outputs[] = {
  { /*.name             = */"default",
    /*.type             = */AVMEDIA_TYPE_VIDEO, },
  { /*.name             = */"default2",
    /*.type             = */AVMEDIA_TYPE_VIDEO, },
  { /*.name = */NULL, }};

AVFilter avfilter_vf_split =
{
    "split",
	0, // priv_size
	NULL, // init
	NULL, // uninit
	NULL, // query_formats
    inputs,
    outputs,
};

