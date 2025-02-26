# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= DroidX-UI

DROIDX_ZIP_TYPE := Vanilla

# Gapps
ifeq ($(DROIDX_GAPPS), true)
    ifeq ($(TARGET_USES_MINI_GAPPS),true)
        $(call inherit-product, vendor/gms/gms_mini.mk)
    else ifeq ($(TARGET_USES_PICO_GAPPS),true)
        $(call inherit-product, vendor/gms/gms_pico.mk)
    else
        $(call inherit-product, vendor/gms/gms_full.mk)
    endif
    DROIDX_ZIP_TYPE := Gapps
    PRODUCT_PACKAGES += OTAGapps
    $(call inherit-product, vendor/pixel-style/config/common.mk)

else
    PRODUCT_PACKAGES += \
    OTAVanilla \
    DXUILauncherQuickStep \
    DXUILauncherOverlay
    
    PRODUCT_PRODUCT_PROPERTIES += \
        setupwizard.theme=glif_v4 \
        ro.config.notification_sound=Argon.ogg \
        ro.config.alarm_alert=Hassium.ogg \
        ro.config.ringtone=Ring_Classic_02.ogg
endif

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Workaround AOSP AM crash
PRODUCT_PROPERTY_OVERRIDES += \
    sys.fflag.override.settings_enable_monitor_phantom_procs=false

# Protobuf - Workaround for prebuilt Qualcomm HAL
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-3.9.1-vendorcompat \
    libprotobuf-cpp-lite-3.9.1-vendorcompat
    
ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=adb
else
ifdef WITH_ADB_INSECURE
# Forcebly disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=none
endif

# Disable extra StrictMode features on all non-eng builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/droidx/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/droidx/prebuilt/common/bin/50-droidx.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-droidx.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-droidx.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/droidx/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/droidx/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# DroidX-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/etc/init/init.droidx-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.droidx-system_ext.rc

# GMS Permissions
PRODUCT_COPY_FILES += \
    vendor/droidx/config/permissions/privapp-permissions-gms.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-gms.xml

# App lock permission
PRODUCT_COPY_FILES += \
    vendor/droidx/config/permissions/privapp-permissions-settings.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-settings.xml

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/droidx/config/permissions/privapp-permissions-lineagehw.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-lineagehw.xml \
    vendor/droidx/config/permissions/org.lineageos.health.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.health.xml \
    vendor/droidx/config/permissions/org.lineageos.health.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.health.xml

PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/etc/init/init.custom-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.custom-system_ext.rc

# App lock permission
PRODUCT_COPY_FILES += \
    vendor/droidx/config/permissions/privapp-permissions-settings.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-settings.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Component overrides
PRODUCT_PACKAGES += \
    droidx-component-overrides.xml

# Google Photos Pixel Exclusive XML
PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/etc/sysconfig/pixel_2016_exclusive.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/pixel_2016_exclusive.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Clean up packages cache to avoid wrong strings and resources
PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# customization
TARGET_SUPPORTS_GOOGLE_RECORDER ?= true
TARGET_INCLUDE_STOCK_ARCORE ?= true
TARGET_SUPPORTS_CALL_RECORDING ?= true
TARGET_USE_GOOGLE_TELEPHONY ?= true
TARGET_USE_MOTO_CALCULATOR ?= false
TARGET_USE_QUICKPIC ?= false
DROIDX_VERSION_APPEND_TIME_OF_DAY ?= true

# UDFPS Animations
EXTRA_UDFPS_ANIMATIONS ?= false
ifeq ($(EXTRA_UDFPS_ANIMATIONS),true)
PRODUCT_PACKAGES += \
    UdfpsResources
endif

ifneq ($(TARGET_DISABLE_EPPE),true)
# Require all requested packages to exist
$(call enforce-product-packages-exist-internal,$(wildcard device/*/$(DROIDX_BUILD)/$(TARGET_PRODUCT).mk),product_manifest.xml rild Calendar Launcher3 Launcher3Go Launcher3QuickStep Launcher3QuickStepGo android.hidl.memory@1.0-impl.vendor vndk_apex_snapshot_package)
endif

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images \
    product_charger_res_images_vendor

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig \
    SimpleSettingsConfig

# Face Unlock
PRODUCT_PACKAGES += \
    FaceUnlock

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml

ifeq ($(filter-out OFFICIAL,$(DROIDX_BUILD_TYPE)),)
# Updater
PRODUCT_PACKAGES += \
    Updater

PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/etc/init/init.droidx-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.droidx-updater.rc
endif

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    bash \
    curl \
    getcap \
    htop \
    nano \
    setcap \
    vim

PRODUCT_PACKAGES += \
    nano_recovery

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

PRODUCT_COPY_FILES += \
    vendor/droidx/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_PROPERTIES += \
    ro.storage_manager.enabled=true

# Default wifi country code
PRODUCT_SYSTEM_PROPERTIES += \
    ro.boot.wificountrycode?=00

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# Root
PRODUCT_PACKAGES += \
    adb_root
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/xbin/su
endif
endif

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Settings \
    NexusLauncherRelease \
    DerpLauncherQuickStep \


PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed

ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    debug.sf.enable_transaction_tracing=false
endif

# SetupWizard
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.day_night_mode_enabled=true \

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/droidx/overlay/common 

PRODUCT_PACKAGES += \
    NetworkStackOverlay \

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/droidx/build/target/product/security/droidx

# TouchGestures
PRODUCT_PACKAGES += \
    TouchGestures
    
# Themepicker
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub

# DroidX-UI Framework
PRODUCT_PACKAGES += \
    DroidXManifest \
    framework-droidx

# Apps
PRODUCT_PACKAGES += \
    Aperture \
    Etar \
    Glimpse \
    Recorder \
    ExactCalculator \
    DroidXUIWallpaperStub \
    LatinIME \

# Repainter integration
PRODUCT_PACKAGES += \
    RepainterServicePriv

# Inherit SystemUI Clocks if they exist
$(call inherit-product-if-exists, vendor/SystemUIClocks/product.mk)

# Fonts
$(call inherit-product, vendor/droidx/config/fonts.mk)

include vendor/droidx/config/version.mk
include vendor/droidx/config/bootanimation.mk
include vendor/droidx/config/telephony.mk
include vendor/droidx/config/themes.mk
-include vendor/droidx-priv/keys/keys.mk
include vendor/prebuilds/prebuilds.mk
