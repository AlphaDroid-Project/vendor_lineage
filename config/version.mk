PRODUCT_VERSION_MAJOR = 14
PRODUCT_VERSION_MINOR = 0

ALPHA_VERSION := 2.6
ALPHA_VARIANT := Droid

ALPHA_BUILD_TYPE ?= UNOFFICIAL

# Only include Updater for official builds
ifeq ($(filter-out OFFICIAL Official official,$(ALPHA_BUILD_TYPE)),)
  PRODUCT_PACKAGES += \
    AlphaUpdater

  PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.lineage-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.lineage-updater.rc

  -include vendor/alpha/keys/keys.mk
endif

# TARGET_BUILD_PACKAGE options:
# 1 - vanilla (default)
# 2 - microg
# 3 - gapps
ifeq ($(TARGET_BUILD_PACKAGE),3)
  ALPHA_BUILD_PACKAGE := gapps
else
  ifeq ($(TARGET_BUILD_PACKAGE),2)
    ALPHA_BUILD_PACKAGE := microg
  else
    ALPHA_BUILD_PACKAGE := vanilla
  endif
endif

# Internal version
LINEAGE_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)

# Display version
LINEAGE_DISPLAY_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)
