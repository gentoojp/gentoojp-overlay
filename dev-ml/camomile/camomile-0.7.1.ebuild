# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit findlib

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml."
HOMEPAGE="http://camomile.sourceforge.net/"
SRC_URI="mirror://sourceforge/camomile/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.09"

src_compile() {
	econf --prefix="/usr" || die
	emake -j1
}

src_install() {
	mkdir -p ${D}/usr/bin
	findlib_src_install BINDIR="${D}usr/bin/" DATADIR="${D}usr/share"
}
