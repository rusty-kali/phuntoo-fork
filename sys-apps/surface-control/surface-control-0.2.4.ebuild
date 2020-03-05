# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	ansi_term-0.11.0
	atty-0.2.13
	backtrace-0.3.37
	backtrace-sys-0.1.31
	bitflags-1.1.0
	cc-1.0.45
	cfg-if-0.1.9
	clap-2.33.0
	failure-0.1.5
	failure_derive-0.1.5
	indoc-0.3.4
	indoc-impl-0.3.4
	libc-0.2.62
	nix-0.15.0
	proc-macro-hack-0.5.9
	proc-macro2-0.4.30
	proc-macro2-1.0.3
	quote-0.6.13
	quote-1.0.2
	rustc-demangle-0.1.16
	strsim-0.8.0
	syn-0.15.44
	syn-1.0.5
	synstructure-0.10.2
	textwrap-0.11.0
	unicode-width-0.1.6
	unicode-xid-0.1.0
	unicode-xid-0.2.0
	unindent-0.1.4
	vec_map-0.8.1
	void-1.0.2
	winapi-0.3.8
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo bash-completion-r1

DESCRIPTION="Control various aspects of Microsoft Surface devices."

HOMEPAGE="https://github.com/qzed/linux-surface-control"
LICENSE="MIT"
KEYWORDS="-* amd64"
SLOT="0"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/qzed/linux-${PN}/archive/v${PV}.tar.gz
"

S="${WORKDIR}/${P}"
IUSE="bash-completion"
#RESTRICT="network-sandbox"

DEPEND="
	>=virtual/rust-1.34.0
"

src_compile() {
	#cd "${S}"/src
	CARGO_TARGET_DIR="${S}/target" CARGO_INCREMENTAL=0 cargo_src_compile
	strip --strip-all "${S}/target/release/surface"
}

src_install() {
	use bash-completion &&
		newbashcomp target/surface.bash surface
	dosbin "${S}/target/release/surface"
}
