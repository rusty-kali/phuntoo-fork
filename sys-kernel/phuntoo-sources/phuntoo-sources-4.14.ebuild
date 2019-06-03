# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel image ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE="surface"
SLOT="${PVR}"

RDEPEND="
	surface? (
		=sys-kernel/phuntoo-config-${PV}*[surface]
		=sys-kernel/surface-patches-${PV}*
	)
	!surface? (
		=sys-kernel/phuntoo-config-${PV}*[-surface]
	)
	=sys-kernel/gentoo-sources-${PV}*
"