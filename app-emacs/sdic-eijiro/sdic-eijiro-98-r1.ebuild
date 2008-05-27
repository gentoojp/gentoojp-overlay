# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp eutils

EIJIRODIC="eijiro${PV}"
WAEIJIDIC="waeiji${PV}"

DESCRIPTION="EIJIRO English-Japanese Database for SDIC"
HOMEPAGE="http://www.eijiro.jp/"
SRC_URI="${EIJIRODIC}.dic ${WAEIJIDIC}.dic"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sary"
RESTRICT="fetch"

SDIC=">=app-emacs/sdic-2.1.3"
PDICCONV="/opt/pdic-conv"
DICTDIR="/usr/share/dict"
SITEFILE="30sdic-eijiro-gentoo.el"

RDEPEND="${SDIC}
	sys-apps/sed"
DEPEND="${RDEPEND}
	dev-lang/perl
	app-i18n/nkf"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please copy ${EIJIRODIC}.dic and ${WAEIJIDIC}.dic"
	einfo "from EIJIRO_3rd Edition CD-ROM"
	einfo "and place them in ${DISTDIR}"
}

pkg_setup() {
	if use sary && ! built_with_use ${SDIC} sary ; then
		echo
		eerror "app-emacs/sdic needs to be compiled with"
		eerror "'sary' USE Flag enabled to use sary dictionaries."
		echo
		die
	fi
}

src_unpack() {
	cp ${DISTDIR}/${EIJIRODIC}.dic ${S}
	cp ${DISTDIR}/${WAEIJIDIC}.dic ${S}
}

src_compile() {
	local contribdir="${SITELISP}/sdic/contrib"

	einfo "Converting ${EIJIRODIC}.dic ..."
	perl -I${PDICCONV}/lib ${PDICCONV}/pdic-dump.pl ${S}/${EIJIRODIC}.dic | \
		nkf -S -e  | \
		perl ${contribdir}/eijirou.perl > ${S}/${EIJIRODIC}.sdic \
		|| die "Failed to convert ${EIJIRODIC}.dic"
	
	einfo "Converting ${WAEIJIDIC}.dic ..."
	perl -I${PDICCONV}/lib ${PDICCONV}/pdic-dump.pl ${S}/${WAEIJIDIC}.dic | \
		nkf -S -e | \
		perl ${contribdir}/eijirou.perl --waei > ${S}/${WAEIJIDIC}.sdic \
		|| die "Failed to convert ${WAEIJIDIC}.dic"

	if use sary ; then
		einfo "Making a suffix array file of ${EIJIRODIC}.sdic ..."
		mksary -c EUC-JP ${S}/${EIJIRODIC}.sdic
		einfo "Making a suffix array file of ${WAEIJIDIC}.sdic ..."
		mksary -c EUC-JP ${S}/${WAEIJIDIC}.sdic
		sed 's/@USE_SARY@/t/g' ${FILESDIR}/${SITEFILE}.in \
			> ${S}/${SITEFILE} || die
	else
		sed 's/@USE_SARY@/nil/g' ${FILESDIR}/${SITEFILE}.in \
			> ${S}/${SITEFILE} || die
	fi
}

src_install() {
	insinto ${DICTDIR}
	doins ${S}/${EIJIRODIC}.sdic ${S}/${WAEIJIDIC}.sdic
	if use sary ; then
		doins ${S}/${EIJIRODIC}.sdic.ary ${S}/${WAEIJIDIC}.sdic.ary
	fi

	elisp-site-file-install ${S}/${SITEFILE} || die
}

