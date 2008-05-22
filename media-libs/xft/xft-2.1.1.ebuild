# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.2.1.ebuild,v 1.18 2004/06/24 23:00:12 agriffis Exp $

inherit eutils gcc

DESCRIPTION="X FreeType library"
HOMEPAGE="http://freedesktop.org/"
SRC_URI="http://pdx.freedesktop.org/software/fontconfig/releases/${P}.tar.gz
http://www.kde.gr.jp/~akito/patch/fontconfig/xft-2.1.1/xft-2.1.1-MakeBold-20040405.patch
http://www.kde.gr.jp/~akito/patch/fontconfig/hintstyle/xft-2.1.1-loadtarget.patch"
LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 ~ppc64"
IUSE=""

DEPEND=">=media-libs/fontconfig-2.2.1-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/xft-2.1.1-loadtarget.patch
	epatch ${DISTDIR}/xft-2.1.1-MakeBold-20040405.patch
}

src_compile() {
	[ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ] && \
		die "Dont compile fontconfig with ccc, it doesnt work very well"

	econf \
		--with-docdir=${D}/usr/share/doc/${PF} \
		--bindir=/usr/X11R6/bin \
		--libdir=/usr/X11R6/lib \
		--includedir=/usr/X11R6/include \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib \
		--with-default-fonts=/usr/X11R6/lib/X11/fonts/Type1 || die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
#	einstall confdir=${D}/etc/fonts \
#		datadir=${D}/usr/share \
#		docdir=${D}/usr/share/doc/${P} || die

#	newman Xft.3
#	dodoc ChangeLog README
}
