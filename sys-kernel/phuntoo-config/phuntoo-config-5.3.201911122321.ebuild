# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
LICENSE="GPL-2"
KEYWORDS="-* ~amd64"
HOMEPAGE="https://www.phuntoo.org/overlay"
DESCRIPTION="Kernel config ebuilds for Gentoo"
IUSE="surface"

# Target specific commit for this package. We don't care about their upstream versioning.
ARCHPACKAGE="linux"
COMMIT="5e1a24286849801b5f2723c16abf265140cd33eb"
SRC_URI="https://git.archlinux.org/svntogit/packages.git/plain/trunk/config?h=packages/${ARCHPACKAGE}&id=${COMMIT} -> ${PN}-${PVR}"

# We want one slot per kernel tree, eg: x.y.
# Updates within each kernel tree will overwrite
# the previous version in slot.
SLOT="$(ver_cut 1-2)"

# Specify output directory to place patches for kcompile to pick up, as well as configfile source path.
FINAL="/usr/share/${PN}/${PN}-${SLOT}"
KCONFIG="${S}/${PN}-${PVR}"

src_unpack() {
	mkdir -p "${S}" || die "Failed to create ${S}"
	cp "${DISTDIR}/${PN}-${PVR}" "${S}"/
}

# A very special THANK YOU to nemesus for helping to streamline
# the src_prepare() function.  I couldn't have done it without you.

src_prepare() {
	OPTIONS=(
		# Enable gentoo systemd and module shit
		CONFIG_GENTOO_LINUX_INIT_SYSTEMD=y
		CONFIG_MODULE_COMPRESS=y
		CONFIG_MODULE_COMPRESS_XZ=y
		CONFIG_LOCALVERSION='""'

		# Enable the following kernel options as y instead of modules
		CONFIG_HID=y
		CONFIG_UHID=y
		CONFIG_HID_GENERIC=y
		CONFIG_USB=y
		CONFIG_KEYBOARD_ATKBD=y
		CONFIG_USB_OHCI_HCD_PCI=y

		# Enable SELinux stuff
		CONFIG_AUDIT=y
		CONFIG_AUDITSYSCALL=y
		CONFIG_AUDIT_WATCH=y
		CONFIG_AUDIT_TREE=y
		CONFIG_SECURITY_NETWORK=y
		CONFIG_LSM_MMAP_MIN_ADDR=65536
		CONFIG_SECURITY_SELINUX=y
		CONFIG_SECURITY_SELINUX_DEVELOP=y
		CONFIG_SECURITY_SELINUX_AVC_STATS=y
		CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=0
		CONFIG_INTEGRITY_AUDIT=y

		# Fix bug where ext4 is missing crc32c module from initramfs
		CONFIG_EXT4_FS=y
		CONFIG_CRYPTO_CRC32C=y
	)

	if use surface; then
		OPTIONS=( ${OPTIONS[@]}
		CONFIG_INTEL_IPTS=m
		CONFIG_INTEL_IPTS_SURFACE=m
		CONFIG_SURFACE_BOOK2_DGPU_HPS=m
		CONFIG_DRM_I915_ALPHA_SUPPORT=y
		CONFIG_INTEL_ATOMISP2_PM=y
		CONFIG_VIDEO_IPU3_CIO2=m
		CONFIG_VIDEO_IPU3_IMGU=m
		CONFIG_VIDEO_OV5693=m
		CONFIG_VIDEO_OV8865=m
		CONFIG_SURFACE_ACPI=m
		CONFIG_SURFACE_ACPI_SAN=y
		CONFIG_SURFACE_ACPI_SSH=y
		CONFIG_SURFACE_ACPI_VHF=y
		CONFIG_SURFACE_ACPI_DTX=y
		CONFIG_SURFACE_ACPI_SID=y
		CONFIG_SURFACE_3_POWER_OPREGION=m
		CONFIG_PCIEPORTBUS=
		)
	fi

	cat "${KCONFIG}" | (
		shopt -s extglob
		FILTER=${OPTIONS[@]//=*}
		FILTER="@(${FILTER// /|})"
		while read line; do
			OPTION=${line//=*}
			OPTION=${OPTION//# }
			OPTION=${OPTION// is not*}
			case "${OPTION}" in
				${FILTER})
					for (( idx=0; idx < ${#OPTIONS[@]}; ++idx )); do
						NAME="${OPTIONS[$idx]//=*}"
						VALUE="${OPTIONS[$idx]//*=}"
						if test "${OPTION}" = "${NAME}"; then
							if test -z "${VALUE}"; then
								einfo "Setting # ${NAME} is not set"
								echo "# ${NAME} is not set"
							else
								einfo "Setting ${NAME}=${VALUE}"
								echo "${NAME}=${VALUE}"
							fi
							OPTIONS[$idx]=""
							break
						fi
					done
					;;
				*)
					echo $line
					;;
			esac
		done
		OPTIONS=( ${OPTIONS[@]} )
		for (( idx=0; idx < ${#OPTIONS[@]}; ++idx )); do
			NAME="${OPTIONS[$idx]//=*}"
			VALUE="${OPTIONS[$idx]//*=}"
			if test -z "${VALUE}"; then
				einfo "# Adding ${NAME} is not set"
				echo "# ${NAME} is not set"
			else
				einfo "Adding ${NAME}=${VALUE}"
				echo "${NAME}=${VALUE}"
			fi
		done
	) > "${KCONFIG}.new" && mv "${KCONFIG}.new" "${KCONFIG}"
	eapply_user
}

src_install() {
	insopts -m 0644
	insinto "${FINAL}"
	newins "${S}/${PN}-${PVR}" config
}
