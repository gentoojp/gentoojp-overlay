# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="XEVIOUS like shooting game"

HOMEPAGE=""
SRC_URI="http://www.nemoto.ecei.tohoku.ac.jp/~wai/Xbat/xev111.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/Xev111

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	sed -i \
		-e 's:/usr/local/games/Xbat/Score:${GAMES_STATEDIR}/${PN}:' \
		-e 's:/usr/local/games/Xbat:${GAMES_DATADIR}/${PN}:' \
		-e 's:/usr/local/bin:${GAMES_PREFIX}/bin:' \
		Imakefile || die "sed Imakefile failed"
}

src_compile() {
	xmkmf -a || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README README.jp
	prepgamesdirs
}
