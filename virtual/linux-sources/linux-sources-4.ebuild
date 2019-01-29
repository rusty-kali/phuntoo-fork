# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Virtual for Linux kernel sources"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86"
IUSE="firmware"

RDEPEND="
	firmware? ( sys-kernel/linux-firmware )
	|| (
        sys-kernel/surface-sources
        sys-kernel/stable-sources
        sys-kernel/longterm-sources
	)"
