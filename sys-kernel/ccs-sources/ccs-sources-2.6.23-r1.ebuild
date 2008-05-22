# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"
K_SECURITY_UNSUPPORTED="1"

inherit eutils kernel-2
detect_version
detect_arch

CCS_TGP="ccs-patch-1.5.3-20080131"
CCS_LSM_TGP="tomoyo-lsm-2.1.1-20071123"
CCS_TGP_SRC="mirror://sourceforge.jp/tomoyo/27219/${CCS_TGP}.tar.gz "
CCS_LSM_TGP_SRC="mirror://sourceforge.jp/tomoyo/28120/${CCS_LSM_TGP}.tar.gz"
CCS_PATCH_VER="2.6.23"

DESCRIPTION="TOMOYO Linux sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CCS_TGP_SRC} ${CCS_LSM_TGP_SRC}"
KEYWORDS="~x86 ~arm ~sh ~ppc ~ia64 ~hppa"
IUSE="lsm ${IUSE}"
RDEPEND="sys-apps/ccs-tools"

K_EXTRAEINFO="Before booting with TOMOYO enabled kernel, you need to
run this command to initialize TOMOYO policies:
# /usr/lib/ccs/init_policy.sh"

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
		sed -i -e '52,62d' patches/ccs-patch-${CCS_PATCH_VER}.diff || die

		cd "${S}"
		epatch "${WORKDIR}"/patches/ccs-patch-${CCS_PATCH_VER}.diff || die
	fi
}

pkg_postinst() {
	kernel-2_pkg_postinst

	if use lsm ;then
		ewarn
		ewarn "Please be aware that there is a window for AB-BA deadlock (see "
		ewarn "http://lkml.org/lkml/2007/11/5/388 for detail) in "
		ewarn "tomoyo-lsm-2.1.1-20071123"
		ewarn
	fi
}