# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${PN}-core-${PV}"
DESCRIPTION="Mining Utilities and System Architecture for Scalable processing of Historical data"
HOMEPAGE="http://musashien.sourceforge.net/"
SRC_URI="mirror://sourceforge.jp/musashi/8248/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libxml2"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
