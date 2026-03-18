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

LINK_LIBEX2_AR = y
#RELEASE_BUILD = y
CONF_ARM ?= $(if $(SDKTARGETSYSROOT),y,)
CONF_X11 ?= $(if $(filter y,$(CONF_ARM)),,y)
MACH := $(if $(filter y,$(CONF_ARM)),_arm,_x86)

APPNAME = ex2demo$(MACH).bin
OBJDIR := out/ex2demo$(MACH)

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
DFLAG += -DLOG_BACKTRACE=1 -DEX2DEMO
#DFLAG += -D_ADD_DEF_TEMPLATE_ # Keep the line.

CSRCS = $(sort $(wildcard src/*.c))
#CSRCS += $(sort $(wildcard template/*.c)) # Keep the line.

CXXSRCS = $(sort $(wildcard src/*.cpp))
CXXSRCS += $(sort $(wildcard src/view/*.cpp))
#CXXSRCS += $(sort $(wildcard template/*.cpp)) # Keep the line.

COBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CSRCS))))
CXXOBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(CXXSRCS))))

INCS += -I../libex2 -Isrc
ifeq ($(CONF_X11), y)
INCS += -I$(SDKTARGETSYSROOT)/usr/include/X11
endif
#INCS += -Itemplate/include # Keep the line.

LIBS += -lpthread -lm
ifeq ($(CONF_X11), y)
LIBS += -lX11
endif
ifeq ($(LINK_LIBEX2_AR), y)
LIBS += -lz -lpng16 -ljpeg -lcairo -lpixman-1 -lfreetype -lfontconfig
LIBS += -lcairo-gobject -lgio-2.0 -lgdk_pixbuf-2.0 -lgobject-2.0 -lglib-2.0
LIBS += -lgtk-3 -lgdk-3 -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -latk-1.0
ALIBS += ../libex2/bin/libgeminit-gn-gdc$(MACH).a
else
LIBS += -lgeminit-gn-gdc$(MACH)
endif
#LIBS += -ltemplate # Keep the line.

#VPATH = . # deprecated
STRIP ?= $(CCPREFIX)strip

CFLAGS = $(DFLAG) $(INCS)
SDFLAGS = $(ALIBS) $(LIBS)
LDFLAGS = $(SDFLAGS) -rdynamic
CXXFLAGS = $(CFLAGS) -std=c++17
#CXXFLAGS = $(CFLAGS) -std=c++2a

#############################################################################
# Targets start here

all: $(APPNAME)

$(OBJDIR)/%.o: %.c
$(OBJDIR)/%.o: %.c $(OBJDIR)/%.d
	@mkdir -p $(dir $@)
	$(CC) $(DEPFLAGS) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.cpp
$(OBJDIR)/%.o: %.cpp $(OBJDIR)/%.d
	@mkdir -p $(dir $@)
	$(CXX) $(DEPFLAGS) $(CXXFLAGS) -c $< -o $@

$(APPNAME): $(COBJS) $(CXXOBJS) $(ALIBS)
	$(CXX) $(COBJS) $(CXXOBJS) $(LDFLAGS) -o $(APPNAME)

strip: all
	$(STRIP) -d $(APPNAME)

clean:
	rm -fr $(OBJDIR)
	rm -f *.o *.err $(APPNAME)

release: all strip

install: all strip
	-cp -v $(APPNAME) ../../pdu-deploy/pkgfiles

DEPFILES := $(CSRCS:%.c=$(OBJDIR)/%.d)
DEPFILES += $(CXXSRCS:%.cpp=$(OBJDIR)/%.d)
DEPFLAGS = -MT $@ -MMD -MP -MF $(OBJDIR)/$*.d

$(DEPFILES):
include $(wildcard $(DEPFILES))
