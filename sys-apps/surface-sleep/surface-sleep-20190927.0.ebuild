# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel sleep script ebuilds for Surface Devices on Gentoo"

HOMEPAGE="https://git.neverserio.us/proj/surface-sleep/"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="0"
SRC_URI="https://git.neverserio.us/proj/${PN}/snapshot/${PN}-${PV}.tar.gz"
IUSE="systemd"
FINAL="${D}/lib/systemd/system-sleep/"
RDEPEND="systemd? ( sys-apps/systemd )"
src_install() {
	mkdir -p "${FINAL}" || die
	mv "${WORKDIR}/${PN}-${PV}/sleep" "${WORKDIR}/${PN}-${PV}/surface-sleep"
	dosbin surface-sleep
	if use systemd; then
		ln -sf /usr/sbin/surface-sleep "${FINAL}/sleep"
	fi
}