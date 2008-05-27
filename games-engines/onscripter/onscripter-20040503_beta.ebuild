# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

IUSE="oggvorbis avi mad"

MY_PN="${PN}-beta"
MY_PV="${PV%_beta}"

DESCRIPTION="A clone of nscripter"
SRC_URI="http://ogapee.at.infoseek.co.jp/${MY_PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://ogapee.tripod.co.jp/onscripter.html"

DEPEND=">=sys-devel/gcc-2.95.4
	>=media-libs/jpeg-6b
	>=app-arch/bzip2-1.0.2
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.3
	>=media-libs/sdl-ttf-2.0.5
	>=media-libs/freetype-2.1.3
	oggvorbis? ( >=media-libs/libogg-1.0
				>=media-libs/libvorbis-1.0 )
	avi? ( >=media-video/avifile-0.7.38 )
	mad? ( >=media-libs/libmad-0.14.2b ) : ( >=media-libs/smpeg-0.4.4 )"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
SLOT="0"

S="${WORKDIR}/${MY_PN}"

src_unpack(){
	unpack ${A}
	cd ${S}

	{
		# includes
		echo 'INCS = `sdl-config --cflags`'

		# libraries
		echo 'LIBS = `sdl-config --libs` -lSDL_ttf -lSDL_image -lSDL_mixer -lbz2 -ljpeg -lm'

		# defines
		echo 'DEFS = -DLINUX'

		# misc
		cat <<-'EOF'
			EXESUFFIX =
			OBJSUFFIX = .o

			.SUFFIXES:
			.SUFFIXES: $(OBJSUFFIX) .cpp .h

			CC = g++
			LD = g++ -o
			RM = rm -f
		EOF

		# cflags
		echo 'CFLAGS = -g -Wall -Wpointer-arith -pipe -c $(INCS) $(DEFS)'
		echo "CFLAGS += ${CFLAGS}"

		# target, extobjs
		echo 'TARGET = onscripter$(EXESUFFIX) sardec$(EXESUFFIX) nsadec$(EXESUFFIX) sarconv$(EXESUFFIX) nsaconv$(EXESUFFIX)'

		# USE
		if [ "`use avi`" ]; then 
			echo 'INCS += `avifile-config --cflags`'
			echo 'LIBS += `avifile-config --libs`'
			echo 'DEFS += -DUSE_AVIFILE'
			echo 'TARGET += simple_aviplay$(EXESUFFIX)'
			echo 'EXT_OBJS = AVIWrapper$(OBJSUFFIX)'
		fi
			
		if [ "`use mad`" ]; then
			echo 'INCS += `smpeg-config --cflags`'
			echo 'LIBS += -lmad' || echo 'LIBS += `smpeg-config --libs`'
			echo 'DEFS += -DMP3_MAD'
			echo 'EXT_OBJS += MadWrapper$(OBJSUFFIX)'
		fi

		if [ "`use oggvorbis`" ]; then
			echo 'LIBS += -lvorbis'	
			echo 'DEFS += -DUSE_OGG_VORBIS'
		fi

		# include Makefile.onscripter
		echo 'include Makefile.onscripter'

	} > Makefile
}

src_compile(){
	emake || die
}

src_install(){
	dogamesbin  nsaconv nsadec onscripter sarconv sardec
	use avi && dogamesbin simple_aviplay

	dodoc COPYING README
	docinto www
	dohtml www/*

	prepgamesdirs
}
