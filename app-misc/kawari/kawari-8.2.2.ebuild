# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

IUSE="doc"

MY_P="${P//.}"

DESCRIPTION="Pseudo AI module for 'Nanika' and other desktop agents for ninix"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
HOMEPAGE="http://kawari.sourceforge.net/"

DEPEND="dev-lang/python"
RDEPEND="app-misc/ninix-aya"

KEYWORDS="~x86 ~alpha"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_P}"

pkg_setup(){
	python_version
}

src_unpack(){
	unpack ${A}
	cd ${S}/build/src
	sed -e "s/^\(MACH_TYPE =\) mingw/\1 linux/" \
		-e "s/^\(STLport =\) yes/\1 no/" \
		-e "s/^\(UPX\)/#\1/" \
		-e "s/^#\(PYTHON = yes\)/\1/" \
		-e 's!^# \(PYTHON_LIBS =\) -L/python22jp/libs!\1 -lpython$(shell python -c "import sys; print sys.version[:3]")!' \
		gcc.mak > Makefile
}

src_compile(){
	cd ${S}/build/src
	emake CFLAGS="${CFLAGS} -I. -I/usr/include/python${PYVER} -fPIC" \
		../mach/linux/libshiori.so || die
}

src_install(){
	cd ${S}/build/mach/linux
	exeinto /usr/lib/python${PYVER}/site-packages/ninix-aya
	newexe libshiori.so _kawari8.so

	cd ${S}
	dodoc license.txt readme.1st

	if use doc; then
		for dir in document document/images document/banners
		do
			(
				cd ${S}/${dir}
				docinto ${dir}
				dohtml *
			)
		done
	fi
}
