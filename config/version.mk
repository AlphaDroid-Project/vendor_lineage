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

# validate input from envsetup stored on GAPPS_BUILD_TYPE
ifeq ($(filter $(strip $(GAPPS_BUILD_TYPE)),0 1 2),)
# if GAPPS_BUILD_TYPE is empty or invalide, pick WITH_GAPPS value (if valid) from dt
ifneq ($(filter $(strip $(WITH_GAPPS)),0 1 2),)
GAPPS_BUILD_TYPE := $(WITH_GAPPS)
else
# default to vanilla if both WITH_GAPPS and GAPPS_BUILD_TYPE are invalid or undefined
GAPPS_BUILD_TYPE := 0
endif
endif

ifeq ($(strip $(GAPPS_BUILD_TYPE)),0)
ALPHA_BUILD_PACKAGE := vanilla
ifeq ($(strip $(TARGET_INCLUDE_GMS_COMPAT)),true)
# Optionally build GmsCompat and GrapheneApps on vanilla builds
PRODUCT_PACKAGES += \
    GmsCompat \
    GmsCompatConfig \
    GrapheneApps
endif
else
ifeq ($(strip $(GAPPS_BUILD_TYPE)),1)
ALPHA_BUILD_PACKAGE := core_gapps
else
ifeq ($(strip $(GAPPS_BUILD_TYPE)),2)
ALPHA_BUILD_PACKAGE := full_gapps
# conditionally include pixel-framework
#ifneq ($(strip $(TARGET_INCLUDE_PIXEL_FRAMEWORK)),false)
#$(call inherit-product-if-exists, vendor/pixel-framework/config.mk)
#endif
endif
endif
endif
# include GMS setup
$(call inherit-product, vendor/gms/setup.mk)

# Internal version
LINEAGE_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)

# Display version
LINEAGE_DISPLAY_VERSION := Alpha$(ALPHA_VARIANT)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-$(ALPHA_BUILD_PACKAGE)-v$(ALPHA_VERSION)
