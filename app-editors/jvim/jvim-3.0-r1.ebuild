# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/portage/app-editors/jvim/jvim-3.0.ebuild,v 1.1.1.1 2003/07/01 08:21:31 usata Exp $

IUSE="X canna"

DESCRIPTION="Japanised Vim (with direct canna support)"

JVIM_PV="2.1b"

HOMEPAGE="http://hp.vector.co.jp/authors/VA003457/vim/vim3/vim.html"
SRC_URI="ftp://ftp.vim.org/pub/vim/unix/vim-${PV}.tar.gz
	http://hp.vector.co.jp/authors/VA003457/vim/vim3/${JVIM_PV}/jvim.${JVIM_PV}.tar.gz
	canna? ( http://canna.sourceforge.jp/canna37patches/jvim3-${JVIM_PV}-canna37.diff )"

LICENSE="vim"

SLOT="0"

KEYWORDS="~x86"

DEPEND="X? ( virtual/x11 )
	canna? ( app-i18n/canna )
	sys-libs/ncurses
	virtual/glibc"

S=${WORKDIR}/vim

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/jvim.diff
	epatch ${FILESDIR}/${P}-gentoo.patch
	use canna && epatch ${DISTDIR}/jvim3-${JVIM_PV}-canna37.diff
	cp ${WORKDIR}/readme.1st ${S}
	mv doc/vim.1 doc/jvim.1
	cp src/makjunix.mak src/Makefile
}

src_compile() {
	cd ${S}/src

	sed -i -e '/^DEFS/s|DEFS = |DEFS = -DDEFVIMRC_FILE=\\"/etc/jvimrc\\" |' Makefile

	if [ -n "`use canna`" ]; then
		sed -i -e '/-DCANNA/,+3s/^#//g' Makefile
	fi

	if [ -n "`use X`" ]; then
		cat >> Makefile <<- EOF
			MACHINE = -DBSD_UNIX -DUSE_LOCALE -DUSE_X11
			CC = ${CC} ${CFLAGS}
			LIBS = -lncurses -L/usr/X11R6/lib -lX11
		EOF
	else
		cat >> Makefile <<- EOF
			MACHINE = -DBSD_UNIX -DUSE_LOCALE
			CC = ${CC} ${CFLAGS}
			LIBS = -lncurses
		EOF
	fi

	emake PREFIX=/usr TARGET=jvim \
		MANLOC=/usr/share/man/man1 HELPLOC=/usr/lib/jvim \
		all || die "make failed"
}

src_install() {
	exeinto /usr/bin
	doexe src/jvim
	newexe src/grep/grep jgrep

	insinto /usr/lib/jvim
	doins doc.j/vim.hlp

	if [ -n "`use canna`" ]; then
		dodir /etc
		echo "set fepctrl" >> ${D}/etc/jvimrc
	fi

	doman doc/jvim.1
	dodoc README credits.txt poster readme.1st readme3.0 uganda.txt todo

	docinto doc ; dodoc doc/*
	docinto doc.j ; dodoc doc.j/*.{txt,doc,dos,jp,htm,ini}
	insinto /usr/share/jvim ; doins doc.j/_jvimrc
	insinto /usr/share/jvim/macros ; doins macros/{center,keyword,readme}
	insinto /usr/share/jvim/macros/hanoi ; doins macros/hanoi/*
	insinto /usr/share/jvim/macros/maze ; doins macros/maze/*
	insinto /usr/share/jvim/macros/urm ; doins macros/urm/*
	insinto /usr/share/jvim/tools ; doins tools/*
	insinto /usr/share/jvim/tutor ; doins tutor/* doc.j/tutor/*
}
