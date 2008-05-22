# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.10-r6.ebuild,v 1.8 2004/07/29 03:50:10 tgall Exp $

inherit flag-o-matic eutils libtool

PATCHVER="1.0"

MY_P=${P/_pre/-pre}
S=${WORKDIR}/${MY_P}

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${MY_P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/${P}-gentoo-patches-${PATCHVER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64"
IUSE="xml nls esd opengl mmx oggvorbis 3dnow mikmod directfb ipv6 cjk alsa oss"

DEPEND="=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	opengl? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	sys-devel/gettext
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="${DEPEND}
	nls? ( dev-util/intltool )
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	cd ${S}

	# Add dynamic taste detection patch...
	# goto http://bugs.xmms.org/show_bug.cgi?id=756 to vote for its inclusion in mainline xmms
	# This patch is no longer included in gentoo xmms due to problems with later versions of glib.
	# epatch ${PATCHDIR}/${P}-dtd.patch

	# Fix gcc3.4 C++ problem. See bug #53125
	epatch ${PATCHDIR}/${P}-gcc34.patch

	# id3v2 editing support in mpg123 plugin
	#epatch ${PATCHDIR}/${P}-id3v2edit.patch

	# Patch to allow external programmes to have the "jump to" dialog box
	epatch ${PATCHDIR}/${P}-jump.patch

	# Save playlist, etc on SIGTERM and SIGINT, bug #13604.
	epatch ${PATCHDIR}/${P}-sigterm.patch

	# Patch for mpg123 to convert Japanese character code of MP3 tag info
	# the Japanese patch and the Russian one overlap, so its one or the other
	if use cjk; then
		epatch ${FILESDIR}/${P}-mpg123j.patch
	else
		# add recode patch http://sourceforge.net/projects/rusxmms/
		# epatch ${PATCHDIR}/${P}-recode-csa27.3.dtd.patch
		epatch ${PATCHDIR}/${P}-recode-csa27.3.patch
		epatch ${PATCHDIR}/${P}-recode-csa27.3.regressionFix.patch
		epatch ${PATCHDIR}/${P}-recode-csa27.3.nullTitle.patch
	fi

	# Add /usr/local/share/xmms/Skins to the search path for skins
	epatch ${PATCHDIR}/${P}-fhs-skinsdir.patch

	# This patch passes audio output through the output plugin
	# before recording via the diskwriter plugin
	# http://forum.xmms.org/viewtopic.php?t=500&sid=c286e1c01fb924a2f81f519969f33764
	epatch ${PATCHDIR}/${P}-diskwriter-audio.patch

	# Patch to enable superior randomised playlists:
	epatch ${PATCHDIR}/${P}-random.patch

	# This patch changes the search-bar's behaviour when playing
	# sid tunes using xmms-sid plugin. It enables you to select the
	# different tunes that are sometimes included in a single .sid file
	epatch ${PATCHDIR}/${P}-sid-songpos.patch

	# Bug #45720 ... bugfix when unpausing with alsa
	epatch ${PATCHDIR}/${P}-alsa-pause.patch

	# Bug #47761 ... Patch to enable seeking in HTTP streams
	epatch ${PATCHDIR}/${P}-stream-seek.patch

	if [ ! -f ${S}/config.rpath ] ; then
		touch ${S}/config.rpath
		chmod +x ${S}/config.rpath
	fi

	# dtd updates Makefile.am, but not Makefile.in
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	for subd in .; do
		cd ${S}/${subd}

		ebegin "Running aclocal in ${S}/${subd}"
		aclocal
		eend $?

		ebegin "Running automake in ${S}/${subd}"
		automake --gnu --add-missing --include-deps
		retval=$?
		eend $retval

		if [ $retval -ne 0 ]; then
			exit 1;
		fi
	done

	elibtoolize
}

src_compile() {
	filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE

	local myconf=""

	# Allow configure to detect mipslinux systems
	gnuconfig_update

	if use amd64; then
		myconf="${myconf} --disable-simd"
	else
	  	if use 3dnow || use mmx; then
			myconf="${myconf} --enable-simd"
		else
			myconf="${myconf} --disable-simd"
		fi
	fi

	use xml || myconf="${myconf} --disable-cdindex"

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
		`use_enable ipv6` \
		`use_enable oss oss` \
		${myconf} \
		|| die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ NEWS README TODO

	keepdir /usr/share/xmms/Skins
	insinto /usr/share/pixmaps/
	donewins xmms/xmms_logo.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/xmms.desktop
	insinto /usr/share/applnk/Multimedia
	doins ${FILESDIR}/xmms.desktop
	insinto /usr/share/applications
	doins ${FILESDIR}/xmms.desktop

	# Add the sexy Gentoo Ice skin
	insinto /usr/share/xmms/Skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README
}
