# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

IUSE="cjk"

DESCRIPTION="PDFscreen package helps to redesign the pdf output of your normal documents fit to be read in a computer monitor."

HOMEPAGE="http://www.river-valley.com/download/download2.shtml#pdfscreen"
SRC_URI="http://sarovar.org/download.php/1/${P}.tar.gz"

LICENSE="LPPL-1.3"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}"

src_unpack() {

	unpack ${A}
	cd ${S}
	use cjk && epatch ${FILESDIR}/japanese-option.patch
}

src_install() {

	latex-package_src_doinstall styles pdf
	insinto ${TEXMF}/tex/latex/misc
	doins ${FILESDIR}/truncate.sty
	# downloaded from
	# ftp://ftp.ctan.org/tex-archive/macros/latex/contrib/misc/truncate.sty

	insinto /usr/share/doc/${P}
	doins manual.tex pdfscreen.cfg.specimen slide.tex tex.png
}
