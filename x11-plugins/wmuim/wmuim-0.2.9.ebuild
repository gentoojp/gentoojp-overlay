# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit libtool

DESCRIPTION="wmuim is a toolbar application for uim"
HOMEPAGE="http://wmuim.sourceforge.jp/index.en.shtml"
SRC_URI="mirror://sourceforge.jp/wmuim/20546/${P}.tar.gz"

DEPEND="x11-libs/libX11
	app-i18n/uim
	virtual/libiconv"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc COPYING ChangeLog README TODO
}
