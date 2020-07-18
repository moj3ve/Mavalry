ARCHS = arm64 arm64e

TARGET = ::13.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Mavalry

Mavalry_FILES = $(wildcard Tweak/*.xm)
Mavalry_EXTRA_FRAMEWORKS += Cephei
Tweak.xm_CFLAGS = -fobjc-arc
Mavalry_FRAMEWORKS = AudioToolbox

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += Preferences
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"