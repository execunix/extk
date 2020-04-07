/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#ifndef __exobject_h__
#define __exobject_h__

#include <exmemory.h>

/* Emulate The C++ RTTI(Run-Time Type Info)
 */
class ExTypeInfo {
    const wchar* name;
    const ExTypeInfo* base;
public:
    explicit ExTypeInfo(const wchar* name, const ExTypeInfo* base)
        : name(name), base(base) {}
    operator const wchar* () const { return name; }
    bool isBase(const ExTypeInfo* type) const {
        for (const ExTypeInfo* t = this; t; t = t->base)
            if (t == type) return true;
        return false;
    }
};

/* ExObject
 */
class ExObject {
protected:
    virtual ~ExObject() {}
    explicit ExObject() {}
public:
    const wchar* getTypeName() const {
        return *getDynamicTypeInfo();
    }
public:
    virtual const ExTypeInfo* getDynamicTypeInfo() const {
        return getStaticTypeInfo();
    }
    static const ExTypeInfo* getStaticTypeInfo() {
        static ExTypeInfo typeinfo(L"ExObject", NULL);
        return &typeinfo;
    }
};

#define Ex_DECLARE_TYPEINFO(ClassName, BaseClass) \
    virtual const ExTypeInfo* getDynamicTypeInfo() const { \
        return getStaticTypeInfo(); } \
    static const ExTypeInfo* getStaticTypeInfo() { \
        static ExTypeInfo typeinfo(L#ClassName, BaseClass::getStaticTypeInfo()); \
        return &typeinfo; }

// Emulate dynamic_cast<T>(obj)
// usage: if (ExIsBase<ExWindow>(widget))
template <typename T> inline bool ExIsBase(const ExObject* obj) {
    return obj->getDynamicTypeInfo()->isBase(T::getStaticTypeInfo());
}

// Emulate typeid(T)==typeid(obj)
// usage: if (ExIsType<ExWindow>(widget))
template <typename T> inline bool ExIsType(const ExObject* obj) {
    return obj->getDynamicTypeInfo() == T::getStaticTypeInfo();
}

#endif//__exobject_h__
