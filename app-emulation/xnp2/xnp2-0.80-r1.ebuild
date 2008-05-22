# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

IUSE="sdl esd oss doc gtk2"

DESCRIPTION="NEC PC-9801 Series emulator for X"
SRC_URI="http://retropc.net/monaka/np2/release/${P}.tar.bz2
	doc? ( http://retropc.net/monaka/np2/release/${PN}-html-0.80.tar.bz2 )"
HOMEPAGE="http://retropc.net/monaka/np2/"

DEPEND="virtual/x11
	gtk2? ( >=x11-libs/gtk+-2 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	sdl? ( media-libs/libsdl
		media-libs/sdl-mixer )
	esd? ( media-sound/esound )"

LICENSE="as-is"
KEYWORDS="~x86 ~ppc64 ~amd64"
SLOT=0

S="${WORKDIR}/${P}/x11"

src_unpack(){
	unpack ${A}
	cd ${S}

	mv config.tmpl config.tmpl.orig

	# Start of Audio configuration.
	if use oss
	then
		echo '#define  USE_OSSAUDIO' >> config.tmpl
	else
		echo '#undef   USE_OSSAUDIO' >> config.tmpl
	fi

	if use sdl
	then
		echo 'SDL_CONFIG= sdl-config' >> config.tmpl
	 	echo '#define  USE_SDLAUDIO'  >> config.tmpl
	 	echo '#define  USE_SDLMIXER'  >> config.tmpl
	else
		echo '#undef   USE_SDLAUDIO'  >> config.tmpl
	 	echo '#undef   USE_SDLMIXER'  >> config.tmpl
	fi

	if use esd
	then
		echo 'ESD_CONFIG= esd-config' >> config.tmpl
		echo '#define  USE_ESDAUDIO'  >> config.tmpl
	else
		echo '#undef   USE_ESDAUDIO'  >> config.tmpl
	fi
	# End of Audio configuration.

    # Start of GUI Toolkit configuration.
	if use gtk2
	then
		echo 'GTK_CONFIG= pkg-config gtk+-2.0' >> config.tmpl
		echo '#define  USE_GTK2' >> config.tmpl
	else
		echo 'GTK_CONFIG= gtk-config' >> config.tmpl
	fi
    # End of GUI Toolkit configuration.

	# Start arch configuration.
	if use sparc || use ppc || use ppc64 || use sparc64
	then
		echo '#define BIGENDIAN' >> config.tmpl
	else
		echo '#undef BIGENDIAN'  >> config.tmpl
	fi
	# End arch configuration.

	echo "CFLAGS+= ${CFLAGS}" >> config.tmpl
}

src_compile(){
	xmkmf || die
	mv Makefile Makefile.orig
	sed -e "s/\$(DESTDIR)[[:space:]]*/\$(DESTDIR)/" \
		Makefile.orig > Makefile
	cp ${PN}.man ${PN}.man.orig
	cp ${PN}.jman ${PN}.man

	emake || die
}

src_install(){
	emake DESTDIR=${D} install || die
	emake DESTDIR=${D} install.man || die

	dodoc README.ja

	if use doc ; then
		dodir /usr/share/doc/${PF}
		cp -r ${WORKDIR}/html ${D}/usr/share/doc/${PF}
	fi
}
