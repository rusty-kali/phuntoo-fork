# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DESCRIPTION="Automatic Gentoo Kernel Upgrades"

HOMEPAGE="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/"

LICENSE="GPL-2"
SLOT="0"
IUSE="dracut genkernel grub"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="git://git.neverserio.us/proj/${PN}"
	EGIT_BRANCH="development"
else
	KEYWORDS="~amd64"
	SRC_URI_SUFFIX="tar.gz"
	SRC_URI="https://git.neverserio.us/proj/${PN}/snapshot/${P}.${SRC_URI_SUFFIX}"
fi

RDEPEND="sys-apps/kmod[lzma]
	net-misc/curl
	app-admin/eclean-kernel
	app-portage/gentoolkit
	dracut? ( sys-kernel/dracut )
	genkernel? ( || ( sys-kernel/genkernel sys-kernel/genkernel-next ) )
	grub? ( sys-boot/grub )"

src_prepare() {
	default
	if [[ ${PV} == 9999 ]]; then
		sed -i "s/@VERSION@/$(git describe --tags | sed 's/v*//')-$(git rev-parse --short HEAD)/" kcompile.8
	else
		sed -i "s/@VERSION@/${PV}/" kcompile.8
	fi
}

src_install() {
	dosbin kcompile
	doman kcompile.8
}
