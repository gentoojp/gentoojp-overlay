# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

IUSE=""

MY_P="${P/-/_}"

DESCRIPTION="Pseudo AI module AYA version 5 for 'Nanika' and other desktop agents"
SRC_URI="http://umeici.hp.infoseek.co.jp/etcetera/aya/v5/download/${MY_P}.zip
	http://ninix-aya.sourceforge.jp/aya5_237-python_20050205.diff.gz"
HOMEPAGE="http://members.jcom.home.ne.jp/umeici/"

DEPEND="dev-lang/python
	app-arch/unzip
	=dev-libs/boost-1.31*"

KEYWORDS="~x86 ~alpha"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_P}"

pkg_setup(){
	python_version
}

src_unpack(){
	cd ${WORKDIR}
	unzip ${DISTDIR}/${MY_P}.zip

	cd ${S}
	epatch ${DISTDIR}/aya5_237-python_20050205.diff.gz || die
}

src_compile(){
	cd ${S}
	mv makefile.python makefile
	emake || die
}

src_install(){
	exeinto /usr/lib/python${PYVER}/site-packages/ninix-aya
	doexe _aya5.so

	dodoc readme.txt
}
