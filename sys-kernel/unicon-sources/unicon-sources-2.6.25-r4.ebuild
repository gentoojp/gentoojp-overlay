# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="5"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="UNICON + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches http://vdr.jp/d/unicon.html"

UNICON_FONTS="vd_unicon-kernel-fonts-20040205.patch.bz2"
UNICON_SRC="vd_unicon-kernel-20080418-2.6.25.patch"
UNIPATCH_LIST="${DISTDIR}/${UNICON_FONTS} ${DISTDIR}/${UNICON_SRC}"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	 http://vdlinux.sourceforge.jp/dists/UNICON/${UNICON_FONTS}
	 http://vdlinux.sourceforge.jp/dists/UNICON/${UNICON_SRC}"

KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	kernel-2_pkg_postinst
	elog "fbcondecor in gentoo patches not applied due to conflict with unicon"
}
