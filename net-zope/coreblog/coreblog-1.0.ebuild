# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog/coreblog-0.6.ebuild,v 1.2 2004/06/25 01:19:39 agriffis Exp $

inherit zproduct

NEW_PV="${PV//./-}"

DESCRIPTION="Blog/Weblog/Web Nikki system for Zope."
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog10.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="COREBlog"
