# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module eutils

IUSE=""

DESCRIPTION="FreeType library for Perl"
SRC_URI="http://www.io.com/~kazushi/xtt/${P}.tar.gz"
HOMEPAGE="http://www.io.com/~kazushi/xtt/"

DEPEND="dev-lang/perl
	=media-libs/freetype-1*"
RDEPEND="${DEPEND}
	dev-perl/jcode_pl"

KEYWORDS="~x86 ~alpha"
LICENSE="BSD"
SLOT=0

S="${WORKDIR}/${P}"

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/perlftlib-${PV}-gentoo.patch
}

src_compile(){
	emake || die
}

src_install(){
	dodir /usr/bin
	export myinst="DESTDIR=${D} PREFIX=${D}/usr"
	perl-module_src_install || die

	dodir /usr/share/man/man1
	cp ${D}/usr/bin/mkttfdir ${D}/usr/share/man/man1/mkttfdir.1
	cp ${D}/usr/bin/ftinfo   ${D}/usr/share/man/man1/ftinfo.1

	dodoc COPYING
	newdoc FreeType/COPYING COPYING.FT.xs
}
