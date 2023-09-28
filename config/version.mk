PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0

ALPHA_VERSION := 1.9
ALPHA_VARIANT := Droid


ALPHA_BUILD_TYPE ?= UNOFFICIAL

# Only include Updater for official builds
ifeq ($(filter-out OFFICIAL Official official,$(ALPHA_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    AlphaUpdater

PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.lineage-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.lineage-updater.rc
endif

WITH_GMS ?= $(WITH_GAPPS)
ifeq ($(WITH_GMS), true)
  ALPHA_BUILD_PACKAGE := gapps
  $(call inherit-product, vendor/gms/setup.mk)
  ifeq ($(TARGET_INCLUDE_PIXEL_FRAMEWORK), true)
    $(call inherit-product-if-exists, vendor/pixel-framework/config.mk)
  endif
else
  ALPHA_BUILD_PACKAGE := vanilla
endif

# Internal version
LINEAGE_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)

# Display version
LINEAGE_DISPLAY_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)
