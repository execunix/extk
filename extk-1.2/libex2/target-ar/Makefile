#
# Copyleft 2007 C.H Park <execunix@gmail.com>
#

#############################################################################
# Tool Chain
TOPDIR := ../..
include $(TOPDIR)/mkcore/config.mk

# Should be setup first the toolchain.
# . /opt/fsl-imx-xwayland/5.15-kirkstone/environment-setup-cortexa9t2hf-neon-poky-linux-gnueabi
# . /opt/fslc-xwayland/3.3/environment-setup-cortexa53-crypto-fslc-linux

#############################################################################
# Make options

# make RELEASE_BUILD=y -j$(nproc)
# make CONF_X11=y -j$(nproc)

OBJDIR := $(OUTDIR)/$(TGTDIR)$(CONF)$(MACH)/_
TARGET := $(OUTDIR)/libex2$(CONF)$(MACH).a

DFLAG += -Wall
#DFLAG += -fshort-wchar
ifeq ($(RELEASE_BUILD), y)
DFLAG += -O2 -D_FORTIFY_SOURCE=2 -D_DEBUG -DDPRINT
else
DFLAG += -O0 -g -D_FORTIFY_SOURCE=0 -D_DEBUG -DDPRINT
endif
DFLAG += $(if $(filter _a64 _arm,$(MACH)),-DSTDCPP_EABI,)
ifeq ($(CONF_X11), y)
DFLAG += -DCONF_X11
endif
DFLAG += -DLIBEX2
DFLAG += -DGTK3_CFLAGS -DLINUX -DWL_EGL_PLATFORM
#DFLAG += -D_ADD_DEF_TEMPLATE_ # Keep the line.

CSRCS += $(sort $(wildcard ../*.c))
CCSRCS += $(sort $(wildcard ../*.cc))
CXXSRCS += $(sort $(wildcard ../*.cpp))
#CXXSRCS += $(sort $(wildcard template/*.cpp)) # Keep the line.

COBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CSRCS))))
CXXOBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CCSRCS))))
CXXOBJS += $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CXXSRCS))))

INCS += -I..
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
ifeq ($(if $(filter _a64 _arm,$(MACH)),y,), y)
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

LIBS += -L..
LIBS += -lpthread -lm
LIBS += -lz -lpng16 -ljpeg -lcairo -lpixman-1 -lfreetype -lfontconfig
LIBS += -lcairo-gobject -lgio-2.0 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0
LIBS += -lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0
#LIBS += -ltemplate # Keep the line.

#VPATH = . # deprecated
STRIP ?= $(CCPREFIX)strip

CFLAGS = $(DFLAG) $(INCS)
CXXFLAGS = $(CFLAGS) -std=c++17
#CXXFLAGS = $(CFLAGS) -std=c++2a

#############################################################################
# Targets start here

all: $(TARGET)

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

$(TARGET): $(COBJS) $(CXXOBJS)
	$(AR) rcs $@ $?

strip: all
	$(STRIP) -d $(TARGET)

clean:
	rm -fr $(dir $(OBJDIR))
	rm -f *.o *.err $(TARGET)

release: all strip

install: all strip
	@mkdir -p $(PKGDIR)
	-cp -v $(TARGET) $(PKGDIR)/

include $(TOPDIR)/mkcore/depend.mk
