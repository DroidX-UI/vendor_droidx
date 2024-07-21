# Inherit full common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common_mobile_full.mk)

# Inherit tablet common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/tablet.mk)

$(call inherit-product, vendor/droidx/config/wifionly.mk)
