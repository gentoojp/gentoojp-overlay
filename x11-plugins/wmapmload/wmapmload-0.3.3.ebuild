# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""
DESCRIPTION="dockapp that monitors your apm battery status."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="virtual/x11"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"
}

src_install () {

	make install DESTDIR=${D} || die "make install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
}

