################################################################################
#
# ti-k3-secdev
#
################################################################################

TI_K3_SECDEV_VERSION = ed6951fd3877c6cac7f1237311f7278ac21634f3
TI_K3_SECDEV_SITE = https://git.ti.com/cgit/security-development-tools/core-secdev-k3/snapshot
TI_K3_SECDEV_SOURCE = core-secdev-k3-$(TI_K3_SECDEV_VERSION).tar.gz
TI_K3_SECDEV_INSTALL_STAGING = NO
TI_K3_SECDEV_INSTALL_TARGET = NO
TI_K3_SECDEV_LICENSE = BSD-3-Clause

UBOOT_MAKE_OPTS += TI_SECURE_DEV_PKG=$(HOST_TI_K3_SECDEV_DIR)

$(eval $(host-generic-package))
