# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel config ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"
LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="${PV%.*}/${PV##*.}"
SRC_URI="https://git.neverserio.us/proj/kconfigs/snapshot/kconfigs-surface-${PV%-r*}.tar.gz"
S="${WORKDIR}"
echo ${D}

src_install() {
    FINAL="${D}/usr/share/${PN}/${PN}-${PV%.*}"
    mkdir -p "${FINAL}"
    cp "${S}/kconfigs-surface-${PV}/config" "${FINAL}/"
    return
}
