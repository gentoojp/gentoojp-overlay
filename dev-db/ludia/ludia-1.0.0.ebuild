# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Full text search add-on for postgresql"
HOMEPAGE="http://www.nttdata.co.jp/services/ludia/index.html"
SRC_URI="http://dl.sourceforge.jp/ludia/24230/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="mecab"

DEPEND="=app-text/senna-1.0.1
	>=dev-db/postgresql-8.1.8
	mecab? ( app-text/mecab )"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make install-strip DESTDIR=${D} || die
	dodoc ChangeLog NEWS README
}

pkg_postinst() {
	echo
	einfo "edit your postgresql.conf and"
        einfo "run command."
        einfo "$ psql -f /usr/share/postgresql/pgsenna2.sql <your db name>"
	echo
}
