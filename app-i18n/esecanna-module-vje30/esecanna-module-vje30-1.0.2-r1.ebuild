# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="esecanna-module-vje30"

DESCRIPTION="Module for esecanna to use VJE-Delta."
HOMEPAGE="http://esecanna.netfort.gr.jp/"
SRC_URI="http://esecanna.netfort.gr.jp/${MY_PN}_${PV}.tar.gz"

S="${WORKDIR}/${MY_PN}_${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
app-i18n/esecanna"
RDEPEND="app-i18n/esecanna"

src_unpack() {

	unpack ${MY_PN}_${PV}.tar.gz || die
}

src_compile() {

	econf || die
	emake || die
}

src_install() {

	einstall || die

}



