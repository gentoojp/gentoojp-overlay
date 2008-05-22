# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python eutils

IUSE=""

MY_P="${P/-/_}"

DESCRIPTION="Pseudo AI module AYA version 5 for 'Nanika' and other desktop agents"
SRC_URI="http://members.jcom.home.ne.jp/umeici/aya/v5/download/${MY_P}.lzh
	http://ninix-aya.sourceforge.jp/${MY_P}-python_20040530.diff.gz"
HOMEPAGE="http://members.jcom.home.ne.jp/umeici/"

DEPEND="dev-lang/python
	app-arch/lha
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
	lha x ${DISTDIR}/${MY_P}.lzh

	cd ${S}
	epatch ${DISTDIR}/${MY_P}-python_20040530.diff.gz || die
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
