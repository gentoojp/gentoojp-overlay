# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/jsclasses/jsclasses-061106.ebuild,v 1.1 2006/12/17 17:36:02 okayama Exp $

inherit latex-package

IUSE="doc"

DESCRIPTION="Japanese document class files for pTeX made by Okumura"

HOMEPAGE="http://oku.edu.mie-u.ac.jp/~okumura/jsclasses/"
SRC_URI="http://oku.edu.mie-u.ac.jp/~okumura/jsclasses/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/unzip
	|| ( ( media-fonts/ptex-jisfonts <=app-text/ptex-3.1.8.1 )
		>app-text/ptex-3.1.8.1 )"

S=${WORKDIR}

src_compile() {

	if use doc
	then
		for src in *.dtx
		do
			einfo "Making documentation: ${src/.dtx/.dvi}"
			VARTEXFONTS=${T}/fonts \
				platex --interaction=batchmode $src &> /dev/null
		done
	fi
}

src_install() {

	insinto ${TEXMF}/ptex/platex/${PN}
	doins *.sty *.cls

	insinto /usr/share/doc/${P}
	doins *.dtx
	use doc && latex-package_src_doinstall dvi
}
