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
 * null video source
 */

#include "libavutil/avstring.h"
#include "libavutil/eval.h"
#include "libavutil/parseutils.h"
#include "avfilter.h"

static const char *var_names[] = {
    "E",
    "PHI",
    "PI",
    "AVTB",   /* default timebase 1/AV_TIME_BASE */
    NULL
};

enum var_name {
    VAR_E,
    VAR_PHI,
    VAR_PI,
    VAR_AVTB,
    VAR_VARS_NB
};

typedef struct {
    int w, h;
    char tb_expr[256];
    double var_values[VAR_VARS_NB];
} NullContext;

static int init(AVFilterContext *ctx, const char *args, void *opaque)
{
    NullContext *priv = (NullContext*)ctx->priv;

    priv->w = 352;
    priv->h = 288;
    av_strlcpy(priv->tb_expr, "AVTB", sizeof(priv->tb_expr));

    if (args)
        sscanf(args, "%d:%d:%255[^:]", &priv->w, &priv->h, priv->tb_expr);

    if (priv->w <= 0 || priv->h <= 0) {
        av_log(ctx, AV_LOG_ERROR, "Non-positive size values are not acceptable.\n");
        return AVERROR(EINVAL);
    }

    return 0;
}

static int config_props(AVFilterLink *outlink)
{
    AVFilterContext *ctx = outlink->src;
    NullContext *priv = (NullContext*)ctx->priv;
    AVRational tb;
    int ret;
    double res;

    priv->var_values[VAR_E]    = M_E;
    priv->var_values[VAR_PHI]  = M_PHI;
    priv->var_values[VAR_PI]   = M_PI;
    priv->var_values[VAR_AVTB] = av_q2d(AV_TIME_BASE_Q);

    if ((ret = av_expr_parse_and_eval(&res, priv->tb_expr, var_names, priv->var_values,
                                      NULL, NULL, NULL, NULL, NULL, 0, NULL)) < 0) {
        av_log(ctx, AV_LOG_ERROR, "Invalid expression '%s' for timebase.\n", priv->tb_expr);
        return ret;
    }
    tb = av_d2q(res, INT_MAX);
    if (tb.num <= 0 || tb.den <= 0) {
        av_log(ctx, AV_LOG_ERROR,
               "Invalid non-positive value for the timebase %d/%d.\n",
               tb.num, tb.den);
        return AVERROR(EINVAL);
    }

    outlink->w = priv->w;
    outlink->h = priv->h;
    outlink->time_base = tb;

    av_log(outlink->src, AV_LOG_INFO, "w:%d h:%d tb:%d/%d\n", priv->w, priv->h,
           tb.num, tb.den);

    return 0;
}

static int request_frame(AVFilterLink *link)
{
    return -1;
}

static AVFilterPad inputs[] = {
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
    /*.request_frame    = */request_frame,
    /*.config_props     = */config_props },
  { /*.name = */NULL, }};

AVFilter avfilter_vsrc_nullsrc = {
    "nullsrc",
    sizeof(NullContext),
    init,
	NULL, // uninit
	NULL, // query_formats
    inputs,
    outputs,
    NULL_IF_CONFIG_SMALL("Null video source, never return images."),
};
