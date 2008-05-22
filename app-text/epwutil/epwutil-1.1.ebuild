# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="EPWUTIL, squeeze and more utility for EPWING."
HOMEPAGE="http://openlab.ring.gr.jp/edict/"
SRC_URI="http://openlab.jp/edict/epwutil/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~arm ~hppa"
IUSE="doc"

src_compile(){
	ln -s makefile.unx makefile &&
	emake || die
}

src_install(){
	dobin bookinfo catdump squeeze || die

	if use doc; then
		dodoc README *.man || die
	fi
}
