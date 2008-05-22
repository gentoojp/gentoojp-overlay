# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="1"

inherit eutils kernel-2
detect_version
detect_arch

TGP="ccs-patch-1.0-20051111"
TGP_SRC="mirror://sourceforge.jp/tomoyo/17467/${TGP}.tar.gz"
DESCRIPTION="TOMOYO Linux sources for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${TGP_SRC} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="~x86"

src_unpack() {
	kernel-2_src_unpack

	cd "${WORKDIR}"
	unpack ${TGP}.tar.gz
	cp -ax fs include "${S}" || die
	sed -i -e '1,12d' ccs-patch-${OKV}.txt || die

	cd "${S}"
	epatch "${WORKDIR}"/ccs-patch-${OKV}.txt
}
