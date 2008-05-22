# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Japanese Input Method Server for X Window System."
HOMEPAGE=""
SRC_URI="${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
	sj3"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-locale.patch
	epatch ${FILESDIR}/${P}-wcswidth.patch
	epatch ${FILESDIR}/${P}-bugs.patch
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	xmkmf -a
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install
	make DESTDIR=${D} install.man
}
