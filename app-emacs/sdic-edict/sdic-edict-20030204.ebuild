# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp

DESCRIPTION="Japanese-English directories for SDIC"
HOMEPAGE="http://www.csse.monash.edu.au/~jwb/edict.html"
SRC_URI="
	ftp://ftp.u-aizu.ac.jp/pub/SciEng/nihongo/ftp.cc.monash.edu.au/edict.gz
	http://www.csse.monash.edu.au/groups/edrdg/licence.html
	ftp://ftp.u-aizu.ac.jp/pub/SciEng/nihongo/ftp.cc.monash.edu.au/edict_doc.txt
	ftp://ftp.u-aizu.ac.jp/pub/SciEng/nihongo/ftp.cc.monash.edu.au/edict_doc.html
"
# Primary distribution
#ftp://ftp.cc.monash.edu.au/pub/nihongo/edict.gz
#ftp://ftp.cc.monash.edu.au/pub/nihongo/edict_doc.txt
#ftp://ftp.cc.monash.edu.au/pub/nihongo/edict_doc.html
LICENSE="as-is"
# EDICT license is stated at:
#	http://www.csse.monash.edu.au/groups/edrdg/licence.html
SLOT="0"
KEYWORDS="~x86"
IUSE="sdic-reverse"
DEPEND="
	>=app-emacs/sdic-2.1.3-r1
	dev-lang/perl
"
RDEPEND=">=app-emacs/sdic-2.1.3-r1"
S=${WORKDIR}

DICTDIR="/usr/share/dict"
LISPSDICDIR="${SITELISP}/sdic"
SITEFILE="10edict-gentoo.el"

src_unpack() {
	unpack ${A// *}	# edict.gz
}

src_compile() {

	# Convert JE dictionary
	perl ${LISPSDICDIR}/contrib/edict.perl \
		${S}/edict > ${S}/jedict.sdic \
		|| die "Failed to convert edict to jedict.sdic"
	
	# Convert EJ dictionary
	use sdic-reverse && (
		perl ${LISPSDICDIR}/contrib/edict.perl --reverse \
			${S}/edict > ${S}/eedict.sdic \
			|| die "Failed to convert edict to eedict.sdic"
	)
	
	# EDICT configuration emacs lisp
	if [ "`use sdic-reverse`" ]; then
		cp ${FILESDIR}/${SITEFILE} ${S}
	else
		grep -v "sdic-eiwa-dictionary-list" \
			${FILESDIR}/${SITEFILE} > ${S}/${SITEFILE} || die
	fi
}

src_install() {

	insinto ${DICTDIR}

	# Install dictionary
	doins ${S}/jedict.sdic
	# Install EJ dictionary
	[ "`use sdic-reverse`" ] && doins eedict.sdic
	# Install documents
	doins ${DISTDIR}/edict_doc.txt ${DISTDIR}/edict_doc.html
	newins ${DISTDIR}/licence.html edict_licence.html
	gzip -9 -f ${D}/${DICTDIR}/edict_doc.txt

	# EDICT configuration emacs lisp
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die	
}
