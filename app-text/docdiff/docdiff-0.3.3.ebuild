# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="DocDiff compares two text files and shows the difference."
SRC_URI="http://www.kt.rim.or.jp/~hisashim/docdiff/${P}.tar.gz"
HOMEPAGE="http://www.kt.rim.or.jp/~hisashim/docdiff"
LICENSE="BSD"
DEPEND="dev-lang/ruby"
KEYWORDS="~x86"

src_compile() {
	emake || die
}

src_install() {
	sitedir=$(/usr/bin/ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')

	dodir ${sitedir}
	cp -r docdiff ${D}/${sitedir}

	dobin docdiff.rb
	dosym /usr/bin/docdiff.rb /usr/bin/docdiff
	dohtml *.html
	dodoc ChangeLog
}
