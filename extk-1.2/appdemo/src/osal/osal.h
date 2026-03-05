//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//

#ifndef _osal_h_
#define _osal_h_

#ifdef WIN32

#include <stdint.h>
#include "framework.h"

//struct epoll_event {
//    HANDLE handle;
//};

#else // __linux__

#include <excompat.h>

#endif // WIN32

#endif // _osal_h_
