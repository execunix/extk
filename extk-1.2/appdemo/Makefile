#
# Copyleft 2007 C.H Park <execunix@gmail.com>
#

#############################################################################
# Tool Chain
TOPDIR := ..
include $(TOPDIR)/mkcore/config.mk

# Should be setup first the toolchain.
# . /opt/fsl-imx-xwayland/5.15-kirkstone/environment-setup-cortexa9t2hf-neon-poky-linux-gnueabi
# . /opt/fslc-xwayland/3.3/environment-setup-cortexa53-crypto-fslc-linux

#############################################################################
# Make options

# make RELEASE_BUILD=y -j$(nproc)
# make CONF_X11=y -j$(nproc)
LINK_LIBEX2_AR = y

OBJDIR := $(OUTDIR)/$(TGTDIR)$(CONF)$(MACH)
TARGET := $(OBJDIR).bin

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
DFLAG += -DEX2DEMO
DFLAG += -DLOG_BACKTRACE=1
#DFLAG += -D_ADD_DEF_TEMPLATE_ # Keep the line.

CSRCS += $(sort $(wildcard src/*.c))
CCSRCS += $(sort $(wildcard src/*.cc))
CXXSRCS += $(sort $(wildcard src/*.cpp))
CXXSRCS += $(sort $(wildcard src/view/*.cpp))
#CXXSRCS += $(sort $(wildcard template/*.cpp)) # Keep the line.

COBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CSRCS))))
CXXOBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CCSRCS))))
CXXOBJS += $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CXXSRCS))))

INCS += -I../libex2 -Isrc
ifeq ($(CONF_X11), y)
INCS += -I$(SDKTARGETSYSROOT)/usr/include/X11
endif
#INCS += -Itemplate/include # Keep the line.

LIBS += -L../out
ifeq ($(CONF_X11), y)
LIBS += -lX11
endif
LIBS += -lpthread -lm
ifeq ($(LINK_LIBEX2_AR), y)
LIBS += -lz -lpng16 -ljpeg -lcairo -lpixman-1 -lfreetype -lfontconfig
LIBS += -lcairo-gobject -lgio-2.0 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0
LIBS += -lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0
ALIBS += $(OUTDIR)/libex2$(CONF)$(MACH).a
else
LIBS += -lex2$(CONF)$(MACH)
endif
#LIBS += -ltemplate # Keep the line.

#VPATH = . # deprecated
STRIP ?= $(CCPREFIX)strip

CFLAGS = $(DFLAG) $(INCS)
LDFLAGS = $(LIBS) -rdynamic
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

$(TARGET): $(COBJS) $(CXXOBJS) $(ALIBS)
	$(CXX) $^ $(LDFLAGS) -o $@

strip: all
	$(STRIP) -d $(TARGET)

clean:
	rm -fr $(OBJDIR)
	rm -f *.o *.err $(TARGET)

release: all strip

install: all strip
	@mkdir -p $(PKGDIR)
	-cp -v $(TARGET) $(PKGDIR)/

include $(TOPDIR)/mkcore/depend.mk
