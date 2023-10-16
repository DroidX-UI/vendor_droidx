$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

# Inherit full common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include DroidX-UI LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/droidx/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/droidx/overlay/dictionaries

$(call inherit-product, vendor/droidx/config/telephony.mk)
