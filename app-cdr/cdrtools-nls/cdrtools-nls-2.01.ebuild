# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gcc gnuconfig
DESCRIPTION="A set of tools for CD recording, including cdrecord"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"
SRC_URI="ftp://plamo.linet.gr.jp/pub/Plamo-test/CDtools/cdrtools-2.01-NLS.tgz"

RESTRICT="nomirror"
LICENSE="GPL-2 freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-macos"
IUSE=""

DEPEND="virtual/libc
	!app-cdr/dvdrtools"
PROVIDE="virtual/cdrtools"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf install
}

src_install() {
	cd ${S}
	dobin usr/bin/*
	dosbin usr/sbin/*
	dolib usr/lib/*
	doman usr/man/*/*
	dodoc usr/doc/cdrtools-2.01-NLS/doc/*
	dodoc usr/doc/dvdrtools-0.1.5/*
	insinto /usr/include
	doins usr/include/*
}

