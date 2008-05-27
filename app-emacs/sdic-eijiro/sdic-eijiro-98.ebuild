# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp

EIJIRODIC="eijiro${PV}"
WAEIJIDIC="waeiji${PV}"

DESCRIPTION="EIJIRO English-Japanese Database for SDIC"
HOMEPAGE="http://www.eijiro.jp/"
SRC_URI="${EIJIRODIC}.dic ${WAEIJIDIC}.dic"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="fetch"

RDEPEND=">=app-emacs/sdic-2.1.3"
DEPEND="${RDEPEND}
	dev-lang/perl
	app-i18n/nkf"

PDICCONV="/opt/pdic-conv"
DICTDIR="/usr/share/dict"
SITEFILE="30sdic-eijiro-gentoo.el"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please copy ${EIJIRODIC}.dic and ${WAEIJIDIC}.dic"
	einfo "from EIJIRO_3rd Edition CD-ROM"
	einfo "and place them in ${DISTDIR}"
}

src_unpack() {
	cp ${DISTDIR}/${EIJIRODIC}.dic ${S}
	cp ${DISTDIR}/${WAEIJIDIC}.dic ${S}
}

src_compile() {
	local contribdir="${SITELISP}/sdic/contrib"

	perl -I${PDICCONV}/lib ${PDICCONV}/pdic-dump.pl ${S}/${EIJIRODIC}.dic | \
		nkf -S -e  | \
		perl ${contribdir}/eijirou.perl > ${S}/${EIJIRODIC}.sdic \
		|| die "failed to convert ${EIJIRODIC}.dic"
	
	perl -I${PDICCONV}/lib ${PDICCONV}/pdic-dump.pl ${S}/${WAEIJIDIC}.dic | \
		nkf -S -e | \
		perl ${contribdir}/eijirou.perl --waei > ${S}/${WAEIJIDIC}.sdic \
		|| die "failed to convert ${WAEIJIDIC}.dic"
}

src_install() {
	insinto ${DICTDIR}
	doins ${S}/${EIJIRODIC}.sdic ${S}/${WAEIJIDIC}.sdic

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
}

