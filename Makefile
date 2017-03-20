TARGET = iphone:clang:latest:9.0
SYSROOT = $(THEOS)/sdks/iPhoneOS10.1.sdk
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LPM
LPM_FILES = Tweak.xm
LPM_PRIVATE_FRAMEWORKS = CoreDuet
LPM_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += lpmprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
