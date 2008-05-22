# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="9"
IUSE="ultra1"
inherit kernel-2 eutils
detect_version
detect_arch

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches"
UC_FONT="vd_unicon-kernel-fonts-20040205.patch.bz2"

DESCRIPTION="Full sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	 http://vdlinux.sourceforge.jp/dists/UNICON/${UC_FONT}"

pkg_setup() {
	if use sparc; then
		# hme lockup hack on ultra1
		use ultra1 || UNIPATCH_EXCLUDE="${UNIPATCH_EXCLUDE} 1705_sparc-U1-hme-lockup.patch"
	fi
}

src_unpack() {
	kernel-2_src_unpack
	cd ${S}
	EPATCH_SUFFIX="bz2" EPATCH_OPTS="-p1" EPATCH_FORCE="yes" \
	epatch ${DISTDIR}/${UC_FONT} || die "epatch failed"
	epatch ${FILESDIR}/${P}-r7-unicon.patch.bz2 || die "epatch failed"
}

pkg_postinst() {
	postinst_sources

	echo

	if [ "${ARCH}" = "sparc" ]; then
		if [ x"`cat /proc/openprom/name 2>/dev/null`" \
			 = x"'SUNW,Ultra-1'" ]; then
			einfo "For users with an Enterprise model Ultra 1 using the HME"
			einfo "network interface, please emerge the kernel using the"
			einfo "following command: USE=ultra1 emerge ${PN}"
		fi
	fi
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
