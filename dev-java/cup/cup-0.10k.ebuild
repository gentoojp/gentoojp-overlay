# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-java/cup/cup-0.10k.ebuild,v 1.3 2004/06/04 06:14:48 okayama Exp $

inherit java-pkg

DESCRIPTION="Java(tm) Based Constructor of Useful Parsers"

HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/CUP/"

MY_PV=${PV/0\./v}
SRC_URI="http://www.cs.princeton.edu/~appel/modern/java/CUP/java_${PN}_${MY_PV}.tar.gz"

LICENSE="jlex"

SLOT="0"

KEYWORDS="~x86"

IUSE="jikes doc"

DEPEND=">=virtual/jdk-1.1"

S=${WORKDIR}

src_compile() {

	cd java_cup
	if [ `use jikes` ]; then
		jikes -q *.java runtime/*.java simple_calc/*.java
	else
		javac -nowarn *.java runtime/*.java simple_calc/*.java
	fi
}

src_install() {

	dodoc CHANGELOG INSTALL* LICENSE README
	use doc && dohtml manual.html cup_logo.gif
	find . -name '*.java' -exec rm {} \;
	zip -rq cup.jar java_cup
	java-pkg_doclass cup.jar
}
