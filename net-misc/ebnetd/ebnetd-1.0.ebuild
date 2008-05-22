# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

IUSE="ipv6"

DESCRIPTION="A server for accessing CD-ROM books with NDTP EBNET EBHTTP"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/ebnetd/index.html"
SRC_URI="ftp://ftp.sra.co.jp/pub/misc/eb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57
	!net-misc/ndtpd"
RDEPEND=">=dev-libs/eb-3
	>=sys-libs/zlib-1.1.3-r2"

pkg_setup() {
	# this is required; src_install() needs ndtpuser:ndtpgrp
	enewgroup ndtpgrp 402
	enewuser ndtpuser 402 -1 /usr/share/dict ndtpgrp
}

src_unpack() {

	unpack ${A}
	cd ${S}
}

src_compile() {

	autoconf || die

	declare myconf="--with-eb-conf=/etc/eb.conf"

	if use ipv6 ; then
		myconf="${myconf} --enable-ipv6=yes"
	else
		myconf="${myconf} --enable-ipv6=no"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall || die

	cp /etc/services ${T}/services
	if ! $(grep 2882/tcp /etc/services >/dev/null 2>&1) ; then
		cat >>${T}/services<<-EOF
		ndtp		2882/tcp			# Network Dictionary Transfer Protocol
		EOF
		insinto /etc
		doins ${T}/services
	fi
	if ! $(grep 80/tcp /etc/services >/dev/null 2>&1) ; then
		cat >>${T}/services<<-EOF
		http		80/tcp			# World Wide Web HTTP
		EOF
		insinto /etc
		doins ${T}/services
	fi
	if ! $(grep 22010/tcp /etc/services >/dev/null 2>&1) ; then
		cat >>${T}/services<<-EOF
		ebnet		22010/tcp			# EBNET
		EOF
		insinto /etc
		doins ${T}/services
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/ndtpd.initd ndtpd
	newexe ${FILESDIR}/ebnetd.initd ebnetd
	newexe ${FILESDIR}/ebhttpd.initd ebhttpd

	insinto /etc/xinetd.d
	newins ${FILESDIR}/ndtpd.xinetd ndtpd
	newins ${FILESDIR}/ebnetd.xinetd ebnetd
	newins ${FILESDIR}/ebhttpd.xinetd ebhttpd

	insinto /etc
	newins ebnetd.conf{.sample,}

	keepdir /var/lib/ebnetd
	fowners ndtpuser:ndtpgrp /var/lib/ebnetd
	fperms 4710 /var/lib/ebnetd

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* UPGRADE*
}
