# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE="png tiff"

DESCRIPTION="ToICO converts PNG, GIF, TIFF, BMP and XPM files to Windows icon format (ICO)."

HOMEPAGE="http://wizard.ae.krakow.pl/~jb/toico/"
SRC_URI="http://wizard.ae.krakow.pl/~jb/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/libc
	sys-libs/zlib
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )"

src_compile() {

	emake || die
}

src_install() {

	dobin toico
	newman toico.man toico.1
}
