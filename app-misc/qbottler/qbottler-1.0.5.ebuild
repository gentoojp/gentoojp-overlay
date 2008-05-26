# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

IUSE=""

MY_PN="QBottler"
DESCRIPTION="Yet Another bottler.py using PyQt"
SRC_URI="http://www13.plala.or.jp/lucier/qbottler/data/${MY_PN}-${PV}.zip"
HOMEPAGE="http://www13.plala.or.jp/lucier/qbottler/"

DEPEND="virtual/python
	dev-python/PyQt
	media-libs/libmng"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${MY_PN}"

pkg_setup(){
	python_version
}

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/${PN}-${PV}-cjkcodecs.patch
}

src_compile(){
	for p in *.py; do
		python_mod_compile $p
	done
}

src_install(){
	insinto /usr/lib/python${PYVER}/site-packages/${PN}
	dodir /usr/lib/python${PYVER}/site-packages/${PN} /usr/bin
	doins *.py{,c,o}
	chmod +x ${D}/usr/lib/python${PYVER}/site-packages/${PN}/${MY_PN}.py

	dosym /usr/lib/python${PYVER}/site-packages/${PN}/${MY_PN}.py \
		/usr/bin/${PN}

	dodir /usr/share/qbottler
	insinto /usr/share/qbottler
	doins lamp.png
	dodoc change readme
}
