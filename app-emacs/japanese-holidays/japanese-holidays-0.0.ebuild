# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp

DESCRIPTION="calendar functions for the Japanese calendar"
HOMEPAGE=""
SRC_URI=""
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

SITEFILE="50japanese-holidays-gentoo.el"

src_unpack() {
	cp "${FILESDIR}/japanese-holidays.el" "${WORKDIR}"
}

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}
