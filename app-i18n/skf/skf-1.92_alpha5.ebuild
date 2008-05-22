# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-i18n/nkf/nkf-2.0.4.ebuild,v 1.3 2004/03/05 17:28:58 nakano Exp $

MY_P="${P/_alpha/a}"
DESCRIPTION="skf is an i18n-capable kanji filter"
HOMEPAGE="http://www.sourceforge.jp/projects/skf/"
SRC_URI="mirror://sourceforge.jp/skf/7391/${MY_P/-/_}.tar.gz"

DEPEND="virtual/glibc"
KEYWORDS="~x86"
IUSE=""
LICENSE="as-is"
SLOT="0"

S=${WORKDIR}/${MY_P}

src_compile() {
	make \
		DESTDIR=/usr \
		CFLAGS="${CFLAGS} \$(SKFDEFINES)" || die
}

src_install () {
	dodir /usr/bin
	make \
		DESTDIR="${D}/usr" \
		DOCDIR="${D}/usr/share/doc/${PF}" \
		install || die
}
