# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

IUSE=""

MY_P="pgPoint-${PV}"

DESCRIPTION="A Presentation tool using PyGame"
SRC_URI="http://gonypage.ddo.jp/pub/${MY_P}.tar.gz"
HOMEPAGE="http://gonypage.ddo.jp/wiki/hiki.cgi?PgPoint"

DEPEND="virtual/python
	dev-python/pygame
	media-libs/libsdl
	media-libs/sdl-ttf"

KEYWORDS="~x86 ~alpha"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile(){
	python_mod_compile pgPoint.py || die
}

src_install(){
	dodir /usr/lib/python${PYVER}/site-packages
	insinto /usr/lib/python${PYVER}/site-packages
	doins pgPoint.py{,c,o}

	dodir /usr/share/doc/${PF}/sample
	insinto /usr/share/doc/${PF}/sample
	doins sample.py logout.wav icon.bmp

	dodoc COPYING README
}
