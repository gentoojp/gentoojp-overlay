# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

IUSE="doc"

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

src_compile() {

	for file in *.ins
	do
		echo "Extracting from $file"
		platex --interaction=batchmode $file &> /dev/null
	done
}

src_install() {

	insinto ${TEXMF}/ptex/platex/${PN}
	doins *.sty *.cls

	if use doc
	then
		insinto /usr/share/doc/${PF}
		doins *.dtx
	fi
}
