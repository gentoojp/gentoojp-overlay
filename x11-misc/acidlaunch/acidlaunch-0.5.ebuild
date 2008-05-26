# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="a small, light-weight app launcher with a simple XML-based configuration syntax"

HOMEPAGE="http://linuxgamers.net/infoPage.php?page=acidlaunch"
SRC_URI="http://freshmeat.net/redir/acidlaunch/18807/url_tgz/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.9
	>=dev-libs/libxml2-2.1.0"

#RDEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
