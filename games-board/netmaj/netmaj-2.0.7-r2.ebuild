# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="Network Mahjong Game"
HOMEPAGE="http://www.sfc.wide.ad.jp/~kusune/netmaj/"
SRC_URI="http://www.sfc.wide.ad.jp/~kusune/netmaj/files/${P}.tar.gz
	http://www.sfc.wide.ad.jp/~kusune/netmaj/files/${PN}-xui-${PV}.tar.gz
	http://www.geocities.co.jp/SiliconValley-PaloAlto/4984/knetmaj/kannetmaj1.0.6.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
	virtual/x11
	dev-lang/perl
	sys-libs/libtermcap-compat"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack ${PN}-xui-${PV}.tar.gz
	unpack kannetmaj1.0.6.tar.gz
}

src_compile() {

	epatch ${FILESDIR}/${P}.patch1
	epatch ${FILESDIR}/${P}.jg.patch
	epatch ${FILESDIR}/${P}-lib64.patch
	epatch ${FILESDIR}/${PN}-kondara.patch
	epatch ${FILESDIR}/${PN}-vararg.patch

	make || die
}

src_install () {
	mkdir -p ${D}/usr/games/lib

	make \
		LIBDIR=${D}/usr/games/lib/netmaj \
		BINDIR=${D}/usr/games/bin \
		install || die

	prepgamesdirs
}
