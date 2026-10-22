LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),X670)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
