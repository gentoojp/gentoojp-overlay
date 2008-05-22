# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="10"
K_SECURITY_UNSUPPORTED="1"

inherit eutils kernel-2
detect_version
detect_arch

CCS_TGP="ccs-patch-1.5.0-20070920"
CCS_LSM_TGP="tomoyo-lsm-2.1.0-20071111"
CCS_TGP_SRC="mirror://sourceforge.jp/tomoyo/27219/${CCS_TGP}.tar.gz "
CCS_LSM_TGP_SRC="mirror://sourceforge.jp/tomoyo/28120/${CCS_LSM_TGP}.tar.gz"
CCS_PATCH_VER="2.6.23-rc7"

DESCRIPTION="TOMOYO Linux sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CCS_TGP_SRC} ${CCS_LSM_TGP_SRC}"
KEYWORDS="~x86"
IUSE="lsm ${IUSE}"

src_unpack() {
	kernel-2_src_unpack

	if use lsm;then
		cd "${WORKDIR}"
		unpack ${CCS_LSM_TGP}.tar.gz

		cd "${S}"
		epatch "${WORKDIR}"/patches/*.diff
		cp -ax linux-${OKV}/security . || die
		rm -r linux-${OKV} || die
	else
		cd "${WORKDIR}"
		unpack ${CCS_TGP}.tar.gz
		cp -ax fs include "${S}" || die
		sed -i -e '1,12d' ccs-patch-${CCS_PATCH_VER}.txt || die

		cd "${S}"
		epatch "${WORKDIR}"/ccs-patch-${CCS_PATCH_VER}.txt || die
	fi
}
