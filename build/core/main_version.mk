# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# crDroid System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.crdroid.build.version=$(LINEAGE_VERSION) \
    ro.crdroid.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.crdroid.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(CR_VERSION) \
    ro.crdroidlegal.url=https://crdroid.net/legal.php

# LineageOS Platform SDK Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)

# Alpha properties
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.alpha.build.version=$(LINEAGE_VERSION) \
    ro.alpha.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.alpha.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.alpha.modversion=$(ALPHA_VERSION) \
    ro.alpha.build.package=$(ALPHA_BUILD_PACKAGE) \
