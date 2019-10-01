# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	ansi_term-0.11.0
	arc-swap-0.4.2
	arrayref-0.3.5
	arrayvec-0.4.11
	atty-0.2.13
	autocfg-0.1.6
	backtrace-0.3.37
	backtrace-sys-0.1.31
	base64-0.10.1
	bitflags-1.1.0
	blake2b_simd-0.5.8
	byteorder-1.3.2
	bytes-0.4.12
	cc-1.0.45
	cfg-if-0.1.9
	chrono-0.4.9
	clap-2.33.0
	cloudabi-0.0.3
	constant_time_eq-0.1.4
	crossbeam-deque-0.7.1
	crossbeam-epoch-0.7.2
	crossbeam-queue-0.1.2
	crossbeam-utils-0.6.6
	dbus-0.6.5
	dbus-tokio-0.3.0
	dirs-1.0.5
	failure-0.1.5
	failure_derive-0.1.5
	fnv-1.0.6
	fuchsia-cprng-0.1.1
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	futures-0.1.29
	iovec-0.1.2
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	libc-0.2.62
	libdbus-sys-0.2.1
	lock_api-0.1.5
	log-0.3.9
	log-0.4.8
	memoffset-0.5.1
	mio-0.6.19
	mio-named-pipes-0.1.6
	mio-uds-0.6.7
	miow-0.2.1
	miow-0.3.3
	net2-0.2.33
	nix-0.15.0
	nodrop-0.1.13
	num-integer-0.1.41
	num-traits-0.2.8
	num_cpus-1.10.1
	owning_ref-0.4.0
	parking_lot-0.7.1
	parking_lot_core-0.4.0
	pkg-config-0.3.16
	proc-macro2-0.4.30
	proc-macro2-1.0.3
	quote-0.6.13
	quote-1.0.2
	rand-0.6.5
	rand_chacha-0.1.1
	rand_core-0.3.1
	rand_core-0.4.2
	rand_hc-0.1.0
	rand_isaac-0.1.1
	rand_jitter-0.1.4
	rand_os-0.1.3
	rand_pcg-0.1.2
	rand_xorshift-0.1.1
	rdrand-0.4.0
	redox_syscall-0.1.56
	redox_users-0.3.1
	rust-argon2-0.5.1
	rustc-demangle-0.1.16
	rustc_version-0.2.3
	scopeguard-0.3.3
	scopeguard-1.0.0
	semver-0.9.0
	semver-parser-0.7.0
	serde-1.0.100
	serde_derive-1.0.100
	signal-hook-0.1.10
	signal-hook-registry-1.1.1
	slab-0.4.2
	slog-2.5.2
	slog-term-2.4.1
	smallvec-0.6.10
	socket2-0.3.11
	stable_deref_trait-1.1.1
	strsim-0.8.0
	syn-0.15.44
	syn-1.0.5
	synstructure-0.10.2
	term-0.5.2
	textwrap-0.11.0
	thread_local-0.3.6
	time-0.1.42
	tokio-0.1.22
	tokio-codec-0.1.1
	tokio-current-thread-0.1.6
	tokio-executor-0.1.8
	tokio-file-unix-0.5.1
	tokio-fs-0.1.6
	tokio-io-0.1.12
	tokio-process-0.2.4
	tokio-reactor-0.1.9
	tokio-signal-0.2.7
	tokio-sync-0.1.6
	tokio-tcp-0.1.3
	tokio-threadpool-0.1.15
	tokio-timer-0.2.11
	tokio-udp-0.1.5
	tokio-uds-0.2.5
	toml-0.5.3
	unicode-width-0.1.6
	unicode-xid-0.1.0
	unicode-xid-0.2.0
	vec_map-0.8.1
	void-1.0.2
	winapi-0.2.8
	winapi-0.3.8
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	ws2_32-sys-0.2.1
"

inherit cargo bash-completion-r1 systemd udev

DESCRIPTION="Control various aspects of Microsoft Surface devices."

HOMEPAGE="https://github.com/qzed/linux-surface-control"
LICENSE="MIT"
KEYWORDS="-* ~amd64"
SLOT="0"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
	https://github.com/qzed/linux-${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

S="${WORKDIR}/linux-${P}"
IUSE="bash-completion systemd udev"

DEPEND="
	>=virtual/rust-1.34.0
	>=virtual/cargo-1.34.0
"
RDEPEND="
	sys-apps/dbus
	systemd? ( sys-apps/systemd )
	udev? ( virtual/udev )
"

src_compile() {
	CARGO_TARGET_DIR="${S}/target" CARGO_INCREMENTAL=0 cargo_src_compile
	strip --strip-all "${S}/target/release/surface-dtx-daemon"
	strip --strip-all "${S}/target/release/surface-dtx-userd"
}

src_install() {
	# Install binaries
	dobin "${S}/target/release/surface-dtx-daemon"
	dobin "${S}/target/release/surface-dtx-userd"

	# Install config files
	insopts -m 0644
	insinto /etc/surface-dtx
	doins "${S}"/etc/dtx/surface-dtx-daemon.conf
	doins "${S}"/etc/dtx/surface-dtx-userd.conf
	insopts -m 0755
	doins "${S}"/etc/dtx/attach.sh
	doins "${S}"/etc/dtx/detach.sh

	# Use flag dependent stuff.
	if use systemd; then
		systemd_dounit "${S}"/etc/systemd/surface-dtx-daemon.service
		systemd_douserunit "${S}"/etc/systemd/surface-dtx-userd.service
	fi
	cp "${S}"/etc/dbus/org.surface.dtx.conf "${D}"/etc/dbus-1/system.d/org.surface.dtx.conf
	if use bash-completion; then
		newbashcomp "${S}"/target/surface-dtx-daemon.bash surface-dtx-daemon
		newbashcomp "${S}"/target/surface-dtx-userd.bash surface-dtx-userd
	fi
	use udev && udev_dorules "${S}"/etc/udev/40-surface_dtx.rules
}
