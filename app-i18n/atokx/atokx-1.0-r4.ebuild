# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvsroot/gentoojp/portage/app-i18n/atokx/atokx-1.0-r4.ebuild,v 1.1 2003/09/04 01:00:31 puntium Exp $

IUSE=""


ATOKXHACK="libatokxhack-0.1"
ATOK_XAUX_DIR="/usr/lib/im/locale/ja/atokserver/xaux"

DESCRIPTION="ATOKX is a commercial Japanese conversion server"
#SRC_URI="http://www.justsystem.co.jp"
SRC_URI="http://osdn.dl.sourceforge.jp/iiimf-skk/1461/${ATOKXHACK}.tar.gz"
HOMEPAGE="http://www.justsystem.co.jp/atokx"
LICENSE="commercial"
KEYWORDS="~x86 -alpha -sparc -ppc"
SLOT="0"

RESTRICT="nostrip"

DEPEND=">=app-i18n/im-sdk-11.4.1467"

RDEPEND="x11-libs/gtk+
		virtual/x11"

ATOKXPKG="atokx-1.0-1.i386.tgz"

S=${WORKDIR}/${ATOKXHACK}

pkg_setup() {

	if [ ! -f ${DISTDIR}/${ATOKXPKG} ] ; then
		eerror "Package not found in ${DISTDIR}"
		eerror "Please mount ATOKX cdrom and make a symbolic link"
		eerror "in ${DISTDIR} named ${ATOKXPKG} "
		eerror "which points to the corresponding package on the CD"
		eerror ""
		eerror "Please make sure to link the tgz files and not the rpms"

		die
	fi
}



src_compile() {

	einfo "Nothing to do, this is a binary package"

    cd ${S}
    ./configure || die "configure of atokxhack failed"
    make || die "build of atokxhack failed"


}

src_install () {

	cd ${D}
	#einfo "Unpacking ${IIIMFPKG}"
	#tar xzf ${DISTDIR}/${IIIMFPKG}
    # no longer needed -- we use app-i18n/iiimf instead
	einfo "Unpacking ${ATOKXPKG}"
	tar xzf ${DISTDIR}/${ATOKXPKG}

	# remove init.d files since they are wrong and are for redhat like
	# distributions

	rm -rf ${D}/etc/rc.id
	exeinto /etc/init.d
	#doexe ${FILESDIR}/IIim
	doexe ${FILESDIR}/atokx

    touch ${D}/usr/lib/im/locale/ja/atokserver/shift_space


    cd ${S}
    make DESTDIR=${D} install
    cp ${S}/src/LookupAux-replace ${D}/${ATOK_XAUX_DIR}

    pushd ${D}/${ATOK_XAUX_DIR}
    einfo "Moving LookupAux to LookupAux-real"
    mv LookupAux LookupAux-real
    einfo "Installing fake LookupAux"
    mv LookupAux-replace LookupAux
    echo "finished.."
    popd


}

pkg_postinst() {



	einfo "ATOKX is now installed. There are some extra setup"
	einfo "you need to perform."
	einfo ""
    einfo "libatokxhack was also installed to improve focus compatibiilty"
    einfo ""
	einfo "add /usr/lib/im/locale/ja/atokserver/atokx_client to your .xinitrc"
	einfo "set XMODIFIERS to \"@im=htt\""

}
