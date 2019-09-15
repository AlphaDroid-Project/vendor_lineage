# Inherit common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_mobile.mk)

PRODUCT_SIZE := full

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd

# Recorder
PRODUCT_PACKAGES += \
    Recorder
