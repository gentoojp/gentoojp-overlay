# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

DESCRIPTION="A library for guessing character encoding"
HOMEPAGE="http://www.cc.rim.or.jp/~yaz/patch.html"
SRC_URI="http://www.cc.rim.or.jp/~yaz/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/libc"

src_install() {
	dodir /usr/lib
	dodir /usr/include
	make DEST="${D}/usr" install || die
}
