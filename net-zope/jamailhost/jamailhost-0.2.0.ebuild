# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="Zope product for Japanese MailHost"

HOMEPAGE="http://www005.upp.so-net.ne.jp/nakagami"
SRC_URI="http://www005.upp.so-net.ne.jp/nakagami/Download/jaMailHost-${PV}.tar.gz"
LICENSE="GPL-1"
KEYWORDS="~x86"

DEPEND="<zope-2.7"

ZPROD_LIST="jaMailHost"

pkg_postinstall ()
{
  einfo "If you use Japanese Character EUC/JIS/S-JIS, you must get JapaneseCodecs."
}

