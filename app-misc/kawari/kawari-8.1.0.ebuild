# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils

IUSE=""

MY_P="${P//.}"

DESCRIPTION="Pseudo AI module for 'Nanika' and other desktop agents for ninix"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.lzh
	http://rinakusu.at.infoseek.co.jp/${MY_P}-py-module.patch"
HOMEPAGE="http://kawari.sourceforge.net/
	http://rinakusu.at.infoseek.co.jp/"

DEPEND="dev-lang/python
	app-arch/lha"

KEYWORDS="~x86 alpha"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	cd ${WORKDIR}
	lha x ${DISTDIR}/${MY_P}.lzh

	cd "${S}"
	epatch ${DISTDIR}/${MY_P}-py-module.patch || die
}

src_compile(){
	distutils_python_version

	cd "${S}"/build/src
	emake CFLAGS="${CFLAGS} -I. -I/usr/include/python${PYVER} -fPIC" \
		-f gcc.mak ../mach/linux/libshiori.so \
		|| die
}

src_install(){
	cd "${S}"/build/mach/linux
	exeinto /usr/lib/ninix
	newexe libshiori.so _kawari8.so

	cd "${S}"
	dodoc license.txt readme.1st

	for dir in document document/images document/banners
	do
	  (
		  cd "${S}"/${dir}
		  docinto ${dir}
		  dohtml *
	  )
	done
}
