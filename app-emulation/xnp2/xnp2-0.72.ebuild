# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE="sdl esd oss doc"

DESCRIPTION="NEC PC-9801 Series emulator for X"
SRC_URI="http://www.asahi-net.or.jp/~aw9k-nnk/np2/release/${P}.tar.gz
	doc? ( http://retropc.net/monaka/np2/release/${PN}-html-${PV}.tar.gz )"
HOMEPAGE="http://www.asahi-net.or.jp/~aw9k-nnk/np2/"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	sdl? ( media-libs/libsdl
			media-libs/sdl-mixer )
	esd? ( media-sound/esound )"

LICENSE="as-is"
KEYWORDS="~x86 ~alpha"
SLOT=0

S="${WORKDIR}/${P}/x11"

src_unpack(){
	unpack ${A}
	cd ${S}

	mv config.tmpl config.tmpl.orig

	# Start of Audio configuration.
	if [ "`use oss`" ]
	then
		echo '#define  USE_OSSAUDIO' >> config.tmpl
	else
		echo '#undef   USE_OSSAUDIO' >> config.tmpl
	fi

	if [ "`use sdl`" ]
	then
		echo 'SDL_CONFIG= sdl-config' >> config.tmpl
	 	echo '#define  USE_SDLAUDIO'  >> config.tmpl
	 	echo '#define  USE_SDLMIXER'  >> config.tmpl
	else
		echo '#undef   USE_SDLAUDIO'  >> config.tmpl
	 	echo '#undef   USE_SDLMIXER'  >> config.tmpl
	fi

	if [ "`use esd`" ]
	then
		echo 'ESD_CONFIG= esd-config' >> config.tmpl
		echo '#define  USE_ESDAUDIO'  >> config.tmpl
	else
		echo '#undef   USE_ESDAUDIO'  >> config.tmpl
	fi
	# End of Audio configuration.

	# Start arch configuration.
	if [ "`use sparc`" ] || [ "`use ppc`" ] || [ "`use sparc64`" ]
	then
		echo '#define BIGENDIAN' >> config.tmpl
	else
		echo '#undef BIGENDIAN'  >> config.tmpl
	fi
	# End arch configuration.

	echo "CFLAGS+= ${CFLAGS}" >> config.tmpl

	# bug?
	xmkmf || die
	mv Makefile Makefile.orig
	sed -e "s/\$(DESTDIR)[[:space:]]*/\$(DESTDIR)/" \
		Makefile.orig > Makefile
	cp ${PN}.man ${PN}.man.orig
	cp ${PN}.jman ${PN}.man
}

src_compile(){
	emake || die
}

src_install(){
	emake DESTDIR=${D} install || die
	emake DESTDIR=${D} install.man || die

	dodoc README.ja

	if [ "`use doc`" ]; then
		dodir /usr/share/doc/${PF}
		cp -r ${WORKDIR}/html ${D}/usr/share/doc/${PF}
	fi
}
