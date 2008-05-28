# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

S=${WORKDIR}/${P}
DESCRIPTION="JaMing is an improvement of Ming to display Japanese characters and to play sounds"
SRC_URI="http://blue.ribbon.to/~harpy/ming/jaming/${P}.tar.gz"
HOMEPAGE="http://blue.ribbon.to/~harpy/ming/jaming/index_en.html"

IUSE=""

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND="virtual/libc
	<=sys-devel/bison-1.35
	!media-libs/ming"

src_unpack() {
	unpack ${A}
	cd ${S}/util
	epatch ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile () {
	make CC="${CC} ${CFLAGS}" || die
	cd util
	make CC="${CC} ${CFLAGS}" bindump hexdump listswf listfdb listmp3 listjpeg \
makefdb swftophp || die
}

src_install () {
	make PREFIX=${D}/usr install || die
	exeinto /usr/lib/jaming
	doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp}
	dodoc CHANGES CREDITS LICENSE README TODO
	newdoc util/README README.util
	newdoc util/TODO TODO.util
}


