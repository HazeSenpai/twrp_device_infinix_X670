# TWRP Device Tree — Infinix NOTE 12 G96 (X670)

Ported from [TeamWin/android_device_infinix_X6531](https://github.com/TeamWin/android_device_infinix_X6531)  
All kernel offsets, fstab entries, and product strings verified against stock `boot.img`.

---

## Device Specs

| Feature       | Spec |
|---------------|------|
| Chipset       | MediaTek MT6781 Helio G96 (12nm) |
| CPU           | 2x Cortex-A76 @ 2.05GHz + 6x Cortex-A55 @ 2.0GHz |
| GPU           | Mali-G57 MC2 |
| RAM           | 8 GB |
| Storage       | 128/256 GB (f2fs userdata) |
| Display       | 6.7" AMOLED 1080x2400 |
| Battery       | 5000mAh, 33W |
| OS (stock)    | Android 12, XOS 10.6 |
| Board name    | CY-X670-H814 (from boot.img header) |
| Build ID      | X670-H814DGHJKL-T-GL-240224V150 |
| Security patch| 2024-02-05 |
| Model name    | X670 / NOTE 12 G96 / NOTE 12 Turbo — **same device, one SKU** |

---

## Critical Architecture Note

**This device uses `boot.img` for recovery — NOT `vendor_boot`.**

The stock `boot.img` ramdisk contains:
- `/system/bin/recovery` — the recovery binary
- `init.recovery.mt6781.rc` — MTK recovery init script

This is a **boot header v2** image with a **self-contained gzip ramdisk**.  
There is no separate recovery partition. Flash target = `boot`.

---

## Verified Kernel Offsets (from stock boot.img)

| Parameter | Value |
|-----------|-------|
| `BOARD_KERNEL_BASE` | `0x40078000` |
| `BOARD_KERNEL_OFFSET` | `0x00008000` |
| `BOARD_RAMDISK_OFFSET` | `0x07c08000` |
| `BOARD_KERNEL_TAGS_OFFSET` | `0x0bc08000` |
| `BOARD_DTB_OFFSET` | `0x0bc08000` |
| `BOARD_PAGE_SIZE` | `2048` |
| `BOARD_DTB_SIZE` | `146359` |
| `BOARD_BOOT_HEADER_VERSION` | `2` |
| cmdline | `bootopt=64S3,32N2,64N2 buildvariant=user` |

---

## Build

```bash
# Sync TWRP 12.1 minimal manifest
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -j$(nproc)

# Place this tree
git clone <your-fork-url> device/infinix/X670

# Copy the prebuilt DTB (extracted from stock boot.img — provided in prebuilt/)
cp prebuilt/dtb.img device/infinix/X670/prebuilt/dtb.img

# Build
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch twrp_X670-eng
mka bootimage
```

---

## Flash

```bash
# fastboot
fastboot flash boot out/target/product/X670/boot.img
fastboot reboot recovery

# OR adb (from running Android)
adb reboot bootloader
fastboot flash boot out/target/product/X670/boot.img
```

---

## Pre-Build: Vendor Crypto Libs

Required for FBE /data decryption. Pull from live device:

```bash
adb pull /vendor/lib64/libkeymaster4.so            device/infinix/X670/prebuilt/
adb pull /vendor/lib64/libkeymaster41.so           device/infinix/X670/prebuilt/
adb pull /vendor/lib64/libpuresoftkeymasterdevice.so device/infinix/X670/prebuilt/
adb pull /vendor/lib64/libion.so                   device/infinix/X670/prebuilt/
adb pull /vendor/lib64/libxml2.so                  device/infinix/X670/prebuilt/
adb pull /vendor/lib64/hw/android.hardware.boot@1.2-mtkimpl.so device/infinix/X670/bootctrl/lib64/
adb pull /vendor/lib/hw/android.hardware.boot@1.2-mtkimpl.so   device/infinix/X670/bootctrl/lib/
```

---

## Status

| Feature | Status |
|---------|--------|
| Screen / Touch | ✅ |
| ADB / MTP | ✅ |
| Backup / Restore | ✅ |
| Sideload | ✅ |
| Decrypt /data (FBE v2) | ⚠️ needs vendor libs above |
| SD card / OTG | ✅ |
| Reboot to fastboot | ✅ |
| Haptics | ❌ (no motor on side fingerprint) |

---

## Credits
- [smiley9000](https://github.com/smiley9000) — X6531 base tree
- [TeamWin](https://github.com/TeamWin) — TWRP
