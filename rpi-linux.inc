DESCRIPTION = "Linux 3.1.9 Kernel"
HOMEPAGE = "N/A"
LICENSE = "GPL-2.0"


SRC_URI += "git://github.com/raspberrypi/linux.git;protocol=git;${SRC_REV}"
SRC_REV ?= "tag=${PV}"
RECIPE_USE_kernel_defconfig ?= "bcmrpi_defconfig"
RECIPE_USE_kernel_imagetype ?= "uImage"

S = "${SRCDIR}/linux"

DEFAULT_PREFERENCE ?= "4"
