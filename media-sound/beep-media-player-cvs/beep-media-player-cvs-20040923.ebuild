# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cvs flag-o-matic

ECVS_BRANCH=""
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/beepmp"
ECVS_USER="anonymous"
ECVS_MODULE="bmp"

DESCRIPTION="Beep Media Player"
HOMEPAGE="http://beepmp.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE="nls gnome opengl oggvorbis mikmod alsa oss esd mmx"

RDEPEND="app-arch/unzip
	>=x11-libs/gtk+-2.4
	>=x11-libs/pango-1.4
	>=dev-libs/libxml-1.8.15
	>=gnome-base/libglade-2.4
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.29 )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )"
DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	cvs_src_unpack || die
	
	cd ${S}
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	./autogen.sh -n || die
}

src_compile() {
	local myconf=""

	# Bug #42893
	replace-flags "-Os" "-O2"

	if use gnome; then
		myconf="${myconf} --enable-gconf --enable-gnome-vfs"
	fi

	if use mmx; then
		myconf="${myconf} --enable-simd"
	fi

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_enable esd` \
		`use_enable esd esdtest` \
		`use_enable mikmod` \
		`use_enable mikmod mikmodtest` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable oss` \
		`use_enable alsa` \
		${myconf} \
		|| die

	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"

	insinto /usr/share/pixmaps
	doins beep.svg
	doins beep/beep_mini.xpm

	# Get the app registered in gnome

	if use gnome; then
		dodir /usr/share/gnome/apps
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/beep-media-player.desktop
	fi

	# We'll use xmms skins / plugins for the time being

	dodir /usr/share/beep
	dosym /usr/share/xmms/Skins /usr/share/beep/Skins
	dosym /usr/share/xmms/Plugins /usr/share/beep/Plugins

	# Plugins want beep-config, this wasn't included
	dobin ${FILESDIR}/beep-config

	dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO
}

pkg_postinst() {
	echo
	einfo "This program is unstable on sparc when poking heavily with the GUI."
	einfo "It's reportedly unstable on some x86 boxes also, YMMV."
	echo
	einfo "We're using xmms skins/plugins for the time being, they have been symlinked."
	echo
}
