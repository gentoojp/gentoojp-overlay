# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

IUSE=""

DESCRIPTION="Nikuhakase is a browser just for Niku-aholics"
HOMEPAGE="http://kazehakase.sourceforge.jp/ja/niku.html"
SRC_URI="mirror://sourceforge.jp/kazehakase/8964/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64"
LICENSE="GPL-2"

DEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool
	<net-www/mozilla-1.7
	x11-libs/pango
	>=x11-libs/gtk+-2*
	dev-util/pkgconfig"

S="${WORKDIR}/${P}"

pkg_setup(){
	if grep -v gtk2 /var/db/pkg/net-www/mozilla-[[:digit:]]*/USE > /dev/null
	then
		echo
		eerror
		eerror "This needs mozilla used gtk2."
		eerror "To build mozilla use gtk2, please type following command:"
		eerror
		eerror "    # USE=\"gtk2\" emerge mozilla"
		eerror
		die
	fi
}

src_compile(){
	econf || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog NEWS README* TODO.ja
}
