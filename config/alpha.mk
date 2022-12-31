PRODUCT_BRAND ?= Alpha

# Packages
#PRODUCT_PACKAGES += \
#    Launcher3QuickStep

ifeq ($(TARGET_INCLUDE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif

# Privapp-permissions whitelist mode
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Disable blur on app launch
PRODUCT_PRODUCT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0
