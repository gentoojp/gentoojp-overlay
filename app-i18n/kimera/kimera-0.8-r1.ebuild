# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit kde-functions
need-qt 3

IUSE=""

MY_P="${P/_}"
DESCRIPTION="A Japanese input method server which supports the XIM protocol"
SRC_URI="mirror://sourceforge.jp/kimera/15221/${MY_P}.tar.gz"
HOMEPAGE="http://kimera.sourceforge.jp/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"

DEPEND="=x11-libs/qt-3*"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	qmake "target.path=/usr/lib/${MY_P}" \
	      "script.path=/usr/bin" kimera.pro || die
	emake || die
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die
	dodoc AUTHORS COPYING INSTALL README
}

