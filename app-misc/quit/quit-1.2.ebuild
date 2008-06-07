# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="2 chenel version of SL"
HOMEPAGE="http://matsu-www.is.titech.ac.jp/~fukuchi/rooms/shortshort/"
SRC_URI="http://matsu-www.is.titech.ac.jp/~fukuchi/archive/misc/${PN}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cjk"

DEPEND="sys-libs/ncurses"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	use cjk && sed -i -e '9s/#//' Makefile
}

src_install() {
	dobin quit

	insinto /usr/share/man/ja/man1
	doins quit.1
}
