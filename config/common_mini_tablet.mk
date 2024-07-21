# Inherit mobile mini common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common_mobile_mini.mk)

# Inherit tablet common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/tablet.mk)

$(call inherit-product, vendor/droidx/config/telephony.mk)
