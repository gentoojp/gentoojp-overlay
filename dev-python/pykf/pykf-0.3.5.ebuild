# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python Codecs for Japanese Language Encodings like EUC, Shift-JIS, ISO-2022"
HOMEPAGE="http://sourceforge.jp/projects/pykf/ http://pypi.python.org/pypi/pykf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!dev-python/pykf-py21"
RDEPEND=""

src_install() {
	distutils_src_install

	dodoc readme.sjis
}
