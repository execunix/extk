//
// Copyright (C) 2020 C.H Park <execunix@gmail.com>
// SPDX-License-Identifier:     GPL-2.0+
//
// appdemo.cpp : Defines the entry point for the application.
//

#include "osal/osal.h"
#ifdef __linux__
#include <ctype.h>
#include <locale.h>
#include <execinfo.h>
#endif // __linux__
#include <functional>
#include <exdebug.h>
#include "appdemo.h"
#include "lcdout.h"
#include "watch.h"
#include "wdmgr.h"
#include "res.h"
#include "env.h"

#if defined(__aarch64__)
//x
#endif

class TestClass {
public:
    uint32 onCb1(ExObject* object, ExCbInfo* cbinfo) {
        dprint("onCb1\n");
        return 0U;
    }
    virtual uint32 onCb2(ExObject* object, ExCbInfo* cbinfo) {
        dprint("onCb2\n");
        return 0U;
    }
    static uint32 onCb3(void* data, ExObject* object, ExCbInfo* cbinfo) {
        dprint("onCb3\n");
        return 0U;
    }
    static uint32 onCb4(TestClass* data, ExObject* object, ExCbInfo* cbinfo) {
        dprint("onCb4\n");
        return 0U;
    }
};

class TestClass2 : public TestClass {
public:
    uint32 onCb5(ExObject* object, TestClass* cbinfo) {
        dprint("onCb5\n");
        return 0U;
    }
};

static uint32
func(void* data, ExWidget* widget, ExCbInfo* cbinfo) {
    dprint("func: data=%p type=%d\n", data, cbinfo ? cbinfo->type : -1);
    return 0U;
}

#if 0
void functional_test() {
    std::function<int(int, int)> fn1 = [](int a, int b) { return a + b; };
    std::function<uint32 (void*, ExWidget*, ExCbInfo*)> fn2 = func;
    std::function<uint32 (void*, ExWidget*, ExCbInfo*)> fn3 = func;
    //ExCallback cb2(fn2, NULL);
    //ExCallback cb3(fn3, NULL);
    ExCallback::FuncPtr fn4 = [](void* data, void* widget, void* cbinfo)->uint32 {
        return 0U; };
    ExCallback cb4(fn4, NULL);
}
#endif

TestClass test_class;
TestClass2 test_class2;

ExCallback cb_list[8];

void add_callback(ExCallback& cb) {
    static int i = 0;
    cb_list[i++] = cb;
}

void cb_test() {
    uint32 r;
    ExCbInfo cbinfo(0);

#if 0
    std::list<int> intList;
    intList.push_back(0);
    intList.push_back(1);
    intList.push_back(2);
    intList.push_back(3);
    int n = 0;
    for (std::list<int>::iterator i = intList.begin(); i != intList.end(); n++) {
        std::list<int>::iterator it = i++;
        if (n == 3) {
            intList.push_back(4);
            intList.erase(it);
        }
    }
#endif
    ExCallback cb0(func, (void*)NULL);
    r = cb0(NULL, NULL);
    dprint("r = %d\n", r);

    ExCallback cb5(&test_class2, &TestClass2::onCb5);
    r = cb5(NULL, cbinfo.set(0));
    dprint("r = %d\n", r);

    ExCallback cb4(&TestClass::onCb3, (void*)&test_class2);
    r = cb4(NULL, NULL);
    dprint("r = %d\n", r);

    ExCallback cb3(&TestClass::onCb4, &test_class);
    r = cb3(NULL, NULL);
    dprint("r = %d\n", r);

    ExCallback cb2(&test_class, &TestClass::onCb2);
    r = cb2(NULL, NULL);
    dprint("r = %d\n", r);

    ExCallback cb1(&test_class, &TestClass::onCb1);
    r = cb1(NULL, NULL);
    dprint("r = %d\n", r);

    ExCallback cb6(cb0);
    r = cb6(NULL, NULL);
    cb5 = cb0;
    r = cb5(NULL, NULL);

    add_callback(cb0);
    add_callback(cb1);
    add_callback(cb2);
    add_callback(cb3);

    cb_list[0](NULL, NULL);
    cb_list[1](NULL, NULL);
    cb_list[2](NULL, NULL);
    cb_list[3](NULL, NULL);

    ExWidget widget;
    widget.addListener(&func, (void*)123, 1);
    widget.invokeListener(1);
}

#ifdef DEBUG
void exwindow_apitest() {
    ExRect rc(0);
    ExWindow* wnd0 = ExWindow::create("TopWindow", 800, 480);
    ExWidget* wgt1 = ExWidget::create(wnd0, "Child1", &rc.set(100, 100, 100, 40));
    ExWidget* wgt2 = ExWidget::create(wnd0, "Child2", &rc.set(200, 200, 100, 40));
    wnd0->realize();
    wnd0->destroy();

    ExWindow* top = new ExWindow;
    ExWidget* ch1 = new ExWidget;
    ExWidget* ch2 = new ExWidget;
    top->init("Top", 800, 480);
    ch1->init(top, "Ch1", &rc.set(100, 100, 100, 40));
    ch2->init(top, "Ch2", &rc.set(200, 200, 100, 40));
    ExWidget* backWgt = top->getChildHead();
    top->destroy();
    delete ch2;
    delete ch1;
    delete top;

    ExWidget* wgts = new ExWidget[100];
    ExWidget* wgt = new ExWidget;
    delete[] wgts;
    delete wgt;

    ExWindow* wnds = new ExWindow[100];
    ExWindow* wnd = new ExWindow;
    delete[] wnds;
    delete wnd;
}
#endif

#define MAGIC_NUMBER_FIXED_16_16 (103079215104.0)
#define MAGIC_NUMBER_FIXED ((1LL << (52 - 8/*CR_FIXED_FRAC_BITS*/)) * 1.5)

static inline int32
_fixed_from_float(float d)
{
    return (int32)(d * 256.f);
}

static inline int32
_fixed_from_double(double d)
{
    return (int32)(d * 256.);
}

/* For 32-bit fixed point numbers */
static inline int32
_fixed_from_doublem(double d)
{
    union {
        double d;
        int32 i[2];
    } u;

    u.d = d + MAGIC_NUMBER_FIXED;
#ifdef FLOAT_WORDS_BIGENDIAN
    return u.i[1];
#else
    return u.i[0];
#endif
}

static inline int32
_fixed_16_16_from_float(float d)
{
    return (int32)(d * 65536.f);
}

static inline int32
_fixed_16_16_from_double(double d)
{
    return (int32)(d * 65536.);
}

static inline int32
_fixed_16_16_from_doublem(double d)
{
    union {
        double d;
        int32 i[2];
    } u;

    u.d = d + MAGIC_NUMBER_FIXED_16_16;
#ifdef FLOAT_WORDS_BIGENDIAN
    return u.i[1];
#else
    return u.i[0];
#endif
}

#define TESTCNT 100000000

int flt_test() {
    volatile int32 val;
    uint64 tick1, tick2;

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = 0;
    }
    tick2 = ExGetTickCount();
    dprint1("val=0 loop test %ld\n", tick2 - tick1);

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_from_float(i * 1.f);
    }
    tick2 = ExGetTickCount();
    dprint1("_fixed_from_float %ld\n", tick2 - tick1);

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_from_double(i * 1.);
    }
    tick2 = ExGetTickCount();
    dprint1("_fixed_from_double %ld\n", tick2 - tick1);

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_from_doublem(i * 1.);
    }
    tick2 = ExGetTickCount();
    dprint1("_fixed_from_doublem %ld\n", tick2 - tick1);

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_16_16_from_float(i * 1.f);
    }
    tick2 = ExGetTickCount();
    dprint1("_fixed_16_16_from_float %ld\n", tick2 - tick1);

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_16_16_from_double(i * 1.);
    }
    tick2 = ExGetTickCount();
    dprint1("_fixed_16_16_from_double %ld\n", tick2 - tick1);

    tick1 = ExGetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_16_16_from_doublem(i * 1.);
    }
    tick2 = ExGetTickCount();
    dprint1("_fixed_16_16_from_doublem %ld\n", tick2 - tick1);

    return 0;
}

int app_test() {
#if 0
    //char aaa1[sizeof(long) == 8 ? 1 : -1];
    //char aaa2[sizeof(ExCallback) == 8 ? 1 : -1];
    //char aaa2[sizeof(ExCallback) == 16 ? 1 : -1];
#endif
    dprint1("sizeof(ExCbInfo)=%d\n", sizeof(ExCbInfo));
    dprint1("sizeof(ExCallback)=%d\n", sizeof(ExCallback));
    //dprint1("sizeof(ExWidget::Callback)=%d\n", sizeof(ExWidget::Callback)); // 16
    //dprint1("sizeof(ExWindow::Callback)=%d\n", sizeof(ExWindow::Callback)); // 12
    dprint1("sizeof(ExObject)=%d\n", sizeof(ExObject));
    dprint1("sizeof(ExWidget)=%d\n", sizeof(ExWidget));
    dprint1("sizeof(ExWindow)=%d\n", sizeof(ExWindow));
    dprint1("sizeof(ExTimer)=%d\n", sizeof(ExTimer));
    dprint1("sizeof(ExApp)=%d\n", sizeof(ExApp));

    ExWindow top;
    ExWidget w1;
    ExWidget w2;
    ExWidget w3;
    ExWidget w11;
    ExWidget w12;
    ExWidget w21;
    ExWidget w22;
    ExWidget w221;
    ExWidget w23;
    ExWidget w231;
    ExWidget w2311;
    ExWidget w23111;
    ExWidget detached;

    top.setName("top");
    w1.setName("w1");
    w2.setName("w2");
    w3.setName("w3");
    w11.setName("w11");
    w12.setName("w12");
    w21.setName("w21");
    w22.setName("w22");
    w221.setName("w221");
    w23.setName("w23");
    w231.setName("w231");
    w2311.setName("w2311");
    w23111.setName("w23111");
    detached.setName("detached");

    top.attachTail(&w1);
    top.attachTail(&w2);
    top.attachTail(&w3);
    w1.attachTail(&w11);
    w1.attachTail(&w12);
    w2.attachTail(&w21);
    w2.attachTail(&w22);
    w2.attachTail(&w23);
    w22.attachTail(&w221);
    w23.attachTail(&w231);
    w231.attachTail(&w2311);
    w2311.attachTail(&w23111);

    dprint1("\n*** top.dumpBackToFront()\n");
    top.dumpBackToFront();
    dprint1("\n*** w221.dumpBackToFront()\n");
    w221.dumpBackToFront();
    dprint1("\n*** w3.dumpBackToFront()\n");
    w3.dumpBackToFront();

    dprint1("\n*** top.dumpFrontToBack()\n");
    top.dumpFrontToBack();
    dprint1("\n*** w2311.dumpFrontToBack()\n");
    w2311.dumpFrontToBack();
    dprint1("\n*** w2.dumpFrontToBack()\n");
    w21.dumpFrontToBack();

    dprint1("top last = %s\n", top.last()->getName());
    dprint1("w1 last = %s\n", w1.last()->getName());
    dprint1("w2 last = %s\n", w2.last()->getName());
    dprint1("w3 last = %s\n", w3.last()->getName());

    top.giveFocus(&w1);
    top.giveFocus(&w2311);

    dprint1("detached.dumpBackToFront()\n");
    detached.dumpBackToFront();
    dprint1("detached.dumpFrontToBack()\n");
    detached.dumpFrontToBack();
    dprint1("detached last = %s\n\n", detached.last()->getName());

    w2.detachParent();
    dprint1("\n*** w2.detachParent()\n");
    top.dumpBackToFront();

    w1.attachHead(&w2);
    dprint1("\n*** w1.attachHead(&w2)\n");
    top.dumpBackToFront();

    w2.detachAll();
    dprint1("\n*** w2.detachAll()\n");
    top.dumpBackToFront();

    top.giveFocus(&w1);
    top.giveFocus(&w2311);
    top.giveFocus(NULL);

    top.addListener([](void* data, ExWidget* widget, ExCbInfo* cbinfo)->uint32 {
        dprint1("\n*** anonymous func data=%p name=%s type=%d\n",
                data, widget->getName(), cbinfo->type);
        return 0; }, &top, 1);
    top.invokeListener(1);
    top.invokeListener(2);

    #if 1 // lambda callback
    static ExTimer timer1;
    timer1.init(exWatchMain, [](void* data, ExTimer* timer, ExCbInfo* cbinfo)->uint32 {
        dprint1("\n*** anonymous func data=%p timer=%4" PRIu64 " type=%d\n",
               data, ((uint64)*timer) % 10000000U, cbinfo->type);
        return 0U; }, (void*)0xaaaa);
    //timer1.enter();
    timer1.start(1U, 1233U);
    //timer1.leave();
    #endif

    return 0;
}

struct CbTest {
    uint32 onTest1(ExTimer* timer, ExCbInfo* cbinfo) {
        printf("onTest1: data=%p value=%" PRIu64 "\n", this, (uint64)*timer);
        return 0;
    }
    static uint32 onTest2(void* data, ExTimer* timer, ExCbInfo* cbinfo) {
        printf("onTest2: data=%p value=%" PRIu64 "\n", data, (uint64)*timer);
        return 0;
    }
};

static uint32 onTimer4(void* data, ExTimer* timer, ExCbInfo* cbinfo) {
    printf("onTimer4: value=%" PRIu64 "\n", (uint64)*timer);
    return 0;
}

void poly_test()
{
    static ExTimer timer1;

    ExCallback cb1((CbTest*)NULL, &CbTest::onTest1);
    ExCallback cb2(&CbTest::onTest2, (void*)NULL);
    cb1(&timer1, NULL);
    cb2(&timer1, NULL);

    ExCallback cb3 = cb1;
    ExCallback cb4 = cb2;
    cb3(&timer1, NULL);
    cb4(&timer1, NULL);

    cb3 = ExCallback((CbTest*)NULL, &CbTest::onTest1);
    cb4 = ExCallback(&CbTest::onTest2, (void*)NULL);
    cb3(&timer1, NULL);
    cb4(&timer1, NULL);

    ExCallback cb5;
    if (cb5) cb5(&timer1, NULL);

    ExCallback cb6(&onTimer4, (void*)NULL);
    cb6(&timer1, NULL);
    ExCallbackList cblist;
    cblist.add((CbTest*)NULL, &CbTest::onTest1, 9U);
    cblist.add(&CbTest::onTest2, (void*)NULL, 9U);
    cblist.add(&onTimer4, (void*)NULL, 9U);
    ExCbInfo cbinfo(5678);
    #if 1 // lambda callback
    auto func = [](int32* data, ExTimer* object, ExCbInfo* cbinfo)->uint32 {
        printf("ExCallbackList func data=%p object=%p cbinfo=%d\n",
               data, object, cbinfo->type);
        #if 0 // test backtrace
        int* buf = NULL;
        *buf = 0;
        #endif
        return 0U;
    };
    int32 data = 0x1234;
    func(&data, &timer1, &cbinfo);
    //ExCallback cb7(static_cast<uint32 (*)(int32*, ExTimer*, ExCbInfo*)>(func), &data);

    uint32 (*func_ptr)(int32*, ExTimer*, ExCbInfo*) = [](int32* data, ExTimer* object, ExCbInfo* cbinfo)->uint32 {
        printf("ExCallbackList func data=%p object=%p cbinfo=%d\n",
               data, object, cbinfo->type);
        #if 0 // test backtrace
        int* buf = NULL;
        *buf = 0;
        #endif
        return 0U;
    };
    cblist.add(ExCallback(func_ptr, &data));
    #endif
    cblist.invoke(&timer1, &cbinfo);
}

#ifdef __linux__
constexpr int32 BT_BUF_SIZE = 32;

#ifdef LOG_BACKTRACE
static void sigaction_exit(const int32 s)
{
    dprint("Signal Exit : %d\n", s);
    (void)gWatchdog.fini();
    _exit(EXIT_FAILURE);
}

static void sigaction_halt(const int32 s)
{
    dprint("Signal Halt : %d\n", s);
    (void)gWatchApp.setHalt();
}
#endif

#ifdef LOG_BACKTRACE
static void sigaction_segv(int32 /*s*/, siginfo_t* /*si*/, void* /*t*/)
{
    int32 j;
    int32 nptrs;
    void* buffer[BT_BUF_SIZE];
    char** strings;

    nptrs = backtrace(&buffer[0], BT_BUF_SIZE);
    dprint("backtrace() returned %d addresses\n", nptrs);

    strings = backtrace_symbols(&buffer[0], nptrs);
    if (strings == nullptr) {
        dprint1("backtrace_symbols - %s\n", exstrerr());
        _exit(EXIT_FAILURE);
    }
    const char* (&btstrs)[nptrs] = *reinterpret_cast<const char* (*)[nptrs]>(strings);
    for (j = 0; j < nptrs; j++) {
        dprint1("%s\n", btstrs[j]);
    }
    ExHeapManager<char>::deallocate(strings);

    dprint0("Signal SEGV : PID=%d, %d(UID=%d)\n", getpid(), si->si_pid, si->si_uid);

    // should be reboot - nop gWatchdog.fini();
    _exit(EXIT_FAILURE);
}
#endif

static int32 init_signal()
{
#ifdef LOG_BACKTRACE
    struct sigaction sa_exit;
    struct sigaction sa_halt;
    struct sigaction sa_segv;

    (void)memset(&sa_exit, 0, sizeof(struct sigaction));
    (void)memset(&sa_halt, 0, sizeof(struct sigaction));
    (void)memset(&sa_segv, 0, sizeof(struct sigaction));

    sa_exit.sa_handler = &sigaction_exit;
    sa_halt.sa_handler = &sigaction_halt;
    sa_segv.sa_sigaction = &sigaction_segv;

    (void)sigemptyset(&(sa_exit.sa_mask));
    (void)sigemptyset(&(sa_halt.sa_mask));
    (void)sigemptyset(&(sa_segv.sa_mask));

    sa_exit.sa_flags = 0;
    sa_halt.sa_flags = 0;
    sa_segv.sa_flags = SA_SIGINFO;

    (void)sigaction(SIGINT, &sa_exit, nullptr);
    (void)sigaction(SIGABRT, &sa_exit, nullptr);
    (void)sigaction(SIGQUIT, &sa_halt, nullptr);
    (void)sigaction(SIGTERM, &sa_halt, nullptr);
    (void)sigaction(SIGSEGV, &sa_segv, nullptr);
#endif

#if 0//defined(_DEBUG)
    // Requests not to send SIGPIPE on errors on stream oriented sockets
    // when the other end breaks the connection
    const sighandler_t sig_ign = reinterpret_cast<sighandler_t>(1); // SIG_IGN
    const sighandler_t sig_old = signal(SIGPIPE, sig_ign);
    dprint1("sig_ign=0x%08x\n", sig_ign);
    dprint1("sig_old=0x%08x\n", sig_old);
#endif

    return 0;
}
#endif // __linux__

static uint32 on_enum(void* /*data*/, const ExWidget* const widget, ExCbInfo* const cbinfo)
{
    uint32 ret = Ex_Break;

    if (cbinfo->type == Ex_CbEnumEnter) {
        char depth[256] = "";
        for (const ExWidget* w = widget; w->getParent(); w = w->getParent()) {
            exstrcat(depth, "   .");
        }
        cbinfo->subtype++;
        const char* const visable_mark = (widget->isFlagVisible() ? "*" : " ");
        dprint("enum: %s [%s] %s\n", depth, visable_mark, widget->getName());
        // ret = (widget->isFlagVisible() ? Ex_Continue : Ex_Discard);
        ret = Ex_Continue;
    } else if (cbinfo->type == Ex_CbEnumLeave) {
        // ret = (widget->isFlagVisible() ? Ex_Continue : Ex_Discard);
        ret = Ex_Continue;
    } else {
        // defense code
    }
    return ret;
}

static uint32 cmdline_coverage(void* /*data*/, const int32* argc, const char** argv)
{
    uint32 ret = Ex_Continue;
    return ret;
}

static uint32 cmdline_dprint(void* /*data*/, const int32* argc, const char** argv)
{
    uint32 ret = Ex_Continue;

    if ((0 == exstrcmp(argv[0], "dp")) || (0 == exstrcmp(argv[0], "dprint"))) {
        if (*argc == 1) {
            dprint("dprint_verbose = %d\n", dprint_verbose);
        } else if (0 == exstrcmp(argv[1], "gps")) {
            if (*argc > 2) {
                env.dp_gps = atoi32(argv[2]);
            } else {
                env.dp_gps = 9;
            }
        } else if (0 == exstrcmp(argv[1], "pkt")) {
            if (*argc > 2) {
                env.dp_pkt = atoi32(argv[2]);
            } else {
                env.dp_pkt = 9;
            }
        } else if (0 == isdigit(*argv[1])) {
            dprint_verbose = !dprint_verbose;
        } else {
            dprint_verbose = atoi32(argv[1]);
        }
        ret = Ex_Break;
    }
    return ret;
}

static uint32 cmdline_halt(void* /*data*/, const int32* argc, const char** argv)
{
    uint32 ret = Ex_Continue;

    if (0 == exstrcmp(argv[0], "halt")) {
        #ifdef __linux__
        //ExQuitMainLoop();
        (void)gWatchApp.setHalt();
        #endif // __linux__
        ret = Ex_Break;
    } else if ((0 == exstrcmp(argv[0], "enum")) && (ExApp::mainWnd != nullptr)) {
        ExCbInfo ci(0U);
        (void)ExWindow::enumBackToFront(ExApp::mainWnd, ExApp::mainWnd, ExCallback(&on_enum, (void*)0), &ci);
        dprint("enum: total %d widgets\n", ci.subtype);
        ret = Ex_Break;
    } else if (0 == exstrcmp(argv[0], "scrcap")) {
        #ifdef __linux__
        (void)ExEmitMessage(WM_COMMAND, CMD_SCREEN_CAPTURE);
        #endif // __linux__
        ret = Ex_Break;
    }
#ifdef _DEBUG // segv test
    else if (0 == exstrcmp(argv[0], "segvtest")) {
        uint64* const p = reinterpret_cast<uint64*>(0xdeaddeaddeaddeadUL);
        *p = 1UL;
        ret = Ex_Break;
    }
#endif
    else {
        // defense code
    }
    return ret;
}

#ifdef __linux__
int main(int argc, char* argv[])
{
    int32 result = EXIT_SUCCESS;

    ExWatch::setTlsSpecific(&gWatchApp);
#ifdef DPRINT
    dprint_verbose = 3;
    if (setlocale(LC_ALL, "en_US.UTF-8") == nullptr) {
        dprint("setlocale(LC_ALL, en_US.UTF-8) failed.\n");
    }
    #if 1 // test
    dprint(dprint_verbose, "mbs 한글 %s\n", "mbs 한글");
    dprint(dprint_verbose, "mbs 한글 %ls\n", L"wcs 한글");
    dprint(dprint_verbose, L"wcs 한글 %s\n", "mbs 한글");
    dprint(dprint_verbose, L"wcs 한글 %ls\n", L"wcs 한글");
    #endif
#else
    dprint_verbose = 0;
#endif
    printf("Welcome to callbacks world 콜백 세계로...\n");
    //printf("errno 35 - %s\n", strerror(35)); // test
    poly_test();
    std::function<int32(void*)> func1 = [](void* data)->int32 {
        dprint("func1: data=%p\n", data);
        return 0;
    };
    (void)func1((void*)0x1234);
    //cb_test();
    //app_test();
    //flt_test();

    (void)init_signal();

    (void)initEnv();
    (void)initRes();
    (void)gWatchApp.startup();
    (void)gWatchApp.enter();
    (void)gWatchDev.init(); // start watch thread for gps and etc
    (void)gWatchMap.init();
    (void)gWatchdog.init();
    // app startup begin
    //
    //CApp app;
    cmdline_callback_list.add(cmdline_halt, (void*)0);
    cmdline_callback_list.add(cmdline_dprint, (void*)0);
    cmdline_callback_list.add(cmdline_coverage, (void*)0);
    //(void)app.startup();
    //
    // app startup end

    (void)gLcdOut.init();

    std::allocator<WndMain> wndmain_allocator;
    gWndMain = wndmain_allocator.allocate(1U);
    wndmain_allocator.construct(gWndMain);
    // gWndMain = new WndMain;
    // (void)gWndMain->setFlags(Ex_FreeMemory); // dealloc by extk
    gWndMain->flushFunc = ExFlushFunc(&gLcdOut, &LcdOut::onFlush);
    if (gWndMain->start() != 0) {
        result = EXIT_FAILURE;
        goto on_failure;
    }
#ifdef __linux__
    (void)gWndMain->flush();
#else
    CreateWindowEx(klass, name, style, x, y, ...);
#endif
    exassert2(ExApp::mainWnd == gWndMain, __FILE__ "@" Ex_STRINGIFY(__LINE__));

    //
    //gWndMain->addFilter(&app, &CApp::onFilter);
    //(void)module.init();
    //

    //(void)gWatchApp.guiloop();
    ExMainLoop();

    //
    //(void)module.fini();
    //

    //
    // When the system window manager closed the app, mainWnd was destroyed.
    //
    if (ExApp::mainWnd != nullptr) { // If the halt flag is set inside the app,
        (void)ExApp::mainWnd->destroy(); // then, mainWnd was not destroyed yet.
        // call XDestroyWindow, emit WM_DESTROY, and post WM_QUIT.
        ExApp::collect(); // call delete gWndMain
    }
    exassert2(ExApp::mainWnd == nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    wndmain_allocator.destroy(gWndMain);
    wndmain_allocator.deallocate(gWndMain, 1U);
    gWndMain = nullptr;

    (void)stopTouchRecord();
    (void)gWatchdog.fini();

    // app cleanup begin
    //
    //(void)app.cleanup();
    //
    // app cleanup end

    (void)gLcdOut.fini();
    (void)gWatchMap.fini();
    (void)gWatchDev.fini();
    (void)gWatchApp.cleanup();
    (void)finiRes();
    (void)saveEnv();
    sync();
on_failure:
    dprint("exit %d\n", result);
    return result;
}
#endif // __linux__

#ifdef WIN32
int APIENTRY WinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPSTR     lpCmdLine,
                     _In_ int       nCmdShow)
{
    ExApp::retCode = EXIT_SUCCESS;

    ExWatch::setTlsSpecific(&gWatchApp);
    SetConsoleOutputCP(CP_UTF8); // CP_UTF8 | CP_ACP
#ifdef DPRINT
    dprint_verbose = 3;
    #if 1 // test
    dprint(dprint_verbose, "mbs 한글 %s\n", "mbs 한글");
    dprint(dprint_verbose, "mbs 한글 %s\n", ExCPACP0(L"wcs 한글"));
    dprint(dprint_verbose, L"wcs 한글 %s\n", ExCPACP0("mbs 한글"));
    dprint(dprint_verbose, L"wcs 한글 %s\n", L"wcs 한글");
    #endif
#else
    dprint_verbose = 0;
#endif
    //cb_test();
    //app_test();
    //flt_test();

    ExApp::init(hInstance, hPrevInstance, lpCmdLine, nCmdShow);
    (void)initEnv();
    (void)initRes();
    (void)gWatchApp.startup();
    (void)gWatchApp.enter();
    (void)gWatchDev.init();
    (void)gWatchMap.init();

    // startup
    gWndMain = new WndMain;
    //gWndMain = WndMain::create(...); // test
    (void)gWndMain->setFlags(Ex_FreeMemory); // tbd
    //gWndMain->flushFunc = ExFlushFunc(&gLcdOut, &LcdOut::onFlush);
    if (gWndMain->start() != 0) {
        ExApp::retCode = EXIT_FAILURE;
        goto on_failure;
    }
    (void)gWndMain->flush();
    exassert(ExApp::mainWnd == gWndMain);

    //(void)gWatchApp.guiloop();
    ExMainLoop();

#if 1
    //
    // When the system window manager closed the app, mainWnd was destroyed.
    //
    if (ExApp::mainWnd != nullptr) { // If the halt flag is set inside the app,
        (void)ExApp::mainWnd->destroy(); // then, mainWnd was not destroyed yet.
        // call XDestroyWindow, emit WM_DESTROY, and post WM_QUIT.
        ExApp::collect(); // call delete gWndMain
    }
    exassert2(ExApp::mainWnd == nullptr, __FILE__ "@" Ex_STRINGIFY(__LINE__));
    //delete gWndMain;
    gWndMain = nullptr;
#endif

    // cleanup
    (void)gWatchMap.fini();
    (void)gWatchDev.fini();
    (void)gWatchApp.cleanup();
    (void)finiRes();
    (void)saveEnv();
    ExApp::exit(ExApp::retCode);
on_failure:
    return ExApp::retCode;
}
#endif // WIN32
