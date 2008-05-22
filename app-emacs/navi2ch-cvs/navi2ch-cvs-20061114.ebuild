# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp

IUSE=""

NAVI2CH_PVR="1"
SITEFILE=50navi2ch-gentoo.el

DESCRIPTION="Navi2ch is navigator for 2ch which works under many Emacsen"
HOMEPAGE="http://navi2ch.sourceforge.net/"
SRC_URI="http://navi2ch.sourceforge.net/snapshot/navi2ch-cvs_0.0.${PV}-${NAVI2CH_PVR}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"

DEPEND="!app-emacs/navi2ch"

src_compile() {
	econf || die
	emake < /dev/null || die
}

src_install() {
	emake < /dev/null \
		DESTDIR=${D} lispdir=${SITELISP}/navi2ch install || die
	elisp-install navi2ch contrib/*.el || die

	# install sitefile from app-emacs/navi2ch
	elisp-site-file-install ${PORTDIR}/app-emacs/navi2ch/files/${SITEFILE} || die
}

pkg_postinst() {
	elisp-site-regen
	einfo
	einfo "Please add to your .emacs"
	einfo "If you use mona-font,"
	einfo "\t(setq navi2ch-mona-enable t)"
	einfo "If you use izonmoji-mode,"
	einfo "\t(require 'izonmoji-mode)"
	einfo "\t(add-hook 'navi2ch-bm-mode-hook      'izonmoji-mode-on)"
	einfo "\t(add-hook 'navi2ch-article-mode-hook 'izonmoji-mode-on)"
	einfo "\t(add-hook 'navi2ch-popup-article-mode-hook 'izonmoji-mode-on)"
	einfo
}
