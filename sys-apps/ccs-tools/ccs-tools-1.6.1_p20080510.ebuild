# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs flag-o-matic

MY_P="${P/_p/-}"

DESCRIPTION="TOMOYO Linux tools"
HOMEPAGE="http://www.sourcefoge.jp/projects/tomoyo/"
SRC_URI="mirror://sourceforge.jp/tomoyo/30298/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline"

S="${WORKDIR}/ccstools/"

src_compile() {
	CFLAGS="${CFLAGS} -Wall -Wno-pointer-sign"
	strip-unsupported-flags
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake INSTALLDIR="${D}" install || die "emake install failed"
	dodoc README.ccs
}
