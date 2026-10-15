ifeq ($(call my-dir),$(call project-path-for,qcom-display))

display-hals := libgralloc libgenlock libcopybit libvirtual
display-hals += libhwcomposer liboverlay libqdutils libexternal libqservice
display-hals += libmemtrack
ifneq ($(TARGET_PROVIDES_LIBLIGHT),true)
display-hals += liblight
endif

ifneq (,$(filter $(QCOM_BOARD_PLATFORMS),$(TARGET_BOARD_PLATFORM)))
    include $(call all-named-subdir-makefiles,$(display-hals))
else
ifneq ($(filter msm8660 msm8226 msm8x26 msm8960 msm8974 msm8x74,$(TARGET_BOARD_PLATFORM)),)
    # Legacy platforms can be absent from the current QCOM board list.
    include $(call all-named-subdir-makefiles,$(display-hals))
endif
endif

include $(CLEAR_VARS)
LOCAL_MODULE := display_headers
LOCAL_HEADER_LIBRARIES := libhardware_headers
LOCAL_EXPORT_HEADER_LIBRARY_HEADERS := libhardware_headers
LOCAL_EXPORT_C_INCLUDE_DIRS := \
    $(display_top)/libcopybit \
    $(display_top)/libexternal \
    $(display_top)/libgralloc \
    $(display_top)/libhwcomposer \
    $(display_top)/liboverlay \
    $(display_top)/libqdutils \
    $(display_top)/libqservice \
    $(display_top)/libvirtual
include $(BUILD_HEADER_LIBRARY)

endif
