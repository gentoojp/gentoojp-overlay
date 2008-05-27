# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

IUSE=""

MY_P="${P/0*_pre}"

DESCRIPTION="equerybts -- command line bugzilla query tool"
HOMEPAGE="http://dev.gentoo.org/~hattya/equerybts/"
SRC_URI="http://dev.gentoo.org/~hattya/${PN}/${MY_P}.tar.bz2"

RESTRICT="nomirror"
LICENSE="MIT"
KEYWORDS="~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/python-2.1"

src_compile() {

	sed -i -e '32,33d' ${PN}

}

src_install() {

	dobin ${PN}

	python_version
	PYM_DIR="/usr/lib/python${PYVER}/site-packages"

	dodir ${PYM_DIR}
	mv lib/${PN} ${D}/${PYM_DIR}

}
