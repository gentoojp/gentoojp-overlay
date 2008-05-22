# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games eutils

IUSE="truetype"

DESCRIPTION="ONE for X"
SRC_URI="http://www.sokohiki.org/~nao/xakane/${P}.tar.gz
		http://ieice.comlab.soft.iwate-pu.ac.jp/~g031y177/gentoo/dists/${P}-gcc3.patch"
HOMEPAGE="http://www.sokohiki.org/~nao/xakane/"

DEPEND="=dev-cpp/gtkmm-1*
	media-sound/mpg123
	media-libs/jpeg
	truetype? ( =media-libs/freetype-1* )"

KEYWORDS="~x86"
LICENSE="BSD"
SLOT="0"

S=${WORKDIR}/${P}

src_unpack(){
	unpack ${A}
	epatch ${DISTDIR}/xakane-0.90-gcc3.patch
}

src_compile(){

	econf --enable-one-archive=${GAMES_DATADIR}/${PN} \
		--enable-cddev=${GAMES_DATADIR}/${PN}/list || die

	emake || die
}

src_install(){
	einstall || die
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
	einfo "you need copy DAT00 from ONE game disc"
	einfo "to ${GAMES_DATADIR}/${PN}"
	einfo "and rip and convert CD-DA audio to 'track_[02-21].mp3'"
	einfo "copy to ${GAMES_DATADIR}/${PN}/bgm/"
}
