# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-zope/zwiki/zwiki-0.22.0.ebuild,v 1.2 2004/02/24 08:46:50 mr_bones_ Exp $

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

