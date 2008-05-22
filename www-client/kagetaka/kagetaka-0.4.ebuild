# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/www-client/kagetaka/kagetaka-0.4.ebuild,v 1.2 2004/11/28 16:47:34 okayama Exp $

DESCRIPTION="KAGETAKA is a Web browser which displays text vertically."
HOMEPAGE="http://www.kagetaka.org/"
SRC_URI="mirror://sourceforge.jp/${PN}/12233/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=virtual/jre-1.1"

src_install() {

	dodoc COPYING ChangeLog* INSTALL* NEWS* README*
	rm    COPYING ChangeLog* INSTALL* NEWS* README*

	insinto /usr/lib/kagetaka
	doins -r ${S}/*

	dosym /usr/lib/kagetaka/docs /usr/share/doc/${PF}/html

	dodir /usr/bin
	dosym /usr/lib/kagetaka/bin/kagetaka.sh /usr/bin/kagetaka

	fperms 755 /usr/lib/kagetaka/bin/kagetaka.sh
	fperms 755 /usr/lib/kagetaka/jet/{build,run}_kagetaka.sh

	dosed "s:/usr/share/:/usr/lib/:" /usr/lib/kagetaka/bin/kagetaka.sh
}
