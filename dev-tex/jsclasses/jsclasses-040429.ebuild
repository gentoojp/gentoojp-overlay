# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Japanese document class files for pTeX made by Okumura"

HOMEPAGE="http://oku.edu.mie-u.ac.jp/~okumura/jsclasses/"

SRC_URI="http://oku.edu.mie-u.ac.jp/~okumura/jsclasses/${P}.zip"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~x86"

DEPEND="app-text/ptex
	app-arch/unzip
	media-fonts/ptex-jisfonts"

S=${WORKDIR}

src_install() {

	insinto /usr/share/texmf/ptex/platex/${PN}
	doins *
}

pkg_postinst() {

	mktexlsr
}

pkg_postrm() {

	mktexlsr
}
