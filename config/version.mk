PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 3

ifeq ($(DROIDX_VERSION_APPEND_TIME_OF_DAY),true)
    DROIDX_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    DROIDX_BUILD_DATE := $(shell date -u +%Y%m%d)
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

DROIDX_VERSION_SUFFIX := $(DROIDX_BUILD_DATE)-$(DROIDX_BUILD_TYPE)-$(DROIDX_BUILD)

# Internal version
DROIDX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(DROIDX_VERSION_SUFFIX)

# Display version
DROIDX_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(DROIDX_VERSION_SUFFIX)

# Codename version
DROIDX_DISPLAY_VERSION_CODENAME := 13-SkyLight

# Props
PRODUCT_GENERIC_PROPERTIES += \
  ro.droidx.version=$(DROIDX_DISPLAY_VERSION_CODENAME) \
  ro.droidx.releasevarient=$(DROIDX_ZIP_TYPE) \
  ro.droidx.releasetype=$(DROIDX_BUILD_TYPE) \
  ro.droidx.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \