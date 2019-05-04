# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Linux upstream longterm kernel ebuilds."

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="${PV}"

DEPEND="sys-kernel/linux-image:${PV}[longterm]"
