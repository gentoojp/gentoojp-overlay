# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

MY_P="${P/0*_pre}"

DESCRIPTION="equerybts -- command line bugzilla query tool"
HOMEPAGE="http://dev.gentoo.org/~hattya/equerybts/"
SRC_URI="http://dev.gentoo.org/~hattya/${PN}/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e '32,33d' ${PN}
}

src_install() {
	dobin ${PN} || die
	insinto "${EPREFIX}/$(python_get_sitedir)"
	doins lib/${PN} || die
}
