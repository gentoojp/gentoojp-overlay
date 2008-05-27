# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${PN}-QPL-${PV}"
DESCRIPTION="X11 based 2-D drawing tool"
HOMEPAGE="http://bourbon.usc.edu:8001/tgif/"
SRC_URI="ftp://bourbon.usc.edu/pub/tgif/${MY_P}.tar.gz"

LICENSE="QPL-1.0 | tgif"
KEYWORDS="~x86"
SLOT="0"
IUSE="nls cjk"

DEPEND="virtual/x11"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}

	cd ${S}
	if use cjk ; then
	epatch ${FILESDIR}/${P}-japanese.patch
	fi
}

src_compile(){
	local mydefines=""

	mydefines="${mydefines} -DUSE_XT_INITIALIZE"

	if use nls ; then
	mydefines="${mydefines} -D_ENABLE_NLS"
	fi
	
	if use cjk ; then
	mydefines="${mydefines} -DOVERTHESPOT -DA4PAPER"
	fi

	xmkmf -a || die
	emake \
		CDEBUGFLAGS="${CFLAGS}" \
		CXXDEBUGFLAGS="${CXXFLAGS}" \
		MOREDEFINES="${mydefines}" \
		LOCAL_LIBRARIES="-lXmu -lXt -lX11" || die

	if use nls ; then
		cd ${S}/po
		xmkmf -a || die
		emake \
			CDEBUGFLAGS="${CFLAGS}" \
			CXXDEBUGFLAGS="${CXXFLAGS}" \
			MOREDEFINES="${mydefines}" \
			LOCAL_LIBRARIES="-lXmu -lXt -lX11" || die
	fi
}

src_install(){
	make DESTDIR=${D} TGIFDIR=/usr/share/tgif install install.man || die
	dodoc Copyright HISTORY README* *.obj example.tex

	if use nls ; then
		cd ${S}/po
		make DESTDIR=${D} TGIFDIR=/usr/share/tgif install install.man || die
		docinto po
		dodoc HISTORY README
	fi

	insinto /etc/X11/app-defaults
	newins ${S}/tgif.Xdefaults Tgif
}
