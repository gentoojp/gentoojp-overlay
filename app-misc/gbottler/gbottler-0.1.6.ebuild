# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

DESCRIPTION="yet another bottler.py using GTK+2"
HOMEPAGE="http://gbottler.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/31311/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/python
	>=x11-libs/gtk+-2.6
	>=dev-python/pygtk-2.6
	dev-python/pyxml"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup(){
	python_version
}

src_compile(){
	emake prefix=/usr \
		libdir=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN} \
		docdir=/usr/share/doc/${PF} \
		|| die "Compile failed."
}

src_install(){
	emake prefix="${D}"/usr \
		libdir="${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/${PN} \
		docdir="${D}"/usr/share/doc/${PF} \
		install || die "Install failed."

	prepalldocs
}
