/*
 * Copyright (C) 2021 C.H Park <execunix@gmail.com>
 * THIS SOURCE CODE, AND ITS USE AND DISTRIBUTION, IS SUBJECT TO THE TERMS
 * AND CONDITIONS OF THE APPLICABLE LICENSE AGREEMENT.
 */

#include <windows.h>
#include <mmsystem.h>
#include "wavplayer.h"
#include "compat.h"
#include <assert.h>

// check the buffer size -- minimum of 1/4 second (word aligned)
//#define BUF_LEN     (((44100 / 4) + 3) & ~3)
#define BUF_LEN     0x3000
#define BUF_NUM     2

class WavOutMutex {
    CRITICAL_SECTION wo_cs;
public:
    ~WavOutMutex() { DeleteCriticalSection(&wo_cs); }
    WavOutMutex() { InitializeCriticalSection(&wo_cs); }
    void unlock() { LeaveCriticalSection(&wo_cs); }
    void lock() { EnterCriticalSection(&wo_cs); }
};

static WavOutMutex wo_mutex;

int WavPlayer::size = BUF_LEN;

void WavPlayer::unlock()
{
    wo_mutex.unlock();
}

void WavPlayer::lock()
{
    wo_mutex.lock();
}

// simple wave player
//
class WavPlayerImpl : public WavPlayer {
public:
    UINT devid;
    HWAVEOUT hwo;
    WAVEFORMATEX wfx;
    WAVEHDR wh[BUF_NUM];
    HANDLE hThread;
    DWORD idThread;
    char* txbuf;
    int nextbuf;

public:
    virtual ~WavPlayerImpl() {
        fini();
    }

    WavPlayerImpl(UINT devid = WAVE_MAPPER) : devid(devid) {
        memset(&wfx, 0, sizeof(wfx));
        memset(wh, 0, sizeof(wh));
        hwo = nullptr;
        txbuf = nullptr;
        hThread = nullptr;
        idThread = 0;
        nextbuf = 0;
    }

public:
    static void mmerror(const wchar_t* str, MMRESULT code) {
        wchar_t errbuf[MAXERRORLENGTH];
        waveOutGetErrorText(code, errbuf, MAXERRORLENGTH);
        dprintf(L"%s - %s\n", str, errbuf);
    }

    void handle_wout(HWAVEOUT hwo, UINT uMsg, DWORD_PTR dwParam1, DWORD_PTR dwParam2) {
        switch (uMsg) {
            case WOM_CLOSE: {
                // Sent when the device is closed using the waveOutClose function.
                dprintf(L"WOM_CLOSE#%d\n", devid);
                break;
            }
            case WOM_DONE: {
                // Sent when the device driver is finished with a data block sent using the waveOutWrite function.
                WAVEHDR* whout = (WAVEHDR*)dwParam1;
                dprintf(L"\t\t\tWOM_DONE#%d %d:%d\n", devid, whout->dwUser, whout->dwBufferLength);
                assert(whout->dwFlags & WHDR_PREPARED);
                assert(whout->dwFlags & WHDR_DONE);
                whout->dwBufferLength = BUF_LEN;
                whout->dwFlags &= ~WHDR_DONE;
                break;
            }
            case WOM_OPEN: {
                // Sent when the device is opened using the waveOutOpen function.
                dprintf(L"WOM_OPEN#%d\n", devid);
                break;
            }
        }
    }

    DWORD thread_run() {
        dprintf(L"thread#%d run\n", devid);
        WAVEHDR* whout = nullptr;
        MMRESULT mr;

        int delaycnt = 0;
        while (idThread) {
            whout = &wh[nextbuf];
            if (whout->dwFlags != WHDR_PREPARED) {
                delaycnt++;
                Sleep(10);
                continue;
            }
            assert(whout->dwFlags == WHDR_PREPARED); // tbd - find delay
            if (delaycnt > 0) {
                dprint1(L"waveOutWrite#%d delay %d\n", devid, delaycnt);
                delaycnt = 0;
            }

            audio_collector(whout->lpData, BUF_LEN);
            whout->dwBufferLength = BUF_LEN;
            mr = waveOutWrite(hwo, whout, sizeof(WAVEHDR));
            if (mr != MMSYSERR_NOERROR) {
                dprint1(L"waveOutWrite#%d fail.\n", devid);
                mmerror(__FUNCTIONW__, mr);
            }
            nextbuf = (nextbuf + 1) % BUF_NUM;
        }
        dprintf(L"thread#%d end\n", devid);
        return 1;
    }

    static void CALLBACK waveOutProc(HWAVEOUT hwo, UINT uMsg, DWORD_PTR dwInstance, DWORD_PTR dwParam1, DWORD_PTR dwParam2) {
        ((WavPlayerImpl*)dwInstance)->handle_wout(hwo, uMsg, dwParam1, dwParam2);
    }

    static DWORD WINAPI threadProc(LPVOID lpParameter) {
        return ((WavPlayerImpl*)lpParameter)->thread_run();
    }

    int fini() {
        idThread = 0; // sig term
        if (hThread) {
            if (WAIT_OBJECT_0 != WaitForSingleObject(hThread, 1000)) // wait drain
                dprint1(L"thread#%d wait fail.\n", devid);
            CloseHandle(hThread);
            hThread = nullptr;
        }
        if (hwo) {
            waveOutReset(hwo);
            for (int i = 0; i < BUF_NUM; i++) {
                if (wh[i].dwUser != 0xFFFF) {
                    waveOutUnprepareHeader(hwo, &wh[i], sizeof(WAVEHDR));
                    wh[i].dwUser = 0xFFFF;
                }
            }
            waveOutClose(hwo);
            hwo = nullptr;
        }
        if (txbuf) {
            free(txbuf);
            txbuf = nullptr;
        }
        nextbuf = 0;
        return 0;
    }

    int init(DWORD freq = 44100, WORD chno = 2, WORD bits = 16) {
        MMRESULT mr;

        // initialize the wavhdr for closing
        for (int i = 0; i < BUF_NUM; i++)
            wh[i].dwUser = 0xFFFF;

        // set basic WAVE format parameters
        wfx.wFormatTag = WAVE_FORMAT_PCM;
        wfx.nChannels = chno/*2*/;
        wfx.nSamplesPerSec = freq;
        wfx.wBitsPerSample = bits/*16*/;
        wfx.nBlockAlign = wfx.nChannels * wfx.wBitsPerSample / 8;
        wfx.nAvgBytesPerSec = wfx.nSamplesPerSec * wfx.nBlockAlign;
        wfx.cbSize = 0;

        // open the audio device
        mr = waveOutOpen(&hwo, devid, &wfx, (DWORD_PTR)waveOutProc, (DWORD_PTR)this, CALLBACK_FUNCTION);
        if (mr != MMSYSERR_NOERROR) {
            dprint1(L"waveOutOpen#%d fail.\n", devid);
            mmerror(__FUNCTIONW__, mr);
            return -1;
        }

        // create the sound buffers
        txbuf = (char*)malloc(BUF_NUM * BUF_LEN);
        memset(txbuf, 0, BUF_NUM * BUF_LEN);

        for (int i = 0; i < BUF_NUM; i++) {
            wh[i].lpData = (LPSTR)(txbuf + BUF_LEN * i);
            wh[i].dwBufferLength = BUF_LEN;
            //wh[i].dwBytesRecorded = 0;
            wh[i].dwUser = i;
            wh[i].dwFlags = WHDR_DONE;
            //wh[i].dwLoops = 0;
            //wh[i].lpNext = nullptr;
            //wh[i].reserved = 0;
            mr = waveOutPrepareHeader(hwo, &wh[i], sizeof(WAVEHDR));
            if (mr != MMSYSERR_NOERROR) {
                dprint1(L"waveOutPrepareHeader#%d fail.\n", devid);
                mmerror(__FUNCTIONW__, mr);
            }
        }
#if 1
        DWORD dwVolume = 0;
        mr = waveOutGetVolume(hwo, &dwVolume);
        if (mr != MMSYSERR_NOERROR)
            dprint1(L"waveOutGetVolume#%d fail.\n", devid);

        mr = waveOutSetVolume(hwo, 0x99009900);
        if (mr != MMSYSERR_NOERROR)
            dprint1(L"waveOutSetVolume#%d fail.\n", devid);
#endif
        // ready to go!
        nextbuf = 0;

        return 0;
    }

    int start() {
        dprintf(L"start#%d\n", devid);
        if ((hThread = CreateThread(nullptr, 0, &threadProc, this, 0, &idThread)) == nullptr) {
            dprint1(L"CreateThread#%d fail.\n", devid);
            return -1;
        }
        return 0;
    }

    int reset(DWORD freq, WORD chno, WORD bits) {
        if (idThread) {
            if (wfx.nChannels == chno &&
                wfx.nSamplesPerSec == freq &&
                wfx.wBitsPerSample == bits)
                return 1;
            fini();
        }
        init(freq, chno, bits);
        start();
        return 0;
    }

    AudioStatus get_status() {
        AudioStatus status = AUDIO_STOPPED;
        if (idThread) {
            if (1/*tbd*/)
                status = AUDIO_PLAYING;
            else
                status = AUDIO_PAUSED;
        }
        return status;
    }

    // tbd - resampling

};

static WavPlayerImpl* wout = nullptr;

int WavPlayer::start(DWORD freq, WORD chno, WORD bits)
{
    assert(wout);
    return wout->reset(freq, chno, bits);
}

int WavPlayer::get_status()
{
    assert(wout);
    return wout->get_status();
}

void WavPlayer::destroy()
{
    assert(wout);
    delete wout;
    wout = nullptr;
}

void WavPlayer::create()
{
    wout = new WavPlayerImpl();
}

