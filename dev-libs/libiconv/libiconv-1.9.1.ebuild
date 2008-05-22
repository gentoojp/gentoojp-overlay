# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.7.ebuild,v 1.13 2003/05/01 10:19:47 pylon Exp $

LIBICONV_JP="${P}-ja-patch-1"

DESCRIPTION="This is a fork of the glibc iconv implementation that is incompatible. it may break things."
SRC_URI="http://ftp.gnu.org/pub/gnu/libiconv/${P}.tar.gz
	cjk? ( http://www2d.biglobe.ne.jp/~msyk/software/libiconv/${LIBICONV_JP}.diff.gz )"
HOMEPAGE="http://www.gnu.org/software/libiconv/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
IUSE="cjk"

src_unpack() {
	unpack ${P}.tar.gz
	if [ -n "`use cjk`" ] ; then
		epatch ${DISTDIR}/${LIBICONV_JP}.diff.gz
	fi
}

src_compile() {
	econf
	mv man/Makefile man/Makefile.orig
	sed -e 's/mkdir/$(MKDIR)/' man/Makefile.orig > man/Makefile
	emake || die
}

src_install() {
	make MKDIR="mkdir -p" DESTDIR=${D} install || die
}
