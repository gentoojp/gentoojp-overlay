# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python cvs

IUSE=""

ECVS_SERVER="cvs.sourceforge.jp:/cvsroot/gbottler"
ECVS_MODULE="gbottler"

DESCRIPTION="yet another bottler.py using GTK+2"
HOMEPAGE="http://gbottler.sourceforge.jp/"

DEPEND="virtual/python
	>=x11-libs/gtk+-2.6
	>=dev-python/pygtk-2.6
	dev-python/pyxml"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${ECVS_MODULE}"

pkg_setup(){
	python_version
}

src_compile(){
	emake prefix=/usr \
		libdir=/usr/lib/python${PYVER}/site-packages/${ECVS_MODULE} \
		docdir=/usr/share/doc/${PF} \
		|| die "Compile failed."
}

src_install(){
	emake prefix=${D}/usr \
		libdir=${D}/usr/lib/python${PYVER}/site-packages/${ECVS_MODULE} \
		docdir=${D}/usr/share/doc/${PF} \
		install || die "Install failed."

	prepalldocs
}
