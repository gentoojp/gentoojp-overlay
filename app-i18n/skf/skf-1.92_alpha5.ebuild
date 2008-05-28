# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P/_alpha/a}"
DESCRIPTION="skf is an i18n-capable kanji filter"
HOMEPAGE="http://www.sourceforge.jp/projects/skf/"
SRC_URI="mirror://sourceforge.jp/skf/7391/${MY_P/-/_}.tar.gz"

DEPEND="virtual/libc"
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
