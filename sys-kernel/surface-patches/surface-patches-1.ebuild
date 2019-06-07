# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel patch ebuilds for Surface Devices on Gentoo"

HOMEPAGE="https://git.neverserio.us/proj/surface-patches/"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="${PV%.*}"
SRC_URI="https://git.neverserio.us/proj/${PN}/snapshot/${PN}-master.tar.gz"
FINAL="${D}/usr/share/${PN}/${PN}-${SLOT}"
RDEPEND="!!>sys/kernel/phuntoo-config-1-r0"

src_install() {
	mkdir -p "${FINAL}" || die
	cp "${WORKDIR}/${PN}-${PVR}/"*.patch "${FINAL}/" || die
}
