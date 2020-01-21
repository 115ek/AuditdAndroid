# Build the auditctl binary
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

ETC_DIR := $(TARGET_OUT)/etc/audit

LOCAL_MODULE := auditctl
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES:= lib/libaudit.c \
			lib/message.c \
			lib/netlink.c \
			lib/lookup_table.c \
			lib/audit_logging.c \
			lib/deprecated.c \
			src/auditctl.c \
			src/auditctl-llist.c \
			src/delete_all.c


LOCAL_C_INCLUDES :=	$(LOCAL_PATH) \
			$(LOCAL_PATH)/lib \
			$(LOCAL_PATH)/libc \
			$(LOCAL_PATH)/kernel \
			$(LOCAL_PATH)/src

LOCAL_SHARED_LIBRARIES := libc libcutils liblog
LOCAL_CFLAGS := -Wno-error

include $(BUILD_EXECUTABLE)


# Build the auditd binary
include $(CLEAR_VARS)

LOCAL_MODULE := auditd
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES:= lib/libaudit.c \
			lib/message.c \
			lib/netlink.c \
			lib/lookup_table.c \
			lib/audit_logging.c \
			lib/deprecated.c \
			src/auditd.c \
			src/auditd-event.c \
			src/auditd-config.c \
			src/auditd-reconfig.c \
			src/auditd-sendmail.c \
			src/auditd-listen.c \
			src/auditd-parse.c \
			src/ev.c \
			src/event.c

LOCAL_C_INCLUDES :=	$(LOCAL_PATH) \
			$(LOCAL_PATH)/lib \
			$(LOCAL_PATH)/libc \
			$(LOCAL_PATH)/kernel \
			$(LOCAL_PATH)/src

LOCAL_SHARED_LIBRARIES := libc libcutils liblog
LOCAL_CFLAGS := -Wno-error -Wno-int-conversion

include $(BUILD_EXECUTABLE)

#spade-audit utility build
include $(CLEAR_VARS)

LOCAL_MODULE := spade-audit
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES:= src/spadeLinuxAudit.c
LOCAL_CFLAGS :=  -fPIE -DPIE -g -D_GNU_SOURCE -fno-strict-aliasing -Wno-error
LOCAL_SHARED_LIBRARIES := libc libcutils libm

include $(BUILD_EXECUTABLE)

# Start copying configuration files
include $(CLEAR_VARS)
LOCAL_MODULE := auditd.conf
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(ETC_DIR)
LOCAL_SRC_FILES := etc/auditd.conf
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := auditd.rules
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(ETC_DIR)
LOCAL_SRC_FILES := etc/auditd.rules
include $(BUILD_PREBUILT)

