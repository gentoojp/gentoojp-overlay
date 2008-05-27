# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde-base

need-kde 3.2
need-qt  3

DESCRIPTION="A browser which can use tab with thumbnail + MDI and RSS, LIRS, HTML view"
SRC_URI="http://nop.net-p.org/files/Tavia/${P}.tar.gz"
HOMEPAGE="http://nop.net-p.org/modules/pukiwiki/index.php?%5B%5BTavia%5D%5D"

LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"

DEPEND="=kde-base/kdebase-3.2*
	=kde-base/kdelibs-3.2*
	=x11-libs/qt-3*"

SLOT="0"
S="${WORKDIR}/${P}"
