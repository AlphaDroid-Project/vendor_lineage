PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0

ALPHA_VERSION := 1.5
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

WITH_GAPPS ?= 0
ifeq ($(filter $(strip $(GAPPS_BUILD_TYPE)),0 1 2),)
GAPPS_BUILD_TYPE := $(strip $(WITH_GAPPS))
endif
include vendor/gms/setup.mk

ifeq ($(strip $(GAPPS_BUILD_TYPE)),1)
ALPHA_BUILD_PACKAGE := core_gapps
else
ifeq ($(strip $(GAPPS_BUILD_TYPE)),2)
ALPHA_BUILD_PACKAGE:= full_gapps
else
ALPHA_BUILD_PACKAGE := vanilla
endif
endif

# Internal version
LINEAGE_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)

# Display version
LINEAGE_DISPLAY_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)
