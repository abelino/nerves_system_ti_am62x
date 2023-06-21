################################################################################
#
# ti-linux-fw
#
################################################################################

CORESDK_RTOS_VERSION = "08.02.00.04"
PRUETH_FW_AM65X_VERSION = "08.00.00.20"
PRUETH_FW_AM65X_SR2_VERSION = "02.02.11.02"
GOODIX_FW_VERSION = "1.0.0.0"
CADENCE_MHDP_FW_VERSION = "2.1.0"
IMG_DEC_FW_VERSION = "1.0"
CNM_WAVE521_FW_VERSION = "1.0.00"
TI_DM_FW_VERSION = "08.06.04"
TI_SYSFW_VERSION = "08.06.04"

TI_LINUX_FW_VERSION = "acab7c9acf6a49687da815dc0f62436b55cd62f0"
TI_LINUX_FW_SITE = $(call git.ti.com,git,processor-firmware,ti-linux-firmware,$(TI_LINUX_FW_VERSION))
TI_LINUX_FW_INSTALL_STAGING = YES
TI_LINUX_FW_INSTALL_TARGET = YES
TI_LINUX_FW_LICENSE = TI-TFL
# TI_LINUX_FW_DEPENDENCIES = libmodbus

$(eval $(cmake-package))

# SUMMARY = "Common include for TI Linux firmware"

# LICENSE = "TI-TFL"
# LIC_FILES_CHKSUM = "file://LICENSE.ti;md5=b5aebf0668bdf95621259288c4a46d76"

# PV = "2022.01"
# INC_PR = "r4"

# # Firmware versions
# CORESDK_RTOS_VERSION = "08.02.00.04"
# PRUETH_FW_AM65X_VERSION = "08.00.00.20"
# PRUETH_FW_AM65X_SR2_VERSION = "02.02.11.02"
# GOODIX_FW_VERSION = "1.0.0.0"
# CADENCE_MHDP_FW_VERSION = "2.1.0"
# IMG_DEC_FW_VERSION = "1.0"
# CNM_WAVE521_FW_VERSION = "1.0.00"
# TI_DM_FW_VERSION = "08.06.04"
# TI_SYSFW_VERSION = "08.06.04"

# TI_LINUX_FW_SRCREV ?= "acab7c9acf6a49687da815dc0f62436b55cd62f0"
# SRCREV = "${TI_LINUX_FW_SRCREV}"

# BRANCH ?= "ti-linux-firmware"

# SRC_URI = "git://git.ti.com/git/processor-firmware/ti-linux-firmware.git;protocol=https;branch=${BRANCH}"

# S = "${WORKDIR}/git"
