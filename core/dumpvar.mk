# ---------------------------------------------------------------
CL_GRN=$(shell tput setaf 2)
CL_RST=$(shell tput sgr0)

# the setpath shell function in envsetup.sh uses this to figure out
# what to add to the path given the config we have chosen.
ifeq ($(CALLED_FROM_SETUP),true)

ifneq ($(filter /%,$(HOST_OUT_EXECUTABLES)),)
ABP:=$(HOST_OUT_EXECUTABLES)
else
ABP:=$(PWD)/$(HOST_OUT_EXECUTABLES)
endif

ANDROID_BUILD_PATHS := $(ABP)
ANDROID_PREBUILTS := prebuilt/$(HOST_PREBUILT_TAG)
ANDROID_GCC_PREBUILTS := prebuilts/gcc/$(HOST_PREBUILT_TAG)

# The "dumpvar" stuff lets you say something like
#
#     CALLED_FROM_SETUP=true \
#       make -f config/envsetup.make dumpvar-TARGET_OUT
# or
#     CALLED_FROM_SETUP=true \
#       make -f config/envsetup.make dumpvar-abs-HOST_OUT_EXECUTABLES
#
# The plain (non-abs) version just dumps the value of the named variable.
# The "abs" version will treat the variable as a path, and dumps an
# absolute path to it.
#
dumpvar_goals := \
	$(strip $(patsubst dumpvar-%,%,$(filter dumpvar-%,$(MAKECMDGOALS))))
ifdef dumpvar_goals

  ifneq ($(words $(dumpvar_goals)),1)
    $(error Only one "dumpvar-" goal allowed. Saw "$(MAKECMDGOALS)")
  endif

  # If the goal is of the form "dumpvar-abs-VARNAME", then
  # treat VARNAME as a path and return the absolute path to it.
  absolute_dumpvar := $(strip $(filter abs-%,$(dumpvar_goals)))
  ifdef absolute_dumpvar
    dumpvar_goals := $(patsubst abs-%,%,$(dumpvar_goals))
    ifneq ($(filter /%,$($(dumpvar_goals))),)
      DUMPVAR_VALUE := $($(dumpvar_goals))
    else
      DUMPVAR_VALUE := $(PWD)/$($(dumpvar_goals))
    endif
    dumpvar_target := dumpvar-abs-$(dumpvar_goals)
  else
    DUMPVAR_VALUE := $($(dumpvar_goals))
    dumpvar_target := dumpvar-$(dumpvar_goals)
  endif

.PHONY: $(dumpvar_target)
$(dumpvar_target):
	@echo $(DUMPVAR_VALUE)

endif # dumpvar_goals

ifneq ($(dumpvar_goals),report_config)
PRINT_BUILD_CONFIG:=
endif

endif # CALLED_FROM_SETUP


ifneq ($(PRINT_BUILD_CONFIG),)
HOST_OS_EXTRA:=$(shell python -c "import platform; print(platform.platform())")
$(info $(CL_GRN)====================Dysfunctional Roms=====================)
$(info == $(CL_RST)@@@@@@@  @@@@@@@   @@@@@@  @@@  @@@ @@@@@@@@ @@@  @@@ $(CL_GRN)==)
$(info == $(CL_RST)@@!  @@@ @@!  @@@ @@!  @@@ @@!  !@@ @@!      @@!@!@@@ $(CL_GRN)==)
$(info == $(CL_RST)@!@!@!@  @!@!!@!  @!@  !@! @!@@!@!  @!!!:!   @!@@!!@! $(CL_GRN)==)
$(info == $(CL_RST)!!:  !!! !!: :!!  !!:  !!! !!: :!!  !!:      !!:  !!! $(CL_GRN)==)
$(info == $(CL_RST):: : ::   :   : :  : :. :   :   ::: : :: ::: ::    :  $(CL_GRN)==)
$(info ===================Steady Breaking Shit====================)
$(info $(CL_GRN)PLATFORM_VERSION_CODENAME=$(CL_RST)$(PLATFORM_VERSION_CODENAME))
$(info $(CL_GRN)PLATFORM_VERSION=$(CL_RST)$(PLATFORM_VERSION))
$(info $(CL_GRN)BROKEN_VERSION=$(CL_RST)$(BROKEN_VERSION))
$(info $(CL_GRN)TARGET_PRODUCT=$(CL_RST)$(TARGET_PRODUCT))
$(info $(CL_GRN)TARGET_BUILD_VARIANT=$(CL_RST)$(TARGET_BUILD_VARIANT))
$(info $(CL_GRN)TARGET_BUILD_TYPE=$(CL_RST)$(TARGET_BUILD_TYPE))
$(info $(CL_GRN)TARGET_BUILD_APPS=$(CL_RST)$(TARGET_BUILD_APPS))
$(info $(CL_GRN)TARGET_ARCH=$(CL_RST)$(TARGET_ARCH))
$(info $(CL_GRN)KERNEL_TOOLCHAIN_PREFIX=$(CL_RST)$(KERNEL_TOOLCHAIN_PREFIX))
$(info $(CL_GRN)KERNEL_TOOLCHAIN=$(CL_RST)$(KERNEL_TOOLCHAIN))
$(info $(CL_GRN)TARGET_NDK_GCC_VERSION=$(CL_RST)$(TARGET_NDK_GCC_VERSION))
$(info $(CL_GRN)TARGET_GCC_VERSION=$(CL_RST)$(TARGET_GCC_VERSION))
$(info $(CL_GRN)STRICT=$(CL_RST)$(STRICT))
$(info $(CL_GRN)TARGET_ARCH_VARIANT=$(CL_RST)$(TARGET_ARCH_VARIANT))
$(info $(CL_GRN)TARGET_CPU_VARIANT=$(CL_RST)$(TARGET_CPU_VARIANT))
$(info $(CL_GRN)TARGET_2ND_ARCH=$(CL_RST)$(TARGET_2ND_ARCH))
$(info $(CL_GRN)TARGET_2ND_ARCH_VARIANT=$(CL_RST)$(TARGET_2ND_ARCH_VARIANT))
$(info $(CL_GRN)TARGET_2ND_CPU_VARIANT=$(CL_RST)$(TARGET_2ND_CPU_VARIANT))
$(info $(CL_GRN)HOST_ARCH=$(CL_RST)$(HOST_ARCH))
$(info $(CL_GRN)HOST_OS=$(CL_RST)$(HOST_OS))
$(info $(CL_GRN)HOST_OS_EXTRA=$(CL_RST)$(HOST_OS_EXTRA))
$(info $(CL_GRN)HOST_BUILD_TYPE=$(CL_RST)$(HOST_BUILD_TYPE))
$(info $(CL_GRN)BUILD_ID=$(CL_RST)$(BUILD_ID))
$(info $(CL_GRN)OUT_DIR=$(CL_RST)$(OUT_DIR))
ifeq ($(CYNGN_TARGET),true)
$(info   CYNGN_TARGET=$(CYNGN_TARGET))
$(info   CYNGN_FEATURES=$(CYNGN_FEATURES))
endif
$(info $(CL_GRN)============================================$(CL_RST))
endif
