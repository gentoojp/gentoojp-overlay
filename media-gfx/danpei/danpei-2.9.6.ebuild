# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk+ based Image Viewer, works on X-Window system"
SRC_URI="mirror://sourceforge/danpei/${P}.tar.gz"
HOMEPAGE="http://danpei.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-1.2.6
	>=media-libs/libpng-1.0.3
	>=media-libs/gdk-pixbuf-0.8
	>=media-gfx/imagemagick-4.2.2
	virtual/x11"


src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install () {
	einstall || die "installation error"

	dodoc ChangeLog* A* COPYING INSTALL* README* FAQ NEWS TODO* misc/about_dot_danpei

}