# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="Zope product for Japanese Splitter"

HOMEPAGE="http://www005.upp.so-net.ne.jp/nakagami"
SRC_URI="http://www005.upp.so-net.ne.jp/nakagami/Download/ejSplitter-${PV}.tar.gz"
LICENSE="GPL-1"
KEYWORDS="~x86"

ZPROD_LIST="ejSplitter"

pkg_postinstall ()
{
  einfo "If you use Japanese Character EUC/JIS/S-JIS, you must get JapaneseCodecs."
}

