# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic

MY_P="${P/_p/-}"
DESCRIPTION="TOMOYO Linux tools"
HOMEPAGE="http://www.sourcefoge.jp/projects/tomoyo/"
SRC_URI="mirror://sourceforge.jp/tomoyo/27220/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/ncurses
	sys-libs/readline"

S="${WORKDIR}/ccstools/"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i \
		-e "/^INSTALLDIR/cINSTALLDIR = ${D}" \
		-e "/^CFLAGS/D" \
		Makefile || die
}

src_compile() {
	CFLAGS="${CFLAGS} -Wall -Wno-pointer-sign"
	strip-unsupported-flags
	emake || die
}

src_install() {
	emake install || die
}
