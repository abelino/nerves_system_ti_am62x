################################################################################
#
# ti-k3-r5-loader-next
#
################################################################################

TI_K3_R5_LOADER_NEXT_VERSION = 08.06.00.007
TI_K3_R5_LOADER_NEXT_SITE = https://git.ti.com/cgit/ti-u-boot/ti-u-boot/snapshot
TI_K3_R5_LOADER_NEXT_SOURCE = ti-u-boot-$(TI_K3_R5_LOADER_NEXT_VERSION).tar.gz
TI_K3_R5_LOADER_NEXT_LICENSE = GPL-2.0+
TI_K3_R5_LOADER_NEXT_LICENSE_FILES = Licenses/gpl-2.0.txt
TI_K3_R5_LOADER_NEXT_CPE_ID_VENDOR = denx
TI_K3_R5_LOADER_NEXT_CPE_ID_PRODUCT = u-boot
TI_K3_R5_LOADER_NEXT_INSTALL_IMAGES = YES
TI_K3_R5_LOADER_NEXT_DEPENDENCIES = \
	host-pkgconf \
	$(BR2_MAKE_HOST_DEPENDENCY) \
	host-arm-gnu-toolchain \
	host-openssl

TI_K3_R5_LOADER_NEXT_MAKE = $(BR2_MAKE)
TI_K3_R5_LOADER_NEXT_MAKE_ENV = $(TARGET_MAKE_ENV)
TI_K3_R5_LOADER_NEXT_KCONFIG_DEPENDENCIES = \
	host-arm-gnu-toolchain \
	$(BR2_MAKE_HOST_DEPENDENCY) \
	$(BR2_BISON_HOST_DEPENDENCY) \
	$(BR2_FLEX_HOST_DEPENDENCY)

TI_K3_R5_LOADER_NEXT_BOARD = $(call qstrip,$(BR2_PACKAGE_TI_K3_R5_LOADER_NEXT_BOARD_DEFCONFIG))
TI_K3_R5_LOADER_NEXT_KCONFIG_DEFCONFIG = $(TI_K3_R5_LOADER_NEXT_BOARD)_defconfig
TI_K3_R5_LOADER_NEXT_MAKE_OPTS = \
	CROSS_COMPILE=$(HOST_DIR)/bin/arm-none-eabi- \
	ARCH=arm \
	HOSTCC="$(HOSTCC) $(subst -I/,-isystem /,$(subst -I /,-isystem /,$(HOST_CFLAGS)))" \
	HOSTLDFLAGS="$(HOST_LDFLAGS)"

define TI_K3_R5_LOADER_NEXT_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(TI_K3_R5_LOADER_NEXT_MAKE) -C $(@D) $(TI_K3_R5_LOADER_NEXT_MAKE_OPTS)
endef

define TI_K3_R5_LOADER_NEXT_INSTALL_IMAGES_CMDS
	cp $(@D)/spl/u-boot-spl.bin $(BINARIES_DIR)/r5-u-boot-spl.bin
endef

$(eval $(kconfig-package))
