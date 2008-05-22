# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $$

IUSE=""

DESCRIPTION="Utility for creating and opening lzh archives"
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
SRC_URI="http://osdn.dl.sourceforge.jp/lha/11617/lha-1.14i-ac20040929.tar.gz"
RESTRICT="nomirror"

LICENSE="lha"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
	cd ${WORKDIR}/lha-1.14i-ac20040929
	econf "--enable-multibyte-filename=euc"|| die
	emake || die
}

src_install() {
	cd ${WORKDIR}/lha-1.14i-ac20040929
	dobin src/lha
	doman man/lha.man
	dodoc olddoc/*
#	dodir /usr/bin
#	dodir /usr/share/man/ja/man1
#	make \
#		BINDIR=${D}/usr/bin \
#		MANDIR=${D}/usr/share/man/ja \
#		install MANSECT=1 || die
#
#	dodoc *.txt *.euc *.eng
}
