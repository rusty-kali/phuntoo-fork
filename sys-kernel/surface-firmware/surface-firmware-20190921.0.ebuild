# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Firmware ebuilds for Surface Devices on Gentoo"

HOMEPAGE="https://git.neverserio.us/proj/surface-firmware/"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="${PV%.*}"
SRC_URI="https://git.neverserio.us/proj/${PN}/snapshot/${PN}-${PV}.tar.gz"
FINAL="${D}/lib/"

src_install() {
	mkdir -p "${FINAL}" || die
	cp -vR "${WORKDIR}/${PN}-${PV}/firmware" "${FINAL}/" || die
}
