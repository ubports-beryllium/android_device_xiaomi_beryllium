#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/halium.mk)

# Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/xiaomi/beryllium/beryllium-vendor.mk)

# Boot animation
TARGET_SCREEN_HEIGHT := 2246
TARGET_SCREEN_WIDTH := 1080

# FM
PRODUCT_PACKAGES += \
    FM2 \
    libqcomfm_jni \
    qcom.fmradio

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    NoCutoutOverlay

# Properties
-include $(LOCAL_PATH)/device-props.mk

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Inherit from sdm845-common
$(call inherit-product, device/xiaomi/sdm845-common/sdm845.mk)

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audio/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_dynamic.xml \
    $(LOCAL_PATH)/audio/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_static.xml \
    $(LOCAL_PATH)/audio/sound_trigger_mixer_paths_wcd9340.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9340.xml \
    $(LOCAL_PATH)/audio/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml

# Device fstab
PRODUCT_PACKAGES += \
    fstab.qcom

# Device init scripts
PRODUCT_PACKAGES += \
    init.target.rc

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/uinput-fpc.idc:system/usr/idc/uinput-fpc.idc \
    $(LOCAL_PATH)/idc/uinput-goodix.idc:system/usr/idc/uinput-goodix.idc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/uinput-fpc.kl:system/usr/keylayout/uinput-fpc.kl \
    $(LOCAL_PATH)/keylayout/uinput-goodix.kl:system/usr/keylayout/uinput-goodix.kl

################
# Ubuntu Touch #
################

# Wakelock
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sensors.wl_dis=true

# droidmedia doesn't support HAL3 yet
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.camera.HAL3.enabled=0

# Aethercast is currently disabled due to kernel panic, will get reenabled at some point.
#PRODUCT_PROPERTY_OVERRIDES += \
#    ubuntu.widi.supported=1

PRODUCT_PACKAGES += \
    libmedia_omx \
    android.frameworks.displayservice@1.0 \
    libion \
    libmedia_compat_layer \
    libsf_compat_layer \
    libui_compat_layer \
    libdroidmedia \
    minimediaservice \
    minisfservice \
    miniafservice \
    libbiometry_fp_api \
    libubuntu_application_api \

## Power off charging mode
PRODUCT_PACKAGES += \
    charger_res_images

## Disable FakeSensorServer so UBports can use it
MINIMEDIA_SENSORSERVER_DISABLE := 1

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/halium/lib/udev/rules.d/70-android.rules:system/halium/lib/udev/rules.d/70-android.rules \
    $(LOCAL_PATH)/rootdir/system/halium/etc/ubuntu-touch-session.d/android.conf:system/halium/etc/ubuntu-touch-session.d/android.conf \
    $(LOCAL_PATH)/rootdir/system/halium/etc/apparmor.d/abstractions/base:system/halium/etc/apparmor.d/abstractions/base \
    $(LOCAL_PATH)/rootdir/system/halium/etc/apparmor.d/local/usr.bin.media-hub-server:system/halium/etc/apparmor.d/local/usr.bin.media-hub-server \
    $(LOCAL_PATH)/rootdir/system/halium/usr/share/apparmor/hardware/graphics.d/apparmor-easyprof-ubuntu_android:system/halium/usr/share/apparmor/hardware/graphics.d/apparmor-easyprof-ubuntu_android \
    $(LOCAL_PATH)/rootdir/system/halium/usr/share/apparmor/hardware/video.d/apparmor-easyprof-ubuntu_android:system/halium/usr/share/apparmor/hardware/video.d/apparmor-easyprof-ubuntu_android 

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.disabled.rc:system/etc/init/init.disabled.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init/servicemanager.rc:system/etc/init/servicemanager.rc \
    $(LOCAL_PATH)/rootdir/system/etc/init_hcismd_up.sh:system/etc/init_hcismd_up.sh \
    $(LOCAL_PATH)/rootdir/system/halium/etc/init/ofono.override:system/halium/etc/init/ofono.override \
    $(LOCAL_PATH)/rootdir/system/halium/etc/init/timekeeper.conf:system/halium/etc/init/timekeeper.conf \
    $(LOCAL_PATH)/rootdir/system/halium/usr/share/upstart/sessions/usensord.conf:system/halium/usr/share/upstart/sessions/usensord.conf \
    $(LOCAL_PATH)/rootdir/system/halium/usr/share/powerd/device_configs/config-default.xml:system/halium/usr/share/powerd/device_configs/config-default.xml
