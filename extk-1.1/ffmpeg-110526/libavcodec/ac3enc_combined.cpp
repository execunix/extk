
#include "libavutil/opt.h"
#include "libavutil/samplefmt.h"
#include "avcodec.h"
#include "ac3.h"

typedef struct CombineContext{
    AVClass *av_class;                      ///< AVClass used for AVOption
    AC3EncOptions options;                  ///< encoding options
    void *ctx;
    AVCodec *codec;
}CombineContext;

static AVClass ac3enc_class = { "AC-3 Encoder", av_default_item_name,
                                ff_ac3_options, LIBAVUTIL_VERSION_INT };

static av_cold AVCodec *get_codec(enum AVSampleFormat s){
#if CONFIG_AC3_FIXED_ENCODER
    if(s==AV_SAMPLE_FMT_S16) return &ff_ac3_fixed_encoder;
#endif
#if CONFIG_AC3_FLOAT_ENCODER
    if(s==AV_SAMPLE_FMT_FLT) return &ff_ac3_float_encoder;
#endif
    return NULL;
}


static av_cold int encode_init(AVCodecContext *avctx)
{
    CombineContext *c= (CombineContext*)avctx->priv_data;
    int ret;
    int offset= (uint8_t*)&c->options - (uint8_t*)c;

    c->codec= get_codec(avctx->sample_fmt);
    if(!c->codec){
        av_log(avctx, AV_LOG_ERROR, "Unsupported sample format\n");
        return -1;
    }
    c->ctx= av_mallocz(c->codec->priv_data_size);
    memcpy((uint8_t*)c->ctx + offset, &c->options, (uint8_t*)&c->ctx - (uint8_t*)&c->options);
    FFSWAP(void *,avctx->priv_data, c->ctx);
    ret= c->codec->init(avctx);
    FFSWAP(void *,avctx->priv_data, c->ctx);
    return ret;
}

static int encode_frame(AVCodecContext *avctx, unsigned char *frame,
                        int buf_size, void *data)
{
    CombineContext *c= (CombineContext*)avctx->priv_data;
    int ret;

    FFSWAP(void *,avctx->priv_data, c->ctx);
    ret= c->codec->encode(avctx, frame, buf_size, data);
    FFSWAP(void *,avctx->priv_data, c->ctx);
    return ret;
}

static av_cold int encode_close(AVCodecContext *avctx)
{
    CombineContext *c= (CombineContext*)avctx->priv_data;
    int ret;

    FFSWAP(void *,avctx->priv_data, c->ctx);
    ret= c->codec->close(avctx);
    FFSWAP(void *,avctx->priv_data, c->ctx);
    return ret;
}

static AVSampleFormat sample_fmts[] = {
#if CONFIG_AC3_FLOAT_ENCODER
        AV_SAMPLE_FMT_FLT,
#endif
#if CONFIG_AC3_FIXED_ENCODER
        AV_SAMPLE_FMT_S16,
#endif
        AV_SAMPLE_FMT_NONE
};

AVCodec ff_ac3_encoder = {
    "ac3",
    AVMEDIA_TYPE_AUDIO,
    CODEC_ID_AC3,
    sizeof(CombineContext),
    encode_init,
    encode_frame,
    encode_close,
    NULL,
	0, // capabilities
	NULL, // next
	NULL, // flush
	NULL, // supported_framerates
	NULL, // pix_fmts
    NULL_IF_CONFIG_SMALL("ATSC A/52A (AC-3)"),
	NULL, // supported_samplerates
    sample_fmts,
    ff_ac3_channel_layouts, // channel_layouts
	0, // max_lowres
    &ac3enc_class, // priv_class
};
