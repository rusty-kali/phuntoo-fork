# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel patch ebuilds for Surface Devices on Gentoo."

HOMEPAGE="https://github.com/qzed/linux-surface"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="$(ver_cut 1-2)"
UPSTREAM="linux-surface"
COMMIT="master"
SRC_URI="https://github.com/qzed/${UPSTREAM}/archive/${COMMIT}.zip -> ${PN}-${PVR}.zip"
IUSE="systemd"
FINAL="/usr/share/${PN}/${PN}-${SLOT}"
S="${WORKDIR}/${UPSTREAM}-${COMMIT}"

src_install() {
	if [ ! -d "${S}/patches/${SLOT}" ]; then
		ewarn "Please beware, there are actually NO"
		ewarn "kernel patches for your surface device"
		ewarn "on this kernel. This is a dummy package"
		ewarn "to prevent dependency issues."
		mkdir -p "${S}/patches/${SLOT}"
		touch "${S}/patches/${SLOT}/dummy.patch"
	fi
	insopts -m 0644
	insinto "${FINAL}"
	doins "${S}/patches/${SLOT}"/*.patch
}
