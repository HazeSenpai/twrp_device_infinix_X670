#
# Copyright (C) 2024 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/infinix/X670/device.mk)

PRODUCT_NAME         := twrp_X670
PRODUCT_DEVICE       := X670
PRODUCT_BRAND        := Infinix
PRODUCT_MODEL        := Infinix NOTE 12 G96
PRODUCT_MANUFACTURER := INFINIX

PRODUCT_GMS_CLIENTID_BASE := android-infinix
