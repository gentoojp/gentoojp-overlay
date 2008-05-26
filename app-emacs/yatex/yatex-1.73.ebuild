# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp eutils

IUSE="cjk"

DESCRIPTION="Yet Another TeX mode for Emacs"
HOMEPAGE="http://www.yatex.org/"
SRC_URI="http://www.yatex.org/${P/-/}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="as-is"

# virtual/emacs is from elisp.eclass
#DEPEND="virtual/emacs"

S=${WORKDIR}/${P/-/}

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.72-gentoo.diff"
	epatch "${FILESDIR}/${P}-yatexhlp-gentoo.diff"
}

src_compile() {

	# compilation b0rks on alpha, sparc and ppc

	cd docs
	mv yatexe yatex.info
	mv yahtmle yahtml.info
	if use cjk ; then
		iconv -f ISO-2022-JP -t EUC-JP yatexj > yatex-ja.info
		iconv -f ISO-2022-JP -t EUC-JP yahtmlj > yahtml-ja.info
	fi
}

src_install() {

	elisp-install ${PN} *.el
	elisp-site-file-install "${FILESDIR}/50yatex-gentoo.el"
	elisp-install ${PN} help/YATEXHLP*

	dodoc docs/*.eng
	if use cjk ; then
		dodoc 00readme install
		dodoc docs/{htmlqa,qanda} docs/*.doc
	fi
	for i in docs/*.info; do
		doinfo ${i}
	done
}
