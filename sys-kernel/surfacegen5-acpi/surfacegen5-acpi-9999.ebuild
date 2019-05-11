# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Linux ACPI/Platform Drivers for 5th Gen. Surface Devices"

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
	BUILD_TARGETS="gentoo-install"
	BUILD_PARAMS="INCLUDEDIR=/lib/modules/${KV_FULL}/build/include KERN_DIR=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} KVERSION=${KV_FULL}"
}

src_compile() {
	echo -e "gentoo-install:" >> ./module/Makefile
	echo -e "\tmake -C ${KV_DIR} M=${S}/module modules" >> ./module/Makefile
	linux-mod_src_compile
	default
}

src_install() {
	linux-mod_src_install
	dosbin "${S}/scripts/sysfs_rqst.py"
}
