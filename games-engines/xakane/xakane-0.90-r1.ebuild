# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games eutils

IUSE="truetype"

DESCRIPTION="ONE for X"
SRC_URI="http://www.sokohiki.org/~nao/xakane/${P}.tar.gz"
HOMEPAGE="http://www.sokohiki.org/~nao/xakane/"

DEPEND="=dev-cpp/gtkmm-1*
	media-sound/mpg123
	virtual/jpeg
	truetype? ( =media-libs/freetype-1* )"

KEYWORDS="~x86"
LICENSE="BSD"
SLOT="0"

S=${WORKDIR}/${P}

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/xakane-0.90-gcc3.patch
}

src_compile(){

	egamesconf --enable-one-archive=${GAMES_DATADIR}/${PN} \
		--enable-cddev=${GAMES_DATADIR}/${PN}/list || die

	emake || die
}

src_install(){
	egamesinstall || die
	into ${GAMES_PREFIX}
	dobin ${FILESDIR}/xakane
	insinto ${GAMES_DATADIR}/${PN}
	doins ${FILESDIR}/list
	exeinto ${GAMES_DATADIR}/${PN}
	doexe ${FILESDIR}/player_wrapper
	keepdir ${GAMES_DATADIR}/${PN}/bgm
	dodoc COPYING* README INSTALL
	prepgamesdirs
}

pkg_postinst(){
	einfo ""
	einfo "you need copy DAT00 from ONE game disc"
	einfo "to ${GAMES_DATADIR}/${PN}"
	einfo "and rip and convert CD-DA audio to 'track_[02-21].mp3'"
	einfo "copy to ${GAMES_DATADIR}/${PN}/bgm/"
	einfo ""
}
