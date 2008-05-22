# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python cvs

IUSE="gtk gnuplot"

ECVS_SERVER="cvs.sourceforge.jp:/cvsroot/abla"
ECVS_MODULE="abla"

DESCRIPTION="The Internet Monitoring System, Agent Based Log Analyzing System on P2P Network"
HOMEPAGE="http://abla.sourceforge.jp/"

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pylibpcap-0.4
	gtk? ( >=dev-python/pygtk-2.6 )
	gnuplot? ( >=dev-python/gnuplot-py-1.7 )"

KEYWORDS="~x86 ~alpha"
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
