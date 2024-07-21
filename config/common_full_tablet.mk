# Inherit full common DroidX-UI stuff
$(call inherit-product, vendor/droidx/config/common_mobile_full.mk)

# Inherit full tablet common Lineage stuff
$(call inherit-product, vendor/droidx/config/full_tablet.mk)

$(call inherit-product, vendor/droidx/config/telephony.mk)
