# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp


DESCRIPTION="TRR19 is a typing game on GNU Emacs"
HOMEPAGE="http://web.yl.is.s.u-tokyo.ac.jp/~ymmt/mydist.shtml"
SRC_URI="http://web.yl.is.s.u-tokyo.ac.jp/~ymmt/dist/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/emacs"

S="${WORKDIR}/${PN}"

SITEFILE=50trr19-gentoo.el

src_compile() {
	mv trr_format.c  trr_format.c.old 
	sed 's/tmpnam/mkstemp/g' trr_format.c.old > trr_format.c

	make trrdir=${SITELISP}/${PN} \
		infodir=/usr/share/info \
		bindir=/usr/bin all || die
}

src_install () {
	dodir /usr/bin
	dodir ${SITELISP}/${PN}

	make trrdir="${D}"/${SITELISP}/${PN} \
		infodir="${D}"/usr/share/info \
		bindir="${D}"/usr/bin install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc README.euc ChangeLog
}
