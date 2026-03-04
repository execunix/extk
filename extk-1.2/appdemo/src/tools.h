//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _tools_h_
#define _tools_h_

#include <exdebug.h>
#include <exmemory.h>
#include <vector>
#include <array>
#include "event.h"

// 시스템 성능저하 방지 및 신뢰성시험 룰을 동시에 만족하기 위한 목적으로서
// C++ 표준 라이브러리(STL) 적용이 불가능한 부분은 하기 클래스로 대체함

inline const char* tstrchr(const char* const sp, const char ch) { // check-slm
    #ifdef __linux__
    const char* const ret = __builtin_strchr(sp, static_cast<int32>(ch)); // tbd
    #else // __linux__
    const char* const ret = strchr(sp, static_cast<int32>(ch)); // tbd
    #endif // __linux__
    return ret;
}

inline size_t tstrchrnul_u64(const char* const sp, const char ch) {
    size_t idx;
    for (idx = 0UL; idx < 4096UL; idx++) {
        if ((sp[idx] == '\0') || (sp[idx] == ch)) {
            break;
        }
    }
    return idx;
}

inline ssize_t tstrchrnul_i64(const char* const sp, const char ch) {
    ssize_t idx;
    for (idx = 0L; idx < 4096L; idx++) {
        if ((sp[idx] == '\0') || (sp[idx] == ch)) {
            break;
        }
    }
    return idx;
}

bool system1(const char* const command);

template <typename... Args>
bool systemf(const char* const fmt, Args&&... arg) {
    char cmdbuf[1024];
    (void)snprintf(&cmdbuf[0], 1024UL, fmt, arg...); // slm-3840 as a pointer type argument
    return system1(&cmdbuf[0]);
}

const char* wcs2utf8(const ucs2_t* wcs); // thread un-safe
const char* wcs2utf8(const ucs4_t* wcs); // thread un-safe

int32 strsplit(char** const toc, const int tno, char* src, const char del);
char* strltrim(char* src, const char* const tch);
char* strrtrim(char* src, const char* const tch);
char* strtrim(char* src, const char* const tch);

// tstring - template for string with stack allocated buffer
// for avoiding misra c++ rules
// usage:
//  tstring<256UL> str;
//  (void)exstrcpy(str.data(), "hello");
//  str.at(5UL) = '\0';
//
template <size_t Size>
class tstring : public std::array<char, Size> {
public:
    static constexpr size_t MaxIndex = (Size - 1UL);
    static_assert(Size > 0UL, "Size is zero");
    static void sclamp(size_t& i) {
        if (i > MaxIndex) {
            i = MaxIndex;
        }
    }
public:
    #if 0 // 0 => for reduce overhead
    tstring() : std::array<char, Size>() {
        this->at(0UL) = '\0';
        if (MaxIndex > 1UL) {
            this->at(MaxIndex) = '\0';
        }
    }
    #endif
    operator const char*() const { return this->data(); }
    //char* operator&() { return this->data(); }
    char* ptr() const { return this->data(); }
    char* ptr(size_t i) { sclamp(i); return &this->at(i); }
    int32 ssize() const { return static_cast<int32>(this->size()); }
    // inherit char& at(size_t i) const;
    char& at(const int32 idx) {
        size_t i = static_cast<size_t>(idx);
        sclamp(i);
        return this->std::array<char, Size>::at(i);
    }
    const char& at(const int32 idx) const {
        size_t i = static_cast<size_t>(idx);
        sclamp(i);
        return this->std::array<char, Size>::at(i);
    }
public:
    #if 1 // test for misra rules
    char* strtrim_misra_test_xxx(const char* const tch) {
        char* rtrim = strrtrim(this->data(), tch);
        char* ltrim = strltrim(rtrim, tch);
        return ltrim;
    }
    #endif
};

// ttocken - template for tockenizer with stack allocated buffer
// for avoiding misra c++ rules
// usage:
//  ttocken<32UL> tocken;
//  if ((2UL == tocken.strsplit(str, '=')) &&
//      (0 == strcmp(tocken.get(0), "key")) &&
//      (0 == strcmp(tocken.get(1), "val"))) { ... }
//
template <size_t Size=32UL>
class ttocken : public std::array<char*, Size> {
public:
    static constexpr size_t MaxIndex = (Size - 1UL);
    static_assert(Size > 0UL, "Size is zero");
private:
    size_t tcount;
public:
    #if 1 // 0 => for reduce overhead
    ttocken() : std::array<char*, Size>(), tcount(0UL) {}
    #endif
    // split string
    // [Parameters]
    //  - ttocken.data(): tocken pointer array
    //  - ttocken.size(): tocken pointer size
    //  - src: source string (input)
    //  - del: delimiter (input)
    // [Return Values]
    //  - return tocken count
    size_t strsplit(char* src, const char del) {
        exassert2(src != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
        tcount = 0UL; // tocken counter
        while (tcount < Size) {
            this->at(tcount++) = src; // store tocken pointer
            while ((*src != '\0') && (*src != del)) {
                src++; // found delimiter
            }
            if (*src == '\0') {
                break; // stop split
            }
            *src++ = '\0'; // cur string
        }
        return tcount;
    }
    size_t getTockenCount() const { return tcount; }
    char* get(const int32 i) { return this->at(static_cast<size_t>(i)); }
    const char* get(const int32 i) const { return this->at(static_cast<size_t>(i)); }
    char& get(const int32 i, const int32 j) {
        char (&sp)[512] = *reinterpret_cast<char (*)[512]>(this->at(static_cast<size_t>(i)));
        return sp[j];
    }
    const char& get(const int32 i, const int32 j) const {
        char (&sp)[512] = *reinterpret_cast<char (*)[512]>(this->at(static_cast<size_t>(i)));
        return sp[j];
    }
};

inline int8 atoi8(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    const int64 val64 = strtol(str, endptr, 10);
    return static_cast<int8>(val64);
}

inline uint8 atou8(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    const uint64 val64 = strtoul(str, endptr, 10);
    return static_cast<uint8>(val64);
}

inline int16 atoi16(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    const int64 val64 = strtol(str, endptr, 10);
    return static_cast<int16>(val64);
}

inline uint16 atou16(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    const uint64 val64 = strtoul(str, endptr, 10);
    return static_cast<uint16>(val64);
}

inline int32 atoi32(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    const int64 val64 = strtol(str, endptr, 10);
    return static_cast<int32>(val64);
}

inline uint32 atou32(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    const uint64 val64 = strtoul(str, endptr, 10);
    return static_cast<uint32>(val64);
}

inline int64 atoi64(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    return strtol(str, endptr, 10);
}

inline uint64 atou64(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    return strtoul(str, endptr, 10);
}

inline float32 atof32(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    #ifdef __linux__
    return strtof32(str, endptr);
    #else // __linux__
    return strtof(str, endptr);
    #endif // __linux__
}

inline float64 atof64(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    char** const endptr = static_cast<char** const>(nullptr);
    #ifdef __linux__
    return strtof64(str, endptr);
    #else // __linux__
    return strtod(str, endptr);
    #endif // __linux__
}

inline float32 absf32(const float32 value)
{
    const float32 rst = (value < 0.F) ? (value * -1.F) : value;
    return rst;
}

inline float64 absf64(const float64 value)
{
    const float64 rst = (value < 0.) ? (value * -1.) : value;
    return rst;
}

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
bool recordTouchEvent(const Event* const ev);
bool recordEventMark(const char* const msg, const int32 wparam);
#endif // __linux__

// MemFifo - stream memory as fifo
//
template <typename T>
class MemFifo {
private:
    size_t reserve;
    size_t element;
    size_t ridx;
    T* pool;
public:
    void fini() {
        if (pool != nullptr) {
            std::allocator<T> ptr_allocator;
            ptr_allocator.deallocate(pool, reserve);
            pool = nullptr;
        }
        reserve = 0UL;
        element = 0UL;
        ridx = 0UL;
    }
    bool init(const size_t reserve_in = 8U * 1024U) {
        std::allocator<T> ptr_allocator;
        pool = ptr_allocator.allocate(reserve_in);
        if (pool != nullptr) {
            reserve = reserve_in;
            element = 0UL;
            ridx = 0UL;
        } else {
            dprint("MemFifo: allocate(%lu) fail.\n", reserve_in);
        }
        return (pool != nullptr);
    }
    size_t size() const { return element; }
    size_t capacity() const { return reserve; }
    bool empty() const { return (element == 0UL); }
    size_t truncat2(size_t trunc_len) {
        if (trunc_len > element) {
            trunc_len = element;
        }
        if (trunc_len > 0UL) {
            const size_t split = reserve - ridx;
            if (split < trunc_len) { // is split ?
                ridx = trunc_len - split;
            } else {
                ridx = (trunc_len < reserve) ? (ridx + trunc_len) : 0UL;
            }
            element -= trunc_len;
        }
        return trunc_len;
    }
    size_t peek(T* const buf, size_t len) const {
        if (len > element) {
            len = element;
        }
        if (len > 0UL) {
            const size_t split = reserve - ridx;
            exassert2(buf != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
            T (&dp)[len] = *reinterpret_cast<T (*)[len]>(buf);
            const T (&sp)[reserve] = *reinterpret_cast<const T (*)[reserve]>(pool);
            if (split < len) { // is split ?
                (void)memcpy(&dp[0], &sp[ridx], split * sizeof(T));
                (void)memcpy(&dp[split], &sp[0], (len - split) * sizeof(T));
            } else {
                (void)memcpy(&dp[0], &sp[ridx], len * sizeof(T));
            }
        }
        return len;
    }
    size_t pop(T* const buf, size_t len) {
        if (len > element) {
            len = element;
        }
        #if 1 // redundant
        if (ridx >= reserve) { // qac: subtraction underflow
            ridx -= reserve;
        }
        #endif
        if (len > 0UL) {
            const size_t split = reserve - ridx; // qac: subtraction underflow
            exassert2(buf != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
            T (&dp)[len] = *reinterpret_cast<T (*)[len]>(buf);
            const T (&sp)[reserve] = *reinterpret_cast<const T (*)[reserve]>(pool);
            if (split < len) { // is split ?
                (void)memcpy(&dp[0], &sp[ridx], split * sizeof(T));
                (void)memcpy(&dp[split], &sp[0], (len - split) * sizeof(T));
                ridx = len - split;
            } else {
                (void)memcpy(&dp[0], &sp[ridx], len * sizeof(T));
                ridx = (((ridx + len) < reserve) ? (ridx + len) : 0UL);
            }
            element -= len;
        }
        return len;
    }
    size_t fill(const T* const buf, size_t len) {
        if (len > reserve) {
            len = reserve;
        }
        //T* wptr = rptr + element;
        size_t widx = ridx + element;
        if (widx >= reserve) {
            widx -= reserve;
        }
        if (len > 0UL) {
            const size_t split = reserve - widx;
            T (&dp)[reserve] = *reinterpret_cast<T (*)[reserve]>(pool);
            if (split < len) { // is split ?
                (void)memcpy(&dp[widx], buf, split * sizeof(T));
                (void)memcpy(&dp[0], &buf[split], (len - split) * sizeof(T)); // slm-2843 an invalid pointer value
                widx = len - split;
            } else {
                (void)memcpy(&dp[widx], buf, len * sizeof(T));
                widx = (((widx + len) < reserve) ? (widx + len) : 0UL);
            }
            if ((element + len) > reserve) {
                dprint("MemFifo: fill overflow. drop %lu bytes\n", (element + len) - reserve);
                element = reserve;
                ridx = widx;
            } else {
                element += len;
            }
        }
        return len;
    }
public:
    ~MemFifo() noexcept {
        fini();
    }
    MemFifo() noexcept : reserve(0UL), element(0UL), ridx(0UL), pool(nullptr) {
#ifdef _DEBUG
        const bool simple = std::is_trivial<T>::value; // (std::is_pod<T>::value && __is_trivial(T))
        static_assert(simple, "type is not simple");
#endif
    }
};

#endif // _tools_h_
