# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="\"The Fountain of Trivia\"'s HE- button"

HOMEPAGE="http://www.3jikai.to/mzk/program/"

SRC_URI="http://www.3jikai.to/mzk/program/${PN}SDL.zip"

LICENSE="freedist"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/libc virtual/x11 media-libs/libsdl"

S=${WORKDIR}

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${PF}.patch
	sed 's/he.wav/moe.wav/' he.c > moe.c
}

src_compile() {

	${CC} ${CFLAGS} he.c -o he_sdl -s `sdl-config --libs --cflags` || die
	${CC} ${CFLAGS} moe.c -o moe_sdl -s `sdl-config --libs --cflags` || die
}

src_install() {

	dobin ${FILESDIR}/he
	exeinto /usr/lib/heSDL
	doexe he_sdl moe_sdl
	insinto /usr/lib/heSDL
	doins *.bmp ${FILESDIR}/moe.wav
	newins he.WAV he.wav
	dodoc README.txt 
}
