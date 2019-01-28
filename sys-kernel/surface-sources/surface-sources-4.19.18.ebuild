# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DESCRIPTION="Kernel ebuilds for Microsoft Surface Devices"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
SLOT="${PV}"

DEPEND="sys-apps/kmod[lzma]
    sys-firmware/intel-microcode
    sys-kernel/linux-image:${PV}[surface]"
