# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/dev-lang/R/R-1.9.1-r1.ebuild,v 1.10 2004/08/28 08:59:03 okayama Exp $

inherit eutils

IUSE="blas lapack X tcltk gnome jpeg png zlib bzlib pcre readline f2c shared static cjk nls doc mozilla pic"
# Using the blas USE flag now instead atlas, as atlas now
# has been broken into blas-atlas and lapack-atlas.
# Danny van Dyk <kugelfang@gentoo.org> 2004/07/11

DESCRIPTION="R is GNU S - A language and environment for statistical computing and graphics."

RELEASE_PATCH="${PN}-release-20040825.diff.gz"
VALUE_PATCH="${P}.i18n.20040625.patch"
GNOME_PATCH="${P}.i18n.gnome.20040625.patch"
REGEX_PATCH="${P}.i18n.regex.20040625.patch"
TCLTK_PATCH="${P}.i18n.tcltk.20040625.patch"
X11_PATCH="${P}.i18n.x11_mb.20040625.patch"
FIG_PATCH="${P}.l10n.psxfigtex.20040628.patch"

SRC_URI="http://cran.r-project.org/src/base/${P}.tgz
	nls? ( http://r.nakama.ne.jp/${P}/patchs/${VALUE_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${GNOME_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${REGEX_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${X11_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${TCLTK_PATCH}
		cjk? http://r.nakama.ne.jp/${P}/patchs/${FIG_PATCH} )"

HOMEPAGE="http://www.r-project.org/"

DEPEND="virtual/libc
	>=dev-lang/perl-5.6.1-r3
	sys-apps/texinfo
	readline? ( >=sys-libs/readline-4.1-r3 )
	cjk? ( media-fonts/kochi-substitute )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	png? ( >=media-libs/libpng-1.2.1 )
	blas? ( virtual/blas )
	lapack? ( virtual/lapack )
	f2c? ( dev-lang/f2c >=dev-libs/libf2c-20021004-r1 )
	X? ( virtual/x11 )
	tcltk? ( dev-lang/tk )
	doc? ( virtual/tetex )
	mozilla? ( net-www/mozilla )
	pcre? ( dev-libs/libpcre )
	bzlib? ( app-arch/bzip2 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.4
		( =gnome-base/libglade-0.17* >=gnome-base/libglade-0.17 )
		>=dev-libs/libxml-1.8.16
		=gnome-base/orbit-0*
		>=media-libs/imlib-1.9.10
		( =x11-libs/gtk+-1.2* >=x11-libs/gtk+-1.2.10 )
		( =dev-libs/glib-1.2* >=dev-libs/glib-1.2.10 )
		>=media-sound/esound-0.2.23
		>=media-libs/audiofile-0.2.1 )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~alpha"

pkg_setup() {

	if [ -z "$(which g77 2>/dev/null)" ]; then
		einfo "Couldn't find g77 Fortran Compiler."
		if ! use f2c ; then
			eerror "Trying to emerge this packet w/o fortran compiler."
			eerror "Try again with USE=\"f2c\" emerge dev-lang/R,"
			eerror "or re-emerge gcc with USE=\"f77\" first."
			die "No fortran compiler, no f2c."
		else
			einfo "Using f2c to translate fortran sources."
		fi
	fi
}

src_unpack() {

	unpack ${P}.tgz
	cd ${S}

	epatch ${FILESDIR}/${RELEASE_PATCH}

	if use nls ; then
		epatch ${DISTDIR}/${VALUE_PATCH}
		epatch ${DISTDIR}/${REGEX_PATCH}

		use gnome && epatch ${DISTDIR}/${GNOME_PATCH}
		use tcltk && epatch ${DISTDIR}/${TCLTK_PATCH}
		use X     && epatch ${DISTDIR}/${X11_PATCH}
		use cjk   && epatch ${DISTDIR}/${FIG_PATCH}

		rm -f src/main/gram.c
	fi
}

src_compile() {

	local myconf="--enable-R-profiling"
	local I18N_CFLAGS L10N_CFLAGS

	if use nls ; then
		I18N_CFLAGS="-DI18N_MB"
		if use cjk ; then
			L10N_CFLAGS="-DL10N_JP"
		fi
	fi

	if use tcltk ; then
		#configure needs to find the files tclConfig.sh and tkConfig.sh
		myconf="${myconf} --with-tcltk"
		myconf="${myconf} --with-tcl-config=/usr/lib/tclConfig.sh"
		myconf="${myconf} --with-tk-config=/usr/lib/tkConfig.sh"
	else
		myconf="${myconf} --without-tcltk"
	fi

	if use shared ; then
		myconf="${myconf} --enable-shared --enable-R-shlib"
	elif use static ; then
		myconf="${myconf} --enable-static"
	else
		:
	fi

	use mozilla && myconf="${myconf} R_BROWSER=/usr/bin/mozilla"
	use pic     && myconf="${myconf} --with-pic"

	econf ${myconf} \
		$(use_with zlib) \
		$(use_with bzlib) \
		$(use_with pcre) \
		$(use_with readline) \
		$(use_with blas) \
		$(use_with lapack) \
		$(use_with X x) \
		$(use_with jpeg jpeglib) \
		$(use_with png libpng) \
		$(use_with gnome) \
		MAIN_CFLAGS="${MAIN_CFLAGS} ${I18N_CFLAGS} ${L10N_CFLAGS}" \
		X_CFLAGS="${X_CFLAGS} ${I18N_CFLAGS}" || die "econf failed"

	emake \
		VARTEXFONTS=${T}/fonts || make \
		VARTEXFONTS=${T}/fonts || die "make failed"

	#If you want to run check, uncomment this.
	#make check-all LANG=C LANGUAGE=C LC_ALL=C || die "check failed"

	if use doc ; then
		make info || die
		make pdf VARTEXFONTS=${T}/fonts || die
	fi
}

src_install() {

	einstall || die "installation failed"

	dodoc AUTHORS BUGS COPYING* COPYRIGHTS ChangeLog FAQ INSTALL *NEWS \
		README RESOURCES THANKS VERSION Y2K

	dosym /usr/lib/R/doc/html   /usr/share/doc/${PF}/html
	dosym /usr/lib/R/doc/manual /usr/share/doc/${PF}/manual

	if use doc ; then
		make infodir=${D}/usr/share/info install-info \
			&& rm -f ${D}/usr/share/info/dir*  || die
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
	if use gnome ; then
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/R.desktop
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/R-logo.png
	fi
}
