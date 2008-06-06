# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit elisp eutils

MY_P="${P%_p*}"

DESCRIPTION="Emacs Backend for Sj3 Ver.2, FreeWnn, Wnn6 and Canna"
HOMEPAGE="http://www.m17n.org/tamago/index.en.html"
SRC_URI="ftp://ftp.m17n.org/pub/tamago/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="canna"

RDEPEND="virtual/emacs
	canna? ( app-i18n/canna )"
DEPEND="${RDEPEND}"

SITEFILE="50tamago-gentoo.el"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	epatch ${FILESDIR}/${P}.diff
}

src_install() {
	dodir ${SITELISP}/${PN}
	emake prefix="${D}"/usr \
		infodir="${D}"/usr/share/info \
		lispdir="${D}"/${SITELISP} \
		etcdir="${D}"/usr/share/${PN} install || die "emake install failed"


	cp ${FILESDIR}/${SITEFILE} ${SITEFILE}
	if use canna ; then
		cat >>${SITEFILE}<<-EOF
		(set-language-info "Japanese" 'input-method "japanese-egg-canna")

		EOF
	fi

	elisp-site-file-install ${SITEFILE} || die "elisp install failed."

	dodoc README.ja.txt AUTHORS PROBLEMS TODO ChangeLog*
}

pkg_postinst() {
	elisp-site-regen

	if ! grep -q inet ${ROOT}/etc/conf.d/canna && use canna ; then
		sed -i -e '/CANNASERVER_OPTS/s/"\(.*\)"/"\1 -inet"/' \
			${ROOT}/etc/conf.d/canna

		einfo
		einfo "Enabled inet domain socket for tamago."
		einfo "You must restart cannaserver in order to use."
		einfo "Beware of increasing security risks."
		einfo
	fi
}
