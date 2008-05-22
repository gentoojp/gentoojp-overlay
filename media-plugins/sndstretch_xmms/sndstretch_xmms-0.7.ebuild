# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

S="${WORKDIR}/${PN}"

DESCRIPTION="an xmms plugin to adjust pitch and speed seperately with two sliders"

SRC_URI="http://www.geocities.com/harpin_floh/mysoft/${P}.tar.gz"

HOMEPAGE="http://www.geocities.com/harpin_floh/sndstretch_page.html"

LICENSE="GPL-2"

DEPEND="media-sound/xmms"
SLOT="0"
IUSE=""

KEYWORDS="~x86"

src_compile() {
	emake || die
}

src_install () {
	XMMS_EPLUGIN_DIR=`xmms-config --effect-plugin-dir`
	XMMS_OPLUGIN_DIR=`xmms-config --output-plugin-dir`
	mkdir -p ${D}/${XMMS_OPLUGIN_DIR}
	mkdir -p ${D}/${XMMS_EPLUGIN_DIR}
	install sndstretch_xmms_out.so ${D}/${XMMS_OPLUGIN_DIR}
	install sndstretch_xmms_eff.so ${D}/${XMMS_EPLUGIN_DIR}
	dodoc ChangeLog COPYING INSTALL README TODO
}
