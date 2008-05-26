# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="g3data is used for extracting data from graphs"
HOMEPAGE="http://www.acclab.helsinki.fi/~frantz/software/g3data.php"
SRC_URI="http://www.acclab.helsinki.fi/~frantz/software/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X gtk2 imlib"

DEPEND=">=x11-libs/gtk+-2.0
		media-libs/imlib"

S=${WORKDIR}/${P}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	emake bindir=${D}/usr/bin mandir=${D}/usr/share/man install || die
}
