# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel sleep script ebuilds for Surface Devices on Gentoo"

HOMEPAGE="https://github.com/qzed/linux-surface"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="0"
COMMIT="aee8e310e0e1ff34762ef1f0ffe606b912df152d"
SRC_URI="https://raw.githubusercontent.com/qzed/linux-surface/${COMMIT}/root/lib/systemd/system-sleep/sleep -> ${PN}-${PVR}"
IUSE="systemd"
FINAL="/lib/systemd/system-sleep"
RDEPEND="systemd? ( sys-apps/systemd )"

src_unpack() {
	mkdir -p "${S}" || die "Failed to create ${S}"
	cp "${DISTDIR}/${PN}-${PVR}" "${S}"/
}

src_install() {
	mv "${WORKDIR}/${PN}-${PVR}/${PN}-${PVR}" "${WORKDIR}/${PN}-${PVR}/surface-sleep"
	dosbin surface-sleep
	if use systemd; then
		dosym /usr/sbin/surface-sleep "${FINAL}/sleep"
	fi
}
