# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmuim/wmuim-0.2.4.ebuild,v 1.5 2005/06/18 02:34:26 tom Exp $

inherit eutils

IUSE=""

DESCRIPTION="wmuim is a toolbar application for uim"
SRC_URI="http://osdn.dl.sourceforge.jp/wmuim/14305/${P}.tar.gz"
HOMEPAGE="http://wmuim.sourceforge.jp/index.en.shtml"

DEPEND="virtual/x11"
RDEPEND="app-i18n/uim
	sys-libs/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {

	unpack ${A}
	cd ${S}

}

src_compile() {

	`libtoolize --copy --force || die`
	econf MY_CFLAGS="${CFLAGS}" || die "Configuration failed"
	emake prefix="/usr/" || die "Compilation failed"

}

src_install() {

	einstall || die "Installation failed"
	dodoc COPYING ChangeLog README TODO
	prepallman

	insinto /usr/share/applications

}
