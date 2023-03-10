PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0

ALPHA_VERSION := 1.2.1
ALPHA_VARIANT := Droid


ALPHA_BUILD_TYPE ?= UNOFFICIAL

# Only include Updater for official builds
ifeq ($(filter-out OFFICIAL Official official,$(ALPHA_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    AlphaUpdater

PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.lineage-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.lineage-updater.rc
endif

ifeq ($(WITH_GAPPS), true)
ifeq ($(TARGET_CORE_GAPPS), true)
ALPHA_BUILD_PACKAGE := core_gapps
else
ALPHA_BUILD_PACKAGE:= full_gapps
endif
else
ALPHA_BUILD_PACKAGE := vanilla
endif

# Internal version
LINEAGE_VERSION := Alpha$(ALPHA_VARIANT)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)
# Display version
LINEAGE_DISPLAY_VERSION := Alpha$(ALPHA_VARIANT)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)

