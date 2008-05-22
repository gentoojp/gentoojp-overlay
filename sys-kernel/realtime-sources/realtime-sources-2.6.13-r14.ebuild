# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.13_p1.ebuild,v 1.1 2005/08/31 16:52:34 marineam Exp $

UNIPATCH_STRICTORDER="yes"
ETYPE="sources"
K_WANT_GENPATCHES="base"
K_GENPATCHES_VER="5"
K_NOSETEXTRAVERSION="don't_set_it"
RESTRICT="nomirror"
inherit kernel-2 eutils
detect_version

RT_VERSION="rt14"
RT_SRC="patch-2.6.13-${RT_VERSION}"
RT_URI="http://people.redhat.com/mingo/realtime-preempt/older/${RT_SRC}"

SWAP_VERSION="15"
SWAP_SRC="vm-swap_prefetch-${SWAP_VERSION}.patch"
SWAP_URI="http://ck.kolivas.org/patches/swap-prefetch/${SWAP_SRC}"

KERN_V="2.6.13"
CK_V="ck7"
DCFQ_SRC="defaultcfq.diff"
DCFQ_URI="http://ck.kolivas.org/patches/2.6/${KERN_V}/${KERN_V}-${CK_V}/patches/${DCFQ_SRC}"

DESCRIPTION="Full sources for the Linux kernel with Ingo Molnar' high performance patchset and mm+ck patchset"
HOMEPAGE="http://people.redhat.com/mingo/realtime-preempt/"
SRC_URI="${KERNEL_URI} ${RT_URI} ${SWAP_URI} ${GENPATCHES_URI} ${DCFQ_URI}"

KEYWORDS="-* ~x86"

src_unpack() {
	kernel-2_src_unpack

	cd ${S}
	EPATCH_EXCLUDE="apply Changelog.txt unapply ToDo" \
	EPATCH_FORCE="yes" \
	EPATCH_SUFFIX="" \
	EPATCH_OPTS="-p1" \
	epatch ${DISTDIR}/${RT_SRC}
	epatch ${DISTDIR}/${SWAP_SRC}
	epatch ${DISTDIR}/${DCFQ_SRC}
}

pkg_postinst() {
	postinst_sources
}
