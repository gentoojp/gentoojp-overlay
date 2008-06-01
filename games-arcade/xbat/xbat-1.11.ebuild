# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="XEVIOUS like shooting game"
HOMEPAGE="http://www.nemoto.ecei.tohoku.ac.jp/~wai/Xbat/"
SRC_URI="http://www.nemoto.ecei.tohoku.ac.jp/~wai/Xbat/xev111.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}"/Xev111

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"

	sed -i \
		-e 's:/usr/local/games/Xbat/Score:${GAMES_STATEDIR}/${PN}:' \
		-e 's:/usr/local/games/Xbat:${GAMES_DATADIR}/${PN}:' \
		-e 's:/usr/local/bin:${GAMES_PREFIX}/bin:' \
		Imakefile || die "sed Imakefile failed"
}

src_compile() {
	xmkmf -a || die "xmkmf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README README.jp
	prepgamesdirs
}
