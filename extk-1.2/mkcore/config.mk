#
# Copyleft 2007 C.H Park <execunix@gmail.com>
#

# Overridden by command line, e.g., make CONF_SDK=MX8 -j$(nproc)

#############################################################################
# Yocto SDK Configuration

ifeq ($(CONF_SDK), MX6)
SDKTARGETSYSROOT = /opt/fsl-imx-xwayland/5.15-kirkstone/sysroots/cortexa9t2hf-neon-poky-linux-gnueabi
SDKFLAGS = -mthumb -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a9 -fstack-protector-strong -Wformat -Wformat-security -Werror=format-security
CCPREFIX = /opt/fsl-imx-xwayland/5.15-kirkstone/sysroots/x86_64-pokysdk-linux/usr/bin/arm-poky-linux-gnueabi/arm-poky-linux-gnueabi-
CXX = $(CCPREFIX)g++ $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
CC = $(CCPREFIX)gcc $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
ARCH = arm
endif

ifeq ($(CONF_SDK), MX8)
SDKTARGETSYSROOT = /opt/fslc-xwayland/3.3/sysroots/cortexa53-crypto-fslc-linux
SDKFLAGS = -mcpu=cortex-a53 -march=armv8-a+crc+crypto -fstack-protector-strong -Wformat -Wformat-security -Werror=format-security
CCPREFIX = /opt/fslc-xwayland/3.3/sysroots/x86_64-fslcsdk-linux/usr/bin/aarch64-fslc-linux/aarch64-fslc-linux-
CXX = $(CCPREFIX)g++ $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
CC = $(CCPREFIX)gcc $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
ARCH = aarch64
endif

ifeq ($(CONF_SDK), ZYNQ)
SDKTARGETSYSROOT = /opt/petalinux/2019.2/sysroots/cortexa9t2hf-neon-xilinx-linux-gnueabi
SDKFLAGS = -march=armv7-a -mthumb -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a9
CCPREFIX = /opt/petalinux/2019.2/sysroots/x86_64-petalinux-linux/usr/bin/arm-xilinx-linux-gnueabi/arm-xilinx-linux-gnueabi-
CXX = $(CCPREFIX)g++ $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
CC = $(CCPREFIX)gcc $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
ARCH = arm
endif

ifeq ($(CONF_SDK), RPI5)
SDKTARGETSYSROOT = /mnt/rpi5
SDKFLAGS = -mcpu=cortex-a76+crc+crypto -Wformat -Wformat-security -Werror=format-security
CCPREFIX = aarch64-linux-gnu-
CXX = $(CCPREFIX)g++ $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
CC = $(CCPREFIX)gcc $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
ARCH = aarch64
endif

ifneq ($(SDKTARGETSYSROOT),)
CXX := $(filter-out -O2 -D_FORTIFY_SOURCE=2,$(CXX))
CPP := $(filter-out -O2 -D_FORTIFY_SOURCE=2,$(CPP))
CC := $(filter-out -O2 -D_FORTIFY_SOURCE=2,$(CC))
endif

# $(info CC = $(CC))

ARCH ?= $(shell uname -m)
CONF := $(if $(filter y,$(CONF_X11)),_x11,_fb0)
ifeq ($(if $(filter aarch64 arm64,$(ARCH)),y,), y)
MACH := _a64
else ifeq ($(if $(filter armv7l arm,$(ARCH)),y,), y)
MACH := _arm
else ifeq ($(ARCH), x86_64)
MACH := _x64
else ifeq ($(ARCH), i686)
MACH := _x86
else
MACH := _$(ARCH)
endif

SRCDIR := $(shell pwd)
OUTDIR := $(TOPDIR)/out
TGTDIR := $(shell realpath --relative-to=$(TOPDIR) $(SRCDIR))
OBJDIR := $(OUTDIR)/$(TGTDIR)$(CONF)$(MACH)
PKGDIR := $(TOPDIR)/pkg/bin$(CONF)$(MACH)

# $(info TGTDIR = $(TGTDIR))
