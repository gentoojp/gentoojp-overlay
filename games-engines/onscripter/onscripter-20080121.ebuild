# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games toolchain-funcs

DESCRIPTION="A clone of nscripter"
HOMEPAGE="http://ogapee.tripod.co.jp/onscripter.html"
SRC_URI="http://ogapee.at.infoseek.co.jp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="vorbis"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/smpeg
	media-libs/jpeg
	media-libs/freetype
	app-arch/bzip2
	vorbis? ( >=media-libs/libogg
			>=media-libs/libvorbis )"


src_unpack(){
	unpack ${A}
	cd "${S}"

	local flags libs
	flags="${CXXFLAGS} -Wall -Wpointer-arith -pipe -c"
	target='onscripter sardec nsadec sarconv nsaconv'

	# sdl, smpeg stuff
	flags="${flags} "'`sdl-config --cflags` `smpeg-config --cflags` -DLINUX'
	libs='`sdl-config --libs` `smpeg-config --libs` -lSDL_ttf -lSDL_image -lSDL_mixer -lbz2 -ljpeg -lm'
	
	if use vorbis; then
		flags="${flags} -DUSE_OGG_VORBIS"
		libs="${libs} -logg -lvorbis -lvorbisfile"
	fi
	
	cat > Makefile <<-EOF
		EXESUFFIX =
		OBJSUFFIX = .o

		.SUFFIXES:
		.SUFFIXES: .o .cpp .h

		CC = $(tc-getCXX) 
		LD = $(tc-getCXX) -o
		RM = rm -f
		CFLAGS = ${flags}
		LIBS = ${libs}

		TARGET = onscripter sardec nsadec sarconv nsaconv
		EXT_OBJS =

		include Makefile.onscripter
	EOF
}

src_install(){
	dogamesbin nsaconv nsadec onscripter sarconv sardec

	dodoc COPYING README
	docinto www
	dohtml www/*

	prepgamesdirs
}
