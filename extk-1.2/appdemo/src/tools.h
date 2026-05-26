//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _tools_h_
#define _tools_h_

#include <extools.h>

// 시스템 성능저하 방지 및 신뢰성시험 룰을 동시에 만족하기 위한 목적으로서
// C++ 표준 라이브러리(STL) 적용이 불가능한 부분은 하기 클래스로 대체함

// TouchRecordStack
//
struct TouchRecord {
    uint32 packet_count;
    uint32 ev_tick;
};

class TouchRecordStack {
private:
    std::array<TouchRecord, 1000UL> rec_pool;
    size_t element;
    size_t topidx;
public:
    TouchRecordStack() noexcept : element(0UL), topidx(0UL) { }
    size_t size() const { return element; }
    bool empty() const { return (element == 0UL); }
    void truncat2(const size_t element_in) {
        if (element > element_in) {
            element = element_in;
        }
    }
    void push(const uint32 packet_count, const uint32 ev_tick) {
        rec_pool[topidx].packet_count = packet_count;
        rec_pool[topidx].ev_tick = ev_tick;
        element = (element < rec_pool.size()) ? (element + 1UL) : rec_pool.size();
        topidx = ((topidx + 1UL) < rec_pool.size()) ? (topidx + 1UL) : 0UL;
    }
    TouchRecord& at(size_t i) {
        if (i > element) {
            i = element;
        }
        size_t idx = topidx - 1UL - i;
        if (static_cast<ssize_t>(idx) < 0L) {
            idx += rec_pool.size();
        }
        return rec_pool[idx];
    }
};

extern TouchRecordStack touch_ic_overheat_dataset;

#ifdef __linux__
bool stopTouchRecord();
bool startTouchRecord();
bool recordTouchEvent(const ExMsg* const em);
bool recordEventMark(const char* const msg, const int32 wparam);
#endif // __linux__

#endif // _tools_h_
