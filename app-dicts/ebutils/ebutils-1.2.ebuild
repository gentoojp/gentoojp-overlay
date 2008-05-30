# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Utility for EPWING Ditionaries"
HOMEPAGE="http://ebsnap.lkj.jp/"
SRC_URI="http://ebsnap.lkj.jp/ebutils-1.2pre-20030906.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

src_compile () {
	cd "${WORKDIR}"/ebutils-1.2pre || die
	econf
	emake
}

src_install() {
	cd "${WORKDIR}"/ebutils-1.2pre || die

	dobin bookinfo
	dobin catdump
	dobin squeeze

	doman bookinfo.1
	doman catdump.1
	doman squeeze.1
}
