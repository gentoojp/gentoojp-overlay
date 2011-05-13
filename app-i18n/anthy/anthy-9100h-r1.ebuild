# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit elisp-common eutils

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/
	http://www.fenix.ne.jp/~G-HAL/soft/nosettle/#anthy"
SRC_URI="!ghal? ( mirror://sourceforge.jp/anthy/37536/${P}.tar.gz )
	ghal? ( http://www.fenix.ne.jp/~G-HAL/soft/nosettle/${P}.patch13-release-2011213.alt-depgraph-110208-angie.zipdic-201101.tar.lzma )"

LICENSE="GPL-2 LGPL-2.1 ghal? ( BSD )"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
IUSE="canna-2ch emacs ghal static-libs"

DEPEND="!app-i18n/anthy-ss
	canna-2ch? ( app-dicts/canna-2ch )
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-anthy_context_t.patch"
	if use ghal; then
		# pkgdata_DATA in top Makefile defines docs.
		# prevent doc files from being installed as data.
		sed -i -e '/^pkgdata_DATA\>/d' Makefile.in || die "sed failed"
	fi

	if use canna-2ch; then
		einfo "Adding nichan.ctd to anthy.dic."
		sed -i \
			-e "/set_input_encoding eucjp/aread ${EPREFIX}/var/lib/canna/dic/canna/nichan.ctd" \
			mkworddic/dict.args.in || die
	fi
}

src_configure() {
	local myconf

	use emacs || myconf="EMACS=no"

	econf \
		$(use_enable static-libs static) \
		${myconf} || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use emacs ; then
		elisp-site-file-install "${FILESDIR}"/50anthy-gentoo.el || die
	fi

	dodoc AUTHORS DIARY NEWS README ChangeLog || die
	use ghal && dodoc AUTHORS.patch sample/conf

	rm -f doc/Makefile*
	docinto doc
	dodoc doc/* || die

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}

pkg_postinst() {
	use emacs && elisp-site-regen

	if use ghal; then
		ewarn "G-HAL patched anthy is NOT compatible with the original version."
		ewarn "You might want to backup your ~/.anthy before use."
		elog
		elog "see ${EPREFIX}/usr/share/doc/${PF}/conf for available settings with comments"
		elog
		elog "To update user's learning data do these:"
		elog "  rm ~/.anthy/last-record1_*.bin"
		elog "  anthy-agent --update-base-record"
		elog "  rm ~/.anthy/last-record1_*.bin"
		elog "  anthy-agent --update-base-record"
		elog "(repeating two times is intended)"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

