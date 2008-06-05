# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="DocDiff compares two text files and shows the difference by word or line."
HOMEPAGE="http://www.kt.rim.or.jp/~hisashim/docdiff"
SRC_URI="http://www.kt.rim.or.jp/~hisashim/docdiff/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-lang/ruby-1.8.4-r3
	dev-ruby/uconv"

src_install() {
	sitedir=$(/usr/bin/ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')

	dodir ${sitedir}
	cp -r docdiff "${D}"/${sitedir}

	dobin docdiff.rb
	dosym /usr/bin/docdiff.rb /usr/bin/docdiff
	dohtml *.html
	dodoc ChangeLog
}
