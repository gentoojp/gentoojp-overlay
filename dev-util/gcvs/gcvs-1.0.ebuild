# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="GUI frontend for CVS from the CVSGUI project"
SRC_URI="mirror://sourceforge/cvsgui/${P}.tar.gz"
HOMEPAGE="http://cvsgui.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	=x11-libs/gtk+-1.2*
	>=dev-lang/tcl-8.3.3
	dev-lang/perl
	sys-devel/bison
	=dev-util/glademm-0.6*"

RDEPEND="${DEPEND}
	>=dev-util/cvs-1.11-r1"

src_unpack() {

	unpack ${A}
	cd ${S}

	mv configure configure.orig
	sed 's| cvsunix||g' configure.orig > configure
	chmod +x configure
	mv Makefile.in Makefile.in.orig
	sed 's| cvsunix||g' Makefile.in.orig > Makefile.in

	epatch ${FILESDIR}/${P}-gcc3-gentoo.patch
}

src_compile() {

	econf || die "could not configure"
	emake || die "emake failed"
}

src_install () {

	make install DESTDIR=${D}

	# note: html docs ignored because they focus on the mac and windows
	# version and seem to be of questionable use with gcvs

	dodoc AUTHORS COPYING ChangeLog INSTALL README
}
