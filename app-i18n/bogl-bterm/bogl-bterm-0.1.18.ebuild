# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P/-bterm-/_}-1"
DESCRIPTION="A terminal program for displaying Unicode on the console"
HOMEPAGE="http://www.msu.edu/user/pfaffben/projects.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/b/bogl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN/-bterm}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README*
}
