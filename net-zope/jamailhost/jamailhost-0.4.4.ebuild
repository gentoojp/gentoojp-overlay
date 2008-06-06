# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="Zope product for Japanese MailHost"
HOMEPAGE="http://www005.upp.so-net.ne.jp/nakagami"
SRC_URI="http://www005.upp.so-net.ne.jp/nakagami/Download/jaMailHost-${PV}.tgz"

LICENSE="GPL-1"
KEYWORDS="~x86"

DEPEND=">=net-zope/zope-2.8"

ZPROD_LIST="jaMailHost"
