# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

inherit elisp eutils

BASEP="tamago-4.0.6"

DESCRIPTION="Emacs Backend for Sj3 Ver.2, FreeWnn, Wnn6 and Canna"
HOMEPAGE="http://www.m17n.org/tamago/index.en.html"
SRC_URI="ftp://ftp.m17n.org/pub/tamago/${BASEP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="canna"

DEPEND="virtual/emacs
	sys-apps/sed"
RDEPEND="virtual/emacs
	canna? ( app-i18n/canna )"

SITEFILE="50tamago-gentoo.el"

S=${WORKDIR}/${BASEP}

src_unpack() {
	unpack ${BASEP}.tar.gz
	epatch ${FILESDIR}/${P}.diff
}

src_compile() {
	econf || die "conf failed."
	emake || die "make failed."
}

src_install() {
	dodir ${SITELISP}/${PN}
	emake prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		lispdir=${D}/${SITELISP} \
		etcdir=${D}/usr/share/${PN}  install || die


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
