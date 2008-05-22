# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="s"
HOMEPAGE="http://www.linux-nis.org/nis/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64 ~ia64"
RESTRICT="nomirror"

DEPEND="virtual/libc
net-nds/openldap"

src_compile() {
	econf ${myconf} || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
