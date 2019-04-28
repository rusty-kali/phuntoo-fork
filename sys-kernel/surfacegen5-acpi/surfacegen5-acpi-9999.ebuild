# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Linux ACPI/Platform Drivers for 5th Gen. Surface Devices (Surface Book 2, Surface Pro 2017, Surface Laptop, and Newer)"

HOMEPAGE="https://github.com/qzed/linux-surfacegen5-acpi"

LICENSE="GPL-2"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/qzed/linux-surfacegen5-acpi"
	EGIT_BRANCH="master"
fi

DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

MODULE_NAMES="surfacegen5_acpi(acpi:${S}/module)"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_TARGETS="all"
}

src_compile() {
	linux-mod_src_compile
	default
}

src_install() {
	linux-mod_src_install
	dosbin ${S}/scripts/sysfs_rqst.py
}
