# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel image ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE="surface systemd dbus"
SLOT="${PV}"

RDEPEND="
	surface? (
		=sys-kernel/phuntoo-config-${PV}*[surface]
		|| (
			=sys-kernel/surface-patches-${PV}*
			<sys-kernel/surface-patches-1.1
		)
		sys-kernel/surface-firmware
		sys-apps/surface-control
		sys-kernel/linux-firmware
		systemd? (
			sys-apps/surface-sleep[systemd]
		)
		!systemd? (
			sys-apps/surface-sleep[-systemd]
		)
		dbus? ( sys-apps/dbus )
	)
	!surface? (
		=sys-kernel/phuntoo-config-${PV}*[-surface]
	)
	=sys-kernel/gentoo-sources-${PV}*
"
