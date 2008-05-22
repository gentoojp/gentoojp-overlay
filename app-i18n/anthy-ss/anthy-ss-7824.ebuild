# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy-ss/anthy-ss-7924.ebuild,v 1.0 2006/06/25 13:11:37 hattya Exp $

inherit elisp-common eutils

IUSE="emacs ucs4 alt-cannadic"

MY_P="${P/-ss/}"

ALT_CANNADIC_PN="alt-cannadic"
ALT_CANNADIC_PV="060617"
ALT_CANNADIC_P="${ALT_CANNADIC_PN}-${ALT_CANNADIC_PV}"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/20668/${MY_P}.tar.gz
http://homepage2.nifty.com/jjade/alt-cannadic/${ALT_CANNADIC_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="!app-i18n/anthy
	emacs? ( virtual/emacs )"

src_unpack() {
	unpack ${MY_P}.tar.gz || die
	if use alt-cannadic; then
		unpack ${ALT_CANNADIC_P}.tar.bz2 || die

		einfo "Replace cannadic to alt-cannadic"
		cp -v -f "${ALT_CANNADIC_PN}/gcanna.ctd" "${MY_P}/cannadic/"
		cp -v -f "${ALT_CANNADIC_PN}/gcannaf.ctd" "${MY_P}/cannadic/"
		cp -v -f "${ALT_CANNADIC_PN}/gtankan.ctd" "${MY_P}/cannadic/"

		einfo "Modify mkworddic"
		cp -v -f "${FILESDIR}/Makefile.in" "${MY_P}/mkworddic/"
		cp -v -f "${FILESDIR}/dict.args.in" "${MY_P}/mkworddic/"
	fi
}
src_compile() {
	
	local myconf
	local cannadicdir=/var/lib/canna/dic/canna

	use emacs || myconf="EMACS=no"
	use ucs4 && myconf="${myconf} --enable-ucs4"

	if has_version 'app-dicts/canna-2ch'; then
		einfo "Adding nichan.ctd to anthy.dic."
		sed -i -e /placename/a"read ${cannadicdir}/nichan.ctd" \
			mkworddic/dict.args.in
	fi

	econf ${myconf} || die
	emake -j1 || die

}

src_install() {

	make DESTDIR=${D} install || die

	### using filesdir trick for OVERLAY
	# use emacs && elisp-site-file-install ${FILESDIR}/50anthy-gentoo.el
	use emacs && elisp-site-file-install ${PORTDIR}/${CATEGORY}/${PN}/files/50anthy-gentoo.el

	rm doc/Makefile*

	dodoc AUTHORS DIARY NEWS README ChangeLog
	dodoc doc/*

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	has_version virtual/emacs && elisp-site-regen

}
