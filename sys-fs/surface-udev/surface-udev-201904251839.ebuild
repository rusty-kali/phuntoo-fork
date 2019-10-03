# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Udev rule ebuilds for Surface Devices on Gentoo"

HOMEPAGE="https://github.com/qzed/linux-surface"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="0"
UPSTREAM="linux-surface"
COMMIT="51d4546450322576ca633a22346265d2c0f5d780"
SRC_URI="https://github.com/qzed/${UPSTREAM}/archive/${COMMIT}.zip -> ${PN}-${PVR}.zip"
FINAL="/etc/udev"
RDEPEND="virtual/udev"
S="${WORKDIR}/${UPSTREAM}-${COMMIT}"

src_install() {
	insopts -m 0644
	insinto	"${FINAL}"
	doins -r "${S}/root/etc/udev/rules.d"
}
