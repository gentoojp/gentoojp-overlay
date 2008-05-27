# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE="cjk"

DESCRIPTION="2 chenel version of SL"
HOMEPAGE="http://matsu-www.is.titech.ac.jp/~fukuchi/rooms/shortshort/"
SRC_URI="http://matsu-www.is.titech.ac.jp/~fukuchi/archive/misc/${PN}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"

S="${WORKDIR}/${PN}"

DEPEND="virtual/libc
	sys-libs/ncurses"

src_compile() {

	if [ "`use cjk`" ]
	then
		sed -e '9s/#//' Makefile > Makefile.tmp
		rm -f Makefile
		mv Makefile.tmp Makefile
	fi

	emake || die

}

src_install() {

	exeinto /usr/bin
	doexe quit

	insinto /usr/share/man/ja/man1
	doins quit.1

}
