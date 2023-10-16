# Inherit full common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include DroidX-UI LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/droidx/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/droidx/overlay/dictionaries

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

$(call inherit-product, vendor/droidx/config/telephony.mk)
