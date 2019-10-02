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
COMMIT="2c9455dbc7feb1e44e29d486a587a34eef9347b0"
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

src_prepare() {
	# Enable gentoo systemd and module shit
	KOPTION="CONFIG_GENTOO_LINUX_INIT_SYSTEMD"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_MODULE_COMPRESS"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_MODULE_COMPRESS_XZ"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi

	# Enable the following kernel options as y instead of modules
	KOPTION="CONFIG_HID"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_UHID"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_HID_GENERIC"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_USB"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_KEYBOARD_ATKBD"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_USB_OHCI_HCD_PCI"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi

	# Enable SELinux stuff
	KOPTION="CONFIG_AUDIT"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_AUDITSYSCALL"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_AUDIT_WATCH"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_AUDIT_TREE"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_SECURITY_NETWORK"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_LSM_MMAP_MIN_ADDR"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=65536" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=65536/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=65536/" ${KCONFIG}; fi
	KOPTION="CONFIG_SECURITY_SELINUX"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_SECURITY_SELINUX_DEVELOP"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_SECURITY_SELINUX_AVC_STATS"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG}; then echo "${KOPTION}=0" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=0/" ${KCONFIG}; sed -i -e "s/# ${KOPTION} is not set/${KOPTION}=0/" ${KCONFIG}; fi
	KOPTION="CONFIG_INTEGRITY_AUDIT"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi

	# Fix bug where ext4 is missing crc32c module from initramfs
	KOPTION="CONFIG_EXT4_FS"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
	KOPTION="CONFIG_CRYPTO_CRC32C"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi

	if use surface; then
		KOPTION="CONFIG_INTEL_IPTS"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_INTEL_IPTS_SURFACE"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_BOOK2_DGPU_HPS"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_DRM_I915_ALPHA_SUPPORT"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
		KOPTION="CONFIG_INTEL_ATOMISP2_PM"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_IPU3_CIO2"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_IPU3_IMGU"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_OV5693"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_OV8865"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_SAN"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_SSH"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_VHF"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_DTX"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_SID"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_3_POWER_OPREGION"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_PCIEPORTBUS"; sed -ie "s/${KOPTION}=.*/\# ${KOPTION} is not set/" ${KCONFIG}
	fi

	sed -i -e "s/CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION=\"\"/" "${KCONFIG}"
	eapply_user
}

src_install() {
	insopts -m 0644
	insinto "${FINAL}"
	newins "${S}/${PN}-${PVR}" config
}
