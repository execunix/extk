/*
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
 * null video filter
 */

#include "avfilter.h"

static AVFilterPad inputs[] = {
  { /*.name             = */"default",
    /*.type             = */AVMEDIA_TYPE_VIDEO,
    /*.min_perms        = */0,
    /*.rej_perms        = */0,
    /*.start_frame      = */avfilter_null_start_frame,
    /*.get_video_buffer = */avfilter_null_get_video_buffer,
    /*.get_audio_buffer = */NULL,
    /*.end_frame        = */avfilter_null_end_frame, },
  { /*.name = */NULL, }};

static AVFilterPad outputs[] = {
  { /*.name             = */"default",
    /*.type             = */AVMEDIA_TYPE_VIDEO, },
  { /*.name = */NULL, }};

AVFilter avfilter_vf_null = {
    "null",
    0,
	NULL, // init
	NULL, // uninit
	NULL, // query_formats
    inputs,
    outputs,
    NULL_IF_CONFIG_SMALL("Pass the source unchanged to the output."),
};
