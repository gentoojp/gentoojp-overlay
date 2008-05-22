# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="skf is an i18n-capable kanji filter"
HOMEPAGE="http://www.sourceforge.jp/projects/skf/"
SRC_URI="mirror://sourceforge.jp/skf/14646/${P/-/_}.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE="nls"
LICENSE="BSD"
SLOT="0"

DEPEND="virtual/libc
	sys-devel/bison"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '/INSTALL_DATA/s/LOCALEDIR/LOCALEJDIR/' Makefile.in || die
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install () {
	make DESTDIR=${D} DOCDIR=/usr/share/doc/${PF} install || die

	if use nls ; then
		make DESTDIR=${D} locale_install || die
	fi
}
