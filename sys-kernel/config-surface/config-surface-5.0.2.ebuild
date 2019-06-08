# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel config ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"
LICENSE="GPL-2"
KEYWORDS=""
SLOT="${PV%.*}/${PV##*.}"
SRC_URI="https://git.neverserio.us/proj/kconfig/snapshot/k${PN}-${PV}.tar.gz"
S="${WORKDIR}"

src_install() {
    FINAL="${D}/usr/share/${PN}/${PN}-${PV%.*}"
    mkdir -p "${FINAL}"
    cp "${S}/k${PN}-${PV}/config" "${FINAL}/"
    return
}
