# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit eutils
DESCRIPTION="quickml - An easy-to-use mailing list system"
HOMEPAGE="http://namazu.org/~satoru/quickml/"
SRC_URI="http://namazu.org/~satoru/quickml/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/mta
	>=dev-lang/ruby-1.8.1"

src_compile() {
	epatch ${FILESDIR}/makefile.patch
	econf --with-pidfile=/var/log/quickml.pid \
	--with-logfile=/var/log/quickml.log --with-user=quickml --with-group=quickml || die
	emake || die
}

src_install() {
	enewgroup quickml 126
	enewuser quickml 126 /bin/false /var/lib/quickml quickml
	make install DESTDIR=${D}
}
