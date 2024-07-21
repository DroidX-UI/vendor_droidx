# Inherit common mobile DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common.mk)

# Include AOSP audio files
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage14.mk)
include vendor/droidx/config/aosp_audio.mk

# Apps
PRODUCT_PACKAGES += \
    LatinIME \

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true
