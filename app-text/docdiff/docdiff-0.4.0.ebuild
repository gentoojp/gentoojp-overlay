# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng

DESCRIPTION="DocDiff compares two text files and shows the difference by word or line."
HOMEPAGE="http://docdiff.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

each_ruby_install() {
	newbin docdiff.rb docdiff
	doruby -r docdiff
}

all_ruby_install() {
	dodoc ChangeLog
	dohtml readme*.html
}

pkg_postinst() {
	if use ruby_targets_ruby18; then
		if ! use elibc_glibc && ! use elibc_uclibc; then
			elog "docdiff uses a ruby iconv ext in ruby 1.8"
			elog "make sure you install virtual/libiconv before installing ruby"
			elog "(no USE=iconv flag for dev-lang/ruby :( )"
		fi
	fi
}
