# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="FDClone: Console Filer"
HOMEPAGE="http://hp.vector.co.jp/authors/VA012337/soft/fd/"
SRC_URI="http://hp.vector.co.jp/authors/VA012337/soft/fd/FD-${PV}.tar.gz \
         ftp://ftp.unixusers.net/src/fdclone/FD-${PV}.tar.gz"

LICENSE="FDCLONE"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="ms-wavedash"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S="${WORKDIR}/FD-${PV}"

pkg_setup()
{
	if use ms-wavedash ; then
		PATCHES="${FILESDIR}/${P}-mswavedash.patch"
	fi
}

src_install(){
	dobin fd fd-dict.tbl fd-unicd.tbl fd-cat.ja fd-cat.C
	dosym fd /usr/bin/fdsh
	dodoc FAQ* HISTORY* Install* LICENSES* README* TECHKNOW* ToAdmin*
	newman fd_e.man fd.1
	dosym /usr/share/man/man1/fd.1 /usr/share/man/man1/fdsh.1
	insinto /usr/share/man/ja/man1
	doins fd.1;
	dosym /usr/share/man/ja/man1/fd.1 /usr/share/man/ja/man1/fdsh.1
	insinto /etc
	newins _fdrc fd2rc
}
