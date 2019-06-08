# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel image ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/repo/phuntoo/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="${PV}"
IUSE="surface stable longterm"
REQUIRED_USE="^^ ( surface stable longterm )"

# Let's get a sane environment for work.
KERNELMAJOR=${PV%%.*}
CFGSLOT=${PV%.*}
UPSTREAMVERSION=${PV}

if [[ "$UPSTREAMVERSION" =~ *.0 ]]; then
    UPSTREAMVERSION="${CFGSLOT}"
fi

SRC_URI="https://cdn.kernel.org/pub/linux/kernel/v${KERNELMAJOR}.x/linux-${UPSTREAMVERSION}.tar.xz"

DEPEND="
    ||
        (
            surface? (
                sys-kernel/config-surface:${CFGSLOT}=
                sys-kernel/patches-surface:${UPSTREAMVERSION}=
            )
            stable? (
                sys-kernel/config-stable:${CFGSLOT}=
            )
            longterm? (
                sys-kernel/config-longterm:${CFGSLOT}=
            )
        )
        sys-apps/kmod[lzma]
                                virtual/libelf
                                sys-devel/bc
    "
src_unpack() {
    mkdir -p "${S}"
    default
}

src_prepare() {
    default
    mkdir -p "${S}/final/usr/src"
}
pkg_postinst() {
    einfo
    elog "You have just installed new kernel sources in /usr/src."
    elog "The sources have been fully configured using the Arch Linux"
    elog "kernel config. It is ready to be built and installed."
    elog "To make this process easier, see package sys-kernel/kcompile"
    elog "in this overlay."
    einfo
}

src_compile() {
    # xiaomiao special.
    unset ARCH

    cd "${WORKDIR}/linux-${PV}" || die
    make -s distclean || die
    if use surface; then
        LOCALVERSION="surface"
        for i in /usr/share/patches-surface/patches-surface-${PV}/*.patch; do eapply "$i"; done || die
    elif use stable; then
        LOCALVERSION="stable"
    elif use longterm; then
        LOCALVERSION="longterm"
    fi
    cp /usr/share/config-${LOCALVERSION}/config-${LOCALVERSION}-${CFGSLOT}/config .config || die
    KERNELNAME="${PV}-${LOCALVERSION}"
    make -s olddefconfig || die
    cp -R ./ "${S}/final/usr/src/linux-$KERNELNAME/" || die
}

src_install() {
    mv -T "${S}/final/" "${D}/" || die
    return
}
