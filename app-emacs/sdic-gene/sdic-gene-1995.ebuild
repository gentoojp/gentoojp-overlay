# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp

DESCRIPTION="English-Japanese directories for SDIC"
HOMEPAGE="http://www.namazu.org/~tsuchiya/sdic/data/gene.html"
GENE_SRC="gene95.tar.bz2"
SRC_URI="${GENE_SRC}"

LICENSE="as-is"
# The license of GENE dictionary is described by the author in Japanese with a
# licensed distributer and SDIC author reprinting at:
#	http://www.namazu.org/~tsuchiya/sdic/data/gene.html
# The summary is:
#	GENE dictionary is not public domain. The author Kurumi (NiftyID: GGD00145)
#	reserves the copyright.	If you want to distribute it, or to use it for
#	purposes except for personal use, please contact to the author. Whether
#	commercial use or not, it is prohibited to distribute GENE dictionary in
#	the form of printing.
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sdic-reverse"

DEPEND=">=app-emacs/sdic-2.1.3-r1
	dev-lang/perl
	app-i18n/nkf
	sdic-reverse? ( app-i18n/kakasi )"
RDEPEND=">=app-emacs/sdic-2.1.3-r1"

RESTRICT="fetch"
S="${WORKDIR}"

DICTDIR="/usr/share/dict"
LISPSDICDIR="${SITELISP}/sdic"
SITEFILE="10gene-gentoo.el"

pkg_nofetch() {
	einfo "Please download ${GENE_SRC} from"
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {

	if [[ ! -f "${DISTDIR}/${GENE_SRC}" ]]; then
		eerror "cannot read ${GENE_SRC}. Please check the permission and try again."
		die
	fi

	unpack ${GENE_SRC}
}

src_compile() {

	nkf -S -e "${S}"/gene.txt > "${S}"/gene.txt.euc \
		|| die "Failed to convert gene.txt to gene.txt.euc"

	# Convert EJ dictionary
	perl ${LISPSDICDIR}/contrib/gene.perl \
		"${S}"/gene.txt.euc > "${S}"/gene.sdic \
		|| die "Failed to convert gene.txt.euc to gene.sdic"

	# Convert JE dictionary
	use sdic-reverse && (
		perl ${LISPSDICDIR}/contrib/gene.perl --compat \
			"${S}"/gene.txt.euc > "${S}"/gene.dic \
			|| die "Failed to convert gene.txt.euc to gene.dic"
	# jgene.perl requires kakasi
	perl ${LISPSDICDIR}/contrib/jgene.perl \
		"${S}"/gene.dic > "${S}"/jgene.sdic \
		|| die "Failed to convert gene.dic to jgene.sdic"
	)

	# GENE configuration emacs lisp
	if [ "`use sdic-reverse`" ]; then
		cp ${FILESDIR}/${SITEFILE} "${S}"
	else
		grep -v "sdic-waei-dictionary-list" \
			${FILESDIR}/${SITEFILE} > "${S}"/${SITEFILE} || die
	fi
}

src_install() {

	insinto ${DICTDIR}

	# Install dictionary
	doins gene.sdic
	use sdic-reverse && doins jgene.sdic

	# Install documents
	newins "${S}"/readme.txt gene_readme.txt
	gzip -9 -f "${D}/${DICTDIR}/gene_readme.txt"
	
	# Install GENE configuration emacs lisp
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die	
}
