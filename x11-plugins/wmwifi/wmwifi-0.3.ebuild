# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

IUSE=""

DESCRIPTION="Wireless Monitor for Window Maker"
SRC_URI="http://digitalssg.net/debian/${P}.tar.gz"
HOMEPAGE="http://wmwifi.digitalssg.net/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	virtual/x11"

src_compile() {
	econf || die "configure failed"

	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS README ChangeLog INSTALL NEWS COPYING
}
