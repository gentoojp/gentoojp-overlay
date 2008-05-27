# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils elisp

DESCRIPTION="A simple/small/speedy interface to look up en-ja/ja-en dictionaries"
HOMEPAGE="http://namazu.org/~tsuchiya/sdic/"
SRC_URI="http://namazu.org/~tsuchiya/sdic/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sary"

RDEPEND="sary? ( app-text/sary )
	sys-apps/sed"
DEPEND="${RDEPEND}"

SITEFILE="20${PN}-gentoo.el"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-infofix.patch
}

src_compile() {
	econf \
		--with-lispdir=${SITELISP}/${PN} \
		--with-dictdir=/usr/share/dict
	
	make || die
	make info || die

	if use sary ; then
		sed 's/@USE_SARY@/t/g' ${FILESDIR}/${SITEFILE}.in \
			> ${S}/${SITEFILE} || die
	else
		sed 's/@USE_SARY@/nil/g' ${FILESDIR}/${SITEFILE}.in \
			> ${S}/${SITEFILE} || die
	fi
}

src_install() {
	make install DESTDIR=${D} || die

	insinto ${SITELISP}/${PN}/contrib
	doins contrib/*.perl

	doinfo texi/sdic.info
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO \
		lisp/sample.emacs

	elisp-site-file-install ${S}/${SITEFILE} || die
}

