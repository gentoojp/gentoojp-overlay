# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/he/he-0.00-r3.ebuild,v 1.4 2005/10/15 12:02:02 okayama Exp $

inherit eutils toolchain-funcs

DESCRIPTION="\"The Fountain of Trivia\"'s HE- button"

HOMEPAGE="http://www.3jikai.to/mzk/program/"
SRC_URI="http://www.3jikai.to/mzk/program/${PN}SDL.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/libc media-libs/libsdl"

S=${WORKDIR}

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${PF}.patch
	sed -e 's/he.wav/moe.wav/g' -e 's/へぇ/萌え/g' he.c > moe.c
}

src_compile() {

	$(tc-getCC)  he.c -o  he_sdl -s `sdl-config --libs --cflags` || die
	$(tc-getCC) moe.c -o moe_sdl -s `sdl-config --libs --cflags` || die
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
