# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${P/_beta/-beta}
SF_DLID="24596"

DESCRIPTION="gtk2 based 2ch browser written in C++"
HOMEPAGE="http://jd4linux.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/jd4linux/${SF_DLID}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.6
	>=dev-cpp/glibmm-2.6
	>=dev-libs/libsigc++-2.0
	>=x11-libs/gtk+-2.6
	dev-libs/expat
	media-libs/libpng
	>=sys-libs/zlib-1.2
	>=dev-libs/openssl-0.9.7"
DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sh autogen.sh || die "autogen.sh failed"
	sed -i -e '/^CXXFLAGS/s:-ggdb::' configure || die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doicon ${PN}.png
	domenu ${PN}.desktop
	dodoc COPYING README ChangeLog
}
