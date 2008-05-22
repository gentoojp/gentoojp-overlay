# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Ming/Ruby is a Ruby extensional library for Ming"
HOMEPAGE="http://madscientist.jp/~ikegami/ruby/ming/"
SRC_URI="http://madscientist.jp/~ikegami/sources/ming-ruby-0.1.6.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="cjk"

DEPEND=">=dev-lang/ruby-1.6.7
	cjk? ( media-libs/jaming )
	!cjk? ( media-libs/ming )"

src_compile() {
	ruby setup.rb config --prefix=/usr || die
	ruby setup.rb setup || die
}

src_install() {
	ruby setup.rb install --prefix=${D} || die
	dodoc ChangeLog README.en README.ja Usage_en.txt Usage_ja.txt \
fonts.en fonts.ja
}
