/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excallback_h__
#define __excallback_h__

#include "exevent.h"
#include <list>

// ExPolyFunc
//
template <typename Ret, typename... Arg>
struct ExPolyFunc {
    // any types
    class Any {};
    typedef Ret (STDCALL Any::*ThisFunc)(Arg...);
    typedef Ret (STDCALL *FuncPtr)(void*, Arg...);
    // variables
    void* data;
    union { // _stdcall mandatory
        ThisFunc func;
        FuncPtr vfunc;
    };
    #if EX2CONF_DISABLE_STDCALL
    // implement restrictions and simplifications from std::function
    Ret (*invoker)(const ExPolyFunc& pf, Arg... arg);
    static Ret thisfunc(const ExPolyFunc& pf, Arg... arg) {
        return (((Any*)(pf.data))->*(pf.func))(arg...);
    }
    static Ret funcptr(const ExPolyFunc& pf, Arg... arg) {
        return (*pf.vfunc)(pf.data, arg...);
    }
    #endif
    // placement
    ExPolyFunc(const ExPolyFunc& cb)
        : data(cb.data), func(cb.func) {
        #if EX2CONF_DISABLE_STDCALL
        invoker = cb.invoker;
        #endif
    }
    ExPolyFunc(void* data)
        : data(data), func(NULL) {
        #if EX2CONF_DISABLE_STDCALL
        invoker = &thisfunc; // default
        #endif
    }
    ExPolyFunc()
        : data(NULL), func(NULL) {
        #if EX2CONF_DISABLE_STDCALL
        invoker = &thisfunc; // default
        #endif
    }
    // functions
    ExPolyFunc& operator = (const ExPolyFunc& cb) {
        func = cb.func;
        data = cb.data;
        #if EX2CONF_DISABLE_STDCALL
        invoker = cb.invoker;
        #endif
        return *this;
    }
    bool operator == (const ExPolyFunc& cb) const {
        return (func == cb.func && data == cb.data);
    }
    Ret operator () (Arg... arg) const {
        #if EX2CONF_DISABLE_STDCALL
        return (*invoker)(*this, arg...);
        #else
        return (((Any*)data)->*func)(arg...);
        #endif
    }
    operator bool () const {
        return (func != NULL);
    }
};

// Callback functions
//
struct ExCallback : public ExPolyFunc<int, void*, void*> {
    template <typename A, typename B, typename C>
    ExCallback(A* d, int (STDCALL A::*f)(B*, C*))  // look like data->func(...)
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, typename B, typename C>
    ExCallback(int (STDCALL *f)(A*, B*, C*), A* d) // look like func(data, ...)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExCallback(const ExCallback& cb)
        : ExPolyFunc(cb) {}
    ExCallback()
        : ExPolyFunc() {}
};

struct ExDrawFunc : public ExPolyFunc<void, ExCanvas*, const ExWidget*, const ExRegion*> {
    template <typename A, class W/*inherit ExWidget*/>
    ExDrawFunc(A* d, void (STDCALL A::*f)(ExCanvas*, const W*, const ExRegion*))
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, class W/*inherit ExWidget*/>
    ExDrawFunc(void (STDCALL *f)(A*, ExCanvas*, const W*, const ExRegion*), A* d)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExDrawFunc(const ExDrawFunc& df)
        : ExPolyFunc(df) {}
    ExDrawFunc()
        : ExPolyFunc() {}
};

struct ExFlushFunc : public ExPolyFunc<void, const ExWidget*, const ExRegion*> {
    template <typename A, class W/*inherit ExWindow*/>
    ExFlushFunc(A* d, void (STDCALL A::*f)(W*, const ExRegion*))
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, class W/*inherit ExWindow*/>
    ExFlushFunc(void (STDCALL *f)(A*, W*, const ExRegion*), A* d)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExFlushFunc(const ExFlushFunc& ff)
        : ExPolyFunc(ff) {}
    ExFlushFunc()
        : ExPolyFunc() {}
};

// ExCallbackList
//
class ExCallbackList {
private:
    struct Callback : public ExCallback {
        uint8_t prio;
        uint8_t flag;
        uint16_t mask;
        Callback(const ExCallback& cb, uint8_t p)
            : ExCallback(cb), prio(p), flag(0), mask(0) {
        }
    };
    class CallbackList : public std::list<Callback> {
        uint16_t influx; // for recurs
        uint16_t change;
    public:
        CallbackList() : std::list<Callback>(), influx(0), change(0) {}
    public:
        // inherit size_t size();
        bool remove2(const ExCallback& cb);
        // inherit void remove(const Callback& cb);
        // inherit void push_back(const Callback& cb);
        // inherit void push_front(const Callback& cb);
        void push(const Callback& cb); // lifo
        int invoke(void* object, void* cbinfo);
    };
    #if 1
    CallbackList cblist;
    #else
    CallbackList filter_list;
    CallbackList handler_list;
    #endif
public:
    ExCallbackList() : cblist() {}
public: // operations
    #if EX2CONF_LAMBDA_CALLBACK
    void add(int (STDCALL *f)(void*, void*, ExCbInfo*), void* d, uint8_t prio = 5) {
        cblist.push(Callback(ExCallback(f, d), prio));
    }
    #endif
    template <typename A, typename B, typename C>
    void add(int (STDCALL *f)(A*, B*, C*), A* d, uint8_t prio = 5) {
        cblist.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, typename B, typename C>
    void add(A* d, int (STDCALL A::*f)(B*, C*), uint8_t prio = 5) {
        cblist.push(Callback(ExCallback(d, f), prio));
    }
    void remove(const ExCallback& cb) {
        cblist.remove2(cb);
    }
    int invoke(void* object, void* cbinfo) {
        return cblist.invoke(object, cbinfo);
    }
    size_t size() const { return cblist.size(); }
};

// ExCallTypeList
//
class ExCallTypeList {
private:
    struct CallType : public ExCallback {
        int type;
        uint8_t prio;
        uint8_t flag;
        uint16_t mask;
        CallType(const ExCallback& cb, int t, uint8_t p)
            : ExCallback(cb), type(t), prio(p), flag(0), mask(0) {
        }
    };
    class CallTypeList : public std::list<CallType> {
        uint16_t influx; // for recurs
        uint16_t change;
    public:
        CallTypeList() : std::list<CallType>(), influx(0), change(0) {}
    public:
        // inherit size_t size();
        bool remove2(int type, uint8_t prio);
        // inherit void remove(const CallType& cb);
        // inherit void push_back(const CallType& cb);
        // inherit void push_front(const CallType& cb);
        void push(const CallType& cb); // lifo
        int invoke(int type, void* object, void* cbinfo);
    };
    CallTypeList cblist;
public:
    ExCallTypeList() : cblist() {}
public: // operations
    #if EX2CONF_LAMBDA_CALLBACK
    void add(int (STDCALL *f)(void*, void*, ExCbInfo*), void* d, int type, uint8_t prio = 5) {
        cblist.push(CallType(ExCallback(f, d), type, prio));
    }
    #endif
    template <typename A, typename B, typename C>
    void add(int (STDCALL *f)(A*, B*, C*), A* d, int type, uint8_t prio = 5) {
        cblist.push(CallType(ExCallback(f, d), type, prio));
    }
    template <typename A, typename B, typename C>
    void add(A* d, int (STDCALL A::*f)(B*, C*), int type, uint8_t prio = 5) {
        cblist.push(CallType(ExCallback(d, f), type, prio));
    }
    void remove(int type, uint8_t prio = 5) {
        cblist.remove2(type, prio);
    }
    int invoke(int type, void* object, void* cbinfo) {
        return cblist.invoke(type, object, cbinfo);
    }
    size_t size() const { return cblist.size(); }
};

// ExNotify
//
struct ExNotify : public ExPolyFunc<int, void*> {
    template <typename A, typename B>
    ExNotify(A* d, int (STDCALL A::*f)(B*))  // look like data->func(...)
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, typename B>
    ExNotify(int (STDCALL *f)(A*, B*), A* d) // look like func(data, ...)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExNotify(const ExNotify& cb)
        : ExPolyFunc(cb) {}
    ExNotify()
        : ExPolyFunc() {}
};

#endif//__excallback_h__
