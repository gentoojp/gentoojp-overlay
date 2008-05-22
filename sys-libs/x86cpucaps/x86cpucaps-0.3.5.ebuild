# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="x86cpucaps is a library, which investigates the various information on CPU using 'cpuid' in assembler."

HOMEPAGE="http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#x86cpucaps"

SRC_URI="http://members.jcom.home.ne.jp/jacobi/linux/files/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {

	make || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README* COPYING
}
