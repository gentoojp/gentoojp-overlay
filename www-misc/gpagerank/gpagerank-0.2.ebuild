# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gcc

IUSE="curl"

DESCRIPTION="Google PageRank for Linux"
SRC_URI="http://www.ssadata.com/linux/${PN}${PV}.tgz"
HOMEPAGE="http://www.ssadata.com/linux/"

DEPEND="virtual/libc
	curl?  ( net-misc/curl )
	!curl? ( net-misc/wget )"

KEYWORDS="~x86"
LICENSE="public-domain"
SLOT="0"

S="${WORKDIR}/${PN}"

src_unpack(){
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e 's/\(\s\+\)gcc/\1$(CC)/' \
		-e "s/^\(CFLAGS=\)\(.\+\)/\1${CFLAGS} \2/" \
		-e "s/^\(CC=\).\+/\1`gcc-getCC`/" \
		Makefile.orig > Makefile

	if use curl; then
		echo '#define CURL_CMD "curl -s"' > config.h
	else
		echo '#define CURL_CMD "wget -O - -q"' > config.h
	fi
}

src_compile(){
	emake || die
}

src_install(){
	dobin gpagerank
}
