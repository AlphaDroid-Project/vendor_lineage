#
# Copyright (C) 2016 The CyanogenMod Project
#               2017-2024 The LineageOS Project
#               2023-2024 AlphaDroid
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# We use 1x1 bootanimation, so no need to resize height

ifeq(TARGET_USES_CUSTOM_BOOTANIMATION,true)
    ifeq ($(TARGET_CUSTOM_BOOTANIMATION_PATH),)
        $(error "bootanimation: TARGET_CUSTOM_BOOTANIMATION_PATH is undefined while TARGET_USES_CUSTOM_BOOTANIMATION is true")
    else
        ifeq (,$(wildcard $(TARGET_CUSTOM_BOOTANIMATION_PATH)/desc.txt))
            $(error "bootanimation: TARGET_CUSTOM_BOOTANIMATION_PATH is defined but $(TARGET_CUSTOM_BOOTANIMATION_PATH)/desc.txt does not exists")
        endif
        ifeq (,$(wildcard $(TARGET_CUSTOM_BOOTANIMATION_PATH)/bootanimation.tar))
            $(error "bootanimation: TARGET_CUSTOM_BOOTANIMATION_PATH is defined but $(TARGET_CUSTOM_BOOTANIMATION_PATH)/bootanimation.tar does not exists")
        endif
        SOURCE_PATH := $(TARGET_CUSTOM_BOOTANIMATION_PATH)
    endif
else
    SOURCE_PATH := vendor/lineage/product/bootanimation
endif
TARGET_GENERATED_BOOTANIMATION := $(TARGET_OUT_INTERMEDIATES)/BOOTANIMATION/bootanimation.zip
$(TARGET_GENERATED_BOOTANIMATION): INTERMEDIATES := $(call intermediates-dir-for,BOOTANIMATION,bootanimation)
$(TARGET_GENERATED_BOOTANIMATION): $(SOONG_ZIP)
	@echo "Building bootanimation.zip from $(SOURCE_PATH)"
	@rm -rf $(dir $@)
	@mkdir -p $(INTERMEDIATES)
	$(hide) tar xfp $(SOURCE_PATH)/bootanimation.tar -C $(INTERMEDIATES)
	$(hide) if [ $(TARGET_SCREEN_HEIGHT) -lt $(TARGET_SCREEN_WIDTH) ]; then \
	    IMAGEWIDTH=$(TARGET_SCREEN_HEIGHT); \
	else \
	    IMAGEWIDTH=$(TARGET_SCREEN_WIDTH); \
	fi; \
	RESOLUTION="$$IMAGEWIDTH"x"$$IMAGEWIDTH"; \
	for part_cnt in 0 1 2; do \
	    mkdir -p $(INTERMEDIATES)/part$$part_cnt; \
	done; \
	prebuilts/tools-lineage/${HOST_OS}-x86/bin/mogrify -resize $$RESOLUTION -colors 256 $(INTERMEDIATES)/*/*.png; \
	echo "$$IMAGEWIDTH $$IMAGEWIDTH 30" > $(INTERMEDIATES)/desc.txt; \
	cat $(SOURCE_PATH)/desc.txt >> $(INTERMEDIATES)/desc.txt
	$(hide) $(SOONG_ZIP) -L 0 -o $@ -C $(INTERMEDIATES) -D $(INTERMEDIATES)

ifeq ($(TARGET_BOOTANIMATION),)
    TARGET_BOOTANIMATION := $(TARGET_GENERATED_BOOTANIMATION)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := bootanimation.zip
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_PRODUCT)/media

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(TARGET_BOOTANIMATION)
	@cp $(TARGET_BOOTANIMATION) $@

include $(CLEAR_VARS)

BOOTANIMATION_SYMLINK := $(TARGET_OUT_PRODUCT)/media/bootanimation-dark.zip
$(BOOTANIMATION_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@mkdir -p $(dir $@)
	$(hide) ln -sf bootanimation.zip $@

ALL_DEFAULT_INSTALLED_MODULES += $(BOOTANIMATION_SYMLINK)
