# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp-common eutils

IUSE="emacs ucs4"

MY_P="${P/-ss/}"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/19482/${MY_P}.tar.gz"

OALICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="emacs? ( virtual/emacs )
	!app-i18n/anthy"

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
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	### using filesdir trick for OVERLAY
	### original is			     ${FILESDIR}/50anthy-gentoo.el
	use emacs && elisp-site-file-install ${PORTDIR}/${CATEGORY}/${PN}/files/50anthy-gentoo.el

	rm doc/Makefile*

	dodoc AUTHORS COPYING DIARY INSTALL NEWS README ChangeLog
	dodoc doc/*

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	has_version virtual/emacs && elisp-site-regen

}
