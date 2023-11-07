################################################################################
#
# ti-k3-boot-firmware
#
################################################################################

TI_K3_BOOT_FIRMWARE_VERSION = 09.01.00.003
TI_K3_BOOT_FIRMWARE_SITE = https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/snapshot
TI_K3_BOOT_FIRMWARE_SOURCE = ti-linux-firmware-$(TI_K3_BOOT_FIRMWARE_VERSION).tar.gz
TI_K3_BOOT_FIRMWARE_INSTALL_IMAGES = YES
TI_K3_BOOT_FIRMWARE_INSTALL_TARGET = YES
TI_K3_BOOT_FIRMWARE_LICENSE = TI Proprietary
TI_K3_BOOT_FIRMWARE_LICENSE_FILES = LICENSE.ti

UBOOT_PRE_BUILD_HOOKS += TI_K3_BOOT_FIRMWARE_RDEPEND_CMD

define TI_K3_BOOT_FIRMWARE_RDEPEND_CMD
	$(MAKE) ti-k3-boot-firmware -C $(BASE_DIR)
endef

TI_DM_FW_DIR = ti-dm/am62xx
TI_DM_FW_FILE = ipc_echo_testb_mcu1_0_release_strip.xer5f

UBOOT_MAKE_OPTS += DM=$(BINARIES_DIR)/$(TI_DM_FW_DIR)/$(TI_DM_FW_FILE)
TI_K3_R5_LOADER_NEXT_MAKE_OPTS += DM=$(BINARIES_DIR)/$(TI_DM_FW_DIR)/$(TI_DM_FW_FILE)

# ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh ${S}/${DM_FW_DIR}/${FW_NAME} ${S}/${DM_FW_DIR}/${FW_NAME}.signed

# Alternative name? am62-main-r5f0_0-fw

define TI_K3_BOOT_FIRMWARE_INSTALL_IMAGES_CMDS
	cp -dpfr $(@D)/ti-sysfw $(BINARIES_DIR)/
	cp -dpfr $(@D)/ti-dm $(BINARIES_DIR)/
endef

define TI_K3_BOOT_FIRMWARE_INSTALL_TARGET_CMDS
	cp -dpfr $(@D)/ti-sysfw $(TARGET_DIR)/lib/firmware/
	cp -dpfr $(@D)/ti-dm $(TARGET_DIR)/lib/firmware/
endef

$(eval $(generic-package))
