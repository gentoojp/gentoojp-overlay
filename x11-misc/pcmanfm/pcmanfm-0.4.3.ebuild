# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit fdo-mime

DESCRIPTION="Extremely fast and lightweight tabbed file manager"
HOMEPAGE="http://pcmanfm.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hal"

RDEPEND=">=x11-libs/gtk+-2.8
	virtual/fam
	x11-libs/startup-notification
	hal? ( >=sys-apps/hal-0.5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf \
		$(use_enable hal) \
		--disable-inotify \
		--disable-dependency-tracking \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	if has_version app-admin/fam ; then
		elog "You are using fam as your file alteration monitor,"
		elog "so you must have famd started before running pcmanfm."
		elog
		elog "To add famd to the default runlevel and start it, run:"
		elog
		elog "# rc-update add famd default"
		elog "# /etc/init.d/famd start"
		elog
		elog "It is recommended you use gamin instead of fam."
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
