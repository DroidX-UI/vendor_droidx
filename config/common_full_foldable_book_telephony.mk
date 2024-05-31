# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/droidx/config/common_mobile_full.mk)

# Enable support of one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/droidx/config/tablet.mk)

$(call inherit-product, vendor/droidx/config/telephony.mk)
