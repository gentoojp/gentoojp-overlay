# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="R is GNU S - A language and environment for statistical computing and graphics."

HOMEPAGE="http://www.r-project.org/"

IUSE="atlas X tcltk gnome jpeg png zlib readline cjk doc mozilla"
#other: I hope "aqua blas bzlib lapack pic pcre" flag.

VALUE_PATCH="${P}.i18n.20031122.patch"
REGEX_PATCH="${P}.i18n.regex.20031122.patch"
X11_PATCH="${P}.i18n.x11_mb.20031122.patch"
TCLTK_PATCH="${P}.i18n.tcltk.20031122.patch"
FIG_PATCH="${P}.l10n.psxfigtex.20031122.patch"

SRC_URI="http://cran.r-project.org/src/base/${P}.tgz
	cjk? ( http://r.nakama.ne.jp/${P}/patchs/${VALUE_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${REGEX_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${X11_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${TCLTK_PATCH}
		http://r.nakama.ne.jp/${P}/patchs/${FIG_PATCH} )"

LICENSE="GPL2 LGPL-2.1"

SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/glibc
		>=dev-lang/perl-5.6.1-r3
		readline? ( >=sys-libs/readline-4.1-r3 )
		zlib? ( >=sys-libs/zlib-1.1.3-r2 )
		jpeg? ( >=media-libs/jpeg-6b-r2 )
		png? ( >=media-libs/libpng-1.2.1 )
		atlas? ( dev-libs/atlas )
		X? ( virtual/x11 )
		tcltk? ( dev-lang/tk )
		doc? ( sys-apps/texinfo virtual/tetex )
		mozilla? ( net-www/mozilla )
		gnome? (  >=gnome-base/gnome-libs-1.4.1.4
			=gnome-base/libglade-0.17*
			>=dev-libs/libxml-1.8.16
			>=gnome-base/ORBit-0.5.12
			>=media-libs/imlib-1.9.10
			>=x11-libs/gtk+-1.2.10
			>=dev-libs/glib-1.2.10
			>=media-sound/esound-0.2.23
			>=media-libs/audiofile-0.2.1 )"

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${P}.tgz
	cd ${S}
	if [ `use cjk` ] ; then
		epatch ${DISTDIR}/${VALUE_PATCH}
		epatch ${DISTDIR}/${REGEX_PATCH}
		if [ `use tcltk` ] ; then
			epatch ${DISTDIR}/${TCLTK_PATCH}
		fi
		if [ `use X` ] ; then
			epatch ${DISTDIR}/${X11_PATCH}
			epatch ${DISTDIR}/${FIG_PATCH}
		fi
		rm -f src/main/gram.c
	fi
}

src_compile() {

	local myconf="--enable-R-shlib"
	local X_CFLAGS MAIN_CFLAGS R_BROWSER

	#Eventually, we will want to take into account that a user may have
	#an alternate or additional blas libraries,
	#i.e. USE variable blas and and virtual/blas

	if [ `use atlas` ] ; then
		myconf="${myconf} --without-blas" #default enabled
	fi

	if [ `use X` ] ; then
		myconf="${myconf} --with-x"
	else
		myconf="${myconf} --without-x"
	fi

	if [ `use tcltk` ] ; then
		#configure needs to find the files tclConfig.sh and tkConfig.sh
		myconf="${myconf} --with-tcltk --with-tcl-config=/usr/lib/tclConfig.sh --with-tk-config=/usr/lib/tkConfig.sh"
	else
		myconf="${myconf} --without-tcltk"
	fi

	if [ `use gnome` ] ; then
		myconf="${myconf} --with-gnome" #default disabled
	fi

	if [ ! `use jpeg` ] ; then
		myconf="${myconf} --without-jpeglib"
	fi

	if [ ! `use png` ] ; then
		myconf="${myconf} --without-libpng"
	fi

	if [ ! `use readline` ] ; then
		myconf="${myconf} --without-readline"
	fi

	if [ ! `use zlib` ] ; then
		myconf="${myconf} --without-zlib"
	fi

	if [ `use cjk` ] ; then
		X_CFLAGS="${X_CFLAGS} -DI18N_MB"
		MAIN_CFLAGS="${MAIN_CFLAGS} -DI18N_MB -DL10N_JP"
	fi

	if [ `use mozilla` ] ; then
		R_BROWSER="/usr/bin/mozilla"
	fi

	if has_version 'app-sci/lapack' ; then
		myconf="${myconf} --with-lapack" #default disabled
	fi

	X_CFLAGS="${X_CFLAGS}" MAIN_CFLAGS="${MAIN_CFLAGS}" \
		R_BROWSER="${R_BROWSER}" \
		./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake || die
	LANG=C LANGUAGE=C LC_ALL=C make check || die "check failed"

	if [ `use doc` ] ; then
		make info || die
		VARTEXFONTS=${T}/fonts make pdf || die 
	fi
}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die "installation failed"

	dodoc AUTHORS BUGS COPYING* COPYRIGHTS ChangeLog FAQ INSTALL *NEWS \
		README RESOURCES THANKS VERSION Y2K

	dosym /usr/lib/R/doc/html /usr/share/doc/${PF}/html
	dosym /usr/lib/R/doc/manual /usr/share/doc/${PF}/manual

	if [ `use doc` ] ; then
		make infodir=${D}/usr/share/info install-info || die
		make rhome=${D}/usr/lib/R install-pdf || die
	fi

	#fix the R wrapper script to have the correct R_HOME_DIR
	#sed regexp borrowed from included debian rules
	cp ${D}/usr/lib/R/bin/R ${S}/bin/R.orig
	sed -e '/^R_HOME_DIR=.*/s::R_HOME_DIR=/usr/lib/R:' \
		${S}/bin/R.orig > ${D}/usr/lib/R/bin/R

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
