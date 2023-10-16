# Inherit common mobile DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common.mk)

# Include AOSP audio files
include vendor/droidx/config/aosp_audio.mk

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true
