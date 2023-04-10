/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#pragma once

typedef enum {
    AUDIO_STOPPED = 0,
    AUDIO_PLAYING,
    AUDIO_PAUSED
} AudioStatus;

class WavPlayer {
public:
    static int size;

public:
    virtual ~WavPlayer() {}
    WavPlayer() {}

    static int bufsize() { return size; }
    static int start(DWORD freq, WORD chno, WORD bits);
    static int get_status();
    static void destroy();
    static void create();
    static void unlock();
    static void lock();
};

void audio_collector(char* buf, int len);

