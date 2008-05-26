# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit findlib fortran toolchain-funcs

DESCRIPTION="BLAS/LAPACK-interface for OCaml"

HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html#toc12"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND="dev-lang/ocaml
	dev-ml/findlib
	virtual/blas
	virtual/lapack"

pkg_setup() {

	fortran_pkg_setup
}

src_unpack() {

	unpack "${A}"
	cd "${S}"
	mv COPYRIGHT AUTHORS

	if [[ "${FORTRANC}" == "gfortran" ]]
	then
		sed -i.bak s/g2c/gfortran/ Makefile.conf
	fi
}

src_compile() {

	emake CC="$(tc-getCC)" || die "emake failed."

	if use examples
	then
		emake examples CC="$(tc-getCC)" || ewarn "emake examples failed."
	fi
}

src_install() {

	findlib_src_install

	dodoc AUTHORS Changes INSTALL LICENSE README TODO VERSION

	if use examples
	then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
