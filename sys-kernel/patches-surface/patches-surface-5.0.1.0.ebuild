# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel patch ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"
LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="${PV%.*}/${PV##*.}"
SRC_URI="https://git.neverserio.us/proj/kpatches/snapshot/kpatches-surface-${PV}.tar.gz"
S="${WORKDIR}"

src_install() {
    FINAL="${D}/usr/share/${PN}/${PN}-${PV%.*}"
    mkdir -p "${FINAL}"
    cd "${S}/kpatches-surface-${PV}/"
    cp *.patch "${FINAL}/"
    return
}

