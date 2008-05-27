# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils ruby

USE_RUBY="ruby18 ruby19"
RUBY_ECONF="--with-ruby=${RUBY}"

DESCRIPTION="LangScan is a program analyzer for source code search engine."
HOMEPAGE="http://gonzui.sourceforge.net/langscan/"
SRC_URI="mirror://sourceforge/gonzui/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ocaml"

DEPEND=">=virtual/ruby-1.8.2
	ocaml? ( dev-lang/ocaml )"
