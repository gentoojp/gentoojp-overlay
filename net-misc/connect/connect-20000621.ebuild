# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Make socket connection using SOCKS4/5 and HTTP tunnel."
HOMEPAGE="http://www.taiyo.co.jp/~gotoh/ssh/connect.html"
SRC_URI="http://www.imasy.or.jp/~gotoh/ssh/connect.c"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} .
}

src_compile() {
	gcc connect.c -o connect
}

src_install() {
	dobin connect
}
