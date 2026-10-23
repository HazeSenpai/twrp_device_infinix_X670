LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE            := libinit_X670
LOCAL_SRC_FILES         := init_Infinix-X670.cpp
LOCAL_CFLAGS            += -Wall
LOCAL_SHARED_LIBRARIES  := libbase
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_CLASS      := SHARED_LIBRARIES
include $(BUILD_SHARED_LIBRARY)
