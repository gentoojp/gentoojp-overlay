# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/cocot/cocot-20041220.ebuild,v 1.1 2006/08/28 14:46:09 okayama Exp $

DESCRIPTION="COde COnverter on Tty"
HOMEPAGE="http://iwa.ath.cx/software/cygwin/cocot.html"
SRC_URI="http://iwa.ath.cx/software/cygwin/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/libiconv"

src_compile() {

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {

	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog* INSTALL NEWS README* UNICODE_MEMO
}
