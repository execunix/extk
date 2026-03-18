#
# Copyleft 2007 C.H Park <execunix@gmail.com>
#

#############################################################################
# Tool Chain
#SDKTARGETSYSROOT = /opt/fslc-xwayland/3.3/sysroots/cortexa53-crypto-fslc-linux
#SDKFLAGS = -mcpu=cortex-a53 -march=armv8-a+crc+crypto -fstack-protector-strong -Wformat -Wformat-security -Werror=format-security
#CCPREFIX = /opt/fslc-xwayland/3.3/sysroots/x86_64-fslcsdk-linux/usr/bin/aarch64-fslc-linux/aarch64-fslc-linux-
#CXX = $(CCPREFIX)g++ $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
#CC = $(CCPREFIX)gcc $(SDKFLAGS) --sysroot=$(SDKTARGETSYSROOT)
ifneq ($(SDKTARGETSYSROOT),)
CC := $(filter-out -O2 -D_FORTIFY_SOURCE=2,$(CC))
CPP := $(filter-out -O2 -D_FORTIFY_SOURCE=2,$(CPP))
CXX := $(filter-out -O2 -D_FORTIFY_SOURCE=2,$(CXX))
endif

#############################################################################
# Make options

# Should be setup first the toolchain.
# . /opt/fslc-xwayland/3.3/environment-setup-cortexa53-crypto-fslc-linux

# make RELEASE_BUILD=y -j$(nproc)

#RELEASE_BUILD = y
CONF_ARM ?= $(if $(SDKTARGETSYSROOT),y,)
CONF_X11 ?= $(if $(filter y,$(CONF_ARM)),,y)
MACH := $(if $(filter y,$(CONF_ARM)),_arm,_x86)

LIBNAME = ../bin/libgeminit-gn-gdc$(MACH).so
OBJDIR := out/lbex2$(MACH)/_

#DFLAG = -Wall -fshort-wchar
DFLAG = -Wall
ifeq ($(RELEASE_BUILD), y)
DFLAG += -O2 -D_FORTIFY_SOURCE=2 -D_DEBUG -DDPRINT
else
DFLAG += -O0 -g -D_FORTIFY_SOURCE=0 -D_DEBUG -DDPRINT
endif
ifeq ($(CONF_ARM), y)
DFLAG += -DSTDCPP_EABI -DCONF_ARM
else
DFLAG += -DSTDCPP_EABIx -DCONF_X86
endif
ifeq ($(CONF_X11), y)
DFLAG += -DCONF_X11
endif
DFLAG += -DLOG_BACKTRACE=1 -DLIBEX2
DFLAG += -DGTK3_CFLAGS -DLINUX -DWL_EGL_PLATFORM
#DFLAG += -D_ADD_DEF_TEMPLATE_ # Keep the line.

CSRCS += $(sort $(wildcard ../*.c))
CSRCS += $(sort $(wildcard ../pdupdfr-24.03.0/pdupdfr/*.c))
#CSRCS += $(sort $(wildcard template/*.c)) # Keep the line.

CCSRCS += $(sort $(wildcard ../pdupdfr-24.03.0/fofi/*.cc))
CCSRCS += $(sort $(wildcard ../pdupdfr-24.03.0/goo/*.cc))
CCSRCS += $(sort $(wildcard ../pdupdfr-24.03.0/pdupdfr/*.cc))
CCSRCS += $(sort $(wildcard ../pdupdfr-24.03.0/spladt/*.cc))

CXXSRCS += $(sort $(wildcard ../*.cpp))
#CXXSRCS += $(sort $(wildcard template/*.cpp)) # Keep the line.

COBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CSRCS))))
CCOBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CCSRCS))))
CXXOBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CXXSRCS))))

INCS = -I..
ifeq ($(CONF_X11), y)
INCS += -I$(SDKTARGETSYSROOT)/usr/include/X11
endif
INCS += -I$(SDKTARGETSYSROOT)/usr/include/gtk-3.0
INCS += -I$(SDKTARGETSYSROOT)/usr/include/gio-unix-2.0
INCS += -I$(SDKTARGETSYSROOT)/usr/include/libdrm
INCS += -I$(SDKTARGETSYSROOT)/usr/include/pango-1.0
INCS += -I$(SDKTARGETSYSROOT)/usr/include/harfbuzz
INCS += -I$(SDKTARGETSYSROOT)/usr/include/fribidi
INCS += -I$(SDKTARGETSYSROOT)/usr/include/atk-1.0
INCS += -I$(SDKTARGETSYSROOT)/usr/include/uuid
INCS += -I$(SDKTARGETSYSROOT)/usr/include/libpng16
INCS += -I$(SDKTARGETSYSROOT)/usr/include/gdk-pixbuf-2.0
INCS += -I$(SDKTARGETSYSROOT)/usr/include/libmount
INCS += -I$(SDKTARGETSYSROOT)/usr/include/blkid
INCS += -I$(SDKTARGETSYSROOT)/usr/include/glib-2.0
ifeq ($(CONF_ARM), y)
INCS += -I$(SDKTARGETSYSROOT)/usr/lib/glib-2.0/include
else
INCS += -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
endif
INCS += -I$(SDKTARGETSYSROOT)/usr/include/cairo
INCS += -I$(SDKTARGETSYSROOT)/usr/include/pixman-1
INCS += -I$(SDKTARGETSYSROOT)/usr/include/freetype2
INCS += -I$(SDKTARGETSYSROOT)/usr/src/debug/libpng/1.6.37-r0/libpng-1.6.37
INCS += -I../pdupdfr-24.03.0
INCS += -I../pdupdfr-24.03.0/fofi -I../pdupdfr-24.03.0/goo
INCS += -I../pdupdfr-24.03.0/pdupdfr -I../pdupdfr-24.03.0/spladt
#INCS += -Itemplate/include # Keep the line.

LIBS = -L..
LIBS += -lpthread -lm
LIBS += -lz -lpng16 -ljpeg -lcairo -lpixman-1 -lfreetype -lfontconfig
LIBS += -lcairo-gobject -lgio-2.0 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0
LIBS += -lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0
#LIBS += -ltemplate # Keep the line.

#VPATH = . # deprecated
STRIP ?= $(CCPREFIX)strip

CFLAGS = $(DFLAG) $(INCS) -fPIC
SDFLAGS = $(LIBS) -shared
CXXFLAGS = $(CFLAGS) -std=c++17
#CXXFLAGS = $(CFLAGS) -std=c++2a

#############################################################################
# Targets start here

all: $(LIBNAME)

$(OBJDIR)/%.o: %.c
$(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
	@mkdir -p $(dir $@)
	$(CC) $(DEPFLAGS) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.cc
$(OBJDIR)/%.o: %.cc $(OBJDIR)/%.d
	@mkdir -p $(dir $@)
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.cpp
$(OBJDIR)/%.o: %.cpp $(OBJDIR)/%.d
	@mkdir -p $(dir $@)
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) -c $< -o $@

$(LIBNAME): $(COBJS) $(CCOBJS) $(CXXOBJS)
	$(CXX) $(COBJS) $(CCOBJS) $(CXXOBJS) $(SDFLAGS) -o $(LIBNAME)

strip: all
	$(STRIP) -d $(LIBNAME)

clean:
	rm -fr out/lbex2$(MACH)
	rm -f *.o *.err $(LIBNAME)

release: all strip

install: all strip
	-cp -v $(LIBNAME) ../../../../pdu-deploy/pkgfiles

DEPFILES := $(CSRCS:%.c=$(OBJDIR)/%.d)
DEPFILES += $(CCSRCS:%.cc=$(OBJDIR)/%.d)
DEPFILES += $(CXXSRCS:%.cpp=$(OBJDIR)/%.d)
DEPFLAGS = -MT $@ -MMD -MP -MF $(OBJDIR)/$*.d

$(DEPFILES):
include $(wildcard $(DEPFILES))
