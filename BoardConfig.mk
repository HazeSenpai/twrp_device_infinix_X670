#
# Copyright (C) 2024 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/infinix/X670

ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_USES_64_BIT_BINDER := true
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Assert — from prop.default: ro.product.system.device=Infinix-X670
TARGET_OTA_ASSERT_DEVICE := Infinix-X670

# Bootloader — confirmed from boot.img board field: CY-X670-H814
TARGET_BOOTLOADER_BOARD_NAME := mt6781
TARGET_NO_BOOTLOADER := true

# Build hacks
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# ----------------------------------------------------------------
# Kernel — boot header v2, self-contained boot.img (NOT vendor_boot)
# This device has recovery INSIDE boot.img — confirmed by ramdisk
# containing /system/bin/recovery and init.recovery.mt6781.rc
# Flash target: boot partition (not vendor_boot)
# ----------------------------------------------------------------
BOARD_BOOT_HEADER_VERSION := 2

# All offsets verified from boot.img header parse:
#   kernel_load_addr  = 0x40080000
#   base              = 0x40078000  (kernel_addr - 0x8000)
#   kernel_offset     = 0x00008000
#   ramdisk_load_addr = 0x47c80000  → ramdisk_offset = 0x07c08000
#   tags_addr         = 0x4bc80000  → tags_offset    = 0x0bc08000
#   dtb_load_addr     = 0x4bc80000  → dtb_offset     = 0x0bc08000
#   page_size         = 2048
#   dtb_size          = 146359 bytes
BOARD_KERNEL_BASE        := 0x40078000
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_RAMDISK_OFFSET     := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_DTB_OFFSET         := 0x0bc08000
BOARD_PAGE_SIZE          := 2048
BOARD_DTB_SIZE           := 146359

# cmdline from boot.img: bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB    := $(DEVICE_PATH)/prebuilt/dtb.img

BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# No vendor_boot — recovery lives in boot ramdisk
TARGET_NO_RECOVERY := false
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Platform
TARGET_BOARD_PLATFORM := mt6781
BOARD_HAS_MTK_HARDWARE := true

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Partitions
# Dynamic partition — super confirmed; no vendor_boot in partition list
BOARD_SUPER_PARTITION_SIZE         := 9126805504
BOARD_SUPER_PARTITION_GROUPS       := main
BOARD_MAIN_SIZE                    := 9122611200
BOARD_MAIN_PARTITION_LIST          := system vendor product system_ext

BOARD_FLASH_BLOCK_SIZE             := 131072   # page_size(2048) * 64
BOARD_USES_METADATA_PARTITION      := true

# Filesystem — system/vendor are erofs (confirmed from fstab.mt6781)
TARGET_USERIMAGES_USE_EXT4         := true
TARGET_USERIMAGES_USE_F2FS         := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Crypto — FBE v2, inlinecrypt (confirmed from fstab userdata entry)
# fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized
TW_INCLUDE_CRYPTO     := true
TW_INCLUDE_CRYPTO_FBE := true
TW_USE_FSCRYPT_POLICY := 2

# Prevent expired-cert decryption failures
PLATFORM_VERSION             := 16777215
PLATFORM_SECURITY_PATCH      := 2127-12-31
VENDOR_SECURITY_PATCH        := 2127-12-31
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
BOOT_SECURITY_PATCH          := 2127-12-31

# Recovery fstab — use the real one extracted from stock boot.img
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# Init lib
TARGET_INIT_VENDOR_LIB         := libinit_X670
TARGET_RECOVERY_DEVICE_MODULES := libinit_X670

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# VNDK
BOARD_VNDK_VERSION := current

# TWRP display — 1080x2400, punch-hole AMOLED
TW_THEME              := portrait_hdpi
TARGET_SCREEN_DENSITY := 393
TW_MAX_BRIGHTNESS     := 4095
TW_DEFAULT_BRIGHTNESS := 2047
TW_BRIGHTNESS_PATH    := "/sys/class/leds/lcd-backlight/brightness"
TW_Y_OFFSET           := 100
TW_H_OFFSET           := -100
TW_FRAMERATE          := 60
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# No separate recovery partition
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SUPPRESS_SECURE_ERASE := true

# Tools
TW_INCLUDE_FASTBOOTD    := true
TW_INCLUDE_NTFS_3G      := true
TW_INCLUDE_REPACKTOOLS  := true
TW_INCLUDE_RESETPROP    := true
TW_EXTRA_LANGUAGES      := true
TW_EXCLUDE_APEX         := true
RECOVERY_SDCARD_ON_DATA := true

# MTK specifics
TW_NO_HAPTICS              := true
TW_CUSTOM_CPU_TEMP_PATH    := "/sys/class/thermal/thermal_zone4/temp"

# Logging
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD    := true
TARGET_USES_MKE2FS  := true

TW_DEVICE_VERSION := X670_G96
