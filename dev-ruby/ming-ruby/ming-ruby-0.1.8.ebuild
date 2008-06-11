# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Ming/Ruby is a Ruby extensional library for Ming"
HOMEPAGE="http://mingruby.rubyforge.org"
SRC_URI="http://rubyforge.org/frs/download.php/15678/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8
	>=media-libs/ming-0.3"

src_compile() {
	ruby setup.rb config --prefix=/usr || die "configure failed"
	ruby setup.rb setup || die "compile failed"
}

src_install() {
	ruby setup.rb install --prefix="${D}" || die "installation failed"
	dodoc ChangeLog README.en README.ja
}
