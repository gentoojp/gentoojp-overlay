# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ECVS_SERVER="cvs.namazu.org:/storage/cvsroot"
ECVS_MODULE="emacs-w3m"
ECVS_BRANCH="HEAD"

inherit elisp cvs

IUSE=""

DESCRIPTION="emacs-w3m is interface program of w3m on Emacs."
HOMEPAGE="http://emacs-w3m.namazu.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="virtual/emacs
	virtual/w3m
	>=app-emacs/apel-10.3
	virtual/flim
	!app-emacs/emacs-w3m"

S=${WORKDIR}/${ECVS_MODULE}

MY_PN=${ECVS_MODULE}

src_compile() {
	[ ! -f ./configure ] && autoconf
	./configure --prefix=/usr \
		--with-lispdir=${SITELISP}/${MY_PN} \
		--with-icondir=/usr/share/${MY_PN}/icon

	make || die
}

src_install () {
	make lispdir=${D}/${SITELISP}/${MY_PN} \
		infodir=${D}/usr/share/info \
		ICONDIR=${D}/usr/share/${MY_PN}/icon \
		install || die

	make lispdir=${D}/${SITELISP}/${MY_PN} \
		ICONDIR=${D}/usr/share/${MY_PN}/icon \
		install-icons || die

	elisp-site-file-install ${FILESDIR}/70emacs-w3m-gentoo.el ${MY_PN}

	dodoc ChangeLog* README* TIPS* FAQ*
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see /usr/share/doc/${P}/README.gz."
}

pkg_postrm() {
	elisp-site-regen
}
