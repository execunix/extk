// camee.cpp : Defines the entry point for the application.
//

#include "framework.h"
#include <objbase.h>
#include "camee.h"
#include "wndmain.h"
#include "ffctx.h"

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name

// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_      HINSTANCE hInstance,
                      _In_opt_  HINSTANCE hPrevInstance,
                      _In_      LPWSTR    lpCmdLine,
                      _In_      int       nCmdShow)
{
    int ret = EXIT_FAILURE;

    // Use HeapSetInformation to specify that the process should
    // terminate if the heap manager detects an error in any heap used
    // by the process.
    // The return value is ignored, because we want to continue running in the
    // unlikely event that HeapSetInformation fails.
    HeapSetInformation(NULL, HeapEnableTerminationOnCorruption, NULL, 0);

    if (!SUCCEEDED(CoInitialize(NULL))) {
        MessageBox(NULL,
                   L"CoInitialize fail.",
                   L"Notice", MB_OK);
        return ret;
    }

    env.sm_w = GetSystemMetrics(SM_CXSCREEN);
    env.sm_h = GetSystemMetrics(SM_CYSCREEN);
    dprintf(L"%s() width=%d height=%d\n", __funcw__, env.sm_w, env.sm_h);
    if (env.sm_w < 1920 ||
        env.sm_h < 1080) {
        MessageBox(NULL,
                   L"Set the display resolution to Full-HD(1920x1080) or higher.",
                   L"Notice", MB_OK);
        goto fail;
    }

    // init lib
    ExInitProcess();

    init_ffctx();

    // init args
    ExApp::hInstance = hInstance;
    ExApp::hPrevInstance = hPrevInstance;
    ExApp::lpCmdLine = lpCmdLine;
    ExApp::nCmdShow = nCmdShow;

    // init vars
    exTickCount = GetTickCount();
    memset(&ExApp::event, 0, sizeof(ExEvent));

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_CAMEE, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    WndMain* wndMain = new WndMain;
    wndMain->setFlags(Ex_FreeMemory);
    if (wndMain->InitInstance() != 0)
        goto fail;

    assert(ExApp::mainWnd == wndMain);

    // Use the virtual-key messages directly,
    // so LoadAccelerators are unnecessary.

    // Main message loop:
    ExInitTimer();
    ExMainLoop();
    ExFiniTimer();

    // cleanup
    fini_ffctx();

    if (ExApp::mainWnd != NULL) { // When the halt flag is set inside the app.
        ExApp::mainWnd->destroy();
        ExApp::collect();
    }
    ExFiniProcess();
    ret = EXIT_SUCCESS;

fail:
    CoUninitialize();
    return ret;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndMain::WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_CAMEE));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = 0; // (HBRUSH)(COLOR_WINDOW + 1);
    wcex.lpszMenuName   = 0; // MAKEINTRESOURCEW(IDC_CAMEE);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
int WndMain::InitInstance()
{
    //this->init(L"WndMain", 1880, 1020);
    this->init(L"WndMain", 1280, 720);
    ExApp::mainWnd = this;

    if (build() != 0)
        return -1;

    this->dwExStyle = 0;
    //this->dwStyle = WS_THICKFRAME | WS_POPUP;
    this->dwStyle = WS_OVERLAPPEDWINDOW;

    HWND hwnd = NULL;
    HWND hwndParent = parent ? parent->getWindow()->getHwnd() : NULL;
    hwnd = CreateWindowEx(dwExStyle, szWindowClass, szTitle, dwStyle,
                          20/*CW_USEDEFAULT*/, 10/*CW_USEDEFAULT*/, this->area.w, this->area.h,
                          hwndParent, NULL, ExApp::hInstance, (PVOID)this);
    assert(this->hwnd && this->hwnd == hwnd);
    if (hwnd == NULL)
        return -1;

    SetWindowText(hwnd, wgtTitle.title);

    ShowWindow(hwnd, ExApp::nCmdShow);
    // send WM_PAINT if the window's update region is not empty
    UpdateWindow(hwnd);

#if 0
    //test_d3d11(hwnd);
    if (disp_init(hwnd)) {
        MessageBox(NULL,
                   L"DirectDraw initialization fail.",
                   L"Notice", MB_OK);
        return -1;
    }
#endif

    return 0;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK // static
WndMain::WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
#if 1
    switch (message) {
        case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId) {
                case IDM_ABOUT:
                    DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                    return 0;
                case IDM_EXIT:
                    DestroyWindow(hWnd);
                    return 0;
                default:
                    return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    }
#endif
    return ExWindow::sysWndProc(hWnd, message, wParam, lParam);
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message) {
        case WM_INITDIALOG:
            return (INT_PTR)TRUE;

        case WM_COMMAND:
            if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL) {
                EndDialog(hDlg, LOWORD(wParam));
                return (INT_PTR)TRUE;
            }
            break;
    }
    return (INT_PTR)FALSE;
}
