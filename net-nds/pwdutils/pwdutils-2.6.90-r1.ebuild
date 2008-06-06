# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE="ldap nis"
DESCRIPTION="pwdutils is a collection of utilities to manage the passwd and shadow user information."
HOMEPAGE="http://www.linux-nis.org/nis/"
SRC_URI="http://ftp.kernel.org/pub/linux/utils/net/NIS/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64 ~ia64"
RESTRICT="mirror"

DEPEND="virtual/libc
dev-libs/openssl
ldap? (net-nds/openldap)
nis? (net-nds/ypbind)"

src_compile() {
	use ldap || use nis || die "ldap or nis USE Flag needed."
	econf ${myconf} || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	if [ ! -f /etc/rpasswdd.pem ] ; then
		openssl req -new -x509 -nodes -days 730 -out ${D}/etc/rpasswdd.pem \
		-keyout ${D}/etc/rpasswdd.pem
	fi
	rm ${D}/etc/init.d/rpasswdd
	cp ${FILESDIR}/rpasswdd ${D}/etc/init.d
	insinto /etc
	doins ${D}/etc/rpasswdd.pem
}
