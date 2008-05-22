# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

MY_PV="${PV//./}"
DESCRIPTION="imake - C preprocessor interface to the make utility"
SRC_URI="mirror://xfree/${PV}/source/X${MY_PV}src-1.tgz
	mirror://xfree/${PV}/source/X${MY_PV}src-3.tgz"
HOMEPAGE="http://www.xfree.org/"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

DEPEND="virtual/glibc"

S="${WORKDIR}/xc"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	cp ${PORTDIR}/x11-base/xfree/files/${PV}/site.def \
		config/cf/xf86site.def || die
	echo "#define ProjectRoot /usr" > config/cf/host.def || die
	touch config/cf/{date,version}.def || die
}

src_compile() {

	emake Makefile.boot || die
	emake -f xmakefile VerifyOS version.def Makefiles includes || die
}

src_install () {

	emake DESTDIR=${D} install || die
}
