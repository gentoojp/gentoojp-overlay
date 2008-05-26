# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV=${PV:0:4}_${PV:4:2}_${PV:6:2}
MY_P=${PN}-${MY_PV}

DESCRIPTION="CPPLapack is a C++ class wrapper for BLAS and LAPACK."
HOMEPAGE="http://cpplapack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/blas
	sci-libs/blas-config
	virtual/lapack
	sci-libs/lapack-config"

S=${WORKDIR}/${MY_P}

src_install() {

	dobin ${FILESDIR}/cpplapack-config
	dosed "s:@VERSION@:${MY_PV}:g"     /usr/bin/cpplapack-config
	dosed "s:@LIBDIR@:$(get_libdir):g" /usr/bin/cpplapack-config

	insinto /usr/include/${PN}
	doins -r include/*

	dodoc README

	insinto /usr/share/doc/${PF}
	doins -r doc/*
	doins -r makefiles
	doins -r test
	doins -r benchmark

	echo "BLAS_LIBS=\"`/usr/bin/blas-config --clibs`\""            >> config
	echo "LAPACK_LIBS=\"`/usr/bin/lapack-config --f77libs`\""      >> config
	echo "CXXFLAGS=\"-I/usr/include/${PN} -Wno-unknown-pragmas \"" >> config
	echo 'CXXLIBS="${BLAS_LIBS} ${LAPACK_LIBS}"'                   >> config
	insinto /usr/$(get_libdir)/${PN}
	doins config
}

pkg_postinst() {

	echo  ""
	einfo "Configuration Command: /usr/bin/cpplapack-config"
	einfo "Configuration File:    /usr/$(get_libdir)/${PN}/config"
	echo  ""
}
