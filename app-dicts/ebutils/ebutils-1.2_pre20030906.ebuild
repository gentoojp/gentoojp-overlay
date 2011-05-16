# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P=${P/_pre/pre-}

DESCRIPTION="Utility for EPWING Ditionaries"
HOMEPAGE="http://ebsnap.lkj.jp/"
SRC_URI="http://ebsnap.lkj.jp/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

S="${WORKDIR}/${P/_pre*/pre/}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-getline.patch" || die
}

src_install() {
	dobin bookinfo
	dobin catdump
	dobin squeeze

	doman bookinfo.1
	doman catdump.1
	doman squeeze.1
}
