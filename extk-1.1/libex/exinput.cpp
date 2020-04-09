/*
 * Copyright (C) 2007 C.H Park <execunix@gmail.com>
 * SPDX-License-Identifier:     GPL-2.0+
 */

#include <exapp.h>
#include <exinput.h>
#include <exthread.h>

// ExInputList
//
class ExInputList : public std::list<ExInput> {
public:
    int         count;
    int         dirty;
    HANDLE      handles[MAXIMUM_WAIT_OBJECTS];
public:
    ExInputList() : std::list<ExInput>(), count(0), dirty(0) {}
public:
    ulong setup();
    void remove(ExInput* input);
    void enumerate(ExCallback& callback, ExCbInfo* cbinfo);
    ExInput* search(HANDLE handle);
    ExInput* insert(HANDLE handle, ExCallback& callback, int pos);
    ExInput* append(HANDLE handle, ExCallback& callback);
    int invoke(ulong waittick = INFINITE);
};

ulong ExInputList::setup() {
    if (dirty) {
        dirty = 0;
        int cnt = 0;
        iterator i = begin();
        while (i != end()) {
            ExInput& input = *i;
            if (input.fRemoved) {
                i = erase(i);
            } else {
                handles[cnt++] = input.handle;
                ++i;
            }
        }
        assert(cnt < MAXIMUM_WAIT_OBJECTS);
        assert(cnt == count);
    }
    return count;
}

void ExInputList::remove(ExInput* input) {
    for (iterator i = begin(); i != end(); ++i) {
        if (input == &*i) {
            if (input->fRemoved) {
                exerror(L"%s warn. already removed\n", __funcw__);
                return;
            }
            input->fRemoved = 1;
            ExWakeupMainThread();
            assert(count > 0);
            count--;
            dirty++;
            return;
        }
    }
    exerror(L"%s fail. invalid input\n", __funcw__);
}

void ExInputList::enumerate(ExCallback& callback, ExCbInfo* cbinfo) {
    for (iterator i = begin(); i != end(); ++i) {
        ExInput& input = *i;
        if (!input.fRemoved) {
            int r = callback(&input, cbinfo);
            if (r != Ex_Continue)
                break;
        }
    }
}

ExInput* ExInputList::search(HANDLE handle) {
    for (iterator i = begin(); i != end(); ++i) {
        ExInput& input = *i;
        if (input.handle == handle &&
            !input.fRemoved) {
            return &input;
        }
    }
    return NULL;
}

ExInput* ExInputList::insert(HANDLE handle, ExCallback& callback, int pos) {
    ExInput* input = search(handle);
    if (input != NULL) { // Remove duplicate handle.
        input->fRemoved = 1;
        count--;
    }
    if (count >= MAXIMUM_WAIT_OBJECTS) {
        exerror(L"%s fail. count=%d\n", __funcw__, count);
        return NULL;
    }
    int cnt = 0;
    iterator i = begin();
    for (; i != end(); ++i) {
        if (!(*i).fRemoved && pos == cnt)
            break;
        ++cnt;
    }
    count++;
    dirty++;
    ExWakeupMainThread();
    return &*std::list<ExInput>::insert(i, ExInput(handle, callback));
}

ExInput* ExInputList::append(HANDLE handle, ExCallback& callback) {
    ExInput* input = search(handle);
    if (input != NULL) { // Remove duplicate handle.
        input->fRemoved = 1;
        count--;
    }
    if (count >= MAXIMUM_WAIT_OBJECTS) {
        exerror(L"%s fail. count=%d\n", __funcw__, count);
        return NULL;
    }
    count++;
    dirty++;
    ExWakeupMainThread();
    push_back(ExInput(handle, callback));
    return &back();
}

int ExInputList::invoke(ulong waittick)
{
    DWORD nCount = setup();
    LPHANDLE pHandles = handles;
    DWORD dwMilliseconds = waittick;//INFINITE;
    DWORD dwWakeMask = QS_ALLEVENTS;//QS_ALLINPUT;
    DWORD dwFlags = MWMO_INPUTAVAILABLE;
    DWORD dwWaitRet; // signaled number

    ExLeave();
    //Sleep(1);
    dwWaitRet = MsgWaitForMultipleObjectsEx(nCount, pHandles,
                                            dwMilliseconds, dwWakeMask, dwFlags);
    ExEnter();

    exTickCount = GetTickCount(); // update tick

    if (dwWaitRet == WAIT_TIMEOUT) {
        dprint0(L"ExInputMgr: nCount=%d WAIT_TIMEOUT\n", nCount);
        return 0; // no messages are available
    }
    if (dwWaitRet == WAIT_OBJECT_0 + nCount) {
        dprint0(L"ExInputMgr: nCount=%d GOT_GWES_MSG\n", nCount);
        return 1; // got message from gwes
    }
    if (dwWaitRet >= WAIT_OBJECT_0 &&
        dwWaitRet < (WAIT_OBJECT_0 + nCount)) {
        dprintf(L"ExInputMgr: dwWaitRet=%p nCount=%d\n", dwWaitRet, nCount);
        int cnt = 1;
        iterator i = begin();
        for (DWORD n = 0; n < nCount; n++) {
            assert(i != end());
            ExInput& input = *i++; // proc input handler
            assert(input.handle == pHandles[n]);
            if (input.fRemoved)
                continue; // discard
            if (input.handle != pHandles[dwWaitRet - WAIT_OBJECT_0] &&
                WaitForSingleObject(input.handle, 0) != WAIT_OBJECT_0)
                continue;
            assert(input.callback.func);
            int r = input.callback(&input, &ExCbInfo(Ex_CbInput));
            if (r & Ex_Halt) {
                return ExApp::setHalt(r);
            }
            if ((r & Ex_Remove) && !input.fRemoved) {
                input.fRemoved = 1;
                count--;
                dirty++;
            }
            cnt++;
        }
        return cnt; // got input signal
    }
    exerror(L"ExInputMgr: dwWaitRet=%p GetLastError=0x%p\n", dwWaitRet, GetLastError());
    return -1; // error
}

ExInputList exInputList;

void ExInput::remove(ExInput* input) {
    if (input == NULL)
        return;
    exInputList.remove(input);
}

int ExInput::invoke(ulong waittick) {
    return exInputList.invoke(waittick);
}

// This routine adds a function to a ExMainLoop() input-event processing chain.
ExInput* ExInput::add(HANDLE handle, ExCallback& callback) {
    if (handle == NULL ||
        handle == INVALID_HANDLE_VALUE)
        return NULL;
    assert(callback.func);
    return exInputList.append(handle, callback);
//	return exInputList.insert(handle, callback, pos);
}

ExInput* ExInput::find(HANDLE handle) {
    if (handle == NULL ||
        handle == INVALID_HANDLE_VALUE)
        return NULL;
    return exInputList.search(handle);
}

void ExInput::enumerate(ExCallback& callback, ExCbInfo* cbinfo) {
    assert(callback);
    exInputList.enumerate(callback, cbinfo);
}

