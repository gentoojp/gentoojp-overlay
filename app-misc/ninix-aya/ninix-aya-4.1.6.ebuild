# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Desktop mascot currently called that like 'Are Igai No Nanika' for X"
HOMEPAGE="http://ninix-aya.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/52006/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome extra nls"

RDEPEND=">=dev-python/pygtk-2.17
	dev-python/numpy
	dev-python/gst-python
	gnome? ( dev-python/gconf-python )
	extra? ( dev-python/chardet
		dev-python/httplib2 )"
DEPEND="${RDEPEND}"

src_install(){
	emake install DESTDIR="${D}" \
		prefix="${EPREFIX}/usr" \
		exec_libdir="${EPREFIX}/$(python_get_sitedir)/${PN}" \
		docdir="${ED}"/usr/share/doc/${PF} \
		python=python2 \
		|| die "emake install failed"

	dodoc doc/*

	use nls || rm -rf "${ED}"/usr/share/locale
}
