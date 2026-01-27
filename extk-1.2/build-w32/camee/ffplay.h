/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

// play context
// hidden class from the gui to minimize locking.
// these data are NOT shared with the main thread.
// operates completely independently of the main thread.
//
class FFPlay : public FFCtx {
public:
    /* options specified by the user */
    const AVInputFormat* file_iformat;
    const char* input_filename;
    const char* window_title;
    int default_width;
    int default_height;
    int screen_width;
    int screen_height;
    int screen_left;
    int screen_top;
    int audio_disable;
    int video_disable;
    int subtitle_disable;
    const char* wanted_stream_spec[AVMEDIA_TYPE_NB];
    int seek_by_bytes;
    float seek_interval;
    int display_disable;
    int startup_volume;
    int show_status;
    int av_sync_type;
    int64_t start_time; // seek time
    int64_t duration;
    int fast;
    int genpts;
    int lowres;
    int decoder_reorder_pts;
    int autoexit;
    int loop;
    int framedrop;
    int infinite_buffer;
    //ShowMode show_mode;
    const char* audio_codec_name;
    const char* subtitle_codec_name;
    const char* video_codec_name;
    double rdftspeed;
    int64_t cursor_last_shown;
    int cursor_hidden;
#if CONFIG_AVFILTER
    const char** vfilters_list;
    int nb_vfilters;
    char* afilters;
#endif
    int autorotate;
    int find_stream_info;
    char* filter_nbthreads;

    /* current context */
    int is_full_screen;
    int64_t audio_callback_time;

public:
    VideoState* video_state;

    //char reserved2[256]; // tbd - mfence

public:
    virtual ~FFPlay();
    FFPlay(int id);

public:
#if CONFIG_AVFILTER
    int opt_add_vfilter(void* optctx, const char* opt, const char* arg);
#endif
    int cmp_audio_fmts(AVSampleFormat fmt1, int64_t channel_count1, AVSampleFormat fmt2, int64_t channel_count2);
    int decoder_decode_frame(Decoder* d, AVFrame* frame, AVSubtitle* sub);
    void video_image_display(VideoState* is);
    void video_audio_display(VideoState* s);
    void stream_close(VideoState* is);
    void cleanup();
    void set_default_window_size(int width, int height, AVRational sar);
    void video_display(VideoState* is);
    void video_refresh(void* opaque, double* remaining_time);
    int queue_picture(VideoState* is, AVFrame* src_frame, double pts, double duration, int64_t pos, int serial);
    int get_video_frame(VideoState* is, AVFrame* frame);
#if CONFIG_AVFILTER
    int configure_video_filters(AVFilterGraph* graph, VideoState* is, const char* vfilters, AVFrame* frame);
    int configure_audio_filters(VideoState* is, const char* afilters, int force_output_format);
#endif
    DWORD audio_proc(VideoState* is);
    DWORD video_proc(VideoState* is);
    DWORD subtitle_proc(VideoState* is);
    void audio_callback(char* stream, int len, int sel);
    int audio_decode_frame(VideoState* is);
    int stream_component_open(VideoState* is, int stream_index);
    DWORD read_proc(VideoState* is);
    VideoState* stream_open(const char* filename, const AVInputFormat* iformat);
    void stream_cycle_channel(VideoState* is, AVMediaType codec_type);
    void refresh_loop_wait_remaining_time(VideoState* is);

public:
    int play(const char* url);

};

