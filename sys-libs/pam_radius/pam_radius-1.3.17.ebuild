# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit pam

DESCRIPTION="a PAM to RADIUS authentication module"
HOMEPAGE="http://www.freeradius.org/pam_radius_auth/"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

src_install() {
	dopammod pam_radius_auth.so
	dodoc ChangeLog USAGE pam_radius_auth.conf
	keepdir /etc/raddb
}

pkg_postinst() {
	elog "See docs in /usr/share/doc/${PF} for an /etc/raddb/server"
	elog "example and PAM configuration"
}
