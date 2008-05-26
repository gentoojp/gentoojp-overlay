# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

IUSE="X java"

DESCRIPTION="VJE-Delta is a commercial Japanese conversion server."
HOMEPAGE="http://www.vacs.co.jp/news/pcuxVJE30.htm"

# vacs's license
LICENSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-apps/sed"
RDEPEND="X? ( virtual/x11 )
java? ( virtual/jdk )"

BASE="/opt/vje30"

pkg_setup () {

	# require CD-ROM

	cdrom_get_cds linux/${PN}-delta-${PV}.tgz 

}

src_unpack() {

	mkdir ${P}
	cd ${P}
	tar xvzpf  ${CDROM_ROOT}/linux/${PN}-delta-${PV}.tgz 

}

src_compile() {
	einfo "Nothing to Compile, this is a binary package."
}

src_install() {


	# copy binaries

	cd usr/local/vje30

	insinto ${BASE}/acc
	doins acc/* || die

	exeinto ${BASE}/bin
	doexe bin/vjed bin/vadd bin/vdel bin/vdispd bin/vmaked \
		bin/vpr bin/vprc || die

	if use X ; then
		exeinto ${BASE}/bin
		doexe bin/vje bin/vjekill bin/vpen || die
	fi

	if use java ; then
		exeinto ${BASE}/bin
		doexe bin/vpu bin/vjeacc bin/vjeacc.jar bin/swingall.jar || die
	fi
		
	insinto ${BASE}/com
	doins com/* || die
	insinto ${BASE}/dic
	doins dic/* || die
	insinto ${BASE}/doc
	doins doc/* || die
	insinto ${BASE}/env
	doins env/* || die
	insinto ${BASE}/lib
	doins lib/* || die

	dodoc FAQ README REQUEST || die
	chmod a+w ${D}${BASE}/dic/vjed95m.dic
	
	# copy configuration files

	cd ${S}/etc/vje30
	cp vje.cfg vje.cfg.orig
	sed -e 's:\(^Path=\).*:\1/opt/vje30:' vje.cfg.orig > vje.cfg
	dodir /etc/vje30
	insinto /etc/vje30
	doins vje.cfg || die

	if [ ! `grep -q vjed /etc/services` ]
	then
		cp /etc/services .
		echo "vjed              11493/tcp               # VJE-Delta2.5 Server" >> services
		insinto /etc
		doins services || die
	fi

	# for env.d

	insinto /etc/env.d
	doins ${FILESDIR}/80vje30 || die


	# for initsystem

	exeinto /etc/init.d
	newexe ${FILESDIR}/vje30.initd vje30 || die
	
	
}


