# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Ming/Ruby is a Ruby extensional library for Ming"
HOMEPAGE="http://mingruby.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/1765/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.6.7
	media-libs/ming"

src_compile() {
	ruby setup.rb config --prefix=/usr || die
	ruby setup.rb setup || die
}

src_install() {
	ruby setup.rb install --prefix=${D} || die
	dodoc ChangeLog README.en README.ja Usage_en.txt Usage_ja.txt \
	fonts.en fonts.ja
}
