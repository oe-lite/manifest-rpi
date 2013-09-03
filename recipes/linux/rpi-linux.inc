DESCRIPTION = "Linux Kernel"
HOMEPAGE = "N/A"
LICENSE = "GPL-2.0"


SRC_URI += "git://github.com/raspberrypi/linux.git;protocol=git;${SRC_REV}"
RECIPE_USE_kernel_defconfig ?= "bcmrpi_defconfig"
RECIPE_USE_kernel_imagetype ?= "Image"

S = "${SRCDIR}/linux"

DEFAULT_PREFERENCE ?= "14"
