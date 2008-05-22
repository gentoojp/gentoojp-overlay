# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-im/linphone-im/linphone-im-0.12.1.ebuild,v 1.1 2004/08/20 16:22:29 okayama Exp $

DESCRIPTION="A modified version for Linphone to work with MSN Messenger voice and video conference modes"

HOMEPAGE="http://gaim-vv.sourceforge.net/"

MY_PV=20040705
SRC_URI="http://mh.sodan.ecc.u-tokyo.ac.jp/~okayama/distfiles/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="X alsa sdl zlib"

DEPEND="!net-im/linphone
	>=dev-libs/glib-2
	dev-util/pkgconfig
	=net-libs/libosip-0.9*
	alsa? ( >media-libs/alsa-lib-0.5 )
	sdl? ( media-libs/libsdl )
	zlib? ( sys-libs/zlib )
	X? ( virtual/x11 )"

S=${WORKDIR}/${PN}

src_compile() {

	econf \
		$(use_enable alsa) \
		$(use_with X x) \
		--with-osip=/usr || die "could not configure"

	(cd libr263 && emake library) && emake || die "emake failed"
}

src_install() {

	make DESTDIR=${D} install || die
	insinto /usr/include/${PN} && newins config.h linphone_config.h
	insinto /usr/include/mediastreamer && doins mediastreamer/*h
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
