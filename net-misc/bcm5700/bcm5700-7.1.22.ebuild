# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://www.broadcom.com/docs/driver_download/570x/linux-7.1.22.zip"
DESCRIPTION="Driver for the bcm5700 10/100/1000 network card (in the form of kernel modules)."
HOMEPAGE="http://www.broadcom.com/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}/linux/${P}/src

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}/linux
	tar -xzpf ${P}.tar.gz

}

src_compile() {

	check_KV

	sed -i -e "s|\$(shell uname -r)|$KV|" -e "s|shell uname -r|echo $KV|" Makefile
	emake || die

}

src_install() {

	mkdir -p ${D}/usr/share/man/man4
	make PREFIX=${D} install || die

}

pkg_postinst() {

	echo ">>> Updating module dependencies..."
	/sbin/depmod -a >/dev/null 2>&1

}
