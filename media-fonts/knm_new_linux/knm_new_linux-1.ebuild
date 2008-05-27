# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="kanamecho fonts for UNIX"
HOMEPAGE="http://unknown.example.org/"
SRC_URI="ftp://ftp.FreeBSD.org/pub/FreeBSD/distfiles/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${RDEPEND}"

S="${WORKDIR}"
FONT_SUFFIX="pcf.gz"
FONT_S="${WORKDIR}/fonts"
DOCS="fonts/readme fonts/changes fonts/gtkrc.sample"

pkg_postinst() {
	einfo "In X environment, you need add the following line to"
	einfo "Files section in /etc/X11/xorg.conf"
	einfo "FontPath     \"/usr/share/fonts/${PN}/\""
	einfo "For terminal use, try something like"
	einfo "-mnkaname-fixed-medium-r-normal-*-12-*-*-*-*-*-jisx0208.1983-*;"
	einfo "in .mlterm/font or .Xdefaults"
}

