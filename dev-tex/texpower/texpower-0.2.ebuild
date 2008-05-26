# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

IUSE="doc"
MY_P="${P/./-}"

DESCRIPTION="A bundle of style and class files for creating dynamic online presentations."
SRC_URI="mirror://sourceforge/texpower/${MY_P}.tar.gz"
HOMEPAGE="http://texpower.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack ${A}

	cd ${S}/tpslifonts
	sed -i "s/\(latex tpslifonts.dtx\)/pdf\1/" Makefile

	cd ../
	sed -i "s/manual: manual.tex/manual: /" Makefile
}

src_compile() {

	einfo "Extracting from tpbundle.ins"
	make unpack &> /dev/null

	cd tpslifonts
	einfo "Extracting from tpslifonts.ins"
	make unpack &> /dev/null

	if use doc
	then
		einfo "Making documentation: tpslifonts.pdf"
		make doc VARTEXFONTS=${T}/fonts &> /dev/null
		cp tpslifonts.sty ../ || die
		cd ../

		einfo "Making documentation: texpower.pdf"
		make doc VARTEXFONTS=${T}/fonts &> /dev/null
		einfo "Making documentation: powersem.pdf"
		make doc-powersem VARTEXFONTS=${T}/fonts &> /dev/null
		einfo "Making documentation: tplists.pdf"
		make doc-tplists VARTEXFONTS=${T}/fonts &> /dev/null
		einfo "Making documentation: manual.pdf"
		make manual VARTEXFONTS=${T}/fonts &> /dev/null

		for file in FAQ-display.tex FAQ-printout.tex fulldemo.tex
		do
			einfo "Making documentation: ${file/.tex/.pdf}"
			VARTEXFONTS=${T}/fonts texi2pdf -q -c \
				--language=latex ${file} &> /dev/null
		done
		rm tpslifonts.sty
	fi
}

src_install() {

	latex-package_src_doinstall styles
	insinto ${TEXMF}/tex/latex/${PN}/tpslifonts
	doins tpslifonts/tpslifonts.sty || die

	if use doc
	then
		latex-package_src_doinstall pdf
		insinto /usr/share/doc/${PF}/tpslifonts
		doins tpslifonts/tpslifonts.pdf || die
	fi

	dodoc *.txt || die
	
	docinto tpslifonts
	dodoc tpslifonts/*.txt || die

	docinto contrib
	dodoc contrib/*.txt || die
	insinto /usr/share/doc/${PF}/contrib 
	doins contrib/{config.landscapeplus,tpmultiinc.tar} || die

	insinto /usr/share/doc/${PF}/examples
	doins *example.tex || die
	insinto /usr/share/doc/${PF}/examples/tpslifonts
	doins tpslifonts/*example.tex || die
}
