# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/-/_}
DESCRIPTION="skf is an i18n-capable kanji filter"
HOMEPAGE="http://www.sourceforge.jp/projects/skf/"
SRC_URI="mirror://sourceforge.jp/skf/10192/${MY_P}.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE=""
LICENSE="as-is"
SLOT="0"

DEPEND="virtual/libc"

S=${WORKDIR}/${P%.*}

src_compile() {
	make \
		DESTDIR=/usr \
		CFLAGS="${CFLAGS} \$(SKFDEFINES)" || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/ja

	make \
		DESTDIR="${D}/usr" \
		DOCDIR="${D}/usr/share/doc/${PF}" \
		install || die
}
