TARGET = iphone:clang:latest:9.0
SYSROOT = $(THEOS)/sdks/iPhoneOS10.1.sdk
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = lpmprefs
lpmprefs_FILES = $(wildcard *.m)
lpmprefs_INSTALL_PATH = /Library/PreferenceBundles
lpmprefs_FRAMEWORKS = UIKit
lpmprefs_PRIVATE_FRAMEWORKS = Preferences
lpmprefs_EXTRA_FRAMEWORKS += CepheiPrefs Cephei

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/lpmprefs.plist$(ECHO_END)
