/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __excallback_h__
#define __excallback_h__

#include "extypes.h"

#include <list>

// Callback Info
//
struct ExCbInfo {
    uint32      type;
    uint32      subtype;
    ExEvent*    event; // A pointer to a ExEvent structure that describes the event
                       //   that caused this callback to be invoked.
    void*       data;  // A pointer to callback-specific data.

    ExCbInfo(uint32 t, uint32 s = 0, ExEvent* e = NULL, void* d = NULL) noexcept
        : type(t), subtype(s), event(e), data(d) {}
    // pointer
    ExCbInfo* set(uint32 t, uint32 s, ExEvent* e, void* d = NULL) {
        type = t; subtype = s; event = e; data = d;
        return this;
    }
    ExCbInfo* set(uint32 t, uint32 s) {
        type = t; subtype = s;
        return this;
    }
    ExCbInfo* set(uint32 t) {
        type = t;
        return this;
    }
    // reference
    ExCbInfo& operator () (uint32 t, uint32 s, ExEvent* e, void* d = NULL) {
        type = t; subtype = s; event = e; data = d;
        return *this;
    }
    ExCbInfo& operator () (uint32 t, uint32 s) {
        type = t; subtype = s;
        return *this;
    }
    ExCbInfo& operator () (uint32 t) {
        type = t;
        return *this;
    }
};

// ExPolyFunc
//
template <typename Ret, typename... Arg>
struct ExPolyFunc {
    // any types
    class Any {};
    typedef Ret (Any::*ThisFunc)(Arg...);
    typedef Ret (*FuncPtr)(void*, Arg...);
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
    ExPolyFunc(const ExPolyFunc& cb) noexcept
        : data(cb.data), func(cb.func) {
        #if EX2CONF_DISABLE_STDCALL
        invoker = cb.invoker;
        #endif
    }
    ExPolyFunc(void* data) noexcept
        : data(data), func(NULL) {
        #if EX2CONF_DISABLE_STDCALL
        invoker = &thisfunc; // default
        #endif
    }
    ExPolyFunc() noexcept
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
struct ExCallback : public ExPolyFunc<uint32, const void*, const void*> {
    template <typename A, typename B, typename C>
    ExCallback(A* d, uint32 (A::*f)(B*, C*)) noexcept // look like data->func(...)
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, typename B, typename C>
    ExCallback(uint32 (*f)(A*, B*, C*), A* d) noexcept // look like func(data, ...)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExCallback(const ExCallback& cb) noexcept
        : ExPolyFunc(cb) {}
    ExCallback() noexcept
        : ExPolyFunc() {}
};

struct ExDrawFunc : public ExPolyFunc<void, const ExCanvas*, const ExWgtRes*, const ExRegion*> {
    template <typename A, typename B, typename C, typename D>
    ExDrawFunc(A* d, void (A::*f)(B*, C*, D*)) noexcept
        : ExPolyFunc(d) {
        using NonConstC = typename std::remove_const<C>::type;
        static_assert(std::is_same<ExWgtRes, NonConstC>::value, "C must be ExWgtRes");
        static_assert(std::is_base_of<ExCanvas, B>::value, "B must be derived from ExCanvas");
        static_assert(std::is_base_of<ExRegion, D>::value, "D must be derived from ExRegion");
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, typename B, typename C, typename D>
    ExDrawFunc(void (*f)(A*, B*, C*, D*), A* d) noexcept
        : ExPolyFunc(d) {
        using NonConstC = typename std::remove_const<C>::type;
        static_assert(std::is_same<ExWgtRes, NonConstC>::value, "C must be ExWgtRes");
        static_assert(std::is_base_of<ExCanvas, B>::value, "B must be derived from ExCanvas");
        static_assert(std::is_base_of<ExRegion, D>::value, "D must be derived from ExRegion");
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExDrawFunc(const ExDrawFunc& df) noexcept
        : ExPolyFunc(df) {}
    ExDrawFunc() noexcept
        : ExPolyFunc() {}
    #if 0 // inherit
    template <typename B, typename C, typename D>
    void operator () (B* canvas, C* widget, D* region) const {
        #if EX2CONF_DISABLE_STDCALL
        (*invoker)(*this, canvas, widget, region);
        #else
        (((Any*)data)->*func)(canvas, widget, region);
        #endif
    }
    #endif
};

struct ExFlushFunc : public ExPolyFunc<void, const ExWidget*, const ExRegion*> {
    template <typename A, class W/*inherit ExWindow*/>
    ExFlushFunc(A* d, void (A::*f)(W*, const ExRegion*)) noexcept
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, class W/*inherit ExWindow*/>
    ExFlushFunc(void (*f)(A*, W*, const ExRegion*), A* d) noexcept
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExFlushFunc(const ExFlushFunc& ff) noexcept
        : ExPolyFunc(ff) {}
    ExFlushFunc() noexcept
        : ExPolyFunc() {}
};

// ExCallbackList
//
class ExCallbackList {
private:
    struct Callback : public ExCallback {
        uint8 prio;
        uint8 flag;
        uint16 mask;
        Callback(const ExCallback& cb, uint8 p) noexcept
            : ExCallback(cb), prio(p), flag(0), mask(0) {
        }
    };
    class CallbackList : public std::list<Callback> {
        uint16 influx; // for recurs
        uint16 change;
    public:
        CallbackList() noexcept : std::list<Callback>(), influx(0), change(0) {}
    public:
        // inherit size_t size();
        bool remove2(const ExCallback& cb);
        // inherit void remove(const Callback& cb);
        // inherit void push_back(const Callback& cb);
        // inherit void push_front(const Callback& cb);
        void push(const Callback& cb); // lifo
        uint32 invoke(const void* object, const void* cbinfo);
    };
    #if 1
    CallbackList cblist;
    #else
    CallbackList filter_list;
    CallbackList handler_list;
    #endif
public:
    ExCallbackList() noexcept : cblist() {}
public: // operations
    void add(const ExCallback& cb, uint8 prio = 5U) { // for lambda or pre-constructed ExCallback
        cblist.push(Callback(cb, prio));
    }
    template <typename A, typename B, typename C>
    void add(uint32 (*f)(A*, B*, C*), A* d, uint8 prio = 5U) {
        cblist.push(Callback(ExCallback(f, d), prio));
    }
    template <typename A, typename B, typename C>
    void add(A* d, uint32 (A::*f)(B*, C*), uint8 prio = 5U) {
        cblist.push(Callback(ExCallback(d, f), prio));
    }
    void remove(const ExCallback& cb) {
        cblist.remove2(cb);
    }
    template <typename B, typename C>
    uint32 invoke(B* object, C* cbinfo) {
        return cblist.invoke(object, cbinfo);
    }
    size_t size() const { return cblist.size(); }
};

// ExListenerList
//
class ExListenerList {
private:
    struct Listener : public ExCallback {
        uint32 type;
        uint8 prio;
        uint8 flag;
        uint16 mask;
        Listener(const ExCallback& cb, uint32 t, uint8 p) noexcept
            : ExCallback(cb), type(t), prio(p), flag(0), mask(0) {
        }
    };
    class ListenerList : public std::list<Listener> {
        uint16 influx; // for recurs
        uint16 change;
    public:
        ListenerList() noexcept : std::list<Listener>(), influx(0), change(0) {}
    public:
        // inherit size_t size();
        bool remove2(uint32 type, uint8 prio);
        // inherit void remove(const Listener& cb);
        // inherit void push_back(const Listener& cb);
        // inherit void push_front(const Listener& cb);
        void push(const Listener& cb); // lifo
        uint32 invoke(uint32 type, const void* object, const void* cbinfo);
    };
    ListenerList cblist;
public:
    ExListenerList() noexcept : cblist() {}
public: // operations
    void add(const ExCallback& cb, uint32 type, uint8 prio = 5U) { // for lambda or pre-constructed ExCallback
        cblist.push(Listener(cb, type, prio));
    }
    template <typename A, typename B, typename C>
    void add(uint32 (*f)(A*, B*, C*), A* d, uint32 type, uint8 prio = 5U) {
        static_assert(std::is_base_of<ExObject, B>::value, "B must be derived from ExObject");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        cblist.push(Listener(ExCallback(f, d), type, prio));
    }
    template <typename A, typename B, typename C>
    void add(A* d, uint32 (A::*f)(B*, C*), uint32 type, uint8 prio = 5U) {
        static_assert(std::is_base_of<ExObject, B>::value, "B must be derived from ExObject");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        cblist.push(Listener(ExCallback(d, f), type, prio));
    }
    void remove(uint32 type, uint8 prio = 5U) {
        cblist.remove2(type, prio);
    }
    template <typename B, typename C>
    uint32 invoke(uint32 type, B* object, C* cbinfo) {
        // using NonConstB = typename std::remove_const<B>::type;
        // using NonConstC = typename std::remove_const<C>::type;
        // return cblist.invoke(type, (NonConstB*)object, (NonConstC*)cbinfo);
        static_assert(std::is_base_of<ExObject, B>::value, "B must be derived from ExObject");
        static_assert(std::is_base_of<ExCbInfo, C>::value, "C must be derived from ExCbInfo");
        return cblist.invoke(type, object, cbinfo);
    }
    size_t size() const { return cblist.size(); }
};

// ExNotify
//
struct ExNotify : public ExPolyFunc<uint32, const void*> {
    template <typename A, typename B>
    ExNotify(A* d, uint32 (A::*f)(B*)) noexcept // look like data->func(...)
        : ExPolyFunc(d) {
        func = reinterpret_cast<ThisFunc>(f);
    }
    template <typename A, typename B>
    ExNotify(uint32 (*f)(A*, B*), A* d) noexcept // look like func(data, ...)
        : ExPolyFunc(d) {
        vfunc = reinterpret_cast<FuncPtr>(f);
        #if EX2CONF_DISABLE_STDCALL
        invoker = &funcptr;
        #endif
    }
    ExNotify(const ExNotify& cb) noexcept
        : ExPolyFunc(cb) {}
    ExNotify() noexcept
        : ExPolyFunc() {}
};

#endif//__excallback_h__
