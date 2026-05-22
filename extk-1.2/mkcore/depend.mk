#
# Copyleft 2007 C.H Park <execunix@gmail.com>
#

ifneq ($(MAKECMDGOALS),clean)

DEPFILES := $(CSRCS:%.c=$(OBJDIR)/%.d)
DEPFILES += $(CCSRCS:%.cc=$(OBJDIR)/%.d)
DEPFILES += $(CXXSRCS:%.cpp=$(OBJDIR)/%.d)
DEPFLAGS = -MT $@ -MMD -MP -MF $(OBJDIR)/$*.d

$(DEPFILES):
-include $(wildcard $(DEPFILES))

endif

# $(info )
$(info OBJDIR = $(OBJDIR))
# $(info DFLAG = $(DFLAG))
# $(info ARCH = $(ARCH))
$(info )
