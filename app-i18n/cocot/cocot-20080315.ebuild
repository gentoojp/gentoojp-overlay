# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="COde COnverter on Tty"
HOMEPAGE="http://vmi.jp/software/cygwin/cocot.html"
SRC_URI="http://vmi.jp/software/cygwin/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libiconv"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog* INSTALL NEWS README* UNICODE_MEMO
}
