# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_PN="PyUMLGraph"
DESCRIPTION="Python debugger that produces UML diagrams by inspecting running Python programs"
SRC_URI="http://adamfeuer.com/~adamf/software/PyUMLGraph/${MY_PN}-${PV}.tar.bz2"
HOMEPAGE="http://adamfeuer.com/~adamf/software/PyUMLGraph/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="virtual/python"

src_install() {
	distutils_src_install
	cd docs
	dohtml PyUMLGraph.css example1.png index.html simple.png
	insinto /usr/share/doc/${PF}
	doins example1.py simple.dot
}
