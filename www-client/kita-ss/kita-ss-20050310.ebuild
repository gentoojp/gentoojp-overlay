# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""
SS_P="${P/-ss}"

DESCRIPTION="Kita - 2ch client for KDE [snapshot]"
HOMEPAGE="http://kita.sourceforge.jp/"
SRC_URI="http://kita.sourceforge.jp/snapshot/${SS_P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~alpha ~amd64"
S="${WORKDIR}/${SS_P}"

RDEPEND="virtual/libc
	>=x11-libs/qt-3.1
	>=kde-base/kdebase-3.1
	>=kde-base/kdelibs-3.1
	>=kde-base/arts-1.1.4
	>=dev-libs/libpcre-4.2
	>=dev-libs/expat-1.95.6
	>=sys-libs/zlib-1.1.4
	>=app-admin/fam-2.6.9
	>=media-libs/libpng-1.2.5
	>=media-libs/jpeg-6b
	>=media-libs/freetype-2.1.4
	>=media-libs/fontconfig-2.2.1
	>=media-libs/libart_lgpl-2.3.16
	sys-devel/gettext"
DEPEND="${RDEPEND}
	!www-client/kita
	>=sys-devel/gcc-3.2"

src_compile() {
	addpredict ${QTDIR}/etc

	econf || die
	emake -j1 || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
