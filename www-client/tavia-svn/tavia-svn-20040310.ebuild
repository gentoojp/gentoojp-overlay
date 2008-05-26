# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit subversion kde-base

need-kde 3.2
need-qt  3

ESVN_REPO_URI="http://dev.net-p.org/repos/tavia/trunk/tavia"

DESCRIPTION="A browser which can use tab with thumbnail + MDI window, and RSS, LIRS, HTML view"
HOMEPAGE="http://nop.net-p.org/modules/pukiwiki/index.php?%5B%5BTavia%5D%5D"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="!net-www/tavia
	=kde-base/kdebase-3.2*
	=kde-base/kdelibs-3.2*
	=x11-libs/qt-3*"

SLOT="0"
S="${WORKDIR}/${P}"

src_unpack() {
	subversion_src_unpack || die "unpack failed."

	cd ${S}
	export WANT_AUTOCONF_2_5=1
	make -f admin/Makefile.common dist || \
		die "bootstrap failed."
}
