# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp-common eutils

### update specific param
ANTHY_SFJP_NO="22809"
ALT_CANNADIC_PV="061031"

# filter for anthy-ss ebuild
MY_P="${P/-ss/}"


ALT_CANNADIC_PN="alt-cannadic"
ALT_CANNADIC_P="${ALT_CANNADIC_PN}-${ALT_CANNADIC_PV}"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/${ANTHY_SFJP_NO}/${MY_P}.tar.gz
http://homepage2.nifty.com/jjade/alt-cannadic/${ALT_CANNADIC_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

IUSE="emacs ucs4 alt-cannadic"

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
		epatch "${FILESDIR}/Makefile.in.patch"
		epatch "${FILESDIR}/dict.args.in.patch"
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
