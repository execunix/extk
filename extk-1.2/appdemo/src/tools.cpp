//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#include <fstream>
#include <exdebug.h>
#include "tools.h"

bool system1(const char* const command)
{
    int32 r;

    r = system(command); // slm-5024 stdlib
    dprint("=> %d: %s\n", r, command);
    return (r == 0);
}

TouchRecordStack touch_ic_overheat_dataset;

class tchrec_stream : public std::ofstream {
public:
    tchrec_stream() noexcept : std::ofstream() {}
};

static tchrec_stream tchrec_fp;

#ifdef __linux__
bool stopTouchRecord()
{
    if (tchrec_fp.is_open()) {
        tchrec_fp.close();
    }
    return true;
}

bool startTouchRecord()
{
    bool ret = false;
    (void)stopTouchRecord();
    tchrec_fp.open("/tmp/tchrec.txt");
    if (!tchrec_fp.fail()) {
        (void)(tchrec_fp << "# touch d|m|u x y" << std::endl);
        ret = true;
    }
    return ret;
}

bool recordTouchEvent(const ExEvent* const ev)
{
    bool ret = false;
    if (!tchrec_fp.fail()) {
        const char* msg_str;
        static uint32 up_tick = 0U;
        static uint32 msg_tick = 0U;
        static uint32 prev_message = 0U;
        if (ev->message == WM_LBUTTONDOWN) {
            msg_str = "down";
            const uint32 diff = ev->time - up_tick;
            (void)(tchrec_fp << "#sleep " << (static_cast<float64>(diff) / 1000.) << std::endl);
        } else if (ev->message == WM_LBUTTONUP) {
            msg_str = "up";
            up_tick = ev->time;
        } else if (ev->message == WM_MOUSEMOVE) {
            msg_str = "move";
            const uint32 diff = ev->time - msg_tick;
            if ((prev_message == ev->message) && (diff < 500U)) {
                msg_str = nullptr;
            }
        } else {
            msg_str = nullptr;
        }
        prev_message = ev->message;
        if (msg_str != nullptr) {
            (void)(tchrec_fp << "touch " << msg_str << " ");
            (void)(tchrec_fp << ev->pt.x << " " << ev->pt.y);
            (void)(tchrec_fp << " #" << ev->time << std::endl);
            msg_tick = ev->time;
            ret = true;
        }
    }
    return ret;
}

bool recordEventMark(const char* const msg, const int32 wparam)
{
    bool ret = false;
    if (!tchrec_fp.fail()) {
        (void)(tchrec_fp << "# " << msg << ": " << wparam << std::endl);
        ret = true;
    }
    return ret;
}
#endif // __linux__
