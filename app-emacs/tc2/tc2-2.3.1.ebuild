# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/app-emacs/tc2/tc2-2.3.1.ebuild,v 1.2 2003/12/01 13:24:30 usata Exp $

inherit elisp

MY_P="tc-${PV}"
DESCRIPTION="Japanese direct input method driver for Emacs"
HOMEPAGE="http://openlab.ring.gr.jp/tcode/tc2/"
SRC_URI="http://openlab.ring.gr.jp/tcode/resources/soft/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/emacs"

S="${WORKDIR}/${MY_P}"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

