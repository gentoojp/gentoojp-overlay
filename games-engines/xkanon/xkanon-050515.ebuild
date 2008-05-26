# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils
append-flags -DUSE_OSS

IUSE="alsa esd truetype joystick mp3"

DESCRIPTION="KANON for X"
SRC_URI="http://creator.club.ne.jp/~jagarl/${P}.tar.gz"
HOMEPAGE="http://creator.club.ne.jp/~jagarl/xkanon.html"

DEPEND="sys-libs/glibc
	=dev-cpp/gtkmm-1.2*
	=x11-libs/gtk+-1.2*
	alsa? ( virtual/alsa )
	esd? ( media-sound/esound )
	truetype? ( =media-libs/freetype-1* )
	mp3? ( media-sound/mpg123 )"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${PN}

src_compile(){

	econf `use_enable alsa` \
		`use_enable esd` \
		`use_enable truetype freetype` \
		`use_enable joystick joy` \
		`use_enable mp3` || die

	emake || die
}

src_install(){
	dodir /usr/bin

	einstall PREFIX=${D}/usr || die
	dodoc COPYING* README
}
