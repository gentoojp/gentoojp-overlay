# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit ruby elisp-common

IUSE="emacs"

DESCRIPTION="Ruby Refactoring Browser"
SRC_URI="http://www.kmc.gr.jp/proj/rrb/archive/${P}.tar.gz"
HOMEPAGE="http://www.kmc.gr.jp/proj/rrb/index-en.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
USE_RUBY="ruby18"

S="${WORKDIR}/${P}"

src_compile() {
	if use emacs; then
		elisp-comp ${S}/elisp/rrb.el || die
	fi
}

src_install() {
	einstall || die
	erubydoc
	if use emacs; then
		elisp-install rrb ${S}/elisp/rrb.el ${S}/elisp/rrb.elc
		elisp-site-file-install ${FILEDIR}/rrb.el
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	user emacs && elisp-site-regen
}