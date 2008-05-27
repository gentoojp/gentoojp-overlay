# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Full text search engine libraries included for compatibility with Any Applications"
HOMEPAGE="http://qwik.jp/senna/"
SRC_URI="http://dl.sourceforge.jp/senna/24191/senna-1.0.1.tar.gz"
S="${WORKDIR}/senna-1.0.1"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mecab"

DEPEND="mecab? ( app-text/mecab )"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	local myconf
	if ! use mecab; then
		myconf="--without-mecab"
	fi
	econf ${myconf} || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make install-strip DESTDIR=${D} || die
	dodoc ChangeLog NEWS README
}

