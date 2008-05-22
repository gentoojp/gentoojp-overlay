# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MYP="${PN}-1.14i-ac${PV}"
DESCRIPTION="Utility for creating and opening lzh archives"
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
SRC_URI="mirror://sourceforge.jp/lha/16650/${MYP}.tar.gz"

LICENSE="lha"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
#IUSE=""

#RDEPEND=""
#DEPEND="${RDEPEND}"

src_compile(){
	cd ${WORKDIR}/${MYP}
	if [ -n "`echo ${LANG}|grep -i '\.utf-[-_]\?8$'`" ];then
		MYCONF='--enable-multibyte-filename=utf8'
	fi
	econf ${MYCONF} || die
	emake || die
}

src_install(){
	cd ${WORKDIR}/${MYP}
	dobin src/lha
	doman man/lha.man
	dodoc 00readme.autoconf
	rm olddoc/Makefile*
	dodoc olddoc/*
}

