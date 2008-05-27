# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils libtool

MY_D="/usr/local"
S=${WORKDIR}/ui/linux

DESCRIPTION="PeerCast is p2p broadcasting for everyone"
HOMEPAGE="http://www.peercast.org/"
SRC_URI="http://www.peercast.org/peercast-src.tgz"
IUSE="" 

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	#local myconf
	emake || die
}

src_install() {
	insinto ${MY_D}/peercast/
	insopts -m755
	doins peercast

	insopts -m644

	insinto ${MY_D}/peercast/html/en/
	doins ../html/en/*
	insinto ${MY_D}/peercast/html/en/images/
	doins ../html/en/images/*

	insinto ${MY_D}/peercast/html/ja/
	doins ../html/ja/*
	insinto ${MY_D}/peercast/html/ja/images/
	doins ../html/ja/images/*

	insinto ${MY_D}/peercast/html/en/
	doins ../html/fr/*
	insinto ${MY_D}/peercast/html/fr/images/
	doins ../html/fr/images/*

	insinto ${MY_D}/peercast/html/de/
	doins ../html/de/*
	insinto ${MY_D}/peercast/html/de/images/
	doins ../html/de/images/*

	mkbin
	into ${MY_D}
	dobin ../peercast
}

function mkbin(){
	BINFILE="../peercast"
	touch ${BINFILE}
	echo "#!/bin/bash"			>> ${BINFILE}
	echo "if [ -e ~/.peercast ];then"	>> ${BINFILE}
	echo "    test -e peercast"		>> ${BINFILE}
	echo "else"				>> ${BINFILE}
	echo "    mkdir ~/.peercast"		>> ${BINFILE}
	echo "ln -s ${MY_D}/peercast/html ~/.peercast/html" >> ${BINFILE}
	echo "fi"				>> ${BINFILE}
	echo "cd ~/.peercast"			>> ${BINFILE}
	echo ${MY_D}/peercast/peercast		>> ${BINFILE}
		
	chomod 755 ${BINFILE}
}