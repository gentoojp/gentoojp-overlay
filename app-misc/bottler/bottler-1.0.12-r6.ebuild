# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

IUSE=""

DESCRIPTION="SSTP Bottle Client for X"
SRC_URI="http://www.geocities.co.jp/SiliconValley-Cupertino/7565/archive/${P}.tar.gz"
HOMEPAGE="http://www.geocities.co.jp/SiliconValley-Cupertino/7565/"

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}
	dev-lang/tcl
	dev-lang/tk
	app-misc/ninix-aya"

KEYWORDS="~x86 ~alpha"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${P}"

pkg_setup(){
	python_tkinter_exists
}

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/${PF}.patch
}

src_install(){
	python_version

	emake DESTDIR=${D} \
		prefix=/usr \
		exec_libdir=/usr/lib/python${PYVER}/site-packages/${PN}-1.0 \
		docdir=${D}/usr/share/doc/${P} \
		install

	prepalldocs
}
