# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DESCRIPTION="Kernel ebuilds for Microsoft Surface Devices"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
SLOT="0"
IUSE="dracut genkernel grub"

DEPEND="sys-apps/kmod[lzma]
	dracut? ( sys-kernel/dracut )
	genkernel? ( || ( sys-kernel/genkernel sys-kernel/genkernel-next ) )
	grub? ( sys-boot/grub )
    sys-firmware/intel-microcode
    =sys-kernel/linux-image:${PV}[surface]"


# These dependencies should pull in a working compiled/installed kernel.  The next steps
#   stage a system to boot with specified kernel.
