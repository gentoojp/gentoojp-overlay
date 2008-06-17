# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A full-featured and high-performance event loop"
HOMEPAGE="http://software.schmorp.de/pkg/libev.html"
SRC_URI="http://dist.schmorp.de/${PN}/${P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable force appending of -O3 flag
	sed -i -e 's/CFLAGS=.*-O3.*/true/' configure
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Changes README
}
