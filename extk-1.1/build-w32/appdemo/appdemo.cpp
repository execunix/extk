// appdemo.cpp : Defines the entry point for the application.
//

#include "framework.h"
#include "appdemo.h"
#include "wndmain.h"
#include <functional>

class TestClass {
public:
    int STDCALL onCb1(ExObject* object, ExCbInfo* cbinfo) {
        dprintf(L"onCb1\n");
        return 0;
    }
    virtual int STDCALL onCb2(ExObject* object, ExCbInfo* cbinfo) {
        dprintf(L"onCb2\n");
        return 0;
    }
    static int STDCALL onCb3(void* data, ExObject* object, ExCbInfo* cbinfo) {
        dprintf(L"onCb3\n");
        return 0;
    }
    static int STDCALL onCb4(TestClass* data, ExObject* object, ExCbInfo* cbinfo) {
        dprintf(L"onCb4\n");
        return 0;
    }
};

class TestClass2 : public TestClass {
public:
    int STDCALL onCb5(ExObject* object, TestClass* cbinfo) {
        dprintf(L"onCb5\n");
        return 0;
    }
};

static int STDCALL
func(void* data, ExWidget* widget, ExCbInfo* cbinfo) {
    dprintf(L"func: data=%d type=%d\n", (int)data, cbinfo ? cbinfo->type : -1);
    return 0;
}

#if 0
void functional_test() {
    std::function<int(int, int)> fn1 = [](int a, int b) { return a + b; };
    std::function<int(void*, ExWidget*, ExCbInfo*)> fn2 = func;
    std::function<int STDCALL(void*, ExWidget*, ExCbInfo*)> fn3 = func;
    //ExCallback cb2(fn2, NULL);
    //ExCallback cb3(fn3, NULL);
    ExCallback::Func fn4 = [](void* data, void* widget, void* cbinfo)->int {
        return 0; };
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
    int r;

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
    dprintf(L"r = %d\n", r);

    ExCallback cb5(&test_class2, &TestClass2::onCb5);
    r = cb5(NULL, &ExCbInfo(0));
    dprintf(L"r = %d\n", r);

    ExCallback cb4(&TestClass::onCb3, (void*)&test_class2);
    r = cb4(NULL, NULL);
    dprintf(L"r = %d\n", r);

    ExCallback cb3(&TestClass::onCb4, &test_class);
    r = cb3(NULL, NULL);
    dprintf(L"r = %d\n", r);

    ExCallback cb2(&test_class, &TestClass::onCb2);
    r = cb2(NULL, NULL);
    dprintf(L"r = %d\n", r);

    ExCallback cb1(&test_class, &TestClass::onCb1);
    r = cb1(NULL, NULL);
    dprintf(L"r = %d\n", r);

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
    widget.addCallback(&func, (void*)123, 1);
    widget.invokeCallback(1);
}

#ifdef DEBUG
void exwindow_apitest() {
    ExWindow* wnd0 = ExWindow::create(L"TopWindow", 800, 480);
    ExWidget* wgt1 = ExWidget::create(wnd0, L"Child1", &ExRect(100, 100, 100, 40));
    ExWidget* wgt2 = ExWidget::create(wnd0, L"Child2", &ExRect(200, 200, 100, 40));
    wnd0->realize();
    wnd0->destroy();

    ExWindow* top = new ExWindow;
    ExWidget* ch1 = new ExWidget;
    ExWidget* ch2 = new ExWidget;
    top->init(L"Top", 800, 480);
    ch1->init(top, L"Ch1", &ExRect(100, 100, 100, 40));
    ch2->init(top, L"Ch2", &ExRect(200, 200, 100, 40));
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
#define MAGIC_NUMBER_FIXED ((1LL << (52 - 8/*CAIRO_FIXED_FRAC_BITS*/)) * 1.5)

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
        int32_t i[2];
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
        int32_t i[2];
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
    ulong tick1, tick2;

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = 0;
    }
    tick2 = GetTickCount();
    dprint1(L"val=0 loop test %d\n", tick2 - tick1);

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_from_float(i * 1.f);
    }
    tick2 = GetTickCount();
    dprint1(L"_fixed_from_float %d\n", tick2 - tick1);

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_from_double(i * 1.);
    }
    tick2 = GetTickCount();
    dprint1(L"_fixed_from_double %d\n", tick2 - tick1);

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_from_doublem(i * 1.);
    }
    tick2 = GetTickCount();
    dprint1(L"_fixed_from_doublem %d\n", tick2 - tick1);

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_16_16_from_float(i * 1.f);
    }
    tick2 = GetTickCount();
    dprint1(L"_fixed_16_16_from_float %d\n", tick2 - tick1);

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_16_16_from_double(i * 1.);
    }
    tick2 = GetTickCount();
    dprint1(L"_fixed_16_16_from_double %d\n", tick2 - tick1);

    tick1 = GetTickCount();
    for (volatile int i = 0; i < TESTCNT; i++) {
        val = _fixed_16_16_from_doublem(i * 1.);
    }
    tick2 = GetTickCount();
    dprint1(L"_fixed_16_16_from_doublem %d\n", tick2 - tick1);

    return 0;
}

int app_test() {
#if 0
    //char aaa1[sizeof(long) == 8 ? 1 : -1];
    //char aaa2[sizeof(ExCallback) == 8 ? 1 : -1];
    //char aaa2[sizeof(ExCallback) == 16 ? 1 : -1];
#endif
    dprint1(L"sizeof(ExCbInfo)=%d\n", sizeof(ExCbInfo));
    dprint1(L"sizeof(ExCallback)=%d\n", sizeof(ExCallback));
    //dprint1(L"sizeof(ExWidget::Callback)=%d\n", sizeof(ExWidget::Callback)); // 16
    //dprint1(L"sizeof(ExWindow::Callback)=%d\n", sizeof(ExWindow::Callback)); // 12
    dprint1(L"sizeof(ExObject)=%d\n", sizeof(ExObject));
    dprint1(L"sizeof(ExWidget)=%d\n", sizeof(ExWidget));
    dprint1(L"sizeof(ExWindow)=%d\n", sizeof(ExWindow));
    dprint1(L"sizeof(ExTimer)=%d\n", sizeof(ExTimer));
    dprint1(L"sizeof(ExApp)=%d\n", sizeof(ExApp));

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

    top.setName(L"top");
    w1.setName(L"w1");
    w2.setName(L"w2");
    w3.setName(L"w3");
    w11.setName(L"w11");
    w12.setName(L"w12");
    w21.setName(L"w21");
    w22.setName(L"w22");
    w221.setName(L"w221");
    w23.setName(L"w23");
    w231.setName(L"w231");
    w2311.setName(L"w2311");
    w23111.setName(L"w23111");
    detached.setName(L"detached");

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

    dprint1(L"\n*** top.dumpBackToFront()\n");
    top.dumpBackToFront();
    dprint1(L"\n*** w221.dumpBackToFront()\n");
    w221.dumpBackToFront();
    dprint1(L"\n*** w3.dumpBackToFront()\n");
    w3.dumpBackToFront();

    dprint1(L"\n*** top.dumpFrontToBack()\n");
    top.dumpFrontToBack();
    dprint1(L"\n*** w2311.dumpFrontToBack()\n");
    w2311.dumpFrontToBack();
    dprint1(L"\n*** w2.dumpFrontToBack()\n");
    w21.dumpFrontToBack();

    dprint1(L"top last = %s\n", top.last()->getName());
    dprint1(L"w1 last = %s\n", w1.last()->getName());
    dprint1(L"w2 last = %s\n", w2.last()->getName());
    dprint1(L"w3 last = %s\n", w3.last()->getName());

    top.giveFocus(&w1);
    top.giveFocus(&w2311);

    dprint1(L"detached.dumpBackToFront()\n");
    detached.dumpBackToFront();
    dprint1(L"detached.dumpFrontToBack()\n");
    detached.dumpFrontToBack();
    dprint1(L"detached last = %s\n\n", detached.last()->getName());

    w2.detachParent();
    dprint1(L"\n*** w2.detachParent()\n");
    top.dumpBackToFront();

    w1.attachHead(&w2);
    dprint1(L"\n*** w1.attachHead(&w2)\n");
    top.dumpBackToFront();

    w2.detachAll();
    dprint1(L"\n*** w2.detachAll()\n");
    top.dumpBackToFront();

    top.giveFocus(&w1);
    top.giveFocus(&w2311);
    top.giveFocus(NULL);

    top.addCallback([](void* data, ExWidget* widget, ExCbInfo* cbinfo)->int {
        dprint1(L"\n*** anonymous func data=%p name=%s type=%d\n",
                data, widget->getName(), cbinfo->type);
        return 0; }, &top, 1);
    top.invokeCallback(1);
    top.invokeCallback(2);

    return 0;
}

static int STDCALL flushMainWnd(void* data, ExWatch* watch, ExCbInfo* cbinfo) {
    if (cbinfo->type != ExWatch::HookTimer)
        return -1;
    if (ExApp::mainWnd != NULL) {
        ExApp::mainWnd->flush();
    }
    return 0;
}

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                      _In_opt_ HINSTANCE hPrevInstance,
                      _In_ LPWSTR    lpCmdLine,
                      _In_ int       nCmdShow)
{
    //cb_test();
    //app_test();
    //flt_test();

    ExApp::init(hInstance, hPrevInstance, lpCmdLine, nCmdShow);

    exWatchMain->enter();
    exWatchMain->hookTimer = ExCallback(&flushMainWnd, (void*)NULL);
    exWatchMain->init();

    // startup
    // tbd - parse args
    //WndMain wndMain; // test
    //WndMain* wndMain = WndMain::create(...); // test
    WndMain* wndMain = new WndMain;
    wndMain->setFlags(Ex_FreeMemory); // tbd
    if (wndMain->start() != 0)
        return EXIT_FAILURE;

    assert(ExApp::mainWnd == wndMain);
    ExMainLoop();
    exWatchMain->fini();
    exWatchMain->leave();

    // cleanup
    ExApp::exit(1);
    return ExApp::retCode;
}
