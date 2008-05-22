# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/x11-plugins/allin1/allin1-0.4.7.ebuild,v 1.1 2004/05/09 17:51:02 okayama Exp $

DESCRIPTION="All in one monitoring dockapp: RAM, CPU, Net, Power, df"
HOMEPAGE="http://ilpettegolo.altervista.org/en_linux_allin1.html"
SRC_URI="mirror://sourceforge/allinone/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/x11"

S=${WORKDIR}/${PN}

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -i "/ README /d" Makefile
}

src_compile() {

	make CC="${CC}" CFLAGS="${CFLAGS}" || die
}

src_install() {

	preplib /usr

	make install DEST_PATH=${D}/usr

	dodoc INSTALL COPYING README README.it TODO ChangeLog BUGS \
		allin1.spec src/allin1.conf.example
}
