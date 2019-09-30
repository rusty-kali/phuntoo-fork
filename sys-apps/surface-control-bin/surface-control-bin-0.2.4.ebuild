# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

DESCRIPTION="Control various aspects of Microsoft Surface devices."

HOMEPAGE="https://github.com/qzed/linux-surface-control"
LICENSE="MIT"
KEYWORDS="-* ~amd64"
SLOT="0"
PNAME=${PN%-*}
SRC_URI="https://github.com/qzed/linux-${PNAME}/releases/download/v${PV}/${PNAME}-${PV}-x86_64.bin.tar.xz"
IUSE="bash-completion"
S="${WORKDIR}"

src_install() {
	use bash-completion &&
		newbashcomp shell-completions/surface.bash surface
	dosbin "bin/surface"
}
