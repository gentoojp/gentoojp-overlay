# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

MY_PV=${PV//./}
DESCRIPTION="Japanized Tales of Middle Earth"
HOMEPAGE="http://t-o-m-e.net/ http://www.hcn.zaq.ne.jp/kusunose/tome/"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tar.gz
        http://www.hcn.zaq.ne.jp/kusunose/tome/tome-${MY_PV}-j073-src.lzh"

LICENSE="Moria"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="virtual/glibc
	dev-lang/lua
	>=sys-libs/ncurses-5
	virtual/x11"
DEPEND="${RDEPEND}
    app-arch/lha
	>=sys-apps/sed-4"

S=${WORKDIR}/tome-${MY_PV}-src

src_unpack() {
#	unpack ${A}
        unpack tome-${MY_PV}-src.tar.gz
        mv tome-${MY_PV}-src tome-${MY_PV}-j073-src
		# unpack JP patches with conv sjis->euc
        lha -xte ${DISTDIR}/tome-${MY_PV}-j073-src.lzh
        mv tome-${MY_PV}-j073-src tome-${MY_PV}-src

	cd ${S}/src
        # apply JP patch
        epatch "${S}/t226j073a.dif"
	epatch "${FILESDIR}/${PV}-j073-display.patch"
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
	cd ${S}
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
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version of ToME with which you started"
	einfo "those save-games."
}
