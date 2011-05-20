# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils toolchain-funcs

DESCRIPTION="\"The Fountain of Trivia\"'s HE- button"
HOMEPAGE="http://www.3jikai.to/mzk/program/"
SRC_URI="http://www.3jikai.to/mzk/program/${PN}SDL.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[X]"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"


src_prepare() {
	epatch "${FILESDIR}"/${PF}.patch
	sed -e 's/he.wav/moe.wav/g' -e 's/へぇ/萌え/g' he.c > moe.c
}

src_compile() {
	$(tc-getCC)  he.c -o  he_sdl -s $(sdl-config --libs --cflags) || die
	$(tc-getCC) moe.c -o moe_sdl -s $(sdl-config --libs --cflags) || die
}

src_install() {
	dobin "${FILESDIR}"/he

	exeinto "${EPREFIX}"/usr/$(get_libdir)/heSDL
	doexe he_sdl moe_sdl

	insinto "${EPREFIX}"/usr/$(get_libdir)/heSDL
	doins *.bmp "${FILESDIR}"/moe.wav
	newins he.WAV he.wav

	dodoc README.txt
}
