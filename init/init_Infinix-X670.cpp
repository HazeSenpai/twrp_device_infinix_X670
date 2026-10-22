/*
 * Copyright (C) 2024 The Android Open Source Project
 * SPDX-License-Identifier: Apache-2.0
 *
 * X670 = Infinix NOTE 12 G96 = NOTE 12 Turbo
 * One device, one SKU, two marketing names.
 * Ground truth from prop.default:
 *   ro.product.system.device  = Infinix-X670
 *   ro.product.system.model   = Infinix X670
 *   ro.product.system.name    = X670-GL
 *   ro.product.board          = Infinix-X670
 *   ro.board.platform         = mt6781
 */

#include <android-base/logging.h>
#include <android-base/properties.h>

using android::base::SetProperty;

void vendor_load_properties() {
    SetProperty("ro.product.vendor.brand",        "Infinix");
    SetProperty("ro.product.vendor.manufacturer", "INFINIX");
    SetProperty("ro.product.vendor.device",       "Infinix-X670");
    SetProperty("ro.product.vendor.model",        "Infinix NOTE 12 G96");
    SetProperty("ro.product.vendor.name",         "X670-GL");
}
