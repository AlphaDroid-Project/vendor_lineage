PRODUCT_BRAND ?= Alpha

PRODUCT_PACKAGES += \
    bootanimation.zip

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

# TARGET_BUILD_PACKAGE options:
# 1 - vanilla (default)
# 2 - microg
# 3 - gapps
ifeq ($(TARGET_BUILD_PACKAGE),3)
  BUILD_GMS_OVERLAYS_AND_PROPS := true
  $(call inherit-product, vendor/gms/products/gms.mk)
else
  ifeq ($(TARGET_BUILD_PACKAGE),2)
    $(call inherit-product, vendor/microg/product.mk)
  endif
endif
