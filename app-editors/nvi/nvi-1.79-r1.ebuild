# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="cjk canna X tcltk ncurses"

PATCH_P="${P}.m17n-20011024.diff"

DESCRIPTION="Multilingualized Vi clone based on ${P}"
SRC_URI="ftp://ftp.sleepycat.com/pub/${P}.tar.gz
	cjk? ftp://ftp.foretune.co.jp/pub/tools/nvi-m17n/${PATCH_P}.gz"
HOMEPAGE="http://www.bostic.com/vi/
	http://www.itojun.org/"

SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="~x86 ~ppc ~sparc"

PROVIDE="virtual/editor"
DEPEND="virtual/glibc
	sys-libs/libtermcap-compat
	tcltk? ( dev-lang/tk )
	ncurses? ( sys-libs/ncurses )
	canna? ( app-i18n/canna )
	X? ( virtual/x11 )"
	#perl? ( dev-lang/perl )

S="${WORKDIR}/${P}/build"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${WORKDIR}/${P}
	zcat ${DISTDIR}/${PATCH_P}.gz | grep -v "^+++" > ${T}/${PATCH_P}
	use cjk && epatch ${T}/${PATCH_P}
}

src_compile() {

	local myconf

	if [ `use canna` -a `use cjk` ]
	then
		myconf="--enable-multibyte=euc-jp
			--enable-canna" 
	elif [ `use cjk` ]
	then
		myconf="--enable-multibyte"
	fi

	# *interp doesn't work with enable-multibyte
	# `use_enable perl perlinterp`
	# `use_enable tcltk tclinterp`
	econf --program-prefix=n \
		`use_enable ncurses curses` \
		`use_enable tcltk tknvi` \
		`use_with X x` \
		${myconf} || die

	emake || die
}

src_install() {

	einstall || die
}

pkg_postinst() {

	if [ `use canna` ]
	then
		einfo
		einfo "If you want to use Canna input method, add"
		einfo "\tset canna"
		einfo "to your nvi configuration file."
		einfo
	fi
}
