# Distributed under the terms of the GNU General Public License v2

inherit eutils gnuconfig

DESCRIPTION="Variant of the MIT xclock with a "cat" mode"
HOMEPAGE=""
SRC_URI="ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/catclock.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="virtual/libc
	x11-libs/openmotif
	X? ( virtual/x11 )
	!X? ( sys-devel/imake )"

S="${WORKDIR}/catclock"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/patch-aa
	epatch ${FILESDIR}/patch-ab
        epatch ${FILESDIR}/patch-ac
	epatch ${FILESDIR}/alarm-time_h.diff
	epatch ${FILESDIR}/imakefile.patch
	mv xclock.man catclock.man
	rm pwd.h makefile
	sed 's/^XClock/Catclock/g' <xclock.ad >Catclock.ad
}

src_compile() {
	xmkmf -a || die
	make CDEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
}

