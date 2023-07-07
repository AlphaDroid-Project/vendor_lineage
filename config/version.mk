PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0

ALPHA_VERSION := 1.7
ALPHA_VARIANT := Droid


ALPHA_BUILD_TYPE ?= UNOFFICIAL

# Only include Updater for official builds
ifeq ($(filter-out OFFICIAL Official official,$(ALPHA_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    AlphaUpdater

PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.lineage-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.lineage-updater.rc
endif

# GAPPS_BUILD_TYPE
# 0 - NO GAPPS (DEFAULT)
# 1 - CORE GAPPS
# 2 - FULL GAPPS

# validate GAPPS_BUILD_TYPE used on envsetup
ifeq ($(filter $(strip $(GAPPS_BUILD_TYPE)),0 1 2),)
# if value is not valid, pick WITH_GAPPS from dt
GAPPS_BUILD_TYPE := $(strip $(WITH_GAPPS))
endif

ifeq ($(GAPPS_BUILD_TYPE),1)
ALPHA_BUILD_PACKAGE := core_gapps
else
ifeq ($(GAPPS_BUILD_TYPE),2)
ALPHA_BUILD_PACKAGE := full_gapps
else # default
ALPHA_BUILD_PACKAGE := vanilla
endif
endif

# include GMS setup
$(call inherit-product, vendor/gms/setup.mk)

# Internal version
LINEAGE_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)

# Display version
LINEAGE_DISPLAY_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)
