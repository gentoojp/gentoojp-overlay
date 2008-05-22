# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-emacs/lsdb/lsdb-0.10.ebuild,v 1.1 2003/12/01 05:36:12 usata Exp $

inherit elisp

DESCRIPTION="a rolodex-like database program for SEMI based MUA. "
HOMEPAGE="http://lsdb.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/lsdb/1494/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=app-emacs/apel-10.2
	virtual/flim"

S=${WORKDIR}/${P}

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	make PREFIX=/usr LISPDIR=${SITELISP} || die
}

src_install () {

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ChangeLog README
}
