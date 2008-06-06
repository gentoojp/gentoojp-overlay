# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="\"The Fountain of Trivia\"'s HE- button"
HOMEPAGE="http://www.3jikai.to/mzk/program/"
SRC_URI="http://www.3jikai.to/mzk/program/${PN}SDL.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

pkg_setup() {
	if ! built_with_use media-libs/libsdl X; then
		eerror "rebuild libsdl with USE=X"
		die "libsdl needs to be built with X"
	fi
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PF}.patch
	sed -e 's/he.wav/moe.wav/g' -e 's/へぇ/萌え/g' he.c > moe.c
}

src_compile() {
	$(tc-getCC)  he.c -o  he_sdl -s `sdl-config --libs --cflags` || die
	$(tc-getCC) moe.c -o moe_sdl -s `sdl-config --libs --cflags` || die
}

src_install() {
	dobin "${FILESDIR}"/he

	exeinto /usr/lib/heSDL
	doexe he_sdl moe_sdl

	insinto /usr/lib/heSDL
	doins *.bmp "${FILESDIR}"/moe.wav
	newins he.WAV he.wav

	dodoc README.txt 
}
