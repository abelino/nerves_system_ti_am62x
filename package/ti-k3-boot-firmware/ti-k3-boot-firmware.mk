################################################################################
#
# ti-k3-boot-firmware
#
################################################################################

# TI_K3_BOOT_FIRMWARE_VERSION = acab7c9acf6a49687da815dc0f62436b55cd62f0
TI_K3_BOOT_FIRMWARE_VERSION = 08.06.00.007
TI_K3_BOOT_FIRMWARE_SITE = https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/snapshot
TI_K3_BOOT_FIRMWARE_SOURCE = ti-linux-firmware-$(TI_K3_BOOT_FIRMWARE_VERSION).tar.gz
TI_K3_BOOT_FIRMWARE_INSTALL_TARGET = YES
TI_K3_BOOT_FIRMWARE_INSTALL_IMAGES = YES
# TI_K3_BOOT_FIRMWARE_RDEPENDENCIES = uboot-tools
TI_K3_BOOT_FIRMWARE_LICENSE = TI-TFL
TI_K3_BOOT_FIRMWARE_LICENSE_FILES = LICENCE.ti-tspa
TI_K3_BOOT_FIRMWARE_CPE_ID_VENDOR = ti
TI_K3_BOOT_FIRMWARE_CPE_ID_PRODUCT = u-boot
TI_K3_BOOT_FIRMWARE_DEPENDENCIES = $(BR2_MAKE_HOST_DEPENDENCY)

UBOOT_PRE_BUILD_HOOKS += TI_K3_BOOT_FIRMWARE_RDEPEND_CMD

define TI_K3_BOOT_FIRMWARE_RDEPEND_CMD
	$(MAKE) ti-k3-boot-firmware -C $(BASE_DIR)
endef

# BR2_MAKE_HOST_DEPENDENCY += ti-k3-boot-firmware
# UBOOT_DEPENDENCIES += ti-k3-boot-firmware

TI_DM_FW_DIR = ti-dm/am62xx
TI_DM_FW_FILE = ipc_echo_testb_mcu1_0_release_strip.xer5f

UBOOT_EXTRA_DOWNLOADS = $(TI_K3_DM_SITE)/$(TI_K3_DM_SOURCE)
UBOOT_MAKE_OPTS += DM=$(BINARIES_DIR)/$(TI_DM_FW_DIR)/$(TI_DM_FW_FILE)

# ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh ${S}/${DM_FW_DIR}/${FW_NAME} ${S}/${DM_FW_DIR}/${FW_NAME}.signed

# install -m 0644 ${S}/${DM_FW_DIR}/${FW_NAME}        ${D}${INSTALL_DM_FW_DIR}/
# install -m 0644 ${S}/${DM_FW_DIR}/${FW_NAME}.signed ${D}${INSTALL_DM_FW_DIR}/

# Alternative name? am62-main-r5f0_0-fw

define TI_K3_BOOT_FIRMWARE_BUILD_CMDS
	cd $(@D)
endef

define TI_K3_BOOT_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware/$(TI_DM_FW_DIR)

	cp -a \
		$(@D)/$(TI_DM_FW_DIR)/${TI_DM_FW_FILE} \
		$(TARGET_DIR)/lib/firmware/$(TI_DM_FW_DIR)/
endef

define TI_K3_BOOT_FIRMWARE_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/$(TI_DM_FW_DIR)

	cp -a \
		$(@D)/$(TI_DM_FW_DIR)/${TI_DM_FW_FILE} \
		$(BINARIES_DIR)/$(TI_DM_FW_DIR)/

	cp -dpfr $(@D)/ti-sysfw $(BINARIES_DIR)/
	cp -dpfr $(@D)/ti-dm $(BINARIES_DIR)/
endef

$(eval $(generic-package))
