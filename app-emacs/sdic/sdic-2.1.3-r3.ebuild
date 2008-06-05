# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils elisp

DESCRIPTION="A simple/small/speedy emacs interface to look up English-Japanese/Japanese-English dictionaries"
HOMEPAGE="http://www.namazu.org/~tsuchiya/sdic/"
SRC_URI="http://www.namazu.org/~tsuchiya/sdic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sary"

RDEPEND="virtual/emacs
	sary? ( app-text/sary )"

SITEFILE="20${PN}-gentoo.el"

src_unpack() {
	unpack ${A}

	# Insert a info directory to texi/sdic.texi
	epatch ${FILESDIR}/${P}-infofix.patch
}

src_compile() {
	econf \
		--with-lispdir=${SITELISP}/${PN} \
		--with-dictdir=/usr/share/dict \
		|| die "econf failed"
	
	make || die "make failed"
	make info || die "make info failed"

	if use sary ; then
		sed -e 's/@USE_SARY@/t/g' ${FILESDIR}/${SITEFILE}.in \
			> ${S}/${SITEFILE} || die
	else
		sed -e 's/@USE_SARY@/nil/g' ${FILESDIR}/${SITEFILE}.in \
			> ${S}/${SITEFILE} || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto ${SITELISP}/${PN}/contrib
	doins contrib/*.perl

	doinfo texi/sdic.info
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO \
		/sample.emacs

	elisp-site-file-install ${S}/${SITEFILE} || die
}
