# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE ?= true

include vendor/droidx/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include hardware/qcom-caf/common/BoardConfigQcom.mk
endif

include vendor/droidx/config/BoardConfigSoong.mk

# Certification
include vendor/certification/BoardConfig.mk
