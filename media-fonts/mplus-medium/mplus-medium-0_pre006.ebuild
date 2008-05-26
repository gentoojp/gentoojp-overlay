# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

MY_P="${PN}-${PV/0_pre/TESTFLIGHT-}"

DESCRIPTION="M+ Japanese outline fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/mplus-fonts/6650/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~amd64 ~ia64"

DEPEND="virtual/x11"

S="${WORKDIR}/${MY_P}"
FONTPATH="/usr/share/fonts/${PN}"

src_install() {

	insinto ${FONTPATH}
	doins ${PN}.ttf fonts.dir
	mkfontscale ${D}${FONTPATH}

	dodoc README_J INSTALL_J LICENSE*
}
