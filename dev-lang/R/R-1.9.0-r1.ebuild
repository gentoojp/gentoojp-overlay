# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-lang/R/R-1.9.0-r1.ebuild,v 1.1 2004/05/14 13:42:27 okayama Exp $

inherit eutils

IUSE="atlas X tcltk gnome jpeg png zlib readline cjk doc mozilla"

DESCRIPTION="R is GNU S - A language and environment for statistical computing and graphics."

RELEASE_PATCH="${PN}-release-20040430.diff.gz"
VALUE_PATCH="${P}.i18n.20040422.patch"
REGEX_PATCH="${P}.i18n.regex.20040422.patch"
X11_PATCH="${P}.i18n.x11_mb.20040523.patch"
TCLTK_PATCH="${P}.i18n.tcltk.20040422.patch"
FIG_PATCH="${P}.l10n.psxfigtex.20040422.patch"

SRC_URI="http://cran.r-project.org/src/base/${P}.tgz
	cjk? ( http://r.nakama.ne.jp/${P}/patchs/${VALUE_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${REGEX_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${TCLTK_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${FIG_PATCH} )"

HOMEPAGE="http://www.r-project.org/"

DEPEND="virtual/glibc
		>=dev-lang/perl-5.6.1-r3
		cjk? ( media-fonts/kochi-substitute )
		readline? ( >=sys-libs/readline-4.1-r3 )
		zlib? ( >=sys-libs/zlib-1.1.4 )
		jpeg? ( >=media-libs/jpeg-6b-r2 )
		png? ( >=media-libs/libpng-1.2.1 )
		atlas? ( dev-libs/atlas )
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tk )
		doc? ( sys-apps/texinfo virtual/tetex )
		mozilla? ( net-www/mozilla )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.4
			( =gnome-base/libglade-0.17* >=gnome-base/libglade-0.17 )
			>=dev-libs/libxml-1.8.16
			>=gnome-base/ORBit-0.5.12
			>=media-libs/imlib-1.9.10
			( =x11-libs/gtk+-1.2* >=x11-libs/gtk+-1.2.10 )		
			( =dev-libs/glib-1.2* >=dev-libs/glib-1.2.10 )
			>=media-sound/esound-0.2.23
			>=media-libs/audiofile-0.2.1 )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86"

src_unpack() {

	unpack ${P}.tgz
	cd ${S}

	epatch ${FILESDIR}/${RELEASE_PATCH}
	#epatch ${FILESDIR}/${P}-gentoo.diff

	if [ `use cjk` ] ; then
		epatch ${DISTDIR}/${VALUE_PATCH}
		epatch ${DISTDIR}/${REGEX_PATCH}
		if [ `use tcltk` ] ; then
			epatch ${DISTDIR}/${TCLTK_PATCH}
		fi
		if [ `use X` ] ; then
			#epatch ${DISTDIR}/${X11_PATCH}
			epatch ${FILESDIR}/${X11_PATCH}
			epatch ${DISTDIR}/${FIG_PATCH}
		fi
		rm -f src/main/gram.c
	fi
}

src_compile() {

	local myconf="--enable-R-profiling --enable-R-shlib"
	local I18N_CFLAGS L10N_CFLAGS

	#Eventually, we will want to take into account that a user may have
	#an alternate or additional blas libraries,
	#i.e. USE variable blas and and virtual/blas
	if [ `use atlas` ] ; then
		myconf="${myconf} --without-blas" #default enabled
	fi

	if [ `use tcltk` ] ; then
		#configure needs to find the files tclConfig.sh and tkConfig.sh
		myconf="${myconf} --with-tcltk"
		myconf="${myconf} --with-tcl-config=/usr/lib/tclConfig.sh"
		myconf="${myconf} --with-tk-config=/usr/lib/tkConfig.sh"
	else
		myconf="${myconf} --without-tcltk"
	fi

	if [ `has_version 'app-sci/lapack'` ] ; then
		myconf="${myconf} --with-lapack" #default disabled
	fi

	if [ `use cjk` ] ; then
		I18N_CFLAGS="-DI18N_MB"
		L10N_CFLAGS="-DL10N_JP"
	fi

	if [ `use mozilla` ] ; then
		myconf="${myconf} R_BROWSER=/usr/bin/mozilla"
	fi

	econf ${myconf} \
		`use_with X x` \
		`use_with gnome` \
		`use_with readline` \
		`use_with zlib` \
		`use_with jpeg jpeglib` \
		`use_with png libpng` \
		X_CFLAGS="${X_CFLAGS} ${I18N_CFLAGS}" \
		MAIN_CFLAGS="${MAIN_CFLAGS} ${I18N_CFLAGS} ${L10N_CFLAGS}" \
		CPPFLAGS="${CPPFLAGS} ${I18N_CFLAGS} ${L10N_CFLAGS}" \
		FFLAGS="${CFLAGS} ${FFLAGS}" || die "econf failed"

	emake || die

	#If you want to run check, uncomment this.
	#make check-all LANG=C LANGUAGE=C LC_ALL=C || die "check failed"

	if [ `use doc` ] ; then
		make info || die
		make pdf VARTEXFONTS=${T}/fonts || die 
	fi
}

src_install () {

	einstall || die "Installation Failed"

	dodoc AUTHORS BUGS COPYING* COPYRIGHTS ChangeLog FAQ INSTALL *NEWS \
		README RESOURCES THANKS VERSION Y2K

	dosym /usr/lib/R/doc/html /usr/share/doc/${PF}/html
	dosym /usr/lib/R/doc/manual /usr/share/doc/${PF}/manual

	if [ `use doc` ] ; then
		make infodir=${D}/usr/share/info install-info \
			&& rm -f ${D}/usr/share/info/dir* || die
		make rhome=${D}/usr/lib/R \
			VARTEXFONTS=${T}/fonts install-pdf || die
	fi

	#fix the R wrapper script to have the correct R_HOME_DIR
	#sed regexp borrowed from included debian rules
	dosed "/^R_HOME_DIR=.*/s::R_HOME_DIR=/usr/lib/R:" /usr/lib/R/bin/R

	#R installs two identical wrappers under /usr/bin and /usr/lib/R/bin/
	#the 2nd one is corrected by above sed, for the 1st
	#I'll just symlink it into /usr/bin
	cd ${D}/usr/bin/
	rm R
	dosym ../lib/R/bin/R /usr/bin/R
	cd ${S}

	#Add rudimentary menu entry if gnome
	if [ `use gnome` ] ; then
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/R.desktop
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/R-logo.png
	fi
}
