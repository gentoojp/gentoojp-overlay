# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="\"The Fountain of Trivia\"'s HE- button"

HOMEPAGE="http://www.3jikai.to/mzk/program/"

SRC_URI="http://www.3jikai.to/mzk/program/${PN}SDL.zip"

LICENSE="freedist"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/glibc virtual/x11 media-libs/libsdl"

src_compile() {

	cd ${WORKDIR}
	gcc ${CFLAGS} he.c -o he_sdl -s `sdl-config --libs --cflags` || die
	sed 's/he.wav/moe.wav/' he.c > moe.c
	gcc ${CFLAGS} moe.c -o moe_sdl -s `sdl-config --libs --cflags` || die
}

src_install() {

	cd ${WORKDIR}
	dobin ${FILESDIR}/he
	exeinto /usr/lib/heSDL
	doexe he_sdl moe_sdl
	insinto /usr/lib/heSDL
	doins *.bmp ${FILESDIR}/moe.wav
	newins he.WAV he.wav
	dodoc README.txt 
}
