#
# Copyright (C) 2024 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/infinix/X670

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# API level — X670 shipped Android 12
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# A/B
ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER    := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    lk \
    odm \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_dlkm

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Keymaster — Trustonic TEE (confirmed from /vendor/bin/hw/)
# Keymaster 4.1 service binary
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@4.1-service.trustonic

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/android.hardware.keymaster@4.1-service.trustonic

# Crypto libs — all pulled from live device /vendor/lib64/
PREBUILT_LIB_PATH := device/infinix/X670/prebuilt/vendor/lib64

PRODUCT_COPY_FILES += \
    $(PREBUILT_LIB_PATH)/libkeymaster4.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster4.so \
    $(PREBUILT_LIB_PATH)/libkeymaster41.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster41.so \
    $(PREBUILT_LIB_PATH)/libkeymaster4support.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster4support.so \
    $(PREBUILT_LIB_PATH)/libkeymaster4_1support.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster4_1support.so \
    $(PREBUILT_LIB_PATH)/libkeymaster_messages.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster_messages.so \
    $(PREBUILT_LIB_PATH)/libkeymaster_portable.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libkeymaster_portable.so \
    $(PREBUILT_LIB_PATH)/libpuresoftkeymasterdevice.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libpuresoftkeymasterdevice.so \
    $(PREBUILT_LIB_PATH)/libion.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libion.so \
    $(PREBUILT_LIB_PATH)/libxml2.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libxml2.so \
    $(PREBUILT_LIB_PATH)/android.hardware.keymaster@3.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.keymaster@3.0.so \
    $(PREBUILT_LIB_PATH)/android.hardware.keymaster@4.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.keymaster@4.0.so \
    $(PREBUILT_LIB_PATH)/android.hardware.keymaster@4.1.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/android.hardware.keymaster@4.1.so \
    $(PREBUILT_LIB_PATH)/vendor.mediatek.hardware.keymaster_attestation@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.mediatek.hardware.keymaster_attestation@1.0.so \
    $(PREBUILT_LIB_PATH)/vendor.mediatek.hardware.keymaster_attestation@1.1.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/vendor.mediatek.hardware.keymaster_attestation@1.1.so \
    $(PREBUILT_LIB_PATH)/hw/gatekeeper.trustonic.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/gatekeeper.trustonic.so \
    $(PREBUILT_LIB_PATH)/hw/kmsetkey.trustonic.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/kmsetkey.trustonic.so \
    $(PREBUILT_LIB_PATH)/hw/vendor.mediatek.hardware.keymaster_attestation@1.1-impl.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/hw/vendor.mediatek.hardware.keymaster_attestation@1.1-impl.so
