LOCAL_PATH := $(call my-dir)

# MTK boot control implementation for MT6781
# The .so files must be extracted from the stock vendor image:
#   adb pull /vendor/lib64/hw/android.hardware.boot@1.2-mtkimpl.so
#   adb pull /vendor/lib/hw/android.hardware.boot@1.2-mtkimpl.so
# Place them in $(DEVICE_PATH)/bootctrl/lib64/ and bootctrl/lib/ respectively.

include $(CLEAR_VARS)
LOCAL_MODULE               := android.hardware.boot@1.2-mtkimpl.recovery
LOCAL_MODULE_CLASS         := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX        := .so
LOCAL_MODULE_PATH          := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SRC_FILES_64         := lib64/android.hardware.boot@1.2-mtkimpl.so
LOCAL_SRC_FILES_32         := lib/android.hardware.boot@1.2-mtkimpl.so
LOCAL_MULTILIB             := both
LOCAL_MODULE_STEM_32       := android.hardware.boot@1.2-mtkimpl
LOCAL_MODULE_STEM_64       := android.hardware.boot@1.2-mtkimpl
LOCAL_MODULE_TAGS          := optional
include $(BUILD_PREBUILT)
