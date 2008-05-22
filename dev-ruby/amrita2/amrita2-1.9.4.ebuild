# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Amrita2 is a xml/xhtml template library for Ruby."
HOMEPAGE="http://amrita2.rubyforge.org/"
# The URL depends implicitly on the version, unfortunately. Even if you
# change the filename on the end, it still downloads the same file.
SRC_URI="http://rubyforge.org/frs/download.php/3947/amrita2_050412.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/amrita2"

IUSE=""
DEPEND=">=dev-lang/ruby-1.8.2"

src_install() {
	local siteruby=$(ruby -r rbconfig -e 'print Config::CONFIG["sitedir"]')
	insinto ${siteruby}
	doins lib/amrita2.rb
	insinto ${siteruby}/amrita2
	doins lib/amrita2/*
	dodoc README*
	docinto docs
	dodoc docs/*
}
