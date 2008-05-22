# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

IUSE="alsa esd oss truetype joystick"

DESCRIPTION="System 3.5 for X Window System"
SRC_URI="http://8ne.sakura.ne.jp:20008/chika/unitbase/xsys35/down/test/${PN}-1.7.3-pre2.tar.gz"
HOMEPAGE="http://8ne.sakura.ne.jp:20008/chika/unitbase/xsys35/index.html"

DEPEND="=x11-libs/gtk+-1*
	media-libs/libvorbis
	sys-libs/zlib
	alsa? ( virtual/alsa )
	esd? ( media-sound/esound )
	truetype? ( =media-libs/freetype-1* )"

KEYWORDS="~x86"
LICENSE="GPL"
SLOT="0"

S=${WORKDIR}/${PN}-1.7.3-pre2

src_compile(){
	egamesconf `use_enable joystick joy` \
		--enable-cdrom=linux,mp3 || die "faild configure"

	make || die "faild emake"
}

src_install(){
	egamesinstall || die
	into ${GAMES_PREFIX}
	dobin ${FILESDIR}/xsystem35-install
	insinto ${GAMES_DATADIR}/${PN}
	doins ${S}/contrib/* ${S}/src/xsys35rc.sample
	exeinto ${GAMES_DATADIR}/${PN}
	doexe ${S}/contrib/instgame

	dodoc COPYING INSTALL doc/README* doc/FAQ doc/GAMES.TXT \
			doc/GRFMT.TXT doc/MISCGAME.TXT doc/BUGS contrib/README.TXT

	prepgamesdirs
}

pkg_postinst(){
	einfo ""
	einfo "you need GAME DISC maid by ALICE SOFT"
	einfo "mount GAME DISC and type command"
	einfo "\$ system35-install HOGE.inf"
	einfo "'HOGE.inf' in ${GAMES_DATADIR}/${PN}/, you can choose suitable file"
	einfo "after installed game data, you type"
	einfo "\$ system35 -gamefile ~/game/HOGE.gr"
	einfo ""
}
