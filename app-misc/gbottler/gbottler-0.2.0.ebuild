# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python

DESCRIPTION="yet another bottler.py using GTK+2"
HOMEPAGE="http://gbottler.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/48739/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.6
	dev-python/pyxml"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}/${PN}-makefile.patch" || die
}

src_compile() { :; }

src_install() {
	emake install \
		PYTHON=python2 \
		DESTDIR="${D}" \
		prefix="${EPREFIX}/usr" \
		libdir="${EPREFIX}/$(python_get_sitedir)/${PN}" \
		docdir="${EPREFIX}/usr/share/doc/${PF}" \
		|| die "install failed"
}
