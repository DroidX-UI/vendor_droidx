# google-sans family
PRODUCT_PACKAGES += \
    GoogleSans-Italic.ttf \
    GoogleSans-Regular.ttf \
    GoogleSansClock-Regular.ttf \
    GoogleSansFlex-Regular.ttf

# General Sans
PRODUCT_PACKAGES += \
    GeneralSans-Bold.ttf \
    GeneralSans-BoldItalic.ttf \
    GeneralSans-Italic.ttf \
    GeneralSans-Medium.ttf \
    GeneralSans-Regular.ttf \
    GeneralSans-MediumItalic.ttf

PRODUCT_PACKAGES += \
    GInterVF-Italic.ttf \
    GInterVF-Roman.ttf \
    Manrope-VF.ttf \
    
# Author
PRODUCT_PACKAGES += \
    Author-Variable.ttf \
    Author-VariableItalic.ttf

# Cabinet-Grotesk
PRODUCT_PACKAGES += \
    CabinetGrotesk-Variable.ttf


# Eudoxus-Sans
PRODUCT_PACKAGES += \
    EudoxusSansGX.ttf

# Fixel
PRODUCT_PACKAGES += \
    FixelVariable.ttf \
    FixelVariableItalic.ttf

# Satoshi
PRODUCT_PACKAGES += \
    Satoshi-Variable.ttf \
    Satoshi-VariableItalic.ttf

# Space-Grotesk
PRODUCT_PACKAGES += \
    SpaceGrotesk-Variable.ttf

# Switzer
PRODUCT_PACKAGES += \
    Switzer-Variable.ttf \
    Switzer-VariableItalic.ttf

# Uncut-Sans
PRODUCT_PACKAGES += \
    Uncut-Sans-VF.ttf

# DM-Sans
PRODUCT_PACKAGES += \
    dm-sans-latin-400-italic.ttf \
    dm-sans-latin-400-normal.ttf \
    dm-sans-latin-500-italic.ttf \
    dm-sans-latin-500-normal.ttf \
    dm-sans-latin-600-italic.ttf \
    dm-sans-latin-600-normal.ttf \
    dm-sans-latin-700-italic.ttf \
    dm-sans-latin-700-normal.ttf

# Customization overlays
PRODUCT_PACKAGES += \
    FontGInterOverlay \
    FontGoogleSansOverlay \
    FontManropeOverlay \
    FontAuthorOverlay \
    CabinetGroteskOverlay \
    DMSansOverlay \
    EudoxusSansOverlay \
    FixelOverlay \
    SatoshiOverlay \
    SpaceGroteskOverlay \
    SwitzerOverlay \
    UncutSansOverlay

# Register vendor fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/droidx/fonts/prebuilt,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    vendor/droidx/fonts/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml
