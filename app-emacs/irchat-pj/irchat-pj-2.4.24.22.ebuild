# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

inherit elisp

DESCRIPTION="irhcat-pj: Perfect Japanization of irchat"
#SRC_URI="http://irc.fan.gr.jp/pj/src/${P}.tar.gz"
SRC_URI="http://his.luky.org/ftp/mirrors/${PN}/${P}.tar.bz2"
HOMEPAGE="http://irc.fan.gr.jp/pj/"	# not available

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/emacs"

S=${WORKDIR}/${P}

src_compile() {

	make || die
}

src_install() {

	dobin dcc/dcc

	elisp-install ${PN} *.el{,c} contrib/*.el || die
	elisp-site-file-install ${FILESDIR}/50irchat-pj-gentoo.el || die
	dodoc contrib/MANIFEST.irchat-pj doc/*
}
