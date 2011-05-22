# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python chasen module"
HOMEPAGE="http://www.domen.cx/yusei/pub/"
SRC_URI="http://www.domen.cx/yusei/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/chasen"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	distutils_src_install

	dodoc README
	insinto /usr/share/doc/${PF}/test
	doins example.py
}

