# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A GkrellM2 plugin that lets you organize and track tasks and to-do items."

HOMEPAGE="http://voidtrance.home.comcast.net/software/"

SRC_URI="http://voidtrance.home.comcast.net/software/files/gtodo/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="nls"

DEPEND="=x11-libs/gtk+-2*
	=dev-libs/glib-2*
	>=app-admin/gkrellm-2.1.7"

S=${WORKDIR}/${PN}

src_unpack() {

	unpack ${A}
	cd ${S}

	sed -i \
		-e 's|$(GLOBAL_INSTALL_PATH)/$(TARGET)|$(INSTALL_PREFIX)&|g' \
		-e 's|install -m 644|install -D -m 644|' Makefile

}

src_compile() {

	use nls && nls_flag=1

	emake CC="${CC}" enable_nls=${nls_flag} || die "emake failed"
}

src_install() {

	make install INSTALL_PREFIX=${D} enable_nls=${nls_flag}

	dodoc BUGS COPYING CREDITS ChangeLog README TODO
	newdoc po/README README.po
}
