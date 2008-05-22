# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ATOKX="${P}-1.i386"
IIIMF="iiimf"
ATOKXHACK="libatokxhack-0.1"
S="${WORKDIR}/${ATOKXHACK}"

ATOKX_PATCH="${P}-1.i386.patch01.tgz"
IIIMF_PATCH="iiimf-1-2.i386.patch03.tgz"
YUUBIN_DICT_PATCH="atok12ydic_2001.patch01.tgz"

IUSE="system-iiimf im-shift_space"

DESCRIPTION="ATOKX is a commercial Japanese conversion server"
HOMEPAGE="http://www.justsystem.co.jp/atokx"
SRC_URI="http://www3.justsystem.co.jp/download/atok/up/lin/${ATOKX_PATCH}
	!system-iiimf? (
	http://www3.justsystem.co.jp/download/atok/up/lin/${IIIMF_PATCH}
	)
	http://www3.justsystem.co.jp/download/atok/up/lin/${YUUBIN_DICT_PATCH}
	mirror://sourceforge.jp/iiimf-skk/1461/${ATOKXHACK}.tar.gz"

LICENSE="ATOKX LGPL-2.1"	# libatokxhack is LGPL
KEYWORDS="-* ~x86"
SLOT="0"

RESTRICT="nostrip"

RDEPEND="=x11-libs/gtk+-1.2*
	virtual/x11
	system-iiimf? (
		app-i18n/iiimsf
		app-i18n/iiimxcf
		dev-libs/csconv
	)
	!system-iiimf? (
		!app-i18n/iiimsf
		!app-i18n/iiimxcf
		!dev-libs/csconv
	)"

pkg_setup() {

	if [ ! -f ${DISTDIR}/${ATOKX}.tgz ] ; then
		eerror "Packages not found in ${DISTDIR}"
		eerror "Please mount ATOKX cdrom and make symbolic links"
		eerror "in ${DISTDIR} named ${ATOKX}.tgz "
		eerror "which point to the corresponding packages on the CD"
		eerror ""
		eerror "Please make sure to link the tgz files and not the rpms"

		die
	fi
	if ! use system-iiimf && [ ! -f ${DISTDIR}/${IIIMF}.tgz ] ; then
		eerror "Packages not found in ${DISTDIR}"
		eerror "Please mount ATOKX cdrom and make symbolic links"
		eerror "in ${DISTDIR} named ${IIIMF}.tgz "
		eerror "which point to the corresponding packages on the CD"
		eerror ""
		eerror "Please make sure to link the tgz files and not the rpms"

		die
	fi
}

src_unpack() {
	unpack ${ATOKXHACK}.tar.gz
}

src_compile() {
	econf || die
	emake || die
}

src_install () {

	cd ${D}
	unpack ${ATOKX}.tgz
	unpack ${ATOKX_PATCH}
	unpack ${YUUBIN_DICT_PATCH}
	doinitd ${FILESDIR}/atokx

	if ! use system-iiimf ; then
		unpack ${IIIMF}.tgz
		unpack ${IIIMF_PATCH}
		doinitd ${FILESDIR}/iiim
	fi

	cd ${S}
	emake DESTDIR=${D} install || die

	cd ${D}
	exeinto /usr/lib/im/locale/ja/atokserver/xaux
	mv  ${D}/usr/lib/im/locale/ja/atokserver/xaux/LookupAux{,-real}
	newexe ${S}/src/LookupAux-replace LookupAux

	dodir /usr/bin
	dosed 's:/usr/lib/im/httx:LANG="ja_JP.eucJP" /usr/lib/im/httx:' \
		/usr/lib/im/locale/ja/atokserver/atokx_client
	dosym /usr/lib/im/locale/ja/atokserver/atokx_client \
		/usr/bin/iiimf-atokx

	use im-shift_space && touch ${D}/usr/lib/im/locale/ja/atokserver/shift_space

	# remove init.d files since they are wrong and are for redhat like
	# distributions
	rm -rf ${D}/etc/rc.d

	keepdir /var/locale/ja/atokserver/{system,users}
}

pkg_postinst() {

	einfo "ATOKX is now installed. There are some extra setup"
	einfo "you need to perform."
	einfo
	einfo "run /etc/init.d/atokx"
	einfo "add /usr/bin/iiimf-atokx to your .xinitrc"
	einfo "set XMODIFIERS to \"@im=htt\""
	einfo

}
