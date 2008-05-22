# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpuyopuyo/xpuyopuyo-0.9.8.ebuild,v 1.4 2005/05/19 10:58:11 okayama Exp $

DESCRIPTION="xpuyopuyo - A tetris-like puzzle game for X11"
HOMEPAGE="http://chaos2.org/xpuyopuyo/"
SRC_URI="http://chaos2.org/xpuyopuyo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="gnome mikmod"

DEPEND="virtual/libc
	virtual/x11
	=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	gnome? ( gnome-base/gnome-libs
		=dev-libs/glib-1.2* )"

S=${WORKDIR}/${P}

src_compile() {

	econf \
		$(use_with mikmod libmikmod) \
		$(use_with gnome) || die "econf failed"

	emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D} install || die "installation failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
