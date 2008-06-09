# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit elisp
SITEFILE="50azik-gentoo.el"

DESCRIPTION="Japanese romaji easy input method for Canna and Tamago"
HOMEPAGE="http://hp.vector.co.jp/authors/VA002116/azik/azikindx.htm"
SRC_URI="http://mannequeen.net/~rock/linux/gentoo/portage-dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~arm ~hppa"
IUSE="doc emacs"

DEPEND="app-i18n/canna
	emacs? (
		virtual/emacs
		app-emacs/tamago )"

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
	if use doc ; then
		dohtml azik.html
	fi
	if use emacs ; then
		dodir /usr/share/emacs/site-lisp/
		  insopts -m0644
		  insinto /usr/share/emacs/site-lisp/
		  doins egg-azik.el
		  doins egg-azik.elc
		elisp-site-file-install ${FILESDIR}/${SITEFILE} || die
	fi
}

pkg_postinst(){
	einfo "-------------------------------------"
	einfo "Please replace romkana-table in ~/.canna"
	einfo "  Ex:"
	einfo "    ;(setq romkana-table "default.cbp")"
	einfo "    (setq romkana-table "azik.cbp")"
	einfo "-------------------------------------"
}
