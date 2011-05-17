# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs

MY_HELP="${PN}-help-20080403"

DESCRIPTION="NEC PC-9801 Series emulator for X"
HOMEPAGE="http://www.asahi-net.or.jp/~aw9k-nnk/np2/"
SRC_URI="http://www.asahi-net.or.jp/~aw9k-nnk/np2/${P}.tar.bz2
	doc? ( http://www.asahi-net.or.jp/~aw9k-nnk/np2/${MY_HELP}.tar.bz2 )"
	# TODO 	内蔵ベルモントの timidity音色ファイル リンク (? 謎)

LICENSE="BSD"
SLOT=0
KEYWORDS="~x86 ~ppc64 ~amd64"
IUSE="doc sound timidity linguas_ja"

RDEPEND=">=x11-libs/gtk+-2.6:2
	x11-libs/libX11
	x11-libs/libXxf86vm
	sound? ( media-libs/libsdl[audio]
		media-libs/sdl-mixer )
	timidity? ( media-sound/timidity++ )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-misc/imake"

S="${WORKDIR}/${P}/x11"

src_configure() {
	rm -f config.tmpl

	# Audio/Video configuration
	if use sound; then
		echo 'SDL_CONFIG= sdl-config' >> config.tmpl
	 	echo '#define  USE_SDLAUDIO'  >> config.tmpl
	 	echo '#define  USE_SDLMIXER'  >> config.tmpl
	else
		echo '#undef   USE_SDLAUDIO'  >> config.tmpl
	 	echo '#undef   USE_SDLMIXER'  >> config.tmpl
	fi
	echo '#define  USE_XF86VIDMODE' >> config.tmpl

	# arch configuration
	if use sparc || use ppc || use ppc64 || use sparc64; then
		echo '#define BIGENDIAN' >> config.tmpl
	else
		echo '#undef BIGENDIAN'  >> config.tmpl
	fi
	echo '#define  CPUCORE_IA32'	>> config.tmpl

	echo "CFLAGS+= ${CFLAGS}" >> config.tmpl

	xmkmf || die "xmkmf failed"
	sed -i -e 's/$(DESTDIR)[[:space:]]*/$(DESTDIR)/' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CCOPTIONS="${CFLAGS}" EXTRA_LDOPTIONS="${LDFLAGS}" \
		CDEBUGFLAGS="" || die "emake failed"
}

src_install(){
	use linguas_ja && mv -f xnp2.{j,}man
	emake DESTDIR="${ED}" install install.man || die "install failed"

	dodoc README.ja
	use doc && dohtml -r "${WORKDIR}/${MY_HELP}/"*
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
