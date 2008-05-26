# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A Trac plugin for administering Trac projects through the web interface."
HOMEPAGE="http://projects.edgewall.com/trac/wiki/WebAdmin"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
myP="trac-webadmin-${PV}"
SRC_URI="mirror://gentoo/${myP}.tar.bz2"
S=${WORKDIR}/${myP}

LICENSE="trac"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

SLOT="0"

DEPEND=">=www-apps/trac-ja-0.10
	>=dev-python/setuptools-0.6_rc1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epath ${FILESDIR}/webadmin-r4429-ja.patch
}

# from marienz's setuptools.eclass:
src_install() {
	"${python}" setup.py install --root=${D} --no-compile \
		--single-version-externally-managed "$@" || die "install failed"
}

src_test() {
	"${python}" setup.py test || die "tests failed"
}

pkg_postinst() {
	elog "To enable the WebAdmin plugin in your Trac environments, you have to add:"
	elog "	[components]"
	elog "	webadmin.* = enabled"
	elog "to your trac.ini files."
	elog
	elog "To be able to see the Admin tab, your users must have the TRAC_ADMIN permission"
	elog "and/or the TICKET_ADMIN permission."
}
