# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit zproduct

DESCRIPTION="A zope wiki-clone for easy-to-edit collaborative websites."
HOMEPAGE="http://zwiki.org/"
SRC_URI="${HOMEPAGE}/releases/ZWiki-${PV}.tgz
	http://www.zope.org/Members/simon/ZWiki/ZWiki-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"

ZPROD_LIST="ZWiki"
MYDOC="ChangeLog GPL.txt ${MYDOC}"


src_unpack()
{
	unpack ${A}
	 if [ `use ja` ];
	 then
		epatch  ${FILESDIR}/zwiki-0.29-ja.diff
	 fi
}

