PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0

ifeq ($(DROIDX_VERSION_APPEND_TIME_OF_DAY),true)
    DROIDX_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    DROIDX_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Set DROIDX_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef DROIDX_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "DROIDX_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^DROIDX_||g')
        DROIDX_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif


# Check Official
ifeq ($(DROIDX_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/droidx/droidx.devices)
    ifeq ($(filter $(DROIDX_BUILD), $(LIST)), $(DROIDX_BUILD))
      DROIDX_BUILD_TYPE := OFFICIAL
    else 
      DROIDX_BUILD_TYPE := UNOFFICIAL
    endif
endif

ifeq ($(DROIDX_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        DROIDX_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

DROIDX_VERSION_SUFFIX := $(DROIDX_BUILD_DATE)-$(DROIDX_BUILDTYPE)$(DROIDX_EXTRAVERSION)-$(DROIDX_BUILD)

# Internal version
DROIDX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(DROIDX_VERSION_SUFFIX)

# Display version
DROIDX_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(DROIDX_VERSION_SUFFIX)

# Codename version
DROIDX_DISPLAY_VERSION_CODENAME := 13-CrackStone