include vendor/droidx/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/droidx/config/BoardConfigQcom.mk
endif

include vendor/droidx/config/BoardConfigSoong.mk
