# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Unzipper for pkzip-compressed files"
HOMEPAGE="ftp://ftp.info-zip.org/pub/infozip/UnZip.html"
SRC_URI="ftp://ftp.info-zip.org/pub/infozip/src/${PN}${PV/.}.tar.gz"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-exec-stack.patch
        epatch "${FILESDIR}"/${P}-CVE-2008-0888.patch #213761

# DFedit: apply Japanese codec patch from Ubuntu-ja
	use nls && epatch ${FILESDIR}/${P}-ubuntuja.patch

	sed -i \
		-e 's:-O3:$(CFLAGS):' \
		-e 's:-O :$(CFLAGS) :' \
		-e "s:CC=gcc :CC=$(tc-getCC) :" \
		-e "s:LD=gcc :LD=$(tc-getCC) :" \
		-e 's:LF2 = -s:LF2 = :' \
		-e 's:LF = :LF = $(LDFLAGS) :' \
		-e 's:SL = :SL = $(LDFLAGS) :' \
		-e 's:FL = :FL = $(LDFLAGS) :' \
		unix/Makefile \
		|| die "sed unix/Makefile failed"
}

src_compile() {
	local TARGET
	case ${CHOST} in
		i?86*-linux*) TARGET=linux_asm ;;
		*-linux*)     TARGET=linux_noasm ;;
		*-dragonfly*) use x86 && TARGET=freebsd || TARGET=bsd ;;
		*-freebsd*)   use x86 && TARGET=freebsd || TARGET=bsd ;;
		*-openbsd*)   TARGET=bsd ;;
		*-darwin*)    TARGET=macosx ;;
		*)            die "Unknown target, you suck" ;;
	esac
	append-lfs-flags #104315
	emake -f unix/Makefile ${TARGET} || die "emake failed"
}

src_install() {
	dobin unzip funzip unzipsfx unix/zipgrep || die "dobin failed"
	dosym unzip /usr/bin/zipinfo || die
	doman man/*.1
	dodoc BUGS History* README ToDo WHERE
}
