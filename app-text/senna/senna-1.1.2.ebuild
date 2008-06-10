# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Full text search engine with support for various languages and DBs"
HOMEPAGE="http://qwik.jp/senna/"
SRC_URI="mirror://sourceforge.jp/${PN}/29884/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mecab ruby unicode" #TODO python php"

DEPEND="mecab? ( >=app-text/mecab-0.81 )
	ruby? ( virtual/ruby )"

src_compile() {
	local myconf
	use unicode && myconf="--with-encoding=utf8"

	econf \
		$(use_with mecab) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
	use ruby && emake -j1 ruby-bindings || die "emake ruby-bindings failed"
}

src_install() {
	make install-strip DESTDIR="${D}" || die "make install failed"
	use ruby && make install-ruby-bindings DESTDIR="${D}"
	dodoc ChangeLog NEWS doc/*
}
