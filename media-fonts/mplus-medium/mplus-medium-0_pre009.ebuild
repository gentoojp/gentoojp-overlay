# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

IUSE=""

MY_P="mplus-${PV/0_pre/TESTFLIGHT-}"

DESCRIPTION="M+ Japanese outline fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/mplus-fonts/6650/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11"

S="${WORKDIR}/${MY_P}"
FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="INSTALL_J LICENSE* README_J BITSTREAM_COPYRIGHT"


