# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit elisp

DESCRIPTION="SDIC emacs lisp package for Emacs to look English-Japanese/Japanese-English directories"
HOMEPAGE="http://www.namazu.org/~tsuchiya/sdic/"
SRC_URI="http://www.namazu.org/~tsuchiya/sdic/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/${P}

SITEFILE="00sdic-gentoo.el"

src_unpack() {

	unpack ${A}

	# Insert a info direntry to texi/sdic.texi so as not to fail
	# install-info in post_emerge
	epatch ${FILESDIR}/${P}-infofix.patch
}

src_compile() {

	econf \
		--with-lispdir=${SITELISP}/${PN} \
		--with-dictdir=/usr/share/dict 

	make || die
	make info || die
}

src_install() {

	make DESTDIR=${D} install || die

	# Install scripts converting a dictionary to sdic format
	insinto ${SITELISP}/${PN}/contrib
	doins contrib/*.perl

	# Install info and documents
	doinfo texi/sdic.info	# Instead of "make install-info"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO \
		lisp/sample.emacs

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die	
}
