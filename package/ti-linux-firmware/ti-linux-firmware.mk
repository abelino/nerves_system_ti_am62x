################################################################################
#
# ti-linux-firmware
#
################################################################################

# TI_LINUX_FIRMWARE_VERSION = acab7c9acf6a49687da815dc0f62436b55cd62f0
TI_LINUX_FIRMWARE_VERSION = 08.06.00.007
TI_LINUX_FIRMWARE_SITE = https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/snapshot
TI_LINUX_FIRMWARE_SOURCE = ti-linux-firmware-$(TI_LINUX_FIRMWARE_VERSION).tar.gz
TI_LINUX_FIRMWARE_INSTALL_STAGING = YES
TI_LINUX_FIRMWARE_INSTALL_TARGET = YES
TI_LINUX_FIRMWARE_LICENSE = TI-TFL
TI_LINUX_FIRMWARE_LICENSE_FILES = licenses/TI-TFL
# TI_LINUX_FIRMWARE_DEPENDENCIES =

TI_DM_FW_DIR = ti-dm/am62xx
TI_DM_FW_FILE = ipc_echo_testb_mcu1_0_release_strip.xer5f

# ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh ${S}/${DM_FW_DIR}/${FW_NAME} ${S}/${DM_FW_DIR}/${FW_NAME}.signed

# install -m 0644 ${S}/${DM_FW_DIR}/${FW_NAME}        ${D}${INSTALL_DM_FW_DIR}/
# install -m 0644 ${S}/${DM_FW_DIR}/${FW_NAME}.signed ${D}${INSTALL_DM_FW_DIR}/

# Alternative name? am62-main-r5f0_0-fw

define TI_LINUX_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware/$(TI_DM_FW_DIR)
	mkdir -p $(UBOOT_DIR)/$(TI_DM_FW_DIR)

	cp -a \
		$(@D)/$(TI_DM_FW_DIR)/${TI_DM_FW_FILE} \
		$(TARGET_DIR)/lib/firmware/$(TI_DM_FW_DIR)/

	cp -a \
		$(@D)/$(TI_DM_FW_DIR)/${TI_DM_FW_FILE} \
		$(UBOOT_DIR)/$(TI_DM_FW_DIR)/
endef

$(eval $(generic-package))
