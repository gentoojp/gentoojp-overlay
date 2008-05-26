# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

IUSE=""

MY_P=${P/-/}

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://plum.madoka.org/plum.html"
SRC_URI="ftp://ftp.madoka.org/pub/plum/${MY_P}.tar.gz"

# The author says it is distributed under GPL2
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	cd ${S}
	perl -pi -e 's:/bin/perl:/usr/bin/perl: ; \
		s:\$1/module:/usr/lib/plum/module: ; \
		s:\./module:/usr/lib/plum/module:' plum
}

src_install() {
	exeinto /usr/bin
	doexe plum

	dodir /usr/lib/plum
	cp -a module support ${D}/usr/lib/plum

	dodoc plum-*.conf

	dohtml doc/*.html
}
