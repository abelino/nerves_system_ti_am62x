################################################################################
#
# ti-k3-image-gen
#
################################################################################

TI_K3_IMAGE_GEN_VERSION = 08.06.00.007
TI_K3_IMAGE_GEN_SITE = https://git.ti.com/cgit/k3-image-gen/k3-image-gen/snapshot
TI_K3_IMAGE_GEN_SOURCE = k3-image-gen-$(TI_K3_IMAGE_GEN_VERSION).tar.gz
TI_K3_IMAGE_GEN_LICENSE = BSD-3-Clause
TI_K3_IMAGE_GEN_LICENSE_FILES = LICENSE
TI_K3_IMAGE_GEN_INSTALL_IMAGES = YES

# ti-k3-image-gen is used to build tiboot3.bin, using the r5-u-boot-spl.bin file
# from the ti-k3-r5-loader package. Hence the dependency on ti-k3-r5-loader.
TI_K3_IMAGE_GEN_DEPENDENCIES = host-arm-gnu-toolchain ti-linux-firmware ti-k3-r5-loader-next host-ti-k3-secdev

ifeq ($(BR2_PACKAGE_TI_K3_IMAGE_GEN_FW_TYPE_TIFS),y)
TI_K3_IMAGE_GEN_FW_TYPE = $(call qstrip,"ti-fs")
else ifeq ($(BR2_PACKAGE_TI_K3_IMAGE_GEN_FW_TYPE_TISCI),y)
TI_K3_IMAGE_GEN_FW_TYPE = $(call qstrip,"ti-sci")
else
$(error No TI K3 Image Gen firmware type set)
endif

TI_K3_IMAGE_GEN_SOC = $(call qstrip,$(BR2_PACKAGE_TI_K3_IMAGE_GEN_SOC))
TI_K3_IMAGE_GEN_SOC_TYPE = $(call qstrip,$(BR2_PACKAGE_TI_K3_IMAGE_GEN_SOC_TYPE))
TI_K3_IMAGE_GEN_CONFIG = $(call qstrip,$(BR2_PACKAGE_TI_K3_IMAGE_GEN_CONFIG))

# This hash comes from the Makefile in ti-k3-image-gen and corresponds to
# FW from Git tag 08.06.00.007
TI_K3_SYSFW_VERSION = 2944354aca1f95525c30d625cb17672930e72572
TI_K3_SYSFW_SITE = https://git.ti.com/processor-firmware/ti-linux-firmware/blobs/raw/$(TI_K3_SYSFW_VERSION)/ti-sysfw
ifeq ($(TI_K3_IMAGE_GEN_SOC_TYPE),gp)
TI_K3_SYSFW_SOURCE = \
	$(TI_K3_IMAGE_GEN_FW_TYPE)-firmware-$(TI_K3_IMAGE_GEN_SOC)-$(TI_K3_IMAGE_GEN_SOC_TYPE).bin
else
TI_K3_SYSFW_SOURCE = \
	$(TI_K3_IMAGE_GEN_FW_TYPE)-firmware-$(TI_K3_IMAGE_GEN_SOC)-$(TI_K3_IMAGE_GEN_SOC_TYPE)-cert.bin \
	$(TI_K3_IMAGE_GEN_FW_TYPE)-firmware-$(TI_K3_IMAGE_GEN_SOC)-$(TI_K3_IMAGE_GEN_SOC_TYPE)-enc.bin
endif
TI_K3_IMAGE_GEN_EXTRA_DOWNLOADS = $(patsubst %,$(TI_K3_SYSFW_SITE)/%,$(TI_K3_SYSFW_SOURCE))

define TI_K3_SYSFW_COPY
	$(foreach f,$(TI_K3_SYSFW_SOURCE), \
		cp $(TI_K3_IMAGE_GEN_DL_DIR)/$(f) $(@D)$(sep))
endef
TI_K3_IMAGE_GEN_POST_EXTRACT_HOOKS += TI_K3_SYSFW_COPY

# The ti-k3-image-gen makefiles seem to need some feature from Make v4.0,
# similar to u-boot. Explicitly use $(BR2_MAKE) here, as the build
# otherwise fails with some misleading error message.
TI_K3_IMAGE_GEN_MAKE = $(BR2_MAKE)
TI_K3_IMAGE_GEN_MAKE_OPTS = \
	SOC=$(TI_K3_IMAGE_GEN_SOC) \
	SOC_TYPE=$(TI_K3_IMAGE_GEN_SOC_TYPE) \
	CONFIG=$(TI_K3_IMAGE_GEN_CONFIG) \
	CROSS_COMPILE=$(HOST_DIR)/bin/arm-none-eabi- \
	SBL=$(BINARIES_DIR)/r5-u-boot-spl.bin \
	O=$(@D)/tmp \
	BIN_DIR=$(@D) \
	TI_SECURE_DEV_PKG=$(HOST_TI_K3_SECDEV_DIR) \
	SYSFW_GIT_HASH=2944354aca1f95525c30d625cb17672930e72572

define TI_K3_IMAGE_GEN_BUILD_CMDS
	$(TI_K3_IMAGE_GEN_MAKE) -C $(@D) $(TI_K3_IMAGE_GEN_MAKE_OPTS)
endef

define TI_K3_IMAGE_GEN_INSTALL_IMAGES_CMDS
	cp $(@D)/tiboot3.bin $(BINARIES_DIR)
endef

$(eval $(generic-package))
