# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit elisp

IUSE="ssl"

DESCRIPTION="great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="http://www.mew.org/Release/${P/_/}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="ssl? ( net-misc/stunnel )
		 >=app-crypt/gnupg-2.0.1 app-crypt/dirmngr
		 app-text/hyperestraier "

SITEFILE=50mew-gentoo.el

S=${WORKDIR}/${P/_/}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN} \
		mandir=${D}/usr/share/man/man1 || die

	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc 00* mew.dot.*
}

pkg_postinst() {
	elisp-site-regen
	einfo
	einfo "Please refer to /usr/share/doc/${PF} for sample configuration files."
	einfo
}

pkg_postrm() {
	elisp-site-regen
}

