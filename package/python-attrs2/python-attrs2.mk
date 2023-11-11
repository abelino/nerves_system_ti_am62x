################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS2_VERSION = 23.1.0
PYTHON_ATTRS2_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS2_SITE = https://files.pythonhosted.org/packages/97/90/81f95d5f705be17872843536b1868f351805acf6971251ff07c1b8334dbb
PYTHON_ATTRS2_SETUP_TYPE = pep517
PYTHON_ATTRS2_LICENSE = MIT
PYTHON_ATTRS2_LICENSE_FILES = LICENSE
PYTHON_ATTRS2_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs
HOST_PYTHON_ATTRS2_DEPENDENCIES = $(PYTHON_ATTRS2_DEPENDENCIES)

$(eval $(python-package))
$(eval $(host-python-package))
