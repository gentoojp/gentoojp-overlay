# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Rast is a full-text search system."
HOMEPAGE="http://projects.netlab.jp/rast/"
SRC_URI="http://projects.netlab.jp/rast/archives/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="mecab unicode ruby"

DEPEND=">=dev-libs/apr-0.9.5
	>=sys-libs/db-4.2.52
	mecab? ( app-text/mecab )
	unicode? ( >=dev-libs/icu-2.8 )
	ruby? ( >=dev-lang/ruby-1.8.1 )"

S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}
