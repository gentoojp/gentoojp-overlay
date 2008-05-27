# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit distutils

MY_P=pykf/${P}
S=${WORKDIR}/${P}
DESCRIPTION="Python Codecs for Japanese Language Encodings like EUC, Shift-JIS, ISO-2022"
SRC_URI="http://www.gembook.jp/html/download/${P}.tgz"
HOMEPAGE="http://www.gembook.jp/tsum/page.pys?wiki=PyKf"

IUSE=""
SLOT="0"
LICENSE="Japanese Kanji filter module"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-1.6
		dev-python/japanesecodecs"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins readme.sjis
	insinto /usr/share/doc/${PF}/test
	doins test/*
	insinto /usr/share/doc/${PF}/misc
	doins misc/*.txt
}
