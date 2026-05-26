/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __extools_h__
#define __extools_h__

#include "exdebug.h"
#include "exiconv.h"
#include "exmemory.h"
#include "exmessage.h"
#include <vector>
#include <array>

// 시스템 성능저하 방지 및 신뢰성시험 룰을 동시에 만족하기 위한 목적으로서
// C++ 표준 라이브러리(STL) 적용이 불가능한 부분은 하기 클래스로 대체함

bool system1(const char* const command);

template <typename... Args>
bool systemf(const char* const fmt, Args&&... arg) {
    char cmdbuf[1024];
    (void)snprintf(&cmdbuf[0], 1024UL, fmt, arg...); // slm-3840 as a pointer type argument
    return system1(&cmdbuf[0]);
}

constexpr char** const __restrict_endptr = static_cast<char** const>(nullptr);

inline int8 atoi8(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    const int64 val64 = strtol(str, __restrict_endptr, 10);
    return static_cast<int8>(val64);
}

inline uint8 atou8(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    const uint64 val64 = strtoul(str, __restrict_endptr, 10);
    return static_cast<uint8>(val64);
}

inline int16 atoi16(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    const int64 val64 = strtol(str, __restrict_endptr, 10);
    return static_cast<int16>(val64);
}

inline uint16 atou16(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    const uint64 val64 = strtoul(str, __restrict_endptr, 10);
    return static_cast<uint16>(val64);
}

inline int32 atoi32(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    const int64 val64 = strtol(str, __restrict_endptr, 10);
    return static_cast<int32>(val64);
}

inline uint32 atou32(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    const uint64 val64 = strtoul(str, __restrict_endptr, 10);
    return static_cast<uint32>(val64);
}

inline int64 atoi64(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    return strtol(str, __restrict_endptr, 10);
}

inline uint64 atou64(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    return strtoul(str, __restrict_endptr, 10);
}

inline float32 atof32(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    #ifdef __linux__
    return strtof32(str, __restrict_endptr);
    #else // __linux__
    return strtof(str, __restrict_endptr);
    #endif // __linux__
}

inline float64 atof64(const char* const str)
{
    exassert2(str != nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    #ifdef __linux__
    return strtof64(str, __restrict_endptr);
    #else // __linux__
    return strtod(str, __restrict_endptr);
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

inline const char* tstrchr(const char* const sp, const char ch) { // check-slm
    #ifdef __linux__
    const char* const ret = __builtin_strchr(sp, static_cast<int32>(ch)); // tbd
    #else // __linux__
    const char* const ret = strchr(sp, static_cast<int32>(ch)); // tbd
    #endif // __linux__
    return ret;
}

inline size_t tstrchrnul_u64(const char* const sp, const char ch) {
    size_t idx = 0UL;
    while (!((sp[idx] == '\0') || (sp[idx] == ch))) {
        idx++;
    }
    return idx;
}

inline ssize_t tstrchrnul_i64(const char* const sp, const char ch) {
    ssize_t idx = 0L;
    while (!((sp[idx] == '\0') || (sp[idx] == ch))) {
        idx++;
    }
    return idx;
}

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
    tstring() noexcept : std::array<char, Size>() {
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
    ttocken() noexcept : std::array<char*, Size>(), tcount(0UL) {}
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
    // inherit const char*& at(size_type __n);
    char* get(const int32 i) { return this->at(static_cast<size_t>(i)); }
    const char* get(const int32 i) const { return this->at(static_cast<size_t>(i)); }
    char& get(const int32 i, const int32 j) { return this->at(static_cast<size_t>(i))[j]; }
    const char& get(const int32 i, const int32 j) const { return this->at(static_cast<size_t>(i))[j]; }
};

#endif//__extools_h__
