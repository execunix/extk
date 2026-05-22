/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exmemory_h__
#define __exmemory_h__

#include "extypes.h"
#include <memory>

// proto - std::copy(src.begin(), src.end(), dst.begin())

// tmemfifo - stream memory as fifo (circular queue)
//
template <typename T, size_t Capacity = 64UL>
class tmemfifo {
public:
    static constexpr size_t Zero = static_cast<size_t>(0);
    static_assert(Capacity > Zero, "Capacity is zero");
protected:
    std::array<T, Capacity> repository;
    size_t data_count;
    size_t head_index;
    static size_t seek(size_t index, const size_t offset) {
        exassert(offset <= Capacity);
        index += offset;
        // return (index < Capacity) ? index : (index - Capacity);
        if (index >= Capacity) {
            index -= Capacity;
        }
        return index;
    }
    size_t tail_index() const {
        return seek(head_index, data_count);
    }
public:
    tmemfifo() noexcept : repository(), data_count(Zero), head_index(Zero) {
#ifdef _DEBUG
        const bool simple = std::is_standard_layout<T>::value;
        //const bool simple = std::is_trivial<T>::value; // (std::is_pod<T>::value && __is_trivial(T))
        //const bool simple = std::is_pod<T>::value;
        static_assert(simple, "type is not simple");
#endif
    }
public:
    size_t size() const {
        return data_count;
    }
    size_t capacity() const {
        return Capacity;
    }
    size_t spare() const {
        return (Capacity - data_count);
    }
    bool is_full() const {
        return (data_count == Capacity);
    }
    bool empty() const {
        return (data_count == Zero);
    }
    void clear() {
        data_count = Zero;
        head_index = Zero;
    }
    T& at(size_t i) {
        i = seek(head_index, i);
        return repository.at(i);
    }
    T& head() { // peek head
        exassert(!empty());
        return repository[head_index];
    }
    T& tail() { // peek tail
        exassert(!empty());
        return repository[tail_index()];
    }
    const T& at(size_t i) const {
        i = seek(head_index, i);
        return repository.at(i);
    }
    const T& head() const { // peek head
        exassert(!empty());
        return repository[head_index];
    }
    const T& tail() const { // peek tail
        exassert(!empty());
        return repository[tail_index()];
    }
    T& pull_head() {
        exassert(!empty());
        T& ref_val = repository[head_index];
        head_index = seek(head_index, 1UL);
        data_count--;
        return ref_val;
    }
    T& push_tail() {
        exassert(!is_full());
        T& ref_val = repository[tail_index()];
        data_count++;
        return ref_val;
    }
    size_t truncat2(size_t len) {
        if (len > data_count) {
            len = data_count;
        }
        if (len > Zero) {
            const size_t split_half = Capacity - head_index;
            if (split_half < len) { // is split ?
                const size_t split_rest = len - split_half;
                head_index = split_rest;
            } else { // no split. rewinds when past the end of the repository.
                head_index = seek(head_index, len);
            }
            data_count -= len;
        }
        return len;
    }
    size_t peek(T* const buf, size_t len) const {
        if (len > data_count) {
            len = data_count;
        }
        if (len > Zero) {
            const size_t split_half = Capacity - head_index;
            if (split_half < len) { // is split ?
                const size_t split_rest = len - split_half;
                // (void)memcpy(&buf[0], &repository[head_index], split_half * sizeof(T));
                std::copy(repository.begin() + head_index, repository.end(), &buf[0]);
                // (void)memcpy(&buf[split_half], &repository[0], split_rest * sizeof(T));
                std::copy(repository.begin(), repository.begin() + split_rest, &buf[split_half]);
            } else {
                // (void)memcpy(&buf[0], &repository[head_index], len * sizeof(T));
                std::copy(repository.begin() + head_index, repository.begin() + head_index + len, &buf[0]);
            }
        }
        return len;
    }
    size_t pull(T* const buf, size_t len) {
        if (len > data_count) {
            len = data_count;
        }
        if (len > Zero) {
            const size_t split_half = Capacity - head_index; // qac: subtraction underflow
            if (split_half < len) { // is split ?
                const size_t split_rest = len - split_half;
                // (void)memcpy(&buf[0], &repository[head_index], split_half * sizeof(T));
                std::copy(repository.begin() + head_index, repository.end(), &buf[0]);
                // (void)memcpy(&buf[split_half], &repository[0], split_rest * sizeof(T));
                std::copy(repository.begin(), repository.begin() + split_rest, &buf[split_half]);
                head_index = split_rest;
            } else { // no split. rewinds when past the end of the repository.
                // (void)memcpy(&buf[0], &repository[head_index], len * sizeof(T));
                std::copy(repository.begin() + head_index, repository.begin() + head_index + len, &buf[0]);
                head_index = seek(head_index, len);
            }
            data_count -= len;
        }
        return len;
    }
    size_t push(const T* const buf, size_t len) {
        if (len > spare()) {
            dprint("tmemfifo: fill overflow. drop %lu bytes\n", len - spare());
            len = spare();
        }
        if (len > Zero) {
            const size_t tail_idx = tail_index();
            const size_t split_half = Capacity - tail_idx;
            if (split_half < len) { // is split ?
                const size_t split_rest = len - split_half;
                // (void)memcpy(&repository[tail_idx], &buf[0], split_half * sizeof(T));
                std::copy(&buf[0], &buf[split_half], repository.begin() + tail_idx);
                // (void)memcpy(&repository[0], &buf[split_half], split_rest * sizeof(T)); // slm-2843 an invalid pointer value
                std::copy(&buf[split_half], &buf[len], repository.begin());
            } else { // no split. rewinds when past the end of the repository.
                // (void)memcpy(&repository[tail_idx], &buf[0], len * sizeof(T));
                std::copy(&buf[0], &buf[len], repository.begin() + tail_idx);
            }
            data_count += len;
        }
        return len;
    }
};

#ifdef WIN32
/*
ExShmemCreate()
    Create a block of shared memory
Description:
    This function creates a block of shared memory. The size argument determines the
    size of the block.
    If you pass name as NULL, this function generates a unique name in the form Pg########;
    this is the preferred mode of operation. If you pass a name, make sure that it isn't
    already in use.
*/

/*
ExShmemDestroy()
    Remove a block of shared memory
*/

void* ExShmemCreate(size_t size, const char* name);
int32 ExShmemDestroy(void* addr);

// tbd - add open/close api

#endif // WIN32

void* ExHeapAllocate(size_t size);
void ExHeapDeallocate(void* ptr);

template <typename T> struct ExHeapManager {
    static T* allocate(size_t num_entry) {
        void* ptr = ExHeapAllocate(num_entry * sizeof(T));
        return static_cast<T*>(ptr);
    }
    static void deallocate(void* ptr) {
        ExHeapDeallocate(ptr);
    }
};

#if 0
template <typename T> T* ExNew() {
    std::allocator<T> obj_allocator;
    T* obj = obj_allocator.allocate(1);
    exassert(obj != nullptr);
    obj_allocator.construct(obj);
    return obj;
}

template <typename T> void ExDelete(T* obj) {
    std::allocator<T> obj_allocator;
    exassert(obj != nullptr);
    obj_allocator.destroy(obj);
    obj_allocator.deallocate(obj);
}
#endif

inline void
exbcopy(const void* src_ptr, void* dst_ptr, size_t n_bytes) {
    uint8* dst = (uint8*)dst_ptr;
    uint8* dst_end = dst + n_bytes;
    const uint8* src = (const uint8*)src_ptr;
    while (dst < dst_end) {
        *dst++ = *src++;
    }
}

inline void
exmemmove(void* dst_ptr, const void* src_ptr, size_t n_bytes) {
    uint8* dst = (uint8*)dst_ptr;
    uint8* dst_end = dst + n_bytes;
    const uint8* src = (const uint8*)src_ptr;
    const uint8* src_end = src + n_bytes;
    if (src_end < dst ||
        dst_end < src) {
        while (dst < dst_end) {
            *dst++ = *src++;
        }
    } else if (dst <= src) {
        while (dst < dst_end) {
            *dst++ = *src++;
        }
    } else {
        while (dst < dst_end) {
            *--dst_end = *--src_end;
        }
    }
}

inline void*
exmemdup(const void* mem, size_t n_bytes) {
    void* dup = ExHeapAllocate(n_bytes);
    if (dup) {
        memcpy(dup, mem, n_bytes);
    }
    return dup;
}

inline char*
exstrdup(const char* mbs) {
    if (mbs == NULL) {
        return NULL;
    }
    return (char*)exmemdup(mbs, strlen(mbs) + 1);
}

inline wchar*
exwcsdup(const wchar* wcs) {
    if (wcs == NULL) {
        return NULL;
    }
    return (wchar*)exmemdup(wcs, (wcslen(wcs) + 1) * sizeof(wchar));
}

inline void*
exmemset4(void* dst_ptr, uint32 set_val, size_t n_bytes) {
    uint32* dst = (uint32*)dst_ptr;
    uint32* dst_end = dst + n_bytes / sizeof(uint32);
    while (dst < dst_end) {
        *dst++ = set_val;
    }
    return dst_ptr;
}

inline void*
exmemcpy4(void* dst_ptr, const void* src_ptr, size_t n_bytes) {
    uint32* dst = (uint32*)dst_ptr;
    uint32* dst_end = dst + n_bytes / sizeof(uint32);
    const uint32* src = (const uint32*)src_ptr;
    while (dst < dst_end) {
        *dst++ = *src++;
    }
    return dst_ptr;
}

inline void*
exmemmov4(void* dst_ptr, const void* src_ptr, size_t n_bytes) {
    uint32* dst_end;
    const uint32* src_end;
    if (dst_ptr <= src_ptr) {
        return exmemcpy4(dst_ptr, src_ptr, n_bytes);
    }
    n_bytes /= sizeof(uint32);
    dst_end = (uint32*)dst_ptr + n_bytes;
    src_end = (const uint32*)src_ptr + n_bytes;
    while (dst_ptr < dst_end) {
        *--dst_end = *--src_end;
    }
    return dst_ptr;
}

inline int32
exmemcmp4(const void* buf1, const void* buf2, size_t n_bytes) {
    int32 r = 0;
    const uint32* p1 = (const uint32*)buf1;
    const uint32* p2 = (const uint32*)buf2;
    const uint32* p1_end = p1 + n_bytes / sizeof(uint32);
    while (p1 < p1_end) {
        if ((r = *p1 - *p2) != 0) {
            break;
        }
        p1++;
        p2++;
    }
    return r;
}

inline uint32
exmemsum4(const void* data, size_t n_bytes) {
    uint32 sum4 = 0;
    const uint32* src = (const uint32*)data;
    const uint32* src_end = src + n_bytes / sizeof(uint32);
    while (src < src_end) {
        sum4 += *src++;
    }
    return sum4;
}

inline uint8
exmemsum(const void* data, size_t n_bytes) {
    uint8 sum = 0;
    const uint8* src = (const uint8*)data;
    const uint8* src_end = src + n_bytes;
    while (src < src_end) {
        sum += *src++;
    }
    return sum;
}

extern char* exstrcpy(char* __restrict __dest, const char* __restrict __src);
extern char* exstrncpy(char* __restrict __dest, const char* __restrict __src, size_t __n);
extern char* exstrcat(char* __restrict __dest, const char* __restrict __src);
extern char* exstrncat(char* __restrict __dest, const char* __restrict __src, size_t __n);
extern int exstrcmp(const char* __s1, const char* __s2);
extern int exstrncmp(const char* __s1, const char* __s2, size_t __n);

#endif//__exmemory_h__
