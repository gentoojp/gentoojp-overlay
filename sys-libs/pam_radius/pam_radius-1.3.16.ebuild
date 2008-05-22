# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/sys-libs/pam_radius/pam_radius-1.3.16.ebuild,v 1.2 2004/06/25 16:45:42 vapier Exp $

DESCRIPTION="PAM to RADIUS authentication module"
HOMEPAGE="http://www.freeradius.org"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/pam_radius-1.3.16.tar"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="sys-libs/pam"

S=${WORKDIR}/pam_radius-1.3.16

src_compile() {
	emake || die
}

src_install () {
    install -d ${D}/lib/security
	install -g root -o root -m 700 -d ${D}/etc/raddb
    install -g root -o root -m 755 pam_radius_auth.so ${D}/lib/security
	install -g root -o root -m 600 pam_radius_auth.conf ${D}/etc/raddb/server
}
