EAPI=6

DESCRIPTION="Automatic Gentoo Kernel Upgrades"
HOMEPAGE="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/"
LICENSE="GPL-3"
SLOT="0"
IUSE="dracut genkernel grub"


if [[ ${PV} == *9999 ]]; then
	VERSION="master"
else
	KEYWORDS="~amd64"
	VERSION="${PV}"
fi

SRC_URI_SUFFIX="tar.gz"
SRC_URI="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/snapshot/kcompile-${VERSION}.${SRC_URI_SUFFIX}"

DEPEND="sys-apps/kmod[lzma]
	net-misc/curl
	app-admin/eclean-kernel
	dracut? ( sys-kernel/dracut )
	genkernel? ( || ( sys-kernel/genkernel sys-kernel/genkernel-next ) )
	grub? ( sys-boot/grub )"

src_unpack() {
	default
	mv ${PN}-*/ ${P}
}

src_prepare() {
	default
}

src_install() {
	dosbin kcompile
	doman kcompile.8
}
