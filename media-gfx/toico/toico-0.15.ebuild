# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="ToICO converts PNG, GIF, TIFF, BMP and XPM files to Windows icon format (ICO)."

HOMEPAGE="http://wizard.ae.krakow.pl/~jb/toico/"

SRC_URI="http://wizard.ae.krakow.pl/~jb/${PN}/${P}.tar.gz"

LICENSE="freedist"

SLOT="0"

KEYWORDS="~x86 ~alpha"

IUSE="gif png tiff"

DEPEND="virtual/glibc
	gif? ( media-libs/libungif )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )"

S=${WORKDIR}/${P}

src_compile() {

	local myconf="`use_enable gif` `use_enable png` `use_enable tiff`"

	econf ${myconf} || die

	emake || die
}

src_install() {

	dobin toico
	doman toico.1
}
