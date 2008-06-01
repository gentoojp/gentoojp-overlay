# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PV=${PV//./}
DESCRIPTION="Japanized Tales of Middle Earth"
HOMEPAGE="http://t-o-m-e.net/
	http://ironhell.sakura.ne.jp/angband/tome/"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tar.bz2
        http://ironhell.sakura.ne.jp/angband/tome/tome-${MY_PV}-j075-src.lzh"

LICENSE="Moria"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="dev-lang/lua
	>=sys-libs/ncurses-5
	x11-libs/libX11"
DEPEND="${RDEPEND}
    app-arch/lha
	x11-misc/makedepend"

S="${WORKDIR}"/tome-${MY_PV}-src

src_unpack() {
	#unpack ${A}
	unpack tome-${MY_PV}-src.tar.bz2
	mv tome-${MY_PV}-src tome-${MY_PV}-j075-src
	# unpack JP patches with conv sjis->euc
	lha -xte ${DISTDIR}/tome-${MY_PV}-j075-src.lzh
	mv tome-${MY_PV}-j075-src tome-${MY_PV}-src

	cd "${S}"/src
	# apply JP patch
	epatch "${S}/t231j075.dif"
	epatch "${FILESDIR}/${PV}-j075-display.patch"
	mv makefile.std makefile
	epatch "${FILESDIR}/${PV}-gentoo-paths.patch"
	sed -i \
		-e "s:GENTOO_DIR:${GAMES_STATEDIR}:" files.c init2.c \
		|| die "sed failed"
}

src_compile() {
	cd src
	make depend || die "make depend failed"
	emake -j1 \
		COPTS="${CFLAGS}" \
		BINDIR=${GAMES_BINDIR} \
		LIBDIR=${GAMES_DATADIR}/${PN} \
		|| die "emake failed"
}

src_install() {
	cd src
	emake -j1 \
		OWNER=${GAMES_USER} \
		BINDIR=${D}/${GAMES_BINDIR} \
		LIBDIR=${D}/${GAMES_DATADIR}/${PN} install \
		|| die "make install failed"
	cd "${S}"
	dodoc *.txt

	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}/${PN}-scores.raw"
	prepgamesdirs
	fperms g+w "${GAMES_STATEDIR}/${PN}-scores.raw"
	fperms g+w "${GAMES_DATADIR}/${PN}/data"
	fperms g+w "${GAMES_DATADIR}/${PN}/data/jp"
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "ToME ${PV} is not save-game compatible with previous versions."
	echo
	elog "If you have older save files and you wish to continue those games,"
	elog "you'll need to remerge the version of ToME with which you started"
	elog "those save-games."
}
