# Distributed under the terms of the GNU General Public License v2

inherit eutils gnuconfig

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE=""
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/ports/distfiles/sj3-2.0.1.20.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

DEPEND="virtual/glibc
	sys-libs/libtermcap-compat
	X? ( virtual/x11 )
	!X? ( sys-devel/imake )"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
# These patches do not work on Linux.
# old one
#	EPATCH_OPTS="-p0" epatch ${FILESDIR}/${PN}-patches-20040724.diff
# new one
#	EPATCH_OPTS="-p0" epatch ${FILESDIR}/${PN}-patches-20040916.diff
# We need strlcpy() to the patches above on Linux.
#	epatch ${FILESDIR}/${P}-strlcpy.diff

# This patch is included in the file above.
	epatch ${FILESDIR}/${P}-dict-Makefile.patch
	epatch ${FILESDIR}/${P}-tmpl.patch
        epatch ${FILESDIR}/${P}-server.patch
	cd dict/dict
	cp ${FILESDIR}/visual+.dic.gz .
	gunzip visual+.dic.gz
	mv visual.dic visual.dic.orig
	mv visual+.dic visual.dic
}

src_compile() {
	xmkmf || die
	make Makefiles || die
	make CDEBUGFLAGS="${CFLAGS}" || die
}

src_install() {

	enewgroup staff

	if ! $(grep 3086/tcp /etc/services >/dev/null 2>&1) ; then
		cp /etc/services ${T}/services
		cat >>${T}/services<<-EOF
		sj3            3086/tcp                        # SJ3
		EOF
		insinto /etc
		doins ${T}/services
	fi

	make SJ3TOP=${D}/usr install || die

	mv ${D}/usr/lib/sj3/sjrc ${D}/usr/lib/sj3/sjrc.orig
	cp ${FILESDIR}/sjrc.kinput2  ${D}/usr/lib/sj3/sjrc
 
	mv ${D}/usr/lib/sj3/sjrk ${D}/usr/lib/sj3/sjrk.orig
	cp ${FILESDIR}/sjrk  ${D}/usr/lib/sj3/

	cp ${FILESDIR}/sjhk  ${D}/usr/lib/sj3/

	dodoc CHANGES.eucJP README*

	exeinto /etc/init.d ; newexe ${FILESDIR}/sj3.initd.new sj3 || die
}

