/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#pragma once

#include "compat.h"

struct AVDictionary;
struct AVFormatContext;
struct AVStream;
struct AVCodec;
enum AVCodecID;

// ffctx
// these data are shared with the main thread.
//
class FFCtx {
public:
    // merge cmdutils.c
    //
    AVDictionary* sws_dict;
    AVDictionary* swr_opts;
    AVDictionary* format_opts;
    AVDictionary* codec_opts;

    /**
     * Initialize the cmdutils option system, in particular
     * allocate the *_opts contexts.
     */
    void init_opts(void);

    /**
     * Uninitialize the cmdutils option system, in particular
     * free the *_opts contexts and their contents.
     */
    void uninit_opts(void);

    /**
     * Check if the given stream matches a stream specifier.
     *
     * @param s  Corresponding format context.
     * @param st Stream from s to be checked.
     * @param spec A stream specifier of the [v|a|s|d]:[\<stream index\>] form.
     *
     * @return 1 if the stream matches, 0 if it doesn't, <0 on error
     */
    static int check_stream_specifier(AVFormatContext* s, AVStream* st, const char* spec);

    /**
     * Filter out options for given codec.
     *
     * Create a new options dictionary containing only the options from
     * opts which apply to the codec with ID codec_id.
     *
     * @param opts     dictionary to place options in
     * @param codec_id ID of the codec that should be filtered for
     * @param s Corresponding format context.
     * @param st A stream from s for which the options should be filtered.
     * @param codec The particular codec for which the options should be filtered.
     *              If null, the default one is looked up according to the codec id.
     * @return a pointer to the created dictionary
     */
    static AVDictionary* filter_codec_opts(AVDictionary* opts, AVCodecID codec_id,
                                           AVFormatContext* s, AVStream* st, const AVCodec* codec);

    /**
     * Setup AVCodecContext options for avformat_find_stream_info().
     *
     * Create an array of dictionaries, one dictionary for each stream
     * contained in s.
     * Each dictionary will contain the options from codec_opts which can
     * be applied to the corresponding stream codec context.
     *
     * @return pointer to the created array of dictionaries.
     * Calls exit() on failure.
     */
    static AVDictionary** setup_find_stream_info_opts(AVFormatContext* s,
                                                      AVDictionary* codec_opts);

    /**
     * Print an error message to stderr, indicating filename and a human
     * readable description of the error code err.
     *
     * If strerror_r() is not available the use of this function in a
     * multithreaded application may be unsafe.
     *
     * @see av_strerror()
     */
    static void print_error(const char* filename, int err);

    static void exit_program(int ret);

    /**
     * Realloc array to hold new_size elements of elem_size.
     * Calls exit() on failure.
     *
     * @param array array to reallocate
     * @param elem_size size in bytes of each element
     * @param size new element count will be written here
     * @param new_size number of elements to place in reallocated array
     * @return reallocated array
     */
    static void* grow_array(void* array, int elem_size, int* size, int new_size);

    /**
     * Atomically add a new element to an array of pointers, i.e. allocate
     * a new entry, reallocate the array of pointers and make the new last
     * member of this array point to the newly allocated buffer.
     * Calls exit() on failure.
     *
     * @param array     array of pointers to reallocate
     * @param elem_size size of the new element to allocate
     * @param nb_elems  pointer to the number of elements of the array array;
     *                  *nb_elems will be incremented by one by this function.
     * @return pointer to the newly allocated entry
     */
    void* allocate_array_elem(void* array, size_t elem_size, int* nb_elems);

    static double get_rotation(int32_t* displaymatrix);

    static void log_callback(void* ptr, int level, const char* fmt, va_list vl);

public:
    // added for multiple contexts
    //
    int ctx_id;
    HANDLE refresh_tid;
    double remaining_time;

    SRWMutex* vid_mutex;

    Texture video_tex[3];
    VideoTexInfo* vtinfo;
    HANDLE hFileMap;
    HANDLE hSigVideo;

    Texture scale_tex[2]; // scaled
    int scale_idx;

    ExRect rtDisp;

    //char reserved1[256]; // tbd - mfence

public:
    virtual ~FFCtx();
    FFCtx(int id);

};

extern FFCtx* ffctx[];

int fini_ffctx();
int init_ffctx();

int ffstartup();

void vid_unlock(int id);
void vid_lock(int id);

extern int selected_audio_ctx_id;

