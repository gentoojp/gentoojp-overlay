# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="5"
K_SECURITY_UNSUPPORTED="1"

inherit eutils kernel-2
detect_version
detect_arch

TOMOYO_TGP="ccs-patch-1.6.1-20080510"
TOMOYO_LSM_TGP="tomoyo-lsm-2.1.1-20071123"
TOMOYO_TGP_SRC="mirror://sourceforge.jp/tomoyo/30297/${TOMOYO_TGP}.tar.gz "
TOMOYO_LSM_TGP_SRC="mirror://sourceforge.jp/tomoyo/28120/${TOMOYO_LSM_TGP}.tar.gz"
TOMOYO_TARGET="2.6.25"

DESCRIPTION="TOMOYO Linux sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://tomoyo.sourceforge.jp/"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TOMOYO_TGP_SRC} ${TOMOYO_LSM_TGP_SRC}"

KEYWORDS="~amd64 ~x86"
IUSE="lsm ${IUSE}"

RDEPEND="sys-apps/ccs-tools"

K_EXTRAEINFO="Before booting with TOMOYO enabled kernel, you need to
run this command to initialize TOMOYO policies:
# /usr/lib/ccs/init_policy.sh"

src_unpack() {
	kernel-2_src_unpack

	if use lsm;then
		cd "${WORKDIR}"
		unpack ${TOMOYO_LSM_TGP}.tar.gz

		cd "${S}"
		epatch "${WORKDIR}"/patches/*.diff
		cp -ax linux-${OKV}/security . || die
		rm -r linux-${OKV} || die
	else
		cd "${WORKDIR}"
		unpack ${TOMOYO_TGP}.tar.gz
		cp -ax fs include "${S}" || die
		# delete a hunk modifying EXTRAVERSION of Makefile
		sed -i -e '45,55d' patches/ccs-patch-${TOMOYO_TARGET}.diff || die

		cd "${S}"
		epatch "${WORKDIR}"/patches/ccs-patch-${TOMOYO_TARGET}.diff || die
		epatch "${FILESDIR}/ccs-patch-2.6.25-include-fix.diff" || die
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
		elog  "See also http://tomoyo.sourceforge.jp/wiki/?TOMOYO-LSM#wca94f00"
		elog  "for differencies between LSM(tomoyo-2) and tomoyo-1."
	fi
}
