# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# DroidX-UI System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.modversion=$(DROIDX_VERSION)
    