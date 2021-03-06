# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel sleep script ebuilds for Surface Devices on Gentoo"

HOMEPAGE="https://github.com/qzed/linux-surface"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="0"
UPSTREAM="linux-surface"
COMMIT="289f9d67e36573cd5fe79936850e8a24ff482195"
SRC_URI="https://github.com/qzed/${UPSTREAM}/archive/${COMMIT}.zip -> ${PN}-${PVR}.zip"
FINAL="/lib"
S="${WORKDIR}/${UPSTREAM}-${COMMIT}"

src_install() {
	insopts -m 0644
	insinto "${FINAL}"
	doins -r "${S}/firmware"
}
