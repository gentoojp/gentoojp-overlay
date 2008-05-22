# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="GVPE creates a virtual ethernet (broadcasts supported, any protocol
that works with a normal ethernet should work with GVPE) by creating encrypted
host-to-host tunnels between multiple endpoints."
HOMEPAGE="http://savannah.gnu.org/projects/gvpe"
SRC_URI="http://ftp.gnu.org/gnu/gvpe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf --enable-hmac-length=16 --enable-rand-length=8 --enable-digest=sha1 || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

