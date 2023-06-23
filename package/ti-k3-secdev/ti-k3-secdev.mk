################################################################################
#
# ti-k3-secdev
#
################################################################################

TI_K3_SECDEV_VERSION = 08.06.00.007
TI_K3_SECDEV_SITE = https://git.ti.com/cgit/security-development-tools/core-secdev-k3/snapshot
TI_K3_SECDEV_SOURCE = core-secdev-k3-$(TI_K3_SECDEV_VERSION).tar.gz
TI_K3_SECDEV_INSTALL_STAGING = NO
TI_K3_SECDEV_INSTALL_TARGET = NO
TI_K3_SECDEV_LICENSE = BSD-3-Clause

$(eval $(host-generic-package))
