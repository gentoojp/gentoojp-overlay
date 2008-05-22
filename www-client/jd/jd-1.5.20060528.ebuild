# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

JD_BETA="1.5"
MY_DATE=${PV##*.}
MY_PV=${PV/#${JD_BETA}/${JD_BETA}rc}
MY_PV=${MY_PV%.*}${MY_DATE:2}
MY_PV=${MY_PV//.}
MY_P=${PN}-${MY_PV}

DESCRIPTION="gtk2 based 2ch browser written in C++"
HOMEPAGE="http://www.geocities.jp/jd4linux/"
SRC_URI="http://www.geocities.jp/jd4linux/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.6
	>=dev-cpp/glibmm-2.6
	>=dev-libs/libsigc++-2.0
	>=x11-libs/gtk+-2.6
	media-libs/libpng
	dev-libs/expat
	>=sys-libs/zlib-1.2
	>=dev-libs/openssl-0.9.7"
DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/jd-15b060522-64bit-type-fix.patch || die "epatch failed"
	sh autogen.sh || die "autogen.sh failed"
	sed -i -e '/^CXXFLAGS/s:-ggdb::' configure || die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doicon ${PN}.png
	domenu ${PN}.desktop
	dodoc COPYING README ChangeLog INSTALL
}
