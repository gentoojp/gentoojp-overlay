# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A utility for switching the LCD and external VGA displays on and off"
HOMEPAGE="http://sourceforge.net/projects/i855crt"
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/i855crt/i855crt-0.4.tar.gz
          http://keihanna.dl.sourceforge.net/sourceforge/i855crt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="sys-apps/pciutils"

src_compile() {
	emake || die "compile failed"
}

src_install() {
	dobin i855crt
}
