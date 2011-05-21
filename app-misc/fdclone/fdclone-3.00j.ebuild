# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils toolchain-funcs

MY_P="FD-${PV}"

DESCRIPTION="FDClone: Console Filer"
HOMEPAGE="http://hp.vector.co.jp/authors/VA012337/soft/fd/"
SRC_URI="http://hp.vector.co.jp/authors/VA012337/soft/fd/${MY_P}.tar.gz"

LICENSE="FDCLONE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-mswavedash.patch

	# system fd2rc settings
	sed	-e '/^#DISPLAYMODE=/{s/^#//;s/0/6/;}' \
		-e '/^#ANSICOLOR=/{s/^#//;s/0/3/}' \
		-e '/^#IMEKEY=/{s/^#//;s/""/ENTER/;}' \
			_fdrc > fd2rc
	#sed -i -e '/^#DEFCOLUMNS=/{s/^#//;s/2/1/;}' fd2rc

	if [ $(tc-arch ${CTARGET}) == "x86" ];then
		sed -i -e '/^#FUNCLAYOUT=/{s/^#//;s/1005/1204/;}' fd2rc
		for((i=1,j=10;i<=12;++i));do
			echo -e "keymap F$i\t\"\\\e["$((i+j))"~\"" >> fd2rc
			if [ $((i%5)) == 0 ];then j=$((j+1));fi
		done
	fi

	if use unicode;then
		sed -i fd2rc -e '/^#UNICODEBUFFER=/{s/^#//;s/=0/=1/;}' \
		-e '/^#\(LANGUAGE\|INPUTKCODE\|FNAMEKCODE\)=/{s/^#//;s/=""/="utf8"/;}'
	fi
}

src_compile(){
	emake \
		PREFIX="${EPREFIX}"/usr \
		CONFDIR="${EPREFIX}"/etc \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -DLINUX=1 -DFILE_OFFSET_BITS=64" || die
}

src_install(){
	dobin fd
	dosym fd "${EPREFIX}"/usr/bin/fdsh
	insinto "${EPREFIX}"/usr/share/fd
	doins fd-dict.tbl fd-unicd.tbl
	dodoc  FAQ* HISTORY* Install* LICENSES* README* TECHKNOW* ToAdmin*
	doman fd.1; dosym fd.1 /usr/share/man/man1/fdsh.1
	insinto "${EPREFIX}"/etc
	doins fd2rc
}

