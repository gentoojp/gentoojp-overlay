# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="ToICO converts PNG, GIF, TIFF, BMP and XPM files to Windows icon format (ICO)."
HOMEPAGE="http://wizard.ae.krakow.pl/~jb/toico/"
SRC_URI="http://wizard.ae.krakow.pl/~jb/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="media-libs/libpng
	media-libs/tiff"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/^CC =.*/CC = $(tc-getCC)/" \
		-e "s/^CFLAGS =.*/CFLAGS = ${CFLAGS}/" \
		-e "s/^LDFLAGS =.*/LDFLAGS = ${LDFLAGS}/" \
		Makefile || die "sed failed"
}

src_install() {
	dobin toico
	newman toico.man toico.1
}
