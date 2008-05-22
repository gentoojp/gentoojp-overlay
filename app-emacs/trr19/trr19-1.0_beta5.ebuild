# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit elisp

IUSE=""

DESCRIPTION="TRR19 is a typing game on GNU Emacs"
SRC_URI="http://web.yl.is.s.u-tokyo.ac.jp/~ymmt/dist/${PN}.tar.gz"
HOMEPAGE="http://web.yl.is.s.u-tokyo.ac.jp/~ymmt/mydist.shtml"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/emacs"



S="${WORKDIR}/${PN}"

SITEFILE=50trr19-gentoo.el

src_unpack() {

	unpack ${PN}.tar.gz
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	make trrdir=${D}${SITELISP}/${PN} \
		infodir=${D}/usr/share/info \
		bindir=${D}/usr/bin all || die
}

src_install () {

	make trrdir=${D}${SITELISP}/${PN} \
		infodir=${D}/usr/share/info \
		bindir=${D}/usr/bin install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc README.euc ChangeLog
}