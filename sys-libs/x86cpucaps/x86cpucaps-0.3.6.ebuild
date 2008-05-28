# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="x86cpucaps is a library, which investigates the various information on CPU using 'cpuid' in assembler."

HOMEPAGE="http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#x86cpucaps"

SRC_URI="http://members.jcom.home.ne.jp/jacobi/linux/files/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/libc"

src_compile() {

	make CC="${CC}" CFLAGS="${CFLAGS}" all || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README* COPYING
}
