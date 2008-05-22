# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P/_p/-}"
DESCRIPTION="TOMOYO Linux tools"
HOMEPAGE="http://www.sourcefoge.jp/projects/tomoyo/"
SRC_URI="mirror://sourceforge.jp/tomoyo/17468/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/ncurses
	sys-libs/readline"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i \
		-e "s/-O3/${CFLAGS}/g" \
		-e "/^all:/s/initrd-loop.img//" \
		Makefile || die
}

src_compile() {
	emake || die
}

src_install() {
	into /
	dosbin remount.exe makesyaoranconf.exe poled.exe poled_old.exe savepolicy
	dosbin ccs-auditd findtemp makelink dumplink makesymlink dumpsymlink
	dosbin syspol.exe setlevel
}
