# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DESCRIPTION="Kernel ebuilds for Microsoft Surface Devices"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="${PV}"

DEPEND="sys-kernel/linux-image:${PV}[surface]"