# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Esecanna behaves like a cannaserver instead of VJE-Delta, Wnn or ATOK."
HOMEPAGE="http://esecanna.netfort.gr.jp/"
SRC_URI="http://esecanna.netfort.gr.jp/${PN}_${PV}.tar.gz"

S="${WORKDIR}/${PN}_${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${PN}_${PV}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-im-ja.patch
}

src_compile() {

	econf || die
	emake || die
}

src_install() {

	einstall || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/esecanna.initd esecanna || die
}

pkg_postinst() {

	ewarn ""
	ewarn " Now esecannaserver was installed."
	ewarn "You may need a module for use of vje25, vje30, Wnn6 or ATOK"
	ewarn "Make sure cannaserver process dosen't exist."
	ewarn "Then edit /etc/esecannarc and /etc/init.d/esecanna start."
	ewarn ""
}


