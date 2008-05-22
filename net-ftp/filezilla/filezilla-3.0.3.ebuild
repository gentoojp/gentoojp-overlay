# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.18-r6.ebuild,v 1.7 2007/09/25 17:01:59 dertobi123 Exp $

inherit eutils

DESCRIPTION="Gnome based FTP Client"
MY_P="FileZilla_3.0.3_src"
SRC_URI="mirror://sourceforge/filezilla/${MY_P}.tar.bz2"
HOMEPAGE="http://filezilla-project.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="cppunit"

RDEPEND=">=dev-libs/glib-2
		 sys-devel/gettext
		 sys-libs/ncurses
		 sys-libs/readline
		 cppunit? ( dev-util/cppunit )
		 >=x11-libs/wxGTK-2.8.6
		 >=net-libs/gnutls-1.5.4
		 >=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	econf $(use_with cppunit)  || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog* README* THANKS TODO docs/USERS-GUIDE
}
