# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils

DESCRIPTION="Python interface to libpcap"
HOMEPAGE="http://sourceforge.net/projects/pylibpcap/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/python
	virtual/libpcap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-python2.4.patch
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
