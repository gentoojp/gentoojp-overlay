# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Japanese romaji easy input method for Canna and Tamago"
HOMEPAGE="http://hp.vector.co.jp/authors/VA002116/azik/azikindx.htm"
#HOMEPAGE="http://www.apm.dnsalias.net/azik/"
#HOMEPAGE="http://air.zive.net/d/20030318.html"
SRC_URI="http://mannequeen.net/~rock/linux/gentoo/portage/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~arm ~hppa"
IUSE="emacs"

DEPEND="app-i18n/canna
	emacs? (
		virtual/emacs
		app-emacs/tamago
	)"
RDEPEND="${DEPEND}"

src_compile(){
	/usr/bin/mkromdic azik.cbpdef
	if use emacs ; then
		/usr/bin/emacs -batch -f batch-byte-compile egg-azik.el
	fi
}

src_install(){
	dodir /usr/share/canna/
	insopts -m0444
	insinto /usr/share/canna/
	doins azik.cbp
	dohtml azik.html
	if use emacs ; then
		dodir /usr/share/emacs/site-lisp/
		insopts -m0644
		insinto /usr/share/emacs/site-lisp/
		doins egg-azik.el
		doins egg-azik.elc
	fi
}

pkg_postinst(){
	einfo "-------------------------------------"
	einfo "Please replace romkana-table in ~/.canna"
	if use emacs ; then
		einfo "           and add 'require' to ~/.emacs"
	fi
	einfo "-------------------------------------"
	einfo "Ex: ~/.canna"
	einfo "  ;(setq romkana-table "default.cbp")"
	einfo "  (setq romkana-table "azik.cbp")"
	if use emacs ; then
		einfo "-------------------------------------"
		einfo "Ex: ~/.emacs"
		einfo "  (require 'egg-azik)"
	fi
	einfo "-------------------------------------"
}
