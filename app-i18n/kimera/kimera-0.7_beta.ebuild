# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde-functions
need-qt 3

IUSE=""

MY_P="${P/_}"
DESCRIPTION="A Japanese input server which supports the XIM protocol"
SRC_URI="mirror://sourceforge.jp/kimera/5546/${MY_P}.tar.gz"
HOMEPAGE="http://kimera.sourceforge.jp/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"

DEPEND="=x11-libs/qt-3*"
S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	cd ${S}

	mv kimera.pro kimera.pro.orig
	sed -e "s:\(target\.path.*=\) /usr/local/bin:\1 /usr/bin:" \
		kimera.pro.orig > kimera.pro
}

src_compile(){
	qmake kimera.pro || die
	emake CFLAGS="-DQT_NO_DEBUG -DQT_NO_DEBUG ${CFLAGS}" \
		CXXFLAGS="-DQT_NO_DEBUG -DQT_NO_DEBUG ${CXXFLAGS}" || die
}

src_install(){
	einstall INSTALL_ROOT="${D}" || die

	dodoc AUTHORS COPYING INSTALL README
}
