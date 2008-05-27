# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm

DESCRIPTION="Wnn7"
HOMEPAGE="http://www.omronsoft.co.jp/SP/pcunix/wnn7/index.html"
SRC_RPMS="dpkey7-1.01-2.i386.rpm \
wnn7-elisp-1.01-1.i386.rpm \
wnn7-maindic-1.01-1.i386.rpm \
wnn7-optiondic-1.01-1.i386.rpm \
wnn7-server-1.01-1.i386.rpm \
wnn7-utils-1.00-1.i386.rpm \
wnn7-xclients-1.03-1.i386.rpm \
dpkeylist"
SRC_URI=${SRC_RPMS}
LICENSE=""
SLOT="0"
KEYWORDS="~x86 -ppc -alpha -sparc"
RESTRICT="fetch"
DEPEND="app-arch/rpm2targz"

pkg_nofetch() {
    einfo "Please copy RPMs and dpkeylist:"
    einfo "${SRC_RPMS}"
    einfo "from CD-ROM or ${HOMEPAGE} and place them in ${DISTDIR}"
}

src_unpack() {
	rpm_src_unpack
	cd ${WORKDIR}
	rm -rf etc/rc.d
}

src_install() {
	cp -a ${WORKDIR}/* ${D}
	exeinto /etc/init.d
	doexe ${FILESDIR}/dpkey7
	doexe ${FILESDIR}/wnn7
	insopts -m0444
	insinto /etc/dpkey
	doins ${DISTDIR}/dpkeylist
}
