PRODUCT_BRAND ?= Alpha

# Packages
PRODUCT_PACKAGES += \
    Launcher3QuickStep \
    AlphaWallpapersStub

ifeq ($(TARGET_INCLUDE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif

# ADB
ifeq ($(strip $(TARGET_DEFAULT_ADB_ENABLED)), true)
  PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
#  ifeq ($(strip $(TARGET_DEFAULT_ADB_ENABLED)), false)
#    PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
#  else
    ifeq ($(TARGET_BUILD_VARIANT),eng)
      PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
    else
      PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
    endif
#  endif
endif

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.boot=verify \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.install=speed-profile \
    pm.dexopt.bg-dexopt=everything

# Privapp-permissions whitelist mode
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Disable blur on app launch
PRODUCT_PRODUCT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0
