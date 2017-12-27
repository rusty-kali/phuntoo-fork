EAPI=6

DESCRIPTION="Automatic Gentoo Kernel Upgrades"
HOMEPAGE="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/"
LICENSE="GPL-2"
SLOT="0"
if [[ ${PV} == *9999 ]]; then
	VERSION="master"
else
	KEYWORDS="~amd64"
	VERSION="${PV}"
fi

SRC_URI_SUFFIX="tar.gz"
SRC_URI="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/snapshot/kcompile-${VERSION}.${SRC_URI_SUFFIX}"

DEPEND="sys-apps/kmod[lzma]"

src_unpack() {
	default
	mv ${PN}-*/ ${P}
}

src_prepare() {
	default
}

src_install() {
	dosbin kcompile
}
