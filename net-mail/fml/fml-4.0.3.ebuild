# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="This is a sample skeleton ebuild file"

HOMEPAGE="http://www.fml.org"
SRC_URI="ftp://ftp.fml.org/pub/fml/release/${P}.tar.gz"
LICENSE=""

SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	virtual/mta"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {

	# change any variable if you'd like to

	# Personal Use or ML-Admin-Group-Shared or fmlserv you use? 
	# Personal, Group, Fmlserv (personal/group/fmlserv) [personal]
	echo "personal" >> ${T}/makefml.conf
	# DOMAIN NAME [your domain name here]
	echo "" >> ${T}/makefml.conf
	# FQDN [your FQDN here]
	echo "" >> ${T}/makefml.conf
	# EXEC FILES DIRECTORY [/usr/local/fml]
	echo "${D}/usr/share/fml" >> ${T}/makefml.conf
	# TOP LEVEL ML DIRECTORY [/var/spool/ml]
	echo "${D}/var/spool/ml" >> ${T}/makefml.conf
	# Language (Japanese or English) [English]
	echo "" >> ${T}/makefml.conf
	# TimeZone (TZ: e.g. +0900, -0300) [your TZ here]
	echo "" >> ${T}/makefml.conf
	# Install the Fml system to ${D}usr/share/fml. (y/n) [n]
	echo "y" >> ${T}/makefml.conf

	make install < ${T}/makefml.conf || die

	dodir /usr/bin
	dosym /usr/share/fml/makefml /usr/bin/makefml
	rm -f ${D}/usr/share/fml/Configurations
	dosym /usr/share/fml/.fml /usr/share/fml/Configurations
	dosed /usr/share/fml/{,sbin/}makefml
	dosed /usr/share/fml/.fml/{cgi.conf,system}
	dosed /usr/share/fml/www/cgi-bin/*/*.cgi
	dosed /usr/share/fml/www/examples/apache/httpd.conf.patch
	dosed /usr/share/fml/www/share/cgi-bin/fml/admin/*.cgi

	dosed /usr/share/fml/doc/man/{fml.8,makefml.1}
	dosed -e "s:/usr/share/fml/makefml:/usr/bin/makefml:g" \
		/usr/share/fml/doc/man/{fml.8,makefml.1}
	dosed -e "s:/usr/share/fml/doc:/usr/share/doc/${P}:g" \
		/usr/share/fml/doc/man/{fml.8,makefml.1}
	doman ${D}/usr/share/fml/doc/man/{fml.8,makefml.1}

	if [ "`use doc`" ] ; then
		rm -rf ${D}/usr/share/fml/doc/man
		mv ${D}/usr/share/fml/doc ${D}/usr/share/doc/${P}
		dosym /usr/share/doc/${P} /usr/share/fml/doc
	else
		rm -rf ${D}/usr/share/fml/doc
	fi

	enewgroup fml 125
	enewuser fml 125 /bin/false /usr/share/fml fml

	fowners fml:fml /var/spool/ml
	fowners fml:fml /var/spool/ml/etc
	keepdir /var/spool/ml/etc
	keepdir /usr/share/fml/www/share/cgi-bin/admin
}
