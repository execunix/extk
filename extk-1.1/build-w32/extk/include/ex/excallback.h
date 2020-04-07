/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excallback_h__
#define __excallback_h__

#include <exevent.h>
#include <list>

// Callback functions
//
struct ExCallback {
    typedef int(STDCALL ExAny::*AnyFunc)(void*, void*);
    typedef int(STDCALL *Func)(void*, void*, void*);
    union { // _stdcall mandatory
        AnyFunc anyfunc;
        Func func;
    };
    void* data;

    template <typename A, typename B, typename C>
    ExCallback(A* d, int(STDCALL A::*f)(B*, C*))  // look like data->func(...)
        : anyfunc(reinterpret_cast<AnyFunc>(f)), data(d) {}
    template <typename A, typename B, typename C>
    ExCallback(int(STDCALL *f)(A*, B*, C*), A* d) // look like func(data, ...)
        : func(reinterpret_cast<Func>(f)), data(d) {}
    ExCallback(const ExCallback& cb)
        : func(cb.func), data(cb.data) {}
    ExCallback(Func f, void* d)
        : func(f), data(d) {}
    ExCallback()
        : func(NULL), data(NULL) {}

    ExCallback& operator = (const ExCallback& cb) {
        func = cb.func;
        data = cb.data;
        return *this;
    }
    bool operator == (const ExCallback& cb) const {
        return (func == cb.func && data == cb.data);
    }
    int operator () (void* object, void* cbinfo) const {
        return (((ExAny*)data)->*anyfunc)(object, cbinfo); // same as "func(data, object, cbinfo)"
    }
    operator bool() const {
        return (func != NULL);
    }
};

struct ExDrawFunc {
    typedef void(STDCALL ExAny::*AnyFunc)(ExCanvas*, const ExWidget*, const ExRegion*);
    typedef void(STDCALL *Func)(void*, ExCanvas*, const ExWidget*, const ExRegion*);
    union { // _stdcall mandatory
        AnyFunc anyfunc;
        Func func;
    };
    void* data;

    template <typename A, class W/*inherit ExWidget*/>
    ExDrawFunc(A* d, void(STDCALL A::*f)(ExCanvas*, const W*, const ExRegion*))
        : anyfunc(reinterpret_cast<AnyFunc>(f)), data(d) {}
    template <typename A, class W/*inherit ExWidget*/>
    ExDrawFunc(void(STDCALL *f)(A*, ExCanvas*, const W*, const ExRegion*), A* d)
        : func(reinterpret_cast<Func>(f)), data(d) {}
    ExDrawFunc(const ExDrawFunc& df)
        : func(df.func), data(df.data) {}
    ExDrawFunc(Func f, void* d)
        : func(f), data(d) {}
    ExDrawFunc()
        : func(NULL), data(NULL) {}

    ExDrawFunc& operator = (const ExDrawFunc& df) {
        func = df.func;
        data = df.data;
        return *this;
    }
    bool operator == (const ExDrawFunc& df) const {
        return (func == df.func && data == df.data);
    }
    void operator () (ExCanvas* canvas, const ExWidget* widget, const ExRegion* damage) const {
        (((ExAny*)data)->*anyfunc)(canvas, widget, damage); // func(data, canvas, widget, damage);
    }
    operator bool() const {
        return (func != NULL);
    }
};

struct ExFlushFunc {
    typedef void(STDCALL ExAny::*AnyFunc)(ExWindow*, const ExRegion*);
    typedef void(STDCALL *Func)(void*, ExWindow*, const ExRegion*);
    union { // _stdcall mandatory
        AnyFunc anyfunc;
        Func func;
    };
    void* data;

    template <typename A, class W/*inherit ExWindow*/>
    ExFlushFunc(A* d, void(STDCALL A::*f)(W*, const ExRegion*))
        : anyfunc(reinterpret_cast<AnyFunc>(f)), data(d) {}
    template <typename A, class W/*inherit ExWindow*/>
    ExFlushFunc(void(STDCALL *f)(A*, W*, const ExRegion*), A* d)
        : func(reinterpret_cast<Func>(f)), data(d) {}
    ExFlushFunc(const ExFlushFunc& ff)
        : func(ff.func), data(ff.data) {}
    ExFlushFunc(Func f, void* d)
        : func(f), data(d) {}
    ExFlushFunc()
        : func(NULL), data(NULL) {}

    ExFlushFunc& operator = (const ExFlushFunc& ff) {
        func = ff.func;
        data = ff.data;
        return *this;
    }
    bool operator == (const ExFlushFunc& ff) const {
        return (func == ff.func && data == ff.data);
    }
    void operator () (ExWindow* window, const ExRegion* updateRgn) const {
        (((ExAny*)data)->*anyfunc)(window, updateRgn); // func(data, window, updateRgn);
    }
    operator bool() const {
        return (func != NULL);
    }
};

#endif//__excallback_h__
