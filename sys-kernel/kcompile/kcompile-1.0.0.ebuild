EAPI=6

DESCRIPTION="Automatic Gentoo Kernel Upgrades"
HOMEPAGE="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/"
LICENSE="GPL-2"
SLOT="0"

if [[ ${PV} == *9999 ]]; then
	SCM="git-r3"
	EGIT_REPO_URI="git://git.neverserio.us/proj/kcompile"
else
	SRC_URI_SUFFIX="tar.gz"
	SRC_URI="https://git.neverserio.us/cgi-bin/cgit.cgi/kcompile/snapshot/kcompile-${PV}.${SRC_URI_SUFFIX}"
	KEYWORDS="~amd64"

fi

src_prepare() {
	default
}

src_install() {
	dosbin kcompile
}
