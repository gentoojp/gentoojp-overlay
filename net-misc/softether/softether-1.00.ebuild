# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="se_${PV/./}_linux"
At="${MY_P}.zip"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="SoftEther - Virtual Ethernet System"
HOMEPAGE="http://www.softether.com/jp/download/"
SRC_URI="${At}"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="~x86 -ppc -sparc -alpha -mips -hppa"
RESTRICT="fetch"

DEPEND="dev-libs/openssl
	app-arch/unzip"

BIN_FILE="se_hub"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${HOMEPAGE}
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi
	mkdir ${S}
	cd ${S}
	unpack ${At}
}

src_compile() {
	cd ${S}
	STATIC_LIB_FILE=`find ${S}/*.a`
	gcc ${STATIC_LIB_FILE} -lpthread -lssl -lcrypto -o ${BIN_FILE} || die
}

src_install() {
	dodir /opt/${P}
	
	cd ${S}
	local files="${BIN_FILE} ca.key ca.crt"
	
	for i in $files ; do
		cp -a $i ${D}/opt/${P}/
	done
	exeinto /etc/init.d ; newexe ${FILESDIR}/sehubd.init sehubd
}

pkg_postinst() {
	einfo "********************************************************"
	einfo " SoftEther Virtual HUB was installed."
	einfo "--------------------------------------------------------"
	einfo " The starting method of SoftEther Virtual HUB"
	einfo ""
	einfo "    # /etc/init.d/sehub start"
	einfo ""
	einfo "--------------------------------------------------------"
	einfo " The stop method of SoftEther Virtual HUB"
	einfo ""
	einfo "    # /etc/init.d/sehub stop"
	einfo ""
	einfo "--------------------------------------------------------"
	eerror " At first, the password is not set to Virtual HUB."
	eerror " If a password is not set up, Virtual HUB will login to "
	eerror " anyone, and a setup will be changed freely. "
	eerror " Please be sure to set up a password."
	eerror " It will be displayed that a password is set up if it "
	eerror " connects with a management console. "
	eerror " (It cannot continue, unless it sets up)"
	eerror ""
	eerror "    # telnet localhost 8023"
	eerror ""
	einfo "********************************************************"
}
