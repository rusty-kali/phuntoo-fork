# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Kernel config ebuilds for Gentoo"

HOMEPAGE="https://git.neverserio.us/proj/phuntoo-config"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
SLOT="${PV%.*}"
SRC_URI="https://git.neverserio.us/proj/${PN}/snapshot/${PN}-${PV}.tar.gz"
IUSE="surface"
FINAL="${D}/usr/share/${PN}/${PN}-${SLOT}"
KCONFIG="${WORKDIR}/${PN}-${PV}/config"

src_install() {
	mkdir -p "${FINAL}"
	if use surface; then
		KOPTION="CONFIG_INTEL_IPTS"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_DRM_I915_ALPHA_SUPPORT"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
		KOPTION="CONFIG_INTEL_ATOMISP2_PM"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=y/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_IPU3_CIO2"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_OV5693"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_VIDEO_OV8865"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_SAN"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_SSH"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_ACPI_VHF"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=y" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=y/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_SURFACE_3_POWER_OPREGION"; if ! grep -sq "${KOPTION}=" ${KCONFIG} && ! grep -sq "${KOPTION} is not set" ${KCONFIG} ; then echo "${KOPTION}=m" >> "${KCONFIG}"; else sed -i -e "s/${KOPTION}=.*/${KOPTION}=m/" ${KCONFIG}; sed -i -e "s/\# ${KOPTION} is not set/${KOPTION}=m/" ${KCONFIG}; fi
		KOPTION="CONFIG_PCIEPORTBUS"; sed -ie "s/${KOPTION}=.*/\# ${KOPTION} is not set/" ${KCONFIG}
	fi
	sed -i -e "s/CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION=\"\"/" "${KCONFIG}"
	cp "${KCONFIG}" "${FINAL}/"
	return
}
