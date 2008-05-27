# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="\"The Fountain of Trivia\"'s HE- button"

HOMEPAGE="http://www.3jikai.to/mzk/program/"

SRC_URI="http://www.3jikai.to/mzk/program/${PN}SDL.zip"

LICENSE="freedist"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/glibc media-libs/libsdl"

src_compile() {

	cd ${WORKDIR}
	gcc ${CFLAGS} he.c -o he_sdl -s `sdl-config --libs --cflags` || die
}

src_install() {

	cd ${WORKDIR}
	echo "#!/bin/sh" > he-
	echo "cd /usr/lib/heSDL ; ./he_sdl" >> he-
	dobin he-
	exeinto /usr/lib/heSDL
	doexe he_sdl
	insinto /usr/lib/heSDL
	doins *.bmp
	newins he.WAV he.wav
	dodoc README.txt 
}
