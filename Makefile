include theos/makefiles/common.mk

TWEAK_NAME = tw280
tw280_FILES = /mnt/d/codes/tw280/Tweak.xm
tw280_FRAMEWORKS = CydiaSubstrate Foundation
tw280_CFLAGS = -fobjc-arc
tw280_LDFLAGS = -Wl,-segalign,4000

tw280_ARCHS = armv7 arm64
export ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/tweak.mk
