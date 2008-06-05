# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnuconfig

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://code.google.com/p/sj3/"
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"

RDEPEND="sys-libs/libtermcap-compat"
DEPEND="${RDEPEND}
	x11-misc/imake"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# These patches do not work on Linux.
	# old one
	#	EPATCH_OPTS="-p0" epatch "${FILESDIRR}"/${PN}-patches-20040724.diff
	# new one
	#	EPATCH_OPTS="-p0" epatch "${FILESDIRR}"/${PN}-patches-20040916.diff
	# We need strlcpy() to the patches above on Linux.
	#	epatch "${FILESDIRR}"/${P}-strlcpy.diff

	# This patch is included in the file above.
	epatch ""${FILESDIRR}"/${P}-dict-Makefile.patch"
	epatch ""${FILESDIRR}"/${P}-tmpl.patch"
	epatch ""${FILESDIRR}"/${P}-server.patch"
	cd dict/dict
	cp ""${FILESDIRR}""/visual+.dic.gz .
	gunzip visual+.dic.gz
	mv visual.dic visual.dic.orig
	mv visual+.dic visual.dic
}

src_compile() {
	xmkmf || die "xmkmf failed"
	make Makefiles || die "make Makefiles failed"
	make CDEBUGFLAGS="${CFLAGS}" || die "make failed"
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

	make SJ3TOP="${D}"/usr install || die

	mv "${D}"/usr/lib/sj3/sjrc "${D}"/usr/lib/sj3/sjrc.orig
	cp "${FILESDIRR}"/sjrc.kinput2 "${D}"/usr/lib/sj3/sjrc

	mv "${D}"/usr/lib/sj3/sjrk "${D}"/usr/lib/sj3/sjrk.orig
	cp "${FILESDIRR}"/sjrk  "${D}"/usr/lib/sj3/

	cp "${FILESDIRR}"/sjhk  "${D}"/usr/lib/sj3/

	dodoc CHANGES.eucJP README*

	exeinto /etc/init.d ; newexe "${FILESDIRR}"/sj3.initd.new sj3 || die
}

