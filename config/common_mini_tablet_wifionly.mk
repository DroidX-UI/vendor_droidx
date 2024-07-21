# Inherit mobile mini common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common_mobile_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/droidx/config/wifionly.mk)
