# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="p2; 2ch browser written by php"
HOMEPAGE="http://akid.s17.xrea.com/"
SRC_URI="http://akid.s17.xrea.com/archive/p2_v1_5_19.zip"
RESTRICT="nomirror"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 -*"

S=${WORKDIR}/${PN}

RDEPEND=">=dev-php/php-4.3.8
		net-www/apache"

IUSE="apache2"

src_install() {
	local destdir=/var/www/localhost/${PN}
	local confdir=/etc/${PN}
	local datadir=/var/lib/p2/data

	dodir ${destdir}
	cp -r . ${D}${destdir}

	dodir ${confdir}
	mv ${D}${destdir}/conf ${D}${confdir}

	dosym ${confdir}/conf ${destdir}/conf

	if use apache2; then
		dodir /etc/apache2/conf/modules.d
		insinto /etc/apache2/conf/modules.d
		newins ${FILESDIR}/${PN}-20050502.conf 97_${PN}.conf
	else
		dodir /etc/apache/conf/addon-modules
		insinto /etc/apache/conf/addon-modules
		newins ${FILESDIR}/${PN}-20050502.conf ${PN}.conf
	fi

	dodoc doc/README.txt doc/ChangeLog.txt
	chown -R apache:apache ${D}${destdir}

	dodir ${datadir}
	chmod 0700 -R ${D}${datadir}
	chown -R apache:apache ${D}${datadir}
}

pkg_postinst() {
	einfo "attention! some default settings are changed."
	einfo "* 50 res. are displayed when you acccess via mobile. (default 15)"
}

