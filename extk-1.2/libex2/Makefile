#
# Copyleft 2007 C.H Park <execunix@gmail.com>
#

#############################################################################
# Tool Chain

# Should be setup first the toolchain.
# . /opt/fsl-imx-xwayland/5.15-kirkstone/environment-setup-cortexa9t2hf-neon-poky-linux-gnueabi
# . /opt/fslc-xwayland/3.3/environment-setup-cortexa53-crypto-fslc-linux

#############################################################################
# Make options

# make RELEASE_BUILD=y -j$(nproc)
# make CONF_X11=y -j$(nproc)

SUBDIRS := target-ar target-so

#############################################################################
# Targets start here

all clean release install: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

# target-so: target-ar

.PHONY: all clean release install $(SUBDIRS)
