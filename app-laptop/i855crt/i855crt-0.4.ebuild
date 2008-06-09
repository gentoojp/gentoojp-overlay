# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A utility for switching the LCD and external VGA displays on and off"
HOMEPAGE="http://sourceforge.net/projects/i855crt"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="sys-apps/pciutils"

src_install() {
	dobin i855crt
}
