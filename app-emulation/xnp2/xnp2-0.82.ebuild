# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO 	内蔵ベルモントの timidity音色ファイル リンク 

inherit eutils

IUSE="sdl timidity doc"

DESCRIPTION="NEC PC-9801 Series emulator for X"
SRC_URI="http://retropc.net/monaka/np2/release/${P}.tar.bz2
	doc? ( http://retropc.net/monaka/np2/release/${PN}-html-0.80.tar.bz2 )"
HOMEPAGE="http://retropc.net/monaka/np2/"

RDEPEND=">=x11-libs/gtk+-2.6
	sdl? ( media-libs/libsdl
		media-libs/sdl-mixer )
	timidity? ( media-sound/timidity++ )"

DEPEND="${RDEPEND}"

LICENSE="as-is"
KEYWORDS="~x86 ~ppc64 ~amd64"
SLOT=0

S="${WORKDIR}/${P}/x11"

src_unpack(){
	unpack ${A}
	cd ${S}

	mv config.tmpl config.tmpl.orig

	# Start of Audio configuration.
	if use sdl
	then
		echo 'SDL_CONFIG= sdl-config' >> config.tmpl
	 	echo '#define  USE_SDLAUDIO'  >> config.tmpl
	 	echo '#define  USE_SDLMIXER'  >> config.tmpl
	else
		echo '#undef   USE_SDLAUDIO'  >> config.tmpl
	 	echo '#undef   USE_SDLMIXER'  >> config.tmpl
	fi
	# End of Audio configuration.

	# Start arch configuration.
	if use sparc || use ppc || use ppc64 || use sparc64
	then
		echo '#define BIGENDIAN' >> config.tmpl
	else
		echo '#undef BIGENDIAN'  >> config.tmpl
	fi
	# End arch configuration.

	echo '#define  CPUCORE_IA32'	>> config.tmpl
	echo '#define  USE_XF86VIDMODE' >> config.tmpl

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

pkg_postinst(){
	if use timidity ; then
		einfo "** timidity **の設定方法。"
		#einfo "例えば eawpatchesがインストールされているのなら"
		#einfo "   ln -fs /usr/share/timidity/eawpatches/timidity.cfg ~/.np2/"
		einfo "   ln -fs ~/.timidity/current/timidity.cfg ~/.np2/"
		einfo "した後に、xnp2 上メニューから Device -> Midi Option... で"
		einfo "ダイアログから MIDI-OUT : VERMOUSE にして下さい。" 
	fi
}
