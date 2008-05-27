# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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

