# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


DESCRIPTION="A fast,light and scalable HTTP server with built-in ruby support"
HOMEPAGE="http://esehttpd.sourceforge.jp/
	http://sourceforge.jp/projects/esehttpd/"
SRC_URI="mirror://sourceforge.jp/${PN}/8007/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="ruby static debug"
DEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6
	ruby? ( >=dev-lang/ruby-1.6.8-r10 )"
#RDEPEND=${DEPEND}

src_compile() {
	local myconf=""
	use ruby && myconf="${myconf} --with-ruby"
	use debug && myconf="${myconf} --enable-debug"
	use static && myconf="${myconf} --enable-static"
	econf ${myconf} || die "econf failed"
	#econf $(use_with ruby) $(use_enable debug) $(use_enable static) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	#einstall || die "installation failed"
	dodir /etc/esehttpd/conf
	dodir /usr/lib/esehttpd
	dodir /var/log/esehttpd
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin

	dosym /etc/esehttpd/conf /usr/lib/esehttpd/conf
	dosym /var/log/esehttpd /usr/lib/esehttpd/log

	exeinto /etc/init.d;  newexe ${FILESDIR}/esehttpd.initd esehttpd
	insinto /etc/conf.d;  newins ${FILESDIR}/esehttpd.confd esehttpd

	exeinto /usr/sbin
		doexe ${S}/src/esehttpd
		doexe ${S}/src/eseconf
		doexe ${S}/src/esepasswd
		doexe ${S}/src/esetestclient
		doexe ${S}/etc/esectl
	insinto /etc/esehttpd/conf
		doins ${S}/etc/mime.types
		doins ${FILESDIR}/esehttpd.conf
	dodoc AUTHORS COPYING ChangeLog* MEMO* NEWS README TODO*
	dohtml -r ${S}/doc/*
}

pkg_postinst() {
	einfo
	einfo "Config files are located in /etc/esehttpd/conf directory."
	einfo
	ewarn "This version of esehttpd returns exit status 0 even if it fails to"
	ewarn "start due to unsuccessful binding in the case that the port which"
	ewarn "esehttpd trys to bind to is already occupied by other process."
	ewarn ""
}
