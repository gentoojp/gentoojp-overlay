# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A clean and simple implementation possible of the JPEG-2000 standard"

HOMEPAGE="http://www.j2000.org/"

SRC_URI="mirror://sourceforge/gaim-vv/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/libc"


src_compile() {

	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README
}
