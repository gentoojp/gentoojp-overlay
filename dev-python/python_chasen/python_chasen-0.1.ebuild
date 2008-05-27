# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
 
inherit distutils
  
MY_P=python_chasen
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python chasen module"
SRC_URI="http://www.domen.cx/yusei/pub/${P}.tar.gz"
HOMEPAGE="http://www.domen.cx/yusei/pub/"
   
IUSE=""
SLOT="0"
LICENSE="GPL2"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-1.6
		app-text/chasen"

src_unpack() {
    unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${P}-dest1.diff
}
	
src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins README
	insinto /usr/share/doc/${PF}/test
	doins example.py
}

